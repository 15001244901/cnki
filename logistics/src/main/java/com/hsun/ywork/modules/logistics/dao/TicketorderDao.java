/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.logistics.entity.Ticketorder;

/**
 * 订票订单DAO接口
 * @author 白云飞
 * @version 2018-06-29
 */
@MyBatisDao
public interface TicketorderDao extends CrudDao<Ticketorder> {
	
}