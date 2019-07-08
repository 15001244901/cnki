/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.service;

import java.util.List;

import com.hsun.ywork.modules.exam.dao.QuestionDao;
import com.hsun.ywork.modules.exam.entity.Question;
import com.hsun.ywork.modules.exam.entity.QuestionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.user.entity.UserQuestion;
import com.hsun.ywork.modules.user.dao.UserQuestionDao;

/**
 * 用户试题收藏Service
 * @author GeCoder
 * @version 2017-03-16
 */
@Service
@Transactional(readOnly = true)
public class UserQuestionService extends CrudService<UserQuestionDao, UserQuestion> {

	@Autowired
	private QuestionDao questionDao;

	public UserQuestion get(String id) {
		return super.get(id);
	}
	
	public List<UserQuestion> findList(UserQuestion userQuestion) {
		return super.findList(userQuestion);
	}
	
	public Page<UserQuestion> findPage(Page<UserQuestion> page, UserQuestion userQuestion) {
		return super.findPage(page, userQuestion);
	}
	
	@Transactional(readOnly = false)
	public void save(UserQuestion userQuestion) {
		if(userQuestion.getDtype()==null||userQuestion.getDtype()==1||userQuestion.getDtype()==5) {//收藏记录重复校验
			List<UserQuestion> list = this.dao.findList(userQuestion);
			if (list != null && list.size() > 0)
				return;
		}
		super.save(userQuestion);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserQuestion userQuestion) {
		super.delete(userQuestion);
	}


	public List countPractice(String uid) {
		return dao.countPractice(uid);
	}

	public Question getUserDayQuestion(String uid){
		Question ret = questionDao.getUserDayQuestion(uid);
		return ret;
	}

	@Transactional(readOnly = false)
	public int deleteUserDayQuestion(String uid) {
		return dao.deleteUserDayQuestion(uid);
	}

	public List countQuestionBasket(String uid) {
		return dao.countQuestionBasket(uid);
	}

	@Transactional(readOnly = false)
	public int deleteByUidAndQtype(UserQuestion userQuestion) {
		return dao.deleteByUidAndQtype(userQuestion);
	}

	@Transactional(readOnly = false)
	public int deleteUserQuestion(UserQuestion userQuestion) {
		return dao.deleteUserQuestion(userQuestion);
	}

	public List<Question> findUserNotPracticeList(Question question) {
		return dao.findUserNotPracticeList(question);
	}
}