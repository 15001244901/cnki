package com.hsun.ywork.modules.logistics.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.logistics.entity.Gooddatesum;

/**
 * 货物按日期汇总dao接口
 * @author yp
 * 
 *
 */
@MyBatisDao
public interface GooddatesumDao extends CrudDao<Gooddatesum> {

}
