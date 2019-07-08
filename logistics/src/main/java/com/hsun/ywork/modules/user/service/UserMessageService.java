/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.user.entity.UserMessage;
import com.hsun.ywork.modules.user.dao.UserMessageDao;

/**
 * 即时消息Service
 * @author GeCoder
 * @version 2017-06-21
 */
@Service
@Transactional(readOnly = true)
public class UserMessageService extends CrudService<UserMessageDao, UserMessage> {

	public UserMessage get(String id) {
		return super.get(id);
	}
	
	public List<UserMessage> findList(UserMessage userMessage) {
		return super.findList(userMessage);
	}

	public List<UserMessage> findAllList(UserMessage userMessage) {
		return dao.findAllList(userMessage);
	}
	
	public Page<UserMessage> findPage(Page<UserMessage> page, UserMessage userMessage) {
		return super.findPage(page, userMessage);
	}
	
	@Transactional(readOnly = false)
	public void save(UserMessage userMessage) {
		super.save(userMessage);
	}

	@Transactional(readOnly = false)
	public void update2Read(Map param) {
		dao.update2Read(param);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserMessage userMessage) {
		super.delete(userMessage);
	}
	
}