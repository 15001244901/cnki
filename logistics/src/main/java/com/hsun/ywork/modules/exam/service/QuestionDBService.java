/**
 *
 */
package com.hsun.ywork.modules.exam.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.exam.entity.QuestionDB;
import com.hsun.ywork.modules.exam.dao.QuestionDBDao;

/**
 * 题库Service
 * @author GeCoder
 * @version 2017-01-17
 */
@Service
@Transactional(readOnly = true)
public class QuestionDBService extends CrudService<QuestionDBDao, QuestionDB> {

	public QuestionDB get(String id) {
		return super.get(id);
	}
	
	public List<QuestionDB> findList(QuestionDB questionDB) {
		return super.findList(questionDB);
	}
	
	public Page<QuestionDB> findPage(Page<QuestionDB> page, QuestionDB questionDB) {
		return super.findPage(page, questionDB);
	}
	
	@Transactional(readOnly = false)
	public void save(QuestionDB questionDB) {
		super.save(questionDB);
	}
	
	@Transactional(readOnly = false)
	public void delete(QuestionDB questionDB) {
		super.delete(questionDB);
	}
	
}