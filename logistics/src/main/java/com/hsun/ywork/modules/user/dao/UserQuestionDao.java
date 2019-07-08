/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.exam.entity.Question;
import com.hsun.ywork.modules.user.entity.UserQuestion;

import java.util.List;

/**
 * 用户试题收藏DAO接口
 * @author GeCoder
 * @version 2017-03-16
 */
@MyBatisDao
public interface UserQuestionDao extends CrudDao<UserQuestion> {
	public int deleteByUidAndQid(UserQuestion uq);

    public List countPractice(String uid);

    public int deleteUserDayQuestion(String uid);

    public List countQuestionBasket(String uid);

    public int deleteByUidAndQtype(UserQuestion uq);

    public int deleteUserQuestion(UserQuestion uq);

    public int deleteByDtypeAndBizid(UserQuestion uq);

    public List<Question> findUserNotPracticeList(Question question);
}