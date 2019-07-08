/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/jywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.test.dao;

import com.hsun.ywork.test.entity.TestDataMain;
import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;

/**
 * 主子表生成DAO接口
 * @author GeCoder
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestDataMainDao extends CrudDao<TestDataMain> {
	
}