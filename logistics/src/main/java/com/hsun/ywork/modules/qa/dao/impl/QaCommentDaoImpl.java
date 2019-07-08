package com.hsun.ywork.modules.qa.dao.impl;

import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.qa.dao.QaCommentDao;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.qa.entity.QaComment;

import java.util.List;

/**
 * @author GeCoder
 *
 */
@MyBatisDao
public class QaCommentDaoImpl extends GenericDaoImpl implements QaCommentDao {

	@Override
	public Long addQuestionsComment(QaComment questionsComment) {
		return this.insert("QaCommentMapper.createQuestionsComment", questionsComment);
	}

	@Override
	public Long deleteQuestionsCommentById(Long id) {
		return this.delete("QaCommentMapper.deleteQuestionsCommentById", id);
	}

	@Override
	public QaComment getQuestionsCommentById(Long id) {
		return this.selectOne("QaCommentMapper.getQuestionsCommentById", id);
	}
	
	@Override
	public void updateQuestionsComment(QaComment questionsComment) {
		this.update("QaCommentMapper.updateQuestionsComment", questionsComment);
	}

	@Override
	public List<QaComment> getQuestionsCommentList(QaComment questionsComment) {
		return this.selectList("QaCommentMapper.getQuestionsCommentList", questionsComment);
	}

	@Override
	public List<QaComment> queryQuestionsCommentListByQuestionsId(QaComment questionsComment,
			PageEntity page) {
		return this.queryForListPage("QaCommentMapper.queryQuestionsCommentListByQuestionsId", questionsComment, page);
	}

	@Override
	public Long delQuestionsCommentByQuestionId(Long id) {
		return this.delete("QaCommentMapper.delQuestionsCommentByQuestionId", id);
	}

	@Override
	public List<QaComment> queryQuestionsCommentList(QaComment questionsComment, PageEntity page) {
		return this.queryForListPageCount("QaCommentMapper.queryQuestionsCommentList",questionsComment , page);
	}

	@Override
	public Long delQuestionsCommentByCommentId(Long commentId) {
		return this.delete("QaCommentMapper.delQuestionsCommentByCommentId", commentId);
	}

}
