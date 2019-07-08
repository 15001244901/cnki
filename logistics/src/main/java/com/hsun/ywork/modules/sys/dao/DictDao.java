/**
 *
 */
package com.hsun.ywork.modules.sys.dao;

import java.util.List;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;
import com.hsun.ywork.modules.sys.entity.Dict;

/**
 * 字典DAO接口
 * @author GeCoder
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
}
