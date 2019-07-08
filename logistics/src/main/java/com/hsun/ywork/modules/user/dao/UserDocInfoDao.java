/**
 *
 */
package com.hsun.ywork.modules.user.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.doc.entity.DocInfo;
import com.hsun.ywork.modules.user.entity.UserDocInfo;

/**
 * 用户文档收藏DAO接口
 * @author GeCoder
 * @version 2016-11-11
 */
@MyBatisDao
public interface UserDocInfoDao extends CrudDao<UserDocInfo> {
	public UserDocInfo findByUidAndDid(String uid , String did);
}