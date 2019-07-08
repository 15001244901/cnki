/**
 *
 */
package com.hsun.ywork.modules.standard.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.standard.entity.YWStandard;

/**
 * 标准管理DAO接口
 * @author GeCoder
 * @version 2016-11-23
 */
@MyBatisDao
public interface YWStandardDao extends CrudDao<YWStandard> {
	
}