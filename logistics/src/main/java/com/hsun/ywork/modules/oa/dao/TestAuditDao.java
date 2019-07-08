/**
 *
 */
package com.hsun.ywork.modules.oa.dao;

import com.hsun.ywork.common.persistence.CrudDao;
import com.hsun.ywork.modules.oa.entity.TestAudit;
import com.hsun.ywork.common.persistence.annotation.MyBatisDao;

/**
 * 审批DAO接口
 * @author GeCoder
 * @version 2014-05-16
 */
@MyBatisDao
public interface TestAuditDao extends CrudDao<TestAudit> {

	public TestAudit getByProcInsId(String procInsId);
	
	public int updateInsId(TestAudit testAudit);
	
	public int updateHrText(TestAudit testAudit);
	
	public int updateLeadText(TestAudit testAudit);
	
	public int updateMainLeadText(TestAudit testAudit);
	
}
