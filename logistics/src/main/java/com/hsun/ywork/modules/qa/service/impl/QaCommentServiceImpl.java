package com.hsun.ywork.modules.qa.service.impl;

import com.hsun.ywork.modules.qa.dao.QaCommentDao;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.qa.entity.QaComment;
import com.hsun.ywork.modules.qa.service.QaCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author GeCoder
 *
 */
@Service("qaCommentService")
public class QaCommentServiceImpl implements QaCommentService {

	@Autowired
	private QaCommentDao qaCommentDao;
	
	@Override
	public Long addQuestionsComment(QaComment questionsComment) {
		return qaCommentDao.addQuestionsComment(questionsComment);
		
	}

	@Override
	public Long deleteQuestionsCommentById(Long id) {
		return qaCommentDao.deleteQuestionsCommentById(id);
	}
	
	@Override
	public QaComment getQuestionsCommentById(Long id) {
		return qaCommentDao.getQuestionsCommentById(id);
	}

	@Override
	public void updateQuestionsComment(QaComment questionsComment) {
		qaCommentDao.updateQuestionsComment(questionsComment);
	}

	@Override
	public List<QaComment> getQuestionsCommentList(QaComment questionsComment) {
		return qaCommentDao.getQuestionsCommentList(questionsComment);
	}

	@Override
	public List<QaComment> queryQuestionsCommentListByQuestionsId(QaComment questionsComment,
			PageEntity page) {
		return qaCommentDao.queryQuestionsCommentListByQuestionsId(questionsComment,page);
	}

	@Override
	public Long delQuestionsCommentByQuestionId(Long id) {
		return qaCommentDao.delQuestionsCommentByQuestionId(id);
	}

	@Override
	public List<QaComment> queryQuestionsCommentList(QaComment questionsComment, PageEntity page) {
		return qaCommentDao.queryQuestionsCommentList(questionsComment,page);
	}

	@Override
	public Long delQuestionsCommentByCommentId(Long commentId) {
		return qaCommentDao.delQuestionsCommentByCommentId(commentId);
	}

}
