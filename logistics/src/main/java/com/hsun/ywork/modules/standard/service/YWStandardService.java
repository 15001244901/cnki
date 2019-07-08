/**
 *
 */
package com.hsun.ywork.modules.standard.service;

import java.util.List;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.modules.standard.dao.YWStandardDao;
import com.hsun.ywork.modules.standard.entity.YWStandard;
import com.hsun.ywork.modules.sys.utils.StandardUtils;
import com.hsun.ywork.common.utils.CacheUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.service.CrudService;

/**
 * 标准管理Service
 * @author GeCoder
 * @version 2016-11-23
 */
@Service
@Transactional(readOnly = true)
public class YWStandardService extends CrudService<YWStandardDao, YWStandard> {

	public YWStandard get(String id) {
		return super.get(id);
	}
	
	public List<YWStandard> findList(YWStandard yWStandard) {
		return super.findList(yWStandard);
	}
	
	public Page<YWStandard> findPage(Page<YWStandard> page, YWStandard yWStandard) {
		return super.findPage(page, yWStandard);
	}
	
	@Transactional(readOnly = false)
	public void save(YWStandard yWStandard) {
		super.save(yWStandard);
		//保存标准后，移除标准缓存
		CacheUtils.remove(StandardUtils.CACHE_STANDARD_MAP);
	}
	
	@Transactional(readOnly = false)
	public void delete(YWStandard yWStandard) {
		super.delete(yWStandard);
	}
	
}