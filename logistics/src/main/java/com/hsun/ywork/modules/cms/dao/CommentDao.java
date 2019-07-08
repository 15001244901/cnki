/**
 *
 */
package com.hsun.ywork.modules.cms.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.cms.entity.Comment;

/**
 * 评论DAO接口
 * @author GeCoder
 * @version 2013-8-23
 */
@MyBatisDao
public interface CommentDao extends CrudDao<Comment> {

}
