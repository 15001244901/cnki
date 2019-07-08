/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.logistics.entity.Ticketorder;
import com.hsun.ywork.modules.logistics.dao.TicketorderDao;

/**
 * 订票订单Service
 * @author 白云飞
 * @version 2018-06-29
 */
@Service
@Transactional(readOnly = true)
public class TicketorderService extends CrudService<TicketorderDao, Ticketorder> {

	public Ticketorder get(String id) {
		return super.get(id);
	}
	
	public List<Ticketorder> findList(Ticketorder ticketorder) {
		return super.findList(ticketorder);
	}
	
	public Page<Ticketorder> findPage(Page<Ticketorder> page, Ticketorder ticketorder) {
		return super.findPage(page, ticketorder);
	}
	
	@Transactional(readOnly = false)
	public void save(Ticketorder ticketorder) {
		super.save(ticketorder);
	}
	
	@Transactional(readOnly = false)
	public void delete(Ticketorder ticketorder) {
		super.delete(ticketorder);
	}
	
}