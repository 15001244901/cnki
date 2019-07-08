package com.hsun.ywork.modules.qa.dao.impl;

import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.qa.dao.QaDao;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.qa.entity.Qa;

import java.util.List;

/**
 * @author GeCoder
 *
 */
@MyBatisDao
public class QaDaoImpl extends GenericDaoImpl implements QaDao {

	@Override
	public Long addQuestions(Qa questions) {
		return this.insert("QaMapper.createQuestions", questions);
	}

	@Override
	public Long deleteQuestionsById(Long id) {
		return this.delete("QaMapper.deleteQuestionsById",id);
	}

	@Override
	public void updateQuestions(Qa questions) {
		this.update("QaMapper.updateQuestions", questions);
	}

	@Override
	public Qa getQuestionsById(Long id) {
		return this.selectOne("QaMapper.getQuestionsById", id);
	}

	@Override
	public List<Qa> getQuestionsList(Qa questions, PageEntity page) {
		return this.queryForListPage("QaMapper.getQuestionsList", questions, page);
	}

	@Override
	public List<Qa> queryQuestionsOrder(int size) {
		return this.selectList("QaMapper.queryQuestionsOrder", size);
	}
	
	@Override
	public int queryAllQuestionsCount() {
		return this.selectOne("QaMapper.queryAllQuestionsCount", null);
	}

}
