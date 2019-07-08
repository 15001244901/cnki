/**
 *
 */
package com.hsun.ywork.modules.cms.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.cms.entity.Guestbook;

/**
 * 留言DAO接口
 * @author GeCoder
 * @version 2013-8-23
 */
@MyBatisDao
public interface GuestbookDao extends CrudDao<Guestbook> {

}
