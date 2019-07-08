/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.exam.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.hsun.ywork.modules.exam.dao.PaperRandomDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.exam.entity.ExamHistory;
import com.hsun.ywork.modules.exam.dao.ExamHistoryDao;

import static oracle.net.aso.C05.e;
import static org.activiti.engine.impl.util.json.XMLTokener.entity;

/**
 * 考生考试记录Service
 * @author GeCoder
 * @version 2017-02-14
 */
@Service
@Transactional(readOnly = true)
public class ExamHistoryService extends CrudService<ExamHistoryDao, ExamHistory> {

	@Autowired
	private PaperRandomDao paperRandomDao;

	public ExamHistory get(String id) {
		return super.get(id);
	}
	
	public List<ExamHistory> findList(ExamHistory examHistory) {
		return super.findList(examHistory);
	}
	
	public Page<ExamHistory> findPage(Page<ExamHistory> page, ExamHistory examHistory) {
		return super.findPage(page, examHistory);
	}
	
	@Transactional(readOnly = false)
	public void save(ExamHistory examHistory) {
		super.save(examHistory);
	}
	
	@Transactional(readOnly = false)
	public void delete(ExamHistory eh) {
		super.delete(eh);
		// 如果试卷类型为随机试卷则级联删除随机试卷配置表信息
		paperRandomDao.deleteByUidAndPid(eh.getUid(),eh.getPid());
	}

	public Map<String, Object> getPaperCheckProgress(String pid) {
		try {
			HashMap map = new HashMap();
			map.put("testing", Integer.valueOf(0));
			map.put("wait", Integer.valueOf(0));
			map.put("checked", Integer.valueOf(0));
			List<ExamHistory> list = this.dao.getPaperCheckProgress(pid);
			for(ExamHistory eh : list){
				if("0".equals(eh.getStatus())){
					eh.setStatus("testing");
				} else if("1".equals(eh.getStatus())){
					eh.setStatus("wait");
				} else if("2".equals(eh.getStatus())){
					eh.setStatus("checked");
				}
				map.put(eh.getStatus(),eh.getChecknums());
			}
			return map;
		} catch (Exception e) {
			logger.error(e.getMessage());
			return null;
		}
	}

	@Transactional(readOnly = false)
	public void deleteAllByPid(String pid){
		this.dao.deleteAllByPid(pid);
	}

	@Transactional(readOnly = false)
	public void checkOneQuestion(String eid, String qid, int score) {
		try {
			ExamHistory e = this.get(eid);
			if(e == null) {
				return;
			} else {
				int total = 0;
				String e_check = e.getChecks();
				JSONObject json = JSONObject.parseObject(e_check);
				json.put(qid, Integer.valueOf(score));

				int val;
				for(Iterator it = json.keySet().iterator(); it.hasNext(); total += val) {
					Object ky = it.next();
					String key = String.valueOf(ky);
					val = json.getInteger(key);
				}

				e.setScore(""+total);
				e.setChecks(json.toJSONString());
				this.save(e);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			return;
		}
	}

	/**
	 * 分页获取用户考试记录列表
	 * @param page
	 * @param examHistory
	 * @return
	 */
	public Page<ExamHistory> findUserHistoryPage(Page<ExamHistory> page, ExamHistory examHistory) {
		examHistory.setPage(page);
		page.setList(dao.findUserHistoryList(examHistory));
		return page;
	}
}