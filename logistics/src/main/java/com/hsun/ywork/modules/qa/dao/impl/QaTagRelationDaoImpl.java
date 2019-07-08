package com.hsun.ywork.modules.qa.dao.impl;

import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.qa.dao.QaTagRelationDao;
import com.hsun.ywork.modules.qa.entity.QaTagRelation;

import java.util.List;

/**
 * 问答和 问答标签的 关联表 实现类
 * @author GeCoder
 */
@MyBatisDao
public class QaTagRelationDaoImpl extends GenericDaoImpl implements QaTagRelationDao {

	@Override
	public Long addQuestionsTagRelation(QaTagRelation questionsTagRelation) {
		return this.insert("QaTagRelationMapper.createQuestionsTagRelation", questionsTagRelation);
	}

	@Override
	public List<QaTagRelation> queryQuestionsTagRelation(QaTagRelation questionsTagRelation) {
		return this.selectList("QaTagRelationMapper.queryQuestionsTagRelation", questionsTagRelation);
	}

}
