package com.hsun.ywork.modules.course.web;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.utils.WebUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.entity.*;
import com.hsun.ywork.modules.course.service.*;
import com.hsun.ywork.modules.qa.utils.ObjectUtils;
import com.hsun.ywork.modules.qa.utils.SingletonLoginUtils;
import com.hsun.ywork.modules.course.entity.QueryTeacher;
import com.hsun.ywork.modules.course.entity.Teacher;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.NumberFormat;
import java.util.*;

/**
 * 前台 Course管理接口
 * @author GeCoder
 */
@Controller
@RequestMapping("/course")
public class CourseController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(CourseController.class);

    // 课程列表
    private static final String showCourseList = getViewPath("/front/course/courses-list");
    // 课程详情 
    private static final String couinfo = getViewPath("/front/course/course-infor");

    @Autowired
    private CourseService courseService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private SubjectService subjectService;
	@Autowired
	private CourseFavoritesService courseFavoritesService;
	@Autowired
	private CourseKpointService courseKpointService;

    // 绑定变量名字和属性，参数封装进类
    @InitBinder("queryCourse")
    public void initBinderQueryCourse(WebDataBinder binder) {
        binder.setFieldDefaultPrefix("queryCourse.");
    }
    @InitBinder("courseFavorites")
    public void initBinderCourseFavorites(WebDataBinder binder) {
    	binder.setFieldDefaultPrefix("courseFavorites.");
    }
    @InitBinder({"page"})
    public void initBinderPage(WebDataBinder binder) {
        binder.setFieldDefaultPrefix("page.");
    }

    /**
     * 课程列表展示,搜索课程
     */
    @RequestMapping("/showcoulist")
    public ModelAndView showCourseList(HttpServletRequest request, @ModelAttribute("page") PageEntity page, @ModelAttribute("queryCourse") QueryCourse queryCourse) {
        ModelAndView model = new ModelAndView();
        try {
        	model.setViewName(showCourseList);
            // 页面传来的数据放到page中
        	page.setPageSize(12);
            //只查询上架的
            queryCourse.setIsavaliable(1);
            //默认按最新排序
            if(StringUtils.isEmpty(queryCourse.getOrder()))
                queryCourse.setOrder("NEW");
            // 搜索课程列表
            List<CourseDto> courseList = courseService.queryWebCourseListPage(queryCourse, page);
            model.addObject("courseList", courseList);
            
            // 查询所有1级专业
            QuerySubject querySubject = new QuerySubject();
            querySubject.setParentId(0);
            List<Subject> subjectList = subjectService.getSubjectList(querySubject);
            
            
            //根据条件专业查询 所有的子专业
            if (ObjectUtils.isNotNull(queryCourse.getSubjectId())) {
                Subject subject = new Subject();
                subject.setSubjectId(queryCourse.getSubjectId());
                subject = subjectService.getSubjectBySubject(subject);
                //查询子专业
                List<Subject> sonSubjectList = null;
                if (subject.getParentId() != 0) {//如果条件为二级专业（根据父级id，查询所有的子级）
                    sonSubjectList = subjectService.getSubjectListByOne(Long.valueOf(subject.getParentId()));
                    model.addObject("subjectParentId", subject.getParentId());//父级id
                } else {//如果条件为一级专业（根据id，查询所有的子级）
                    sonSubjectList = subjectService.getSubjectListByOne(Long.valueOf(subject.getSubjectId()));
                }
                model.addObject("sonSubjectList", sonSubjectList);
            }
            
            // 全部教师
            QueryTeacher query = new QueryTeacher();
            List<Teacher> teacherList =teacherService.queryTeacherList(query);
            
            model.addObject("page",page);
            model.addObject("queryCourse", queryCourse);
            model.addObject("teacherList", teacherList);
            model.addObject("subjectList", subjectList);
        } catch (Exception e) {
        	model.setViewName(this.setExceptionRequest(request, e));
            logger.error("showCourseList()--error", e);
        }
        return model;
    }

    /**
     * 课程详情
     * 不管是课程套餐还是课程目录时都放到list(coursePackageList)中
     */
    @RequestMapping("/couinfo/{id}")
    public ModelAndView couinfo(HttpServletRequest request, @PathVariable("id") int courseId) {
        ModelAndView model = new ModelAndView();
    	try {
    		model.setViewName(couinfo);
            // 查询课程详情
            Course course = courseService.queryCourseById(courseId);
            if(course!=null){
            	model.addObject("course", course);
                //更新课程的浏览量
                courseService.updateCourseCount("pageViewcount",courseId);

            	//查询课程老师
            	List<Map<String,Object>> teacherList = teacherService.queryCourseTeacerList(courseId);
            	model.addObject("teacherList", teacherList);
            	//相关课程
            	List<CourseDto> courseList = courseService.queryInterfixCourseLis(course.getSubjectId(), 5,course.getCourseId());
            	for(CourseDto tempCoursedto : courseList){
            		teacherList=teacherService.queryCourseTeacerList(tempCoursedto.getCourseId());
            		tempCoursedto.setTeacherList(teacherList);
            	}
            	model.addObject("courseList", courseList);
            	String userId = UserUtils.getUser().getId();//SingletonLoginUtils.getLoginUserId(request);
            	if(StringUtils.isNotEmpty(userId)){
            		//查询登用户是否已经收藏
        			boolean isFavorites = courseFavoritesService.checkFavorites(userId, courseId);
        			model.addObject("isFavorites", isFavorites);
            	}
            	//查询课程章节目录
            	List<CourseKpoint> parentKpointList = new ArrayList<CourseKpoint>();//一级 课程章节
            	List<CourseKpoint> kpointList = courseKpointService.queryCourseKpointByCourseId(courseId);
            	if(kpointList!=null && kpointList.size()>0){
            		for(CourseKpoint temp:kpointList){
                		if (temp.getParentId()==0) {
                			parentKpointList.add(temp);
    					}
                	}
            		int freeVideoId=0;
            		for(CourseKpoint tempParent:parentKpointList){
                		for(CourseKpoint temp:kpointList){
                    		if (temp.getParentId()==tempParent.getKpointId()) {
                    			tempParent.getKpointList().add(temp);
        					}
                    		//获取一个可以试听的视频id
                    		if (freeVideoId==0&&temp.getFree()==1&&temp.getKpointType()==1) {
                    			freeVideoId=temp.getKpointId();
                    			model.addObject("freeVideoId",freeVideoId);
							}
                    	}
                	}
                	model.addObject("parentKpointList", parentKpointList);
            	}
            }
            model.addObject("isok", true);
        } catch (Exception e) {
        	model.setViewName(this.setExceptionRequest(request, e));
            logger.error("couinfo()----error", e);
        }
        return model;
    }
    
    /**
     * 添加课程收藏
     */
    @RequestMapping("/createfavorites/{courseId}")
    @ResponseBody
    public Map<String,Object> createFavorites(HttpServletRequest request, @ModelAttribute("courseFavorites") CourseFavorites courseFavorites, @PathVariable("courseId") int courseId){
    	Map<String,Object> json = new HashMap<String,Object>();
    	try{
    		String userId = UserUtils.getUser().getId();
    		if(StringUtils.isEmpty(userId)){
    			json = this.setJson(false, "请登录！", null);
    			return json;
    		}
    		if(courseId<=0){
    			json = this.setJson(false, "请选择要收藏的课程！", null);
    			return json;
    		}
    		boolean is = courseFavoritesService.checkFavorites(userId, courseId);
    		if(is){
    			json = this.setJson(false, "该课程你已经收藏过了！", null);
    			return json;
    		}
    		courseFavorites.setUserId(userId);
    		courseFavorites.setAddTime(new Date());
    		courseFavoritesService.createCourseFavorites(courseFavorites);
    		json = this.setJson(true, "收藏成功", null);
    	}catch (Exception e) {
    		this.setAjaxException(json);
			logger.error("createFavorites()--error",e);
		}
    	return json;
    }


    @Autowired
    private CourseStudyhistoryService courseStudyhistoryService;

    /**
     * 进入播放页面
	 * @param request
	 * @param courseId 课程ID
	 * @return ModelAndView
	 */
    @RequestMapping("/play/{courseId}")
    @RequiresPermissions("user")
    public ModelAndView playVideo(HttpServletRequest request,@PathVariable("courseId") int courseId){
        ModelAndView model = new ModelAndView();
        try{
            model.setViewName(getViewPath("/front/usercenter/player-video"));
            //获取课程
            Course course = courseService.queryCourseById(courseId);
            if(course!=null){
                model.addObject("course", course);
                String userId = UserUtils.getUser().getId();
                //查询是否已经收藏
                boolean isFavorites = courseFavoritesService.checkFavorites(userId, courseId);
                model.addObject("isFavorites", isFavorites);

                //查询课程目录
                List<CourseKpoint> parentKpointList = new ArrayList<CourseKpoint>();
                List<CourseKpoint> kpointList = courseKpointService.queryCourseKpointByCourseId(courseId);
                if(kpointList!=null && kpointList.size()>0){
                    //遍历 一级目录
                    for(CourseKpoint temp:kpointList){
                        if (temp.getParentId()==0) {
                            parentKpointList.add(temp);
                        }
                    }

                    //遍历 获取二级目录
                    for(CourseKpoint tempParent:parentKpointList){
                        for(CourseKpoint temp:kpointList){
                            if (temp.getParentId()==tempParent.getKpointId()) {
                                tempParent.getKpointList().add(temp);
                            }
                        }
                    }
                    model.addObject("parentKpointList", parentKpointList);
                }

                //相关课程
                List<CourseDto> courseList = courseService.queryInterfixCourseLis(course.getSubjectId(), 5,course.getCourseId());
                for(CourseDto tempCoursedto : courseList){
                    List<Map<String,Object>> teacherList=teacherService.queryCourseTeacerList(tempCoursedto.getCourseId());
                    tempCoursedto.setTeacherList(teacherList);
                }
                model.addObject("courseList", courseList);


                CourseStudyhistory courseStudyhistory=new CourseStudyhistory();
                courseStudyhistory.setUserId(userId);
                courseStudyhistory.setCourseId(Long.valueOf(String.valueOf(courseId)));
                //我的课程学习记录
                List<CourseStudyhistory>  couStudyhistorysLearned=courseStudyhistoryService.getCourseStudyhistoryList(courseStudyhistory);
                int courseHistorySize=0;
                if (couStudyhistorysLearned!=null&&couStudyhistorysLearned.size()>0) {
                    courseHistorySize=couStudyhistorysLearned.size();
                    model.addObject("currentKpoint",couStudyhistorysLearned.get(courseHistorySize-1));
                }
                //二级视频节点的 总数
                int sonKpointCount=courseKpointService.getSecondLevelKpointCount(Long.valueOf(courseId));
                NumberFormat numberFormat = NumberFormat.getInstance();
                //我的学习进度百分比
                // 设置精确到小数点后0位
                numberFormat.setMaximumFractionDigits(0);
                String studyPercent = numberFormat.format((float) courseHistorySize / (float) sonKpointCount * 100);
                if(sonKpointCount==0){
                    studyPercent="0";
                }
                course.setStudyPercent(studyPercent);
                model.addObject("isok", true);
            }

        }catch (Exception e) {
            model.setViewName(this.setExceptionRequest(request, e));
            logger.error("playVideo()--error",e);
        }
        return model;
    }

    /**
     * 个人中心-在学课程
     * @param request
     * @return ModelAndView
     */
    @RequestMapping("/myCourses")
    public ModelAndView listMyCourse(HttpServletRequest request,@ModelAttribute("page") PageEntity page,@ModelAttribute("queryCourse") QueryCourse queryCourse){
        ModelAndView model = new ModelAndView();
        try{
            model.setViewName(getViewPath("/front/usercenter/course-mylist"));
            // 页面传来的数据放到page中
            page.setPageSize(12);
            //只查询上架的
            queryCourse.setIsavaliable(1);
            queryCourse.setIsFree("true");//查询免费的课程
            // 搜索课程列表
            List<CourseDto> courseList = courseService.queryWebCourseListPage(queryCourse, page);
            if(courseList!=null&&courseList.size()>0){
                //获取登录用户ID
                String userId = UserUtils.getUser().getId();
                for(Course course:courseList){
                    CourseStudyhistory courseStudyhistory=new CourseStudyhistory();
                    courseStudyhistory.setUserId(userId);
                    courseStudyhistory.setCourseId(Long.valueOf(String.valueOf(course.getCourseId())));
                    //我的课程学习记录
                    List<CourseStudyhistory>  couStudyhistorysLearned=courseStudyhistoryService.getCourseStudyhistoryList(courseStudyhistory);
                    int courseHistorySize=0;
                    if (couStudyhistorysLearned!=null&&couStudyhistorysLearned.size()>0) {
                        courseHistorySize=couStudyhistorysLearned.size();
                    }
                    //二级视频节点的 总数
                    int sonKpointCount=courseKpointService.getSecondLevelKpointCount(Long.valueOf(course.getCourseId()));
                    NumberFormat numberFormat = NumberFormat.getInstance();
                    //我的学习进度百分比
                    // 设置精确到小数点后0位
                    numberFormat.setMaximumFractionDigits(0);
                    String studyPercent = numberFormat.format((float) courseHistorySize / (float) sonKpointCount * 100);
                    if(sonKpointCount==0){
                        studyPercent="0";
                    }
                    course.setStudyPercent(studyPercent);
                }
            }
            model.addObject("courseList", courseList);
            model.addObject("page",page);
        }catch (Exception e) {
            model.setViewName(this.setExceptionRequest(request, e));
            logger.error("ucIndex()--error",e);
        }
        return model;
    }

    /**
     * 删除课程收藏
     * @param request
     * @return
     */
    @RequestMapping("/deleteFaveorite/{ids}")
    @RequiresPermissions("user")
    public ModelAndView deleteFavorite(HttpServletRequest request,@PathVariable("ids") String ids){
        ModelAndView model = new ModelAndView();
        try{
            courseFavoritesService.deleteCourseFavoritesById(ids);
                model.setViewName("redirect:/course/myFavourites");
        }catch (Exception e) {
            model.setViewName(this.setExceptionRequest(request, e));
            logger.error("deleteFavorite()---error",e);
        }
        return model;
    }

    /**
     * 我的收藏列表
     * @param request
     * @return ModelAndView
     */
    @RequestMapping("/myFavourites")
    @RequiresPermissions("user")
    public ModelAndView myFavorites(HttpServletRequest request,@ModelAttribute("page") PageEntity page){
        ModelAndView model = new ModelAndView(getViewPath("/front/usercenter/course-myfavourites"));
        try{
            page.setPageSize(5);
            String userId = UserUtils.getUser().getId();
            List<FavouriteCourseDTO> favoriteList = courseFavoritesService.queryFavoritesPage(userId, page);
            model.addObject("favoriteList", favoriteList);
            model.addObject("page", page);
            request.getSession().setAttribute("favoritesListUri", WebUtils.getServletRequestUriParms(request));
        }catch (Exception e) {
            model.setViewName(this.setExceptionRequest(request, e));
            logger.error("myFavorites()---error",e);
        }
        return model;
    }
}