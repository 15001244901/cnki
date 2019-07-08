/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.bk.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.bk.entity.Encyclopedia;

/**
 * 百科DAO接口
 * @author GeCoder
 * @version 2017-08-10
 */
@MyBatisDao
public interface EncyclopediaDao extends CrudDao<Encyclopedia> {
	
}