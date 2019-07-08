package com.hsun.ywork.modules.logistics.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.common.utils.CacheUtils;
import com.hsun.ywork.modules.logistics.dao.GooddatesumDao;
import com.hsun.ywork.modules.logistics.dao.GoodinfoDao;
import com.hsun.ywork.modules.logistics.entity.Goodaddr;
import com.hsun.ywork.modules.logistics.entity.Gooddatesum;
import com.hsun.ywork.modules.logistics.entity.Goodinfo;
import com.hsun.ywork.modules.logistics.utils.LogisticsDicUtils;
/**
 * 货物按日期汇总service
 * @author yp
 *
 */
@Service
@Transactional(readOnly = true)
public class GooddatesumService extends CrudService<GooddatesumDao, Gooddatesum>{
	@Autowired
	private GooddatesumDao goodDateSumDao;
	
	public Gooddatesum get(String id) {
		return super.get(id);
	}
	
	public List<Gooddatesum> findList(Gooddatesum gooddatesum) {
		return super.findList(gooddatesum);
	}
	
	public Page<Gooddatesum> findPage(Page<Gooddatesum> page, Gooddatesum gooddatesum) {
		return super.findPage(page, gooddatesum);
	}
	
	@Transactional(readOnly = false)
	public void save(Gooddatesum gooddatesum) {
		super.save(gooddatesum);
		
	}
	@Transactional(readOnly = false)
	public void delete(Gooddatesum gooddatesum) {
		super.delete(gooddatesum);
	}

	

	/*public Page<Gooddatesum> findPageByFhrq(Page<Gooddatesum> page, Gooddatesum gooddatesum) {
		return super.findPageByFhrq(page, gooddatesum);
	}*/
}
