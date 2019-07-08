/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.service;

import java.util.*;

import com.hsun.ywork.common.utils.CacheUtils;
import com.hsun.ywork.modules.exam.entity.*;
import com.hsun.ywork.modules.exam.service.PaperService;
import com.hsun.ywork.modules.exam.service.QuestionService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.dao.UserQuestionDao;
import com.hsun.ywork.modules.user.entity.UserQuestion;
import com.thoughtworks.xstream.XStream;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.user.entity.UserPractice;
import com.hsun.ywork.modules.user.dao.UserPracticeDao;

import javax.servlet.http.HttpServletRequest;

/**
 * 模拟练习Service
 * @author GeCoder
 * @version 2017-03-15
 */
@Service
@Transactional(readOnly = true)
public class UserPracticeService extends CrudService<UserPracticeDao, UserPractice> {

	@Autowired
	private QuestionService questionService;

	@Autowired
	private UserQuestionDao userQuestionDao;

	@Autowired
	private PaperService paperService;

	public UserPractice get(String id) {
		return super.get(id);
	}
	
	public List<UserPractice> findList(UserPractice userPractice) {
		return super.findList(userPractice);
	}
	
	public Page<UserPractice> findPage(Page<UserPractice> page, UserPractice userPractice) {
		return super.findPage(page, userPractice);
	}
	
	@Transactional(readOnly = false)
	public void save(UserPractice userPractice) {
		super.save(userPractice);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserPractice userPractice) {
		UserQuestion uq = new UserQuestion();
		uq.setDtype(2);
		uq.setBizid(userPractice.getId());
		userQuestionDao.deleteByDtypeAndBizid(uq);
		super.delete(userPractice);
	}

	public Paper buildTestPaper(HttpServletRequest request) {
		XStream xstream = new XStream();
		String uid = UserUtils.getUser().getId();
		String cacheName = "UserTestPaperCache";
		String cacheKey = "UTP" + uid;
		logger.info(String.format("用户创建自测试卷...uid=%s", new Object[]{uid}));
		Paper paper = new Paper();
		int total_score = 0;
		String p_name = request.getParameter("p_name");
		String p_duration = request.getParameter("p_duration");
		paper.setId("0");
		paper.setName(p_name);
		paper.setStatus(1);
		paper.setStarttime((Date)null);
		paper.setEndtime((Date)null);
		paper.setDuration(Integer.parseInt(p_duration));
		paper.setShowtime((Date)null);
		paper.setTotalscore(0);
		paper.setPassscore(0);
		paper.setOrdertype(0);
		paper.setPapertype(2);
		paper.setRemark("");

		String[] p_section_names = request.getParameterValues("p_section_names");
		String[] p_section_remarks = request.getParameterValues("p_section_remarks");
		String[] p_dbids = request.getParameterValues("p_dbids");
		String[] p_subjects = request.getParameterValues("p_subjects");
		String[] p_topics = request.getParameterValues("p_topics");
		String[] p_qtypes = request.getParameterValues("p_qtypes");
		String[] p_qnums = request.getParameterValues("p_qnums");
		String[] p_levels = request.getParameterValues("p_levels");
		String[] p_scores = request.getParameterValues("p_scores");
		String[] p_posts = request.getParameterValues("p_posts");
		if(p_section_names != null && p_section_names.length > 0) {
			for(int i = 0; i < p_section_names.length; ++i) {
				String sectionName = p_section_names[i];
				String sectionRemark = p_section_remarks[i];
				String sectionDBId = null;
				if(p_dbids != null)
					sectionDBId = p_dbids.length==1?p_dbids[0]:null;
				String sectionQtype = p_qtypes == null?null:p_qtypes[i];
				String sectionQnums = p_qnums == null?"0":(StringUtils.isEmpty(p_qnums[i])?"0":p_qnums[i]);
				String sectionQScore = p_scores == null?"0":(StringUtils.isEmpty(p_scores[i])?"0":p_scores[i]);

				String sectionSubject = "" , sectionTopic = "" , sectionPost = "";
				if(p_subjects != null) {
					for(String _subject : p_subjects) {
						sectionSubject += "," + _subject;
					}
					sectionSubject = sectionSubject.replaceFirst(",","");
				}

				if(p_topics != null) {
					for(String _topic : p_topics) {
						sectionTopic += "," + _topic;
					}
					sectionTopic = sectionTopic.replaceFirst(",","");
				}

				if(p_posts != null) {
					for(String _post : p_posts) {
						sectionPost += "," + _post;
					}
					sectionPost = sectionPost.replaceFirst(",","");
				}

				String sectionQlevel = null;
				if(p_levels != null)
					sectionQlevel = p_levels.length==1?p_levels[0]:p_levels[i];

				PaperSection section = new PaperSection(String.valueOf(i), sectionName, sectionRemark);
				section.setRdbid(sectionDBId);
				section.setSubject(sectionSubject);
				section.setTopic(sectionTopic);
				section.setPost(sectionPost);
				section.setRlevel(sectionQlevel);
				section.setRnum(Integer.parseInt(sectionQnums));
				section.setRscore(Integer.parseInt(sectionQScore));
				section.setRtype(sectionQtype);

				List<QuestionVO> questions = questionService.getRandomQuestions(section);

				for(QuestionVO qv : questions){
					total_score += qv.getQScore();
				}

				section.setQuestions(questions);
				paper.addSection(section);
			}

			paper.setTotalscore(total_score);
		}

//		String[] p_section_names = request.getParameterValues("p_section_names");
//		String[] p_section_remarks = request.getParameterValues("p_section_remarks");
//		String[] p_dbids = request.getParameterValues("p_dbids");
//		String[] p_subjects = request.getParameterValues("p_subjects");
//		String[] p_topics = request.getParameterValues("p_topics");
//		String[] p_qtypes = request.getParameterValues("p_qtypes");
//		String[] p_qnums = request.getParameterValues("p_qnums");
//		String[] p_levels = request.getParameterValues("p_levels");
//		String[] p_scores = request.getParameterValues("p_scores");
//		if(p_section_names != null && p_section_remarks != null && p_dbids != null) {
//			for(int i = 0; i < p_section_names.length; ++i) {
//				String section_name = p_section_names[i];
//				String section_remark = p_section_remarks[i];
//				String dbid = p_dbids[i];
//				String subject = p_subjects[i];
//				String topic = p_topics[i];
//				int qnums = Integer.parseInt(p_qnums[i]);
//				int qscore = Integer.parseInt(p_scores[i]);
//				PaperSection section = new PaperSection(String.valueOf(i), section_name, section_remark);
//				section.setRdbid(dbid);
//				section.setSubject(subject);
//				section.setTopic(topic);
//				section.setRtype(p_qtypes[i]);
//				section.setRlevel(p_levels[i]);
//				section.setRnum(qnums);
//				section.setRscore(qscore);
//				List<QuestionVO> questions = questionService.getRandomQuestions(section);
//
//				for(QuestionVO qv : questions){
//					total_score += qv.getQScore();
//				}
//
//				section.setQuestions(questions);
//				paper.addSection(section);
//			}
//
//			paper.setTotalscore(total_score);
//		}

		CacheUtils.put(cacheName, cacheKey, paper);

		paper.setData(xstream.toXML(paper));
		return paper;
	}

	@Transactional(readOnly = false)
	public int saveTestPaper(HttpServletRequest request) {
		String uid = UserUtils.getUser().getId();
		String cacheName = "UserTestPaperCache";
		String cacheKey = "UTP" + uid;
		logger.info(String.format("用户提交自测试卷...uid=%s", new Object[]{uid}));
		Paper paper = (Paper)CacheUtils.get(cacheName, cacheKey);
		if(paper == null) {
			logger.info(String.format("用户提交自测试卷...uid=%s...临时自测试卷丢失", new Object[]{uid}));
			return 0;
		} else {
			HashMap map = new HashMap();
			Map mapx = request.getParameterMap();
			Iterator result = mapx.entrySet().iterator();

			String timecost;
			while(result.hasNext()) {
				Map.Entry json = (Map.Entry)result.next();
				timecost = (String)json.getKey();
				if(timecost.startsWith("Q-")) {
					map.put(timecost, StringUtils.join((Object[])json.getValue(), "`"));
				}
			}

			map.put("pid", "0");
			map.put("uid", uid);
			JSONObject json1 = JSONObject.fromObject(map);
			int dtype = 2;//2代表练习记录

			UserPractice up = new UserPractice();
			up.preInsert();
			PaperCheckResult result1 = this.paperService.doCheckPaper(paper, json1 , dtype,up.getId());
			if(result1 != null && result1.isSuccess()) {
				timecost = StringUtils.isNotEmpty(request.getParameter("t_timecost"))?request.getParameter("t_timecost"):"-1";
				String duration = StringUtils.isNotEmpty(request.getParameter("t_duration"))?request.getParameter("t_duration"):"-1";
				up.setName(paper.getName());
				up.setUid(uid);
				up.setTotalscore(paper.getTotalscore());
				up.setUserscore(result1.getScore());
				up.setPaper(paper.getData());
				up.setAnswer(result1.getUserdata().toString());
				up.setCheck(result1.getResult().toString());
				up.setTimecost(Integer.valueOf(timecost));
				up.setDuration(Integer.valueOf(duration));

				try {
					dao.insert(up);
					return 1;
				} catch (Exception e) {
					logger.error(e.getMessage());
					return 0;
				}
			} else {
				logger.error("随机试卷自动批改发生异常.");
				return 0;
			}
		}
	}

	@Transactional(readOnly = false)
	public Paper copy(String id , String copyname) {
		Paper paper = paperService.getPaper(id);
		paper.setName(copyname);
		paper.setId(null);
		return paper;
	}
}