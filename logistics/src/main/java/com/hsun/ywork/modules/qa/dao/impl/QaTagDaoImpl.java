package com.hsun.ywork.modules.qa.dao.impl;


import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.qa.dao.QaTagDao;
import com.hsun.ywork.modules.qa.entity.QaTag;

import java.util.List;
import java.util.Map;

/**
 * QuestionsTag对象操作实现类
 * @author GeCoder
 */
@MyBatisDao
public class QaTagDaoImpl extends GenericDaoImpl implements QaTagDao {

	
	public int createQuestionsTag(QaTag questionsTag) {
		this.insert("QaTagMapper.createQuestionsTag", questionsTag);
		return questionsTag.getQuestionsTagId();
	}

	
	public List<QaTag> getQuestionsTagList(QaTag query) {
		return this.selectList("QaTagMapper.getQuestionsTagList", query);
	}

	
	public void updateQuestionsTagParentId(Map<String, Object> map) {
		this.update("QaTagMapper.updateQuestionsTagParentId", map);
	}

	
	public void updateQuestionsTag(QaTag questionsTag) {
		this.update("QaTagMapper.updateQuestionsTag", questionsTag);
	}

	
	public void deleteQuestionsTag(int questionsTagId) {
		this.update("QaTagMapper.deleteQuestionsTag", questionsTagId);
	}
	
}
