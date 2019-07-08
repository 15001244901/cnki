/**
 */
package com.hsun.ywork.modules.sys.service;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.DateUtils;
import com.hsun.ywork.modules.sys.dao.LogDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.sys.entity.Log;

/**
 * 日志Service
 * @author GeCoder
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class LogService extends CrudService<LogDao, Log> {

	public Page<Log> findPage(Page<Log> page, Log log) {
		
		// 设置默认时间范围，默认当前月
		if (log.getBeginDate() == null){
			log.setBeginDate(DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1));
		}
		if (log.getEndDate() == null){
			log.setEndDate(DateUtils.addMonths(log.getBeginDate(), 1));
		}
		
		return super.findPage(page, log);
		
	}
	
}
