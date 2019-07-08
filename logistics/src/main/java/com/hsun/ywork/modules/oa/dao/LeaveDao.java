/**
 */
package com.hsun.ywork.modules.oa.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.modules.oa.entity.Leave;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;

/**
 * 请假DAO接口
 * @author GeCoder
 * @version 2013-8-23
 */
@MyBatisDao
public interface LeaveDao extends CrudDao<Leave> {
	
	/**
	 * 更新流程实例ID
	 * @param leave
	 * @return
	 */
	public int updateProcessInstanceId(Leave leave);
	
	/**
	 * 更新实际开始结束时间
	 * @param leave
	 * @return
	 */
	public int updateRealityTime(Leave leave);
	
}
