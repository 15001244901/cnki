/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.logistics.entity.Ticketposition;
import com.hsun.ywork.modules.logistics.dao.TicketpositionDao;

/**
 * 订票铺位Service
 * @author 白云飞
 * @version 2018-06-29
 */
@Service
@Transactional(readOnly = true)
public class TicketpositionService extends CrudService<TicketpositionDao, Ticketposition> {

	public Ticketposition get(String id) {
		return super.get(id);
	}
	
	public List<Ticketposition> findList(Ticketposition ticketposition) {
		return super.findList(ticketposition);
	}
	
	public Page<Ticketposition> findPage(Page<Ticketposition> page, Ticketposition ticketposition) {
		return super.findPage(page, ticketposition);
	}
	
	@Transactional(readOnly = false)
	public void save(Ticketposition ticketposition) {
		super.save(ticketposition);
	}
	
	@Transactional(readOnly = false)
	public void delete(Ticketposition ticketposition) {
		super.delete(ticketposition);
	}
	
}