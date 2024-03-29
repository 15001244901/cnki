package com.hsun.ywork.modules.course.web;
import com.hsun.ywork.common.utils.EhCacheUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.course.entity.CourseStudyhistory;
import com.hsun.ywork.modules.course.service.CourseStudyhistoryService;
import com.hsun.ywork.modules.qa.utils.SingletonLoginUtils;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CourseStudyhistory 用户课程学习记录 Controller
 * @author GeCoder
 */
@Controller
@RequestMapping("/course")
public class CourseStudyhistoryController extends BaseController {

 	@Autowired
    private CourseStudyhistoryService courseStudyhistoryService;

    private Logger logger = LoggerFactory.getLogger(CourseStudyhistoryController.class);

 	/**
	 * 添加播放次数 ,播放记录
	 * @return
	 */
	@RequestMapping("/couserStudyHistory/ajax/playertimes")
	@ResponseBody
	public Object addCoursePlayerTime(HttpServletRequest request, @ModelAttribute("courseId") Long courseId,
                                      @ModelAttribute("kpointId") Long kpointId) {
		Map<String,Object> json = new HashMap<String,Object>();
		// 要更新3个表 edu_course_profile,edu_course_studyhistory,edu_course_kpoint
		try {
			CourseStudyhistory courseStudyhistory = new CourseStudyhistory();
			courseStudyhistory.setCourseId(courseId);
			courseStudyhistory.setKpointId(kpointId);
			courseStudyhistory.setUserId(UserUtils.getUser().getId());
			courseStudyhistoryService.playertimes(courseStudyhistory);
			json = this.setJson(true, "", null);
		} catch (Exception e) {
			logger.error("CourseStudyhistoryController.addCoursePlayerTime()",e);
			return setExceptionRequest(request, e);
		}
		return json;
	}
 	
	/**
	 * 学过此课程的用户
	 * @return
	 */
	@RequestMapping("/couserStudyHistory/ajax/courseLearnedUser/{courseId}")
	@ResponseBody
	public Object getCourseLearnedUser(HttpServletRequest request, @PathVariable("courseId") Long courseId) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			//从缓存中获取
			//学习此课程的总人数
			Long couStudyhistorysLearnedCount=(Long) EhCacheUtils.get("COURSE_LEARNED_USER_COUNT_"+courseId);
			//学习此课程的人 (最新8个)
			List<CourseStudyhistory> couStudyhistorysLearned=(List<CourseStudyhistory>)EhCacheUtils.get("COURSE_LEARNED_USER_"+courseId);
			if(couStudyhistorysLearned==null||couStudyhistorysLearned.size()==0){
				couStudyhistorysLearned=courseStudyhistoryService.getCourseStudyhistoryListByCouId(Long.valueOf(String.valueOf(courseId)));
				EhCacheUtils.set("COURSE_LEARNED_USER_"+courseId, couStudyhistorysLearned,3600);//缓存一小时
				
				couStudyhistorysLearnedCount=Long.valueOf(courseStudyhistoryService.getCourseStudyhistoryCountByCouId(courseId));
				EhCacheUtils.set("COURSE_LEARNED_USER_COUNT_"+courseId, couStudyhistorysLearnedCount,3600);//缓存一小时
			}
			json = this.setJson(true, String.valueOf(couStudyhistorysLearnedCount), couStudyhistorysLearned);
		} catch (Exception e) {
			logger.error("CourseStudyhistoryController.getCourseLearnedUser()",e);
			json = this.setJson(false, "","");
		}
		return json;
	}
}