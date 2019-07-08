package com.hsun.ywork.modules.qa.dao;

import com.hsun.ywork.modules.qa.entity.Praise;

/**
 * 点赞管理接口
 *@author GeCoder
 */
public interface PraiseDao {
	/**
	 * 添加点赞记录
	 */
	public Long addPraise(Praise praise);
	
	/**
	 * 根据条件查询点赞数
	 */
	public int queryPraiseCount(Praise praise);
}
