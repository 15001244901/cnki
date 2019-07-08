package com.hsun.ywork.modules.qa.dao.impl;

import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.qa.dao.PraiseDao;
import com.hsun.ywork.modules.qa.entity.Praise;
import org.springframework.stereotype.Repository;

/**
 * @author GeCoder
 *
 */
@Repository("praiseDao")
public class PraiseDaoImpl extends GenericDaoImpl implements PraiseDao {

	@Override
	public Long addPraise(Praise praise) {
		return this.insert("PraiseMapper.addPraise", praise);
	}

	@Override
	public int queryPraiseCount(Praise praise) {
		return this.selectOne("PraiseMapper.queryPraiseCount", praise);
	}

}
