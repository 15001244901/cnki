/**
 *
 */
package com.hsun.ywork.modules.sys.service;

import java.util.ArrayList;
import java.util.List;

import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.sys.entity.Office;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.service.TreeService;
import com.hsun.ywork.modules.sys.dao.OfficeDao;

import static org.apache.shiro.web.filter.mgt.DefaultFilter.user;

/**
 * 机构Service
 * @author GeCoder
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {

	public List<Office> findAll(){
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return UserUtils.getOfficeAllList();
		}else{
			return UserUtils.getOfficeList();
		}
	}
	
	@Transactional(readOnly = true)
	public List<Office> findList(Office office){
		if(office != null){
			if(StringUtils.isNotEmpty(office.getParentIds()))
				office.setParentIds(office.getParentIds()+"%");
			office.getSqlMap().put("dsf", dataScopeFilter(UserUtils.getUser(), "a", null));
			return dao.findByParentIdsLike(office);
		}
		return  new ArrayList<Office>();
	}

	@Transactional(readOnly = true)
	public List<Office> findListNoDsf(Office office){
		if(office != null){
			if(StringUtils.isNotEmpty(office.getParentIds()))
				office.setParentIds(office.getParentIds()+"%");
			return dao.findByParentIdsLikeNoDsf(office);
		}
		return  new ArrayList<Office>();
	}
	
	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

    public Office getByName(Office office) {
    	return dao.getByName(office);
    }
}
