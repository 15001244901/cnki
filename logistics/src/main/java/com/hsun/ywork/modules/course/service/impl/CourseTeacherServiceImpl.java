package com.hsun.ywork.modules.course.service.impl;

import com.hsun.ywork.modules.course.dao.CourseTeacherDao;
import com.hsun.ywork.modules.course.service.CourseTeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * CourseTeacher管理接口
 * @author GeCoder
 */
@Service("courseTeacherService")
public class CourseTeacherServiceImpl implements CourseTeacherService {

 	@Autowired
    private CourseTeacherDao courseTeacherDao;

	
	public void addCourseTeacher(String value) {
		courseTeacherDao.addCourseTeacher(value);
	}

	
	public void deleteCourseTeacher(int courseId) {
		courseTeacherDao.deleteCourseTeacher(courseId);
	}
}