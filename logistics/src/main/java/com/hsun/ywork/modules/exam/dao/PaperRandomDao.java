/**
 *
 */
package com.hsun.ywork.modules.exam.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.exam.entity.PaperRandom;

/**
 * 试卷DAO接口
 * @author GeCoder
 * @version 2017-01-17
 */
@MyBatisDao
public interface PaperRandomDao extends CrudDao<PaperRandom> {
	public PaperRandom getUserRandomPaper(String uid , String pid);

	public int deleteByUidAndPid(String uid , String pid);
}