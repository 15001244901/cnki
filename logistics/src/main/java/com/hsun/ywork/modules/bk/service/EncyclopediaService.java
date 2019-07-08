/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.bk.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.bk.entity.Encyclopedia;
import com.hsun.ywork.modules.bk.dao.EncyclopediaDao;

/**
 * 百科Service
 * @author GeCoder
 * @version 2017-08-10
 */
@Service
@Transactional(readOnly = true)
public class EncyclopediaService extends CrudService<EncyclopediaDao, Encyclopedia> {

	public Encyclopedia get(String id) {
		return super.get(id);
	}
	
	public List<Encyclopedia> findList(Encyclopedia encyclopedia) {
		return super.findList(encyclopedia);
	}
	
	public Page<Encyclopedia> findPage(Page<Encyclopedia> page, Encyclopedia encyclopedia) {
		return super.findPage(page, encyclopedia);
	}
	
	@Transactional(readOnly = false)
	public void save(Encyclopedia encyclopedia) {
		super.save(encyclopedia);
	}
	
	@Transactional(readOnly = false)
	public void delete(Encyclopedia encyclopedia) {
		super.delete(encyclopedia);
	}
	
}