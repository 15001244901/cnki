package com.hsun.ywork.modules.course.dao.impl;

import com.hsun.ywork.modules.course.dao.CourseDao;
import com.hsun.ywork.modules.course.entity.Course;
import com.hsun.ywork.modules.course.entity.CourseDto;
import com.hsun.ywork.modules.course.entity.QueryCourse;
import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.common.entity.PageEntity;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author GeCoder
 *
 */
@Repository("courseDao")
public class CourseDaoImpl extends GenericDaoImpl implements CourseDao {

	
	public int addCourse(Course course) {
		this.insert("CourseMapper.createCourse", course);
		return course.getCourseId();
	}

	
	public List<CourseDto> queryCourseListPage(QueryCourse query, PageEntity page) {
		return this.queryForListPage("CourseMapper.queryCourseListPage", query, page);
	}

	
	public Course queryCourseById(int courseId) {
		return this.selectOne("CourseMapper.queryCourseById", courseId);
	}

	
	public void updateCourse(Course course) {
		this.update("CourseMapper.updateCourse", course);
	}

	
	public void updateAvaliableCourse(Map<String, Object> map) {
		this.update("CourseMapper.updateAvaliableCourse", map);
	}

	
	public List<CourseDto> queryRecommenCourseList() {
		return this.selectList("CourseMapper.queryRecommenCourseList", null);
	}

	
	public List<CourseDto> queryCourseList(QueryCourse query) {
		return this.selectList("CourseMapper.queryCourseList", query);
	}

	
	public List<CourseDto> queryWebCourseListPage(QueryCourse queryCourse,PageEntity page) {
		return this.queryForListPage("CourseMapper.queryWebCourseListPage", queryCourse, page);
	}

	
	public List<CourseDto> queryInterfixCourseList(Map<String, Object> map) {
		return this.selectList("CourseMapper.queryInterfixCourseList", map);
	}

	
	public List<CourseDto> queryMyCourseList(int userId, PageEntity page) {
		return this.queryForListPage("CourseMapper.queryMyCourseList", userId, page);
	}

	
	public int queryAllCourseCount() {
		return this.selectOne("CourseMapper.queryAllCourseCount", null);
	}

	
	public List<Map<String, Object>> queryMyCourseListByMap(Map<String, Object> map) {
		return this.selectList("CourseMapper.queryMyCourseListByMap", map);
	}


	public List<CourseDto> queryRecommenCourseListByRecommendId(Long recommendId, Long count) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("recommendId", recommendId);
		map.put("count", count);
		return selectList("CourseMapper.queryRecommenCourseListByRecommendId", map);
	}


	public List<CourseDto> queryCourse(QueryCourse queryCourse) {
		return selectList("CourseMapper.queryCourse", queryCourse);
	}

	/**
	 * 更新课程数据（浏览数，购买数）
	 * @param type pageViewcount浏览数 pageBuycount购买数
	 * @param courseId 课程id
	 */
	public void updateCourseCount(String type,int courseId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("type", type);// 类型
		map.put("courseId", courseId);// 课程id
		this.update("CourseMapper.updateCourseCount", map);
	}
	

}
