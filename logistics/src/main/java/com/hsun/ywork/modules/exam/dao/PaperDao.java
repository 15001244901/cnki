/**
 *
 */
package com.hsun.ywork.modules.exam.dao;

import com.hsun.ywork.modules.exam.entity.Paper;
import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;

/**
 * 试卷DAO接口
 * @author GeCoder
 * @version 2017-01-17
 */
@MyBatisDao
public interface PaperDao extends CrudDao<Paper> {
	
}