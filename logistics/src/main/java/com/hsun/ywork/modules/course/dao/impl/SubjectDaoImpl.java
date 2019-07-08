package com.hsun.ywork.modules.course.dao.impl;

import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.course.dao.SubjectDao;
import com.hsun.ywork.modules.course.entity.QuerySubject;
import com.hsun.ywork.modules.course.entity.Subject;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Subject对象操作实现类
 * @author GeCoder
 */
@Repository("subjectDao")
public class SubjectDaoImpl extends GenericDaoImpl implements SubjectDao {

	public int createSubject(Subject subject) {
		this.insert("SubjectMapper.createSubject", subject);
		return subject.getSubjectId();
	}

	public List<Subject> getSubjectList(QuerySubject query) {
		return this.selectList("SubjectMapper.getSubjectList", query);
	}

	public void updateSubjectParentId(Map<String, Object> map) {
		this.update("SubjectMapper.updateSubjectParentId", map);
	}

	public void updateSubject(Subject subject) {
		this.update("SubjectMapper.updateSubject", subject);
	}
	/**
	 * 修改排序
	 */
	public void updateSubjectSort(Subject subject){
		this.update("SubjectMapper.updateSubjectSort", subject);
	}
	public void deleteSubject(int subjectId) {
		this.update("SubjectMapper.deleteSubject", subjectId);
	}

	@Override
	public Subject getSubjectBySubject(Subject subject) {
		return this.selectOne("SubjectMapper.getSubjectBySubject", subject);
	}

	@Override
	public List<Subject> getSubjectListByOne(Long subjectId) {
		return this.selectList("SubjectMapper.getSubjectListByOne", subjectId);
	}

}
