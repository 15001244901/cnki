package com.hsun.ywork.modules.qa.dao;

import com.hsun.ywork.modules.qa.entity.QaTagRelation;

import java.util.List;

/**
 * 问答和 问答标签的 关联表dao层接口
 * @author GeCoder
 */
public interface QaTagRelationDao {
	/**
	 * 添加
	 * @param questionsTagRelation
	 * @return
	 */
	public Long addQuestionsTagRelation(QaTagRelation questionsTagRelation);
	
	/**
	 * 查询
	 */
	public List<QaTagRelation> queryQuestionsTagRelation(QaTagRelation questionsTagRelation);
}
