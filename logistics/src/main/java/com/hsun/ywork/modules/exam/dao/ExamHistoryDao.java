/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.exam.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.exam.entity.ExamHistory;

import java.util.List;

/**
 * 考生考试记录DAO接口
 * @author GeCoder
 * @version 2017-02-14
 */
@MyBatisDao
public interface ExamHistoryDao extends CrudDao<ExamHistory> {

    /**
     * 获取试卷批改进度
     * @param pid
     * @return
     */
    public List<ExamHistory> getPaperCheckProgress(String pid);

    /**
     * 删除试卷下所有考试记录
     * @param pid
     * @return
     */
    public int deleteAllByPid(String pid);

    public int batchUpdate(List<ExamHistory> ehList);

    /**
     * 获取用户所有考试记录
     * @param examHistory 参数中隐含用户id
     * @return 用户考试记录列表
     */
    public List<ExamHistory> findUserHistoryList(ExamHistory examHistory);
}