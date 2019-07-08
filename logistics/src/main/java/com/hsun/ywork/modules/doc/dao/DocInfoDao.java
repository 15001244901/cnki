/**
 *
 */
package com.hsun.ywork.modules.doc.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.doc.entity.DocInfo;

/**
 * 文档维护DAO接口
 * @author GeCoder
 * @version 2016-11-11
 */
@MyBatisDao
public interface DocInfoDao extends CrudDao<DocInfo> {
	
}