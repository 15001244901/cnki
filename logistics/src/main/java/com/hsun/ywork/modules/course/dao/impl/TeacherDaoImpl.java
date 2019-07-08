package com.hsun.ywork.modules.course.dao.impl;

import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.dao.TeacherDao;
import com.hsun.ywork.modules.course.entity.QueryTeacher;
import com.hsun.ywork.modules.course.entity.Teacher;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 教师dao层
 * @author GeCoder
 */
@Repository("teacherDao")
public class TeacherDaoImpl extends GenericDaoImpl implements TeacherDao {

	
	public int addTeacher(Teacher teacher) {
		this.insert("TeacherMapper.createTeacher", teacher);
		return teacher.getId();
	}

	
	public void deleteTeacherById(int tcId) {
		this.update("TeacherMapper.deleteTeacherById", tcId);
	}

	
	public void updateTeacher(Teacher teacher) {
		this.update("TeacherMapper.updateTeacher", teacher);
		
	}

	
	public Teacher getTeacherById(int tcId) {
		return this.selectOne("TeacherMapper.getTeacherById", tcId);
	}

	
	public List<Teacher> queryTeacherListPage(QueryTeacher query, PageEntity page) {
		return this.queryForListPageCount("TeacherMapper.queryTeacherListPage", query, page);
	}

	
	public List<Map<String, Object>> queryCourseTeacerList(int courseId) {
		return this.selectList("TeacherMapper.queryCourseTeacerList", courseId);
	}

	
	public List<Teacher> queryTeacherList(QueryTeacher queryTeacher) {
		return this.selectList("TeacherMapper.queryTeacherList", queryTeacher);
	}
}
