package com.hsun.ywork.modules.qa.service;

import com.hsun.ywork.modules.qa.entity.Praise;

/**
 * 点赞服务接口
 *@author GeCoder
 */
public interface PraiseService {
	/**
	 * 添加点赞记录
	 */
	public Long addPraise(Praise praise);
	
	/**
	 * 根据条件查询点赞数
	 */
	public int queryPraiseCount(Praise praise);
}
