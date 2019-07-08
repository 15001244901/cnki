/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/jywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.test.dao;

import com.hsun.ywork.common.persistence.TreeDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.test.entity.TestTree;

/**
 * 树结构生成DAO接口
 * @author GeCoder
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}