/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.service;

import java.util.List;

import com.hsun.ywork.common.utils.CacheUtils;
import com.hsun.ywork.modules.logistics.utils.LogisticsDicUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.logistics.entity.Goodaddr;
import com.hsun.ywork.modules.logistics.dao.GoodaddrDao;

/**
 * 收货地址管理Service
 * @author 白云飞
 * @version 2018-04-08
 */
@Service
@Transactional(readOnly = true)
public class GoodaddrService extends CrudService<GoodaddrDao, Goodaddr> {

	public Goodaddr get(String id) {
		return super.get(id);
	}
	
	public List<Goodaddr> findList(Goodaddr goodaddr) {
		return super.findList(goodaddr);
	}
	
	public Page<Goodaddr> findPage(Page<Goodaddr> page, Goodaddr goodaddr) {
		return super.findPage(page, goodaddr);
	}
	
	@Transactional(readOnly = false)
	public void save(Goodaddr goodaddr) {
		super.save(goodaddr);
		CacheUtils.remove(LogisticsDicUtils.CACHE_GADDR_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Goodaddr goodaddr) {
		super.delete(goodaddr);
	}
	
}