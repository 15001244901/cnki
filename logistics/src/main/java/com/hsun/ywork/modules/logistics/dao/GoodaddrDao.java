/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.logistics.entity.Goodaddr;

/**
 * 收货地址管理DAO接口
 * @author 白云飞
 * @version 2018-04-08
 */
@MyBatisDao
public interface GoodaddrDao extends CrudDao<Goodaddr> {
	
}