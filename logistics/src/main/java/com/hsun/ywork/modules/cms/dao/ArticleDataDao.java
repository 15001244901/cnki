/**
 *
 */
package com.hsun.ywork.modules.cms.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.cms.entity.ArticleData;

/**
 * 文章DAO接口
 * @author GeCoder
 * @version 2013-8-23
 */
@MyBatisDao
public interface ArticleDataDao extends CrudDao<ArticleData> {
	
}
