package com.hsun.ywork.modules.qa.dao;

import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.qa.entity.QaComment;

import java.util.List;

/**
 * QaComment管理接口
 * @author GeCoder
 */
public interface QaCommentDao {

    /**
     * 添加QuestionsComment
     * @param questionsComment 要添加的QuestionsComment
     * @return id
     */
    public Long addQuestionsComment(QaComment questionsComment);

    /**
     * 根据id删除一个QuestionsComment
     *
     * @param id 要删除的id
     */
    public Long deleteQuestionsCommentById(Long id);
    
    /**
     * 根据id查询QuestionsComment
     *
     * @param id 要查询的id
     */
    public QaComment getQuestionsCommentById(Long id);

    /**
     * 修改QuestionsComment
     *
     * @param questionsComment 要修改的QuestionsComment
     */
    public void updateQuestionsComment(QaComment questionsComment);

    /**
     * 根据条件获取QuestionsComment列表
     *
     * @param questionsComment 查询条件
     * @return List<QuestionsComment>
     */
    public List<QaComment> getQuestionsCommentList(QaComment questionsComment);

    /**
     * 通过问答id 查询该问答下的回复
     * @return List<QuestionsComment>
     */
    public List<QaComment> queryQuestionsCommentListByQuestionsId(QaComment questionsComment, PageEntity page);
    
    /**
     * 根据问答id删除QuestionsComment
     *
     * @param id 要删除的id
     */
    public Long delQuestionsCommentByQuestionId(Long id);
    
    /**
     * 查询所有的问答
     */
    public List<QaComment> queryQuestionsCommentList(QaComment questionsComment, PageEntity page);
    
    /**
     * 根据问答回复id删除QuestionsComment
     */
    public Long delQuestionsCommentByCommentId(Long commentId);
}