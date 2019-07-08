package com.hsun.ywork.modules.qa.service;

import com.hsun.ywork.modules.qa.entity.QaTag;

import java.util.List;


/**
 * 专业接口
 * @author GeCoder
 */
public interface QaTagService {
	/**
	 * 创建专业
	 * @param questionsTag
	 * @return 返回专业ID
	 */
	public int createQuestionsTag(QaTag questionsTag);
	
	/**
	 * 查询专业列表
	 * @return List<QuestionsTag>
	 */
	public List<QaTag> getQuestionsTagList(QaTag query);
	
	/**
	 * 修改专业父ID
	 * @param questionsTagId 专业ID
	 * @param parentId 专业父ID
	 */
	public void updateQuestionsTagParentId(int questionsTagId, int parentId);
	
	/**
	 * 修改专业
	 * @param questionsTag
	 */
	public void updateQuestionsTag(QaTag questionsTag);
	
	/**
	 * 删除专业 
	 * @param questionsTagId 要删除的专业ID
	 */
	public void deleteQuestionsTag(int questionsTagId);
}
