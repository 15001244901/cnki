/**
 *
 */
package com.hsun.ywork.modules.sys.dao;

import com.hsun.ywork.common.persistence.TreeDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * @author GeCoder
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
