package com.hsun.ywork.modules.course.service;

import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.entity.QueryTeacher;
import com.hsun.ywork.modules.course.entity.Teacher;

import java.util.List;
import java.util.Map;

/**
 * Teacher管理接口
 * @author GeCoder
 */
public interface TeacherService {
	/**
     * 添加Teacher
     */
    public int addTeacher(Teacher teacher);

	/**
     * 删除讲师
     */
    public void deleteTeacherById(int tcId);

	/**
     * 修改讲师信息
     */
    public void updateTeacher(Teacher teacher);

	/**
     * 通过讲师ID，查询讲师数据
     */
    public Teacher getTeacherById(int tcId);

	/**
     * 分页查询讲师列表
     */
    public List<Teacher> queryTeacherListPage(QueryTeacher query, PageEntity page);

	/**
     * 查询课程讲师列表
     */
    public List<Map<String,Object>> queryCourseTeacerList(int courseId);

	/**
     * 条件查询老师列表
     */
    public List<Teacher> queryTeacherList(QueryTeacher queryTeacher);
}