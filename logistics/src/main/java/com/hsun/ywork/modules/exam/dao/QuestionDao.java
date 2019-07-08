/**
 *
 */
package com.hsun.ywork.modules.exam.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.exam.entity.Question;

import java.util.List;
import java.util.Map;

/**
 * 试题管理DAO接口
 * @author GeCoder
 * @version 2016-12-23
 */
@MyBatisDao
public interface QuestionDao extends CrudDao<Question> {
	public int check(Question question);

	public List<Question> findUserQuestionList(Question question);

	public Question getUserDayQuestion(String uid);

	public List countQuestionNums(Question question);

	public int findMaxNo();
}