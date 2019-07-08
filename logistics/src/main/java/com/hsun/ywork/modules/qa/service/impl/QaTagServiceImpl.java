package com.hsun.ywork.modules.qa.service.impl;

import com.hsun.ywork.modules.qa.dao.QaTagDao;
import com.hsun.ywork.modules.qa.entity.QaTag;
import com.hsun.ywork.modules.qa.service.QaTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 专业service实现
 * @author GeCoder
 */
@Service("qaTagService")
public class QaTagServiceImpl implements QaTagService {

    @Autowired
    private QaTagDao qaTagDao;

	
	public int createQuestionsTag(QaTag questionsTag) {
		return qaTagDao.createQuestionsTag(questionsTag);
	}

	
	public List<QaTag> getQuestionsTagList(QaTag query) {
		return qaTagDao.getQuestionsTagList(query);
	}

	
	public void updateQuestionsTagParentId(int questionsTagId, int parentId) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("questionsTagId", questionsTagId);
		map.put("parentId", parentId);
		qaTagDao.updateQuestionsTagParentId(map);
	}

	
	public void updateQuestionsTag(QaTag questionsTag) {
		qaTagDao.updateQuestionsTag(questionsTag);
	}

	
	public void deleteQuestionsTag(int questionsTagId) {
		qaTagDao.deleteQuestionsTag(questionsTagId);
	}
}
