package com.hsun.ywork.modules.qa.service.impl;

import com.hsun.ywork.modules.qa.dao.QaDao;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.qa.entity.Qa;
import com.hsun.ywork.modules.qa.service.QaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * questions服务接口 实现
 *@author GeCoder
 */
@Service("qaService")
public class QaServiceImpl implements QaService {

	@Autowired
	private QaDao qaDao;
	
	@Override
	public Long addQuestions(Qa questions) {
		return qaDao.addQuestions(questions);
	}

	@Override
	public Long deleteQuestionsById(Long id) {
		return qaDao.deleteQuestionsById(id);
	}

	@Override
	public void updateQuestions(Qa questions) {
		qaDao.updateQuestions(questions);
	}

	@Override
	public Qa getQuestionsById(Long id) {
		return qaDao.getQuestionsById(id);
	}

	@Override
	public List<Qa> getQuestionsList(Qa questions, PageEntity page) {
		return qaDao.getQuestionsList(questions, page);
	}

	@Override
	public List<Qa> queryQuestionsOrder(int size) {
		return qaDao.queryQuestionsOrder(size);
	}
	
	@Override
	public int queryAllQuestionsCount() {
		return qaDao.queryAllQuestionsCount();
	}

}
