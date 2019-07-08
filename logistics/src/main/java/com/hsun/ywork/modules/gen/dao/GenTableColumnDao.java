/**
 *
 */
package com.hsun.ywork.modules.gen.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * @author GeCoder
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTableColumnDao extends CrudDao<GenTableColumn> {
	
	public void deleteByGenTableId(String genTableId);
}
