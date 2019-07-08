/**
 *
 */
package com.hsun.ywork.modules.exam.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.exam.entity.QuestionDB;

/**
 * 题库DAO接口
 * @author GeCoder
 * @version 2017-01-17
 */
@MyBatisDao
public interface QuestionDBDao extends CrudDao<QuestionDB> {
	
}