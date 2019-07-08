/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.user.entity.UserPractice;

/**
 * 模拟练习DAO接口
 * @author GeCoder
 * @version 2017-03-15
 */
@MyBatisDao
public interface UserPracticeDao extends CrudDao<UserPractice> {
	
}