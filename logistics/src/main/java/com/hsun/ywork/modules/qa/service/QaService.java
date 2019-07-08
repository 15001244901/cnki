package com.hsun.ywork.modules.qa.service;

import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.qa.entity.Qa;

import java.util.List;

/**
 * questions服务接口
 * @author GeCoder
 */
public interface QaService {

    /**
     * 添加Questions
     *
     * @param questions 要添加的Questions
     * @return id
     */
    public Long addQuestions(Qa questions);

    /**
     * 根据id删除一个Questions
     *
     * @param id 要删除的id
     */
    public Long deleteQuestionsById(Long id);

    /**
     * 修改Questions
     *
     * @param questions 要修改的Questions
     */
    public void updateQuestions(Qa questions);

    /**
     * 根据id获取单个Questions对象
     *
     * @param id 要查询的id
     * @return Questions
     */
    public Qa getQuestionsById(Long id);

    /**
     * 根据条件获取Questions列表
     *
     * @param questions 查询条件
     * @param page       分页参数
     * @return List<Questions>
     */
    public List<Qa> getQuestionsList(Qa questions, PageEntity page);

    /**
     * 最新排行
     *
     * @param size 传入显示的条数
     * @return List<Questions>
     */
    public List<Qa> queryQuestionsOrder(int size);
    
    /**
     * 所有问答数
     * @return
     */
    public int queryAllQuestionsCount();
}