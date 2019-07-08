package com.hsun.ywork.modules.course.service.impl;

import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.dao.TeacherDao;
import com.hsun.ywork.modules.course.entity.QueryTeacher;
import com.hsun.ywork.modules.course.entity.Teacher;
import com.hsun.ywork.modules.course.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Teacher管理接口
 * @author GeCoder
 */
@Service("teacherService")
public class TeacherServiceImpl implements TeacherService {
	@Autowired
	private TeacherDao teacherDao;

	public int addTeacher(Teacher teacher) {
		return teacherDao.addTeacher(teacher);
	}

	public void deleteTeacherById(int tcId) {
		teacherDao.deleteTeacherById(tcId);
	}

	public void updateTeacher(Teacher teacher) {
		teacherDao.updateTeacher(teacher);
	}

	public Teacher getTeacherById(int tcId) {
		return teacherDao.getTeacherById(tcId);
	}

	public List<Teacher> queryTeacherListPage(QueryTeacher query, PageEntity page) {
		return teacherDao.queryTeacherListPage(query, page);
	}

	public List<Map<String, Object>> queryCourseTeacerList(int courseId) {
		return teacherDao.queryCourseTeacerList(courseId);
	}

	public List<Teacher> queryTeacherList(QueryTeacher queryTeacher) {
		return teacherDao.queryTeacherList(queryTeacher);
	}
}