/**
 *
 */
package com.hsun.ywork.modules.sys.dao;

import com.hsun.ywork.common.persistence.TreeDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.sys.entity.Office;

import java.util.List;

/**
 * 机构DAO接口
 * @author GeCoder
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {
	public List<Office> findByParentIdsLikeNoDsf(Office office);

    Office getByName(Office office);
}
