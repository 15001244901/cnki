package com.hsun.ywork.modules.course.web;


import com.hsun.ywork.common.utils.WebUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.entity.*;
import com.hsun.ywork.modules.course.service.CourseService;
import com.hsun.ywork.modules.course.service.CourseTeacherService;
import com.hsun.ywork.modules.course.service.SubjectService;
import com.hsun.ywork.modules.course.service.WebsiteCourseService;
import com.hsun.ywork.modules.course.service.TeacherService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 后台课程管理
 * @author www.inxedu.com
 */
@Controller
@RequestMapping("${adminPath}/course")
public class AdminCourseController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(AdminCourseController.class);
 
	private static final String showCourseList = "/modules/course/course_list";//课程列表
	private static final String toAddCourse = "/modules/course/courseForm";//添加课程
    private static final String showRecommendCourseList = "/modules/course/course_recommend_list";//课程列表(推荐课程)
	private static final String update_course="/modules/course/courseForm";//更新课程

	@Autowired
	private CourseService courseService;
	@Autowired
	private SubjectService subjectService;
    @Autowired
    private CourseTeacherService courseTeacherService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private WebsiteCourseService websiteCourseService;

	// 绑定变量名字和属性，参数封装进类
	@InitBinder("queryCourse")
	public void initBinderQueryCourse(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("queryCourse.");
	}
	@InitBinder("course")
	public void initBinderCourse(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("course.");
	}
	@InitBinder({"page"})
	public void initBinderPage(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	/**
	 * 课程列表展示
	 */
	@RequestMapping("/list")
	public ModelAndView showCourseList(HttpServletRequest request, @ModelAttribute("page") PageEntity page, @ModelAttribute("queryCourse") QueryCourse queryCourse) {
		ModelAndView model = new ModelAndView();
		try {
			page.setPageSize(14);
			model.setViewName(showCourseList);
			//queryCourse.setIsavaliable(1);//上架
			//查询课程
			List<CourseDto> courseList = courseService.queryCourseListPage(queryCourse, page);
			model.addObject("page", page);
			model.addObject("courseList", courseList);
			model.addObject("queryCourse", queryCourse);
			// TODO: 2017-09-12  此处需改为从字典表查询专业列表
			//查询专业
            QuerySubject querySubject = new QuerySubject();
			List<Subject> subjectList = subjectService.getSubjectList(querySubject);
			model.addObject("subjectList", gson.toJson(subjectList));
			//保存 当前请求到session ，下次返回
//			request.getSession().setAttribute("courseListUri", WebUtils.getServletRequestUriParms(request));
		} catch (Exception e) {
			model.setViewName("error/500");
			logger.error("CourseController.showCourseList", e);
		}
		return model;
	}

    /**
     * 到添加课程页面
     */
    @RequestMapping("/toAddCourse")
    public ModelAndView toAddCourse(HttpServletRequest request) {
    	ModelAndView model = new ModelAndView();
        try {
        	model.setViewName(toAddCourse);
            //查询专业
            QuerySubject querySubject = new QuerySubject();
            List<Subject> subjectList = subjectService.getSubjectList(querySubject);
            model.addObject("subjectList", gson.toJson(subjectList));
			Course course = new Course();
			course.setIsavaliable(1);
			model.addObject("course",course);

			//查询所有讲师
			QueryTeacher queryTeacher = new QueryTeacher();
			List<Teacher> allTeachers = teacherService.queryTeacherList(queryTeacher);
			model.addObject("allTeachers",allTeachers);
        } catch (Exception e) {
        	model.setViewName("error/500");
            logger.error("CourseController.toAddCourse", e);
        }
        return model;
    }
    
    /**
     * 添加课程
     * @param request
     * @param course 课程对象
     * @return ModelAndView
     */
    @RequestMapping("/addCourse")
    public ModelAndView addCourse(HttpServletRequest request, @ModelAttribute("course") Course course){
    	ModelAndView model = new ModelAndView();
    	try{
    		model.setViewName("redirect:/a/course/list");
    		course.setAddTime(new Date());
    		course.setUpdateTime(new Date());
    		//course.setIsavaliable(1);//上架
    		courseService.addCourse(course);
    		//添加课程与讲师的关联数据
    		this.addCourseTeacher(request, course);
    	}catch (Exception e) {
			model.setViewName("error/500");
		}
    	return model;
    }

    /**
     * 添加课程与讲师的关联数据
     * @param request
     * @param course 课程
     */
	private void addCourseTeacher(HttpServletRequest request, Course course) {
		//先清除之前的数据，再添加
		courseTeacherService.deleteCourseTeacher(course.getCourseId());
		String teacherIds = course.getTeacherIdArr();
		if(teacherIds!=null && teacherIds.trim().length()>0){
			String[] tcIdArr = teacherIds.split(",");
			StringBuffer val = new StringBuffer();
			for(int i=0;i<tcIdArr.length;i++){
				if(i<tcIdArr.length-1){
					val.append("("+course.getCourseId()+","+tcIdArr[i]+"),");
				}else{
					val.append("("+course.getCourseId()+","+tcIdArr[i]+")");
				}
			}
			courseTeacherService.addCourseTeacher(val.toString());
		}
	}
    
    /**
     * 初始化修改页面
     * @param request
     * @param courseId 课程ID
     * @return ModelAndView
     */
    @RequestMapping("/initUpdate/{courseId}")
    public ModelAndView initUpdatePage(HttpServletRequest request, @PathVariable("courseId") int courseId){
    	ModelAndView model = new ModelAndView();
    	try{
    		model.setViewName(update_course);
    		Course course = courseService.queryCourseById(courseId);
    		model.addObject("course", course);
    		 //查询专业
            QuerySubject querySubject = new QuerySubject();
            List<Subject> subjectList = subjectService.getSubjectList(querySubject);
            model.addObject("subjectList", gson.toJson(subjectList));

			//查询所有讲师
			QueryTeacher queryTeacher = new QueryTeacher();
			List<Teacher> allTeachers = teacherService.queryTeacherList(queryTeacher);
			model.addObject("allTeachers",allTeachers);
            
            //查询课程所属老师
            List<Map<String,Object>> teacherList = teacherService.queryCourseTeacerList(course.getCourseId());
            model.addObject("teacherList", gson.toJson(teacherList));
			String tids = "";
			for(Map<String,Object> map : teacherList) {
				tids += ","+map.get("id").toString();
			}
			tids = tids.replaceFirst(",","");
			course.setTeacherIdArr(tids);
			model.addObject("course", course);

    	}catch (Exception e) {
    		model.setViewName(this.setExceptionRequest(request, e));
			logger.error("initUpdatePage()---error",e);
		}
    	return model;
    }
    
    /**
     * 修改课程
     * @param request
     * @param course 课程数据
     * @return ModelAndView
     */
    @RequestMapping("/updateCourse")
    public ModelAndView updateCourse(HttpServletRequest request, @ModelAttribute("course") Course course){
    	ModelAndView model = new ModelAndView();
    	try{
    		model.setViewName("redirect:/a/course/list");
    		course.setUpdateTime(new Date());
    		courseService.updateCourse(course);
			//获得历史请求 ， 跳转
//    		Object uri = request.getSession().getAttribute("courseListUri");
//    		if(uri!=null){
//    			model.setViewName("redirect:"+uri.toString());
//    		}
    		//修改课程与讲师的关联数
    		this.addCourseTeacher(request, course);
    	}catch (Exception e) {
    		model.setViewName(this.setExceptionRequest(request, e));
			logger.error("updateCourse()--error",e);
		}
    	return model;
    }
    
    /**
     * 删除课程
     * @param courseId 课程ID
     * @param type 1正常（上架） 2删除（下架）
     * @return Map<String,Object>
     */
    @RequestMapping("/avaliable/{courseId}/{type}")
    @ResponseBody
    public Map<String,Object> avaliable(@PathVariable("courseId") int courseId, @PathVariable("type") int type){
    	Map<String,Object> json = new HashMap<String,Object>();
    	try{
    		courseService.updateAvaliableCourse(courseId,type);
    		json = this.setJson(true, null, null);
    	}catch (Exception e) {
			this.setAjaxException(json);
			logger.error("avaliable()--error",e);
		}
    	return json;
    }

    /**
     * 推荐选择课程列表
     * @param request
     * @return ModelAndView
     */
    @RequestMapping("/showrecommendList")
    public ModelAndView showRecommendCourseList(HttpServletRequest request, @ModelAttribute("page") PageEntity page, @ModelAttribute("queryCourse") QueryCourse queryCourse){
    	ModelAndView model = new ModelAndView();
    	try{
    		model.setViewName(showRecommendCourseList);
    		//查询课程
    		//queryCourse.setIsavaliable(1);//上架
			List<CourseDto> courseList = courseService.queryCourseListPage(queryCourse, page);
			model.addObject("page", page);
			model.addObject("courseList", courseList);
			model.addObject("queryCourse", queryCourse);
			//查询专业
            QuerySubject querySubject = new QuerySubject();
			List<Subject> subjectList = subjectService.getSubjectList(querySubject);
			model.addObject("subjectList", gson.toJson(subjectList));
			
			//查询推荐分类
			List<WebsiteCourse> webstieList = websiteCourseService.queryWebsiteCourseList();
			model.addObject("webstieList", webstieList);
    	}catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("showRecommendCourseList()--error",e);
		}
    	return model;
    }
}