/**
 *
 */
package com.hsun.ywork.modules.gen.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.gen.entity.GenTemplate;

/**
 * 代码模板DAO接口
 * @author GeCoder
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTemplateDao extends CrudDao<GenTemplate> {
	
}
