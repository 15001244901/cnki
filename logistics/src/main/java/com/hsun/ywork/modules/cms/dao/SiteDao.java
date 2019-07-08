/**
 *
 */
package com.hsun.ywork.modules.cms.dao;

import com.hsun.ywork.modules.cms.entity.Site;
import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;

/**
 * 站点DAO接口
 * @author GeCoder
 * @version 2013-8-23
 */
@MyBatisDao
public interface SiteDao extends CrudDao<Site> {

}
