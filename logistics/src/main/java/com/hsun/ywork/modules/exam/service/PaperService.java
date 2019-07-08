/**
 *
 */
package com.hsun.ywork.modules.exam.service;

import java.util.*;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.*;
import com.hsun.ywork.modules.exam.dao.ExamHistoryDao;
import com.hsun.ywork.modules.exam.dao.PaperDao;
import com.hsun.ywork.modules.exam.dao.PaperRandomDao;
import com.hsun.ywork.modules.exam.entity.*;
import com.hsun.ywork.modules.user.entity.UserQuestion;
import com.hsun.ywork.modules.user.service.UserQuestionService;
import com.thoughtworks.xstream.XStream;
import net.sf.json.JSONObject;
import org.apache.poi.openxml4j.opc.internal.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.service.CrudService;

import javax.servlet.http.HttpServletRequest;

import static com.sun.tools.doclint.Entity.sup;
import static oracle.net.aso.C01.x;
import static oracle.net.aso.C05.e;
import static org.activiti.engine.impl.util.json.XMLTokener.entity;

/**
 * 试卷Service
 * @author GeCoder
 * @version 2017-01-17
 */
@Service
@Transactional(readOnly = true)
public class PaperService extends CrudService<PaperDao, Paper> {

	@Autowired
	private QuestionService questionService;

	@Autowired
	private PaperRandomDao paperRandomDao;

	@Autowired
	private ExamHistoryDao examHistoryDao;

	@Autowired
	private ExamHistoryService examHistoryService;

	@Autowired
	private PaperUOService paperUOService;

	@Autowired
	private UserQuestionService userQuestionService;

	public Paper get(String id) {
		Paper paper = super.get(id);
		if(paper==null)
			return null;
        //试卷分类为成套试卷的，不设置具体考试部门
        if(paper.getCategory() == 2)
            return paper;
		PaperUO puo = new PaperUO();
		puo.setPid(id);
		List<PaperUO> list = paperUOService.findList(puo);
//		List<String> offices = new ArrayList<String>();
//		for(PaperUO o : list){
//			offices.add(o.getOuid());
//		}
//		paper.setDepartments(offices);

		//发起考试：将部门关系变更为人员关系
		List<String> users = new ArrayList<String>();
		for(PaperUO o : list){
			users.add(o.getOuid());
		}
		paper.setUsers(users);
		return paper;
	}
	
	public List<Paper> findList(Paper paper) {
		return super.findList(paper);
	}
	
	public Page<Paper> findPage(Page<Paper> page, Paper paper) {
		return super.findPage(page, paper);
	}
	
	@Transactional(readOnly = false)
	public void save(Paper paper) {

		XStream xStream = new XStream();
		xStream.autodetectAnnotations(true);//剔除被注解标记为不转换的字段
		if (paper.getIsNewRecord()){
			paper.preInsert();
			paper.setData(xStream.toXML(paper));
			dao.insert(paper);
		}else{
			paper.preUpdate();
			Paper _paper = this.getPaper(paper.getId());
			paper.setSections(_paper.getSections());
			paper.setData(xStream.toXML(paper));
			dao.update(paper);
		}

		if(StringUtils.isNotEmpty(paper.getId()))
			CacheUtils.remove("PaperCache", "P" + paper.getId());

		//类型不是成套试卷的存储试卷考试部门人员关系表数据
        if(paper.getCategory() != 2){
            paperUOService.deleteByPid(paper.getId());

//			if(paper.getDepartments()!=null) {
//				for (String ouid : paper.getDepartments()) {
//					PaperUO puo = new PaperUO();
//					puo.setPid(paper.getId());
//					puo.setOuid(ouid);
//					puo.setLtype(1);//指定部门
//					paperUOService.save(puo);
//				}
//			}
			if(paper.getUsers()!=null) {
				//为保证数据一致性，线下卷需先清理所有考试结果
				if(paper.getIsoffline()!=null&&paper.getIsoffline() == 1)
					examHistoryDao.deleteAllByPid(paper.getId());
				for (String ouid : paper.getUsers()) {
					PaperUO puo = new PaperUO();
					puo.setPid(paper.getId());
					puo.setOuid(ouid);
					puo.setLtype(2);//指定人员
					paperUOService.save(puo);

					if(paper.getIsoffline()!=null&&paper.getIsoffline() == 1) {
						//线下卷直接将空的考试记录写入到考试记录表中

						ExamHistory eh = new ExamHistory();
						eh.setPid(paper.getId());
						eh.setUid(ouid);
						eh.setStarttime(paper.getStarttime());
						eh.setEndtime(paper.getEndtime());
						eh.setTimecost(paper.getDuration().toString());
						eh.setScore("0");//线下考试：系统预判分为0分
						eh.setStatus("2");//线下考试：直接标记为已判卷状态
						examHistoryService.save(eh);
					}
				}
			}
        }
	}
	
	@Transactional(readOnly = false)
	public void delete(Paper paper) {
		super.delete(paper);
	}

	@Transactional(readOnly = false)
    public int updatePaperDetail(Paper paper, HttpServletRequest request) {
		this.buildPaper(paper, request);
        //试卷类型为2智能组卷时，则马上构建段落和试题
		if(paper.getPapertype() == 2){
			this.buildAutoPaper(paper);
			XStream xStream = new XStream();
			xStream.autodetectAnnotations(true);
			paper.setData(null);
			paper.setData(xStream.toXML(paper));
		}
		try {
			int e = this.dao.update(paper);
			if(e >= 0) {
				//试卷缓存机制还未实现
				CacheUtils.remove("PaperCache", "P" + paper.getId());
			}
			return e;
		} catch (Exception exp) {
			exp.printStackTrace();
			logger.error(exp.getMessage());
			return 0;
		}
    }

	public void buildPaper(Paper paper, HttpServletRequest request) {
		String result = "";
		XStream xstream = new XStream();
		xstream.autodetectAnnotations(true);
		try {
			String[] e = request.getParameterValues("ln_bid");
			if(e != null && e.length > 0) {
				paper.setDepartments(Arrays.asList(e));
			}

			String[] p_section_ids = request.getParameterValues("p_section_ids");
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
					String sectionId = p_section_ids == null?(String.valueOf(i)):p_section_ids[i];
					String sectionName = p_section_names[i];
					String sectionRemark = p_section_remarks[i];
					String sectionDBId = p_dbids == null?null:p_dbids[i];
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

					PaperSection section = new PaperSection(sectionId, sectionName, sectionRemark);
					if(paper.getPapertype() != 1) {
						String[] p_question_ids = request.getParameterValues("p_question_ids_" + sectionId);
						String[] p_question_types = request.getParameterValues("p_question_types_" + sectionId);
						String[] p_question_scores = request.getParameterValues("p_question_scores_" + sectionId);
						String[] p_question_cnts = request.getParameterValues("p_question_cnts_" + sectionId);
						if(p_question_ids != null && p_question_ids.length > 0) {
							for(int j = 0; j < p_question_ids.length; ++j) {
								String question_id = p_question_ids[j];
								String question_type = p_question_types[j];
								String question_score = p_question_scores[j];
								String p_question_cnt = questionService.get(question_id).getQContent();//p_question_cnts[j];
								QuestionVO question = new QuestionVO();
								question.setId(question_id);
								question.setQType(question_type);
								question.setQScore(Integer.parseInt(question_score));
								question.setQContent(p_question_cnt);
								section.addQuestion(question);
							}
						}
					}

					if(paper.getPapertype() != 0){
						section.setRdbid(sectionDBId);
						section.setSubject(sectionSubject);
						section.setTopic(sectionTopic);
						section.setPost(sectionPost);
						section.setRlevel(sectionQlevel);
						section.setRnum(Integer.parseInt(sectionQnums));
						section.setRscore(Integer.parseInt(sectionQScore));
						section.setRtype(sectionQtype);
					}

					paper.addSection(section);
				}
			}

			paper.setData(null);

			result = xstream.toXML(paper);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		paper.setData(result);
	}

	private void buildNormalPaper(Paper paper) {
		if(paper.getSections()==null)
			return;
		for(PaperSection section : paper.getSections()){
			List<QuestionVO> newQuestions = new ArrayList<QuestionVO>();
			for(QuestionVO question : section.getQuestions()){
				String qid = question.getId();
				int score = question.getQScore();
				question = (QuestionVO)questionService.getQuestion(question.getId());
				if(question != null){
					question.setQScore(score);
                    newQuestions.add(question);
				} else {
					logger.warn("组卷需要的试题不存在：qid=" + qid);
				}
			}
			section.setQuestions(newQuestions);
		}
	}

	public boolean validatePaper(Paper paper) {
		String cacheName = "PaperCache";
		String cacheKey = "P" + paper.getId();
		Paper _paper = (Paper) EhCacheUtils.get(cacheName, cacheKey);
		if(_paper != null) {
			return true;
		} else {
			if(StringUtils.isNotEmpty(paper.getData())) {
				XStream xStream = new XStream();
				paper = (Paper) xStream.fromXML(paper.getData());
			}
			if(paper == null) {
				logger.warn("PID=" + paper.getId() + "的试卷不存在");
				return false;
			} else {
				EhCacheUtils.put(cacheName, cacheKey, paper);
				return true;
			}
		}
	}

    @Transactional(readOnly = false)
	public Paper getPaper(String pid) {
		String cacheName = "PaperCache";
		String cacheKey = "P" + pid;
		Paper paper = (Paper) EhCacheUtils.get(cacheName, cacheKey);
		if(paper != null) {
			return paper;
		} else {
			paper = this.get(pid);
			if(StringUtils.isNotEmpty(paper.getData())) {
				XStream xStream = new XStream();
				paper = (Paper) xStream.fromXML(paper.getData());
			}
			if(paper == null) {
				logger.warn("PID=" + pid + "的试卷不存在");
				return null;
			} else {
				if(paper.getPapertype() != 1) {
					this.buildNormalPaper(paper);
				}

				EhCacheUtils.put(cacheName, cacheKey, paper);
				return paper;
			}
		}
	}

    @Transactional(readOnly = false)
	public Paper getUserRandomPaper(String uid, String pid) {
		Paper xpaper = null;
		logger.info("获取学员随机试卷...pid=" + pid + ",uid=" + uid);

		// 针对随机试卷
		try {
			PaperRandom e = paperRandomDao.getUserRandomPaper(uid, pid);
			if(e == null) {
				logger.info("获取学员随机试卷...pid=" + pid + ",uid=" + uid + ",不存在");
				return null;
			}

			String paperData = String.valueOf(e.getDetail());
			XStream xStream = new XStream();
			xpaper = (Paper)xStream.fromXML(paperData);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}

		return xpaper;
	}

	/**
	 * 根据用户ID和试卷ID获取试卷
	 * @param uid
	 * @param pid
	 * @return
	 */
    @Transactional(readOnly = false)
	public Paper getPaper(String uid, String pid) {
		logger.info(String.format("用户获取试卷，uid=%s，pid=%s", new Object[]{uid, pid}));
		Paper paper = this.getPaper(pid);
		if(paper == null) {
			return null;
		} else if(paper.getPapertype() != 1) {
			return paper;
		} else {
			paper = this.getUserRandomPaper(uid, pid);
			if(paper == null) {
				// 构建用户随机试卷
				paper = this.buildUserRandomPaper(uid, pid);
			}

			return paper;
		}
	}

    @Transactional(readOnly = false)
    public Paper buildUserRandomPaper(String uid, String pid) {
        Paper xpaper = null;
        PaperRandom pr = null;
        logger.info("获取随机试卷...pid=" + pid + ",uid=" + uid);

        try {
            pr = paperRandomDao.getUserRandomPaper(uid, pid);
            XStream xStream = new XStream();
            if(pr == null) {
                logger.info("获取随机试卷...pid=" + pid + ",uid=" + uid + ",首次创建");
                xpaper = this.buildRandomPaper(pid);
                String detail = xStream.toXML(xpaper);

                pr = new PaperRandom(uid,pid,detail);
                int e = paperRandomDao.insert(pr);
                logger.info("保存首次生成的试卷入库,pid=" + pid + ",uid=" + uid + ",rows=" + e);
            } else {
                logger.info("获取随机试卷...pid=" + pid + ",uid=" + uid + ",数据库获取");
                xpaper = (Paper)xStream.fromXML(pr.getDetail());
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        return xpaper;
    }

    public Paper buildRandomPaper(String pid) {
        Paper paper = this.getPaper(pid);
        List sections = paper.getSections();
        if(sections != null) {
            Iterator it = sections.iterator();

            while(it.hasNext()) {
                PaperSection section = (PaperSection)it.next();
                List questions = questionService.getRandomQuestions(section);
                section.setQuestions(questions);
            }
        }

        return paper;
    }

	public void buildAutoPaper(Paper paper) {
		List sections = paper.getSections();
		if(sections != null) {
			Iterator it = sections.iterator();

			while(it.hasNext()) {
				PaperSection section = (PaperSection)it.next();
                if(section.getQuestions()==null||section.getQuestions().size()==0){
                    List questions = questionService.getRandomQuestions(section);
                    section.setQuestions(questions);
                } else {
                    section.setRnum(section.getQuestions().size());
                }
			}
		}
	}

	public int loadAllPapers() {
		int rows = 0;

		try {
			// 将线上已发起考试的试卷加入到判卷队列中
			Paper param = new Paper();
			param.setStatus(1);
			param.setIsoffline(0);
			List<Paper> list = this.findList(param);
			for(Paper p : list){
				if(this.validatePaper(p)){
					++rows;
				}
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}

		return rows;
	}


	//-------------------- 试卷批改部分----------------------


	public PaperCheckResult doCheckPaper(Paper paper, JSONObject json) {
		return this.doCheckPaper(paper,json,3,paper.getId());//参数dtype=3代表考试记录
	}

	@Transactional(readOnly = false)
	public PaperCheckResult doCheckPaper(Paper paper, JSONObject json , Integer dtype,String bizid) {
		if(paper == null) {
			logger.error("自动批改:试卷对象不存在.");
			return null;
		} else if(json == null) {
			logger.error("自动批改:用户答案不存在.");
			return null;
		} else if(paper.getSections() != null && paper.getSections().size() >= 1) {
			JSONObject check = new JSONObject();
			int totalScore = 0;

			try {
				Iterator uid = paper.getSections().iterator();

				label84:
				while(true) {
					PaperSection e;
					do {
						do {
							do {
								if(!uid.hasNext()) {
									String e1 = json.getString("pid");
									String uid1 = json.getString("uid");
									json.remove("pid");
									json.remove("uid");
									PaperCheckResult result1 = new PaperCheckResult();
									result1.setResult(check);
									result1.setScore(totalScore);
									result1.setPid(e1);
									result1.setUid(uid1);
									result1.setUserdata(json);
									result1.setSuccess(true);
									return result1;
								}

								e = (PaperSection)uid.next();
							} while(e == null);
						} while(e.getQuestions() == null);
					} while(e.getQuestions().size() <= 0);

					Iterator result = e.getQuestions().iterator();

					while(true) {
						QuestionVO userdata;
						do {
							if(!result.hasNext()) {
								continue label84;
							}

							userdata = (QuestionVO)result.next();
						} while(userdata == null);

						String qType = userdata.getQType();
						String userkey = "";

						try {
							userkey = json.getString("Q-" + userdata.getId());
						} catch (Exception var14) {
							logger.error("自动批改:获取用户答案失败，答案不存在，可能没作答." + var14.getMessage());
						}
						int userScore = 0;

						// TODO: 2017-04-05  记录用户考试、练习记录，后续需考虑去除重复记录的问题
						UserQuestion uq = new UserQuestion();
						uq.setBizid(bizid);
						uq.setUid(json.getString("uid"));
						uq.setQid(userdata.getId());
						uq.setDtype(dtype);//2代表练习记录
						uq.setTopic(userdata.getTopic());
						uq.setQtype(userdata.getQType());
						uq.setUkey(userkey);
						uq.setWtype(0);//初始设置试题为正常状态，答案不一致时设置为1代表错误试题

						// TODO: 2017-04-05  简答题/计算题不自动判分，也不做错题记录
						if(!"1".equals(qType) && !"2".equals(qType) && !"3".equals(qType)) {
							if("4".equals(qType)) {
								QuestionBlankFill _question1 = (QuestionBlankFill)userdata;
								userScore = this.blankFillChecker(_question1, userkey,uq);
							}
						} else {
							String _question = StringUtils.isEmpty(userdata.getQKey())?"":userdata.getQKey().replace(",", "").replace("`", "").replace(" ", "");
							String _userkey = userkey == null?"":userkey.replace("`", "");
							if(_question.equals(_userkey)) {
								userScore = userdata.getQScore();
							} else {
								//用户答案与标准答案不一致，则标记用户错题记录
								uq.setWtype(1);//2代表错题记录
							}
						}
						userQuestionService.save(uq);

						check.put("Q-" + userdata.getId(), Integer.valueOf(userScore));
						totalScore += userScore;

					}
				}
			} catch (Exception var15) {
				logger.error("自动批改:批改时发生异常." + var15.getMessage());
				var15.printStackTrace();
				return null;
			}
		} else {
			logger.error("自动批改:试卷不完整.");
			return null;
		}
	}

	@Transactional(readOnly = false)
	public int doCheckPaperQueue() {
		List list = new ArrayList();

		int ips;
		for (ips = 0; ips < 10; ++ips) {
			Map results = (Map) SystemQueue.USER_PAPER_QUEUE.poll();
			if (results != null) {
				list.add(results);
			}
		}

		ips = list.size();
		if (ips < 1) {
			return 0;
		} else {
			logger.info("批量批改:获取到[" + ips + "]份答卷数据");
			List _list = new ArrayList();
			Iterator it = list.iterator();

			while (true) {
				while (true) {
					while (it.hasNext()) {
						Map map = (Map) it.next();
						String pid = String.valueOf(map.get("pid"));
						String uid = String.valueOf(map.get("uid"));
						if (!StringUtils.isEmpty(pid) && !StringUtils.isEmpty(uid)) {
							Paper paper = this.getPaper(pid);
							if (paper == null) {
								logger.error("批量批改:试卷不存在!!!.pid=" + pid + ",uid=" + uid);
							} else {
								if (1 == paper.getPapertype()) {
									paper = this.getUserRandomPaper(uid, pid);
								}

								if (paper == null) {
									logger.error("批量批改:随机试卷不存在!!!.pid=" + pid + ",uid=" + uid);
								} else {
									//JSONObject json = JSONObject.fromObject(map);
									JSONObject json = JSONObject.fromObject(map);
									PaperCheckResult result = this.doCheckPaper(paper, json);
									if (result != null && result.isSuccess()) {
										_list.add(result);
									} else {
										logger.error("自动批改发生异常，答卷被存到磁盘文件, map = " + map);

										try {
											String e = pid + "_" + uid + ".dat";
											String separator = System.getProperty("file.separator");
											String basepath = separator + "files" + separator + "data" + separator;
											String filepath = System.getProperty("ywork.root") + basepath + e;
											FileUtils.doWriteFile(filepath, map.toString());
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
								}
							}
						} else {
							logger.error("批量批改:用户或试卷信息丢失.pid=" + pid + ",uid=" + uid);
						}
					}

					if (_list != null && _list.size() > 0) {
						return this.doSaveUserPapers(_list);
					} else {
						return 0;
					}
				}
			}
		}
	}

	@Transactional(readOnly = false)
	public int doSaveUserPapers(List<PaperCheckResult> list) {
		if (list != null && list.size() >= 1) {

			List<ExamHistory> ehList = new ArrayList<ExamHistory>();

			for(PaperCheckResult pcr : list){
				ExamHistory eh = new ExamHistory();
				eh.setData(pcr.getUserdata() == null?"":pcr.getUserdata().toString());
				eh.setChecks(pcr.getResult() == null?"":pcr.getResult().toString());
				eh.setScore(pcr.getScore()+"");
				eh.setStatus("2");
				eh.setUid(pcr.getUid());
				eh.setPid(pcr.getPid());
				ehList.add(eh);
			}

			try {
				int rows = this.examHistoryDao.batchUpdate(ehList);
				return rows<=0?0:rows;
			} catch (Exception e) {
				logger.error(e.getLocalizedMessage());
				return 0;
			}
		} else {
			logger.warn("自动批改:保存用户试卷，目标队列为空.");
			return 0;
		}
	}

	public int blankFillChecker(QuestionBlankFill question, String userkey , UserQuestion uq) {
		if(!StringUtils.isEmpty(userkey) && question != null) {
			int score = question.getQScore();
			int total = 0;
			int getScore;
			if(question.isComplex()) {
				HashMap f_total = new HashMap();
				Iterator rate = question.getBlanks().iterator();

				while(rate.hasNext()) {
					QBlank f_total_qs = (QBlank)rate.next();
					f_total.put(f_total_qs.getValue(), "1");
				}

				String[] _key;
				getScore = (_key = userkey.split("`")).length;

				for(int var15 = 0; var15 < getScore; ++var15) {
					String var12 = _key[var15];
					if(f_total.containsKey(var12)) {
						++total;
						f_total.remove(var12);
					}
				}
			} else {
				String[] var10 = userkey.split("`");

				for(int var13 = 0; var13 < var10.length; ++var13) {
					String var16 = var10[var13];

					try {
						QBlank var18 = (QBlank)question.getBlanks().get(var13);
						String var19 = var18.getValue();
						if(var16.equals(var19)) {
							++total;
						}
					} catch (Exception var9) {
						System.out.println("批改填空题发生异常：" + var9.getMessage());
						var9.printStackTrace();
					}
				}
			}

			float var11 = (float)total * 1.0F;
			float var14 = (float)question.getBlanks().size() * 1.0F;
			float var17 = var11 / var14;
			getScore = (int)((float)score * var17);

			if(total<question.getBlanks().size())
				uq.setWtype(1);//填空题只要有错就记录到错题记录中
			return getScore;
		} else {
			return 0;
		}
	}

	@Transactional(readOnly = false)
	public Paper copy(String id , String copyname , int category) {
		XStream xStream = new XStream();
		xStream.autodetectAnnotations(true);
		Paper paper = (Paper)xStream.fromXML(this.get(id).getData());
		paper.setName(copyname);
		paper.setId(null);
		paper.setCategory(category);//从成套试卷、考试试卷相互转换
		paper.setStatus(0);//试卷状态为未发起考试
		paper.setIscomplete(1);//试卷直接标记为创建完成
		paper.preInsert();
		paper.setData(xStream.toXML(paper));
		dao.insert(paper);
		return paper;
	}
}