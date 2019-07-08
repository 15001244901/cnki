/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.service;

import java.util.Date;
import java.util.List;

import com.hsun.ywork.common.utils.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.logistics.entity.Goodinfo;
import com.hsun.ywork.modules.logistics.dao.GoodinfoDao;

/**
 * 货物信息Service
 * @author 白云飞
 * @version 2018-04-09
 */
@Service
@Transactional(readOnly = true)
public class GoodinfoService extends CrudService<GoodinfoDao, Goodinfo> {

	public Goodinfo get(String id) {
		return super.get(id);
	}
	
	public List<Goodinfo> findList(Goodinfo goodinfo) {
		return super.findList(goodinfo);
	}
	
	public Page<Goodinfo> findPage(Page<Goodinfo> page, Goodinfo goodinfo) {
		return super.findPage(page, goodinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(Goodinfo goodinfo) {
		// Modify by 白云飞 on 2018-04-23
		// 货单号在手机端录入，不再自动生成
		if(StringUtils.isEmpty(goodinfo.getId())) {
			// 生成货单号
			goodinfo.setGno("HD"+new Date().getTime());
		}
		super.save(goodinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Goodinfo goodinfo) {
		super.delete(goodinfo);
	}

	@Transactional(readOnly = false)
	public void updateStatus(Goodinfo goodinfo) {
		dao.updateStatus(goodinfo);
	}

	@Transactional(readOnly = false)
	public void updateIsread(Goodinfo goodinfo) {
		dao.updateIsread(goodinfo);
	}

    public Goodinfo getByGno(String gno) {
    	return dao.getByGno(gno);
    }
}