package com.hsun.ywork.modules.course.dao.impl;

import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.course.dao.CourseTeacherDao;
import org.springframework.stereotype.Repository;

/**
 * @author GeCoder
 *
 */
@Repository("courseTeacherDao")
public class CourseTeacherDaoImpl extends GenericDaoImpl implements CourseTeacherDao {

	
	public void addCourseTeacher(String value) {
		this.insert("CourseTeacherMapper.createCourseTeacher", value);
		
	}

	
	public void deleteCourseTeacher(int courseId) {
		this.delete("CourseTeacherMapper.deleteCourseTeacher", courseId);
	}

}
