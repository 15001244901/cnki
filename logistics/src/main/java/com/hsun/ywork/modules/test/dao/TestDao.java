/**
 *
 */
package com.hsun.ywork.modules.test.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.test.entity.Test;

/**
 * 测试DAO接口
 * @author GeCoder
 * @version 2013-10-17
 */
@MyBatisDao
public interface TestDao extends CrudDao<Test> {
	
}
