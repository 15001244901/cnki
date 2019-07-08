/**
 *
 */
package com.hsun.ywork.modules.exam.service;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.exam.dao.PaperUODao;
import com.hsun.ywork.modules.exam.dao.QuestionDBDao;
import com.hsun.ywork.modules.exam.entity.PaperUO;
import com.hsun.ywork.modules.exam.entity.QuestionDB;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 题库Service
 * @author GeCoder
 * @version 2017-01-17
 */
@Service
@Transactional(readOnly = true)
public class PaperUOService extends CrudService<PaperUODao, PaperUO> {

	public PaperUO get(String id) {
		return super.get(id);
	}
	
	public List<PaperUO> findList(PaperUO paperUO) {
		return super.findList(paperUO);
	}
	
	public Page<PaperUO> findPage(Page<PaperUO> page, PaperUO paperUO) {
		return super.findPage(page, paperUO);
	}
	
	@Transactional(readOnly = false)
	public void save(PaperUO paperUO) {
		super.save(paperUO);
	}
	
	@Transactional(readOnly = false)
	public void delete(PaperUO paperUO) {
		super.delete(paperUO);
	}

	public void deleteByPid(String pid) {
		this.dao.deleteByPid(pid);
	}
}