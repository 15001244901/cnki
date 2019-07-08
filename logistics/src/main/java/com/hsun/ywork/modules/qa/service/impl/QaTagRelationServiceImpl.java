package com.hsun.ywork.modules.qa.service.impl;

import com.hsun.ywork.modules.qa.dao.QaTagRelationDao;
import com.hsun.ywork.modules.qa.entity.QaTagRelation;
import com.hsun.ywork.modules.qa.service.QaTagRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* 问答和 问答标签的 关联表service层接口实现
* @author GeCoder
*/
@Service("qaTagRelationService")
public class QaTagRelationServiceImpl implements QaTagRelationService {

	@Autowired
	private QaTagRelationDao qaTagRelationDao;
	@Override
	public Long addQuestionsTagRelation(QaTagRelation questionsTagRelation) {
		return qaTagRelationDao.addQuestionsTagRelation(questionsTagRelation);
	}

	@Override
	public List<QaTagRelation> queryQuestionsTagRelation(QaTagRelation questionsTagRelation) {
		return qaTagRelationDao.queryQuestionsTagRelation(questionsTagRelation);
	}

}
