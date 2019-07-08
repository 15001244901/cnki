/**
 *
 */
package com.hsun.ywork.modules.sys.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.sys.entity.Log;

/**
 * 日志DAO接口
 * @author GeCoder
 * @version 2014-05-16
 */
@MyBatisDao
public interface LogDao extends CrudDao<Log> {

}
