/**
 *
 */
package com.hsun.ywork.modules.exam.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.hsun.ywork.common.utils.EhCacheUtils;
import com.hsun.ywork.common.xstream.XStreamUtility;
import com.hsun.ywork.modules.exam.entity.*;
import com.hsun.ywork.common.utils.HtmlUtils;
import com.hsun.ywork.common.utils.StringUtils;
import com.thoughtworks.xstream.XStream;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.service.CrudService;
import com.hsun.ywork.modules.exam.dao.QuestionDao;

import static org.activiti.engine.impl.util.json.XMLTokener.entity;
import static org.bouncycastle.asn1.ua.DSTU4145NamedCurves.params;

/**
 * 试题管理Service
 * @author GeCoder
 * @version 2016-12-23
 */
@Service
@Transactional(readOnly = true)
public class QuestionService extends CrudService<QuestionDao, Question> {

	public Question get(String id) {
		return super.get(id);
	}
	
	public List<Question> findList(Question question) {
		List<Question> list = super.findList(question);
		for(Question q : list){
			q.setQContent(HtmlUtils.Html2TextFormat(q.getQContent()));
		}
		return list;
	}
	
	public Page<Question> findPage(Page<Question> page, Question question) {
		page = super.findPage(page, question);
		for(Question q : page.getList()){
			q.setQContent(HtmlUtils.Html2TextFormat(q.getQContent()));
		}
		return page;
	}
	
	/**
	 * @param question
	 */
	@Transactional(readOnly = false)
	public void save(Question question) {
		try {

			//获取最大编号并+1
			if(question.getIsNewRecord())
				question.setQno(dao.findMaxNo()+1);
			super.save(question);
			this.buildQuestionXmlData(question);
			super.save(question);

			//试题试题发生变化则移除试题VO的缓存，历史考试记录不影响
			String cacheName = "QuestionCache";
			String cacheKey = "Q" + question.getId();
			EhCacheUtils.remove(cacheName,cacheKey);
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	@Transactional(readOnly = false)
	public void check(Question question) {
		try {
			dao.check(question);
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	@Transactional(readOnly = false)
	public void delete(Question question) {
		super.delete(question);
	}

	private void buildQuestionXmlData(Question question) throws Exception{

		QuestionVO qv = null;
		XStream xstream = new XStream();
		if("1".equals(question.getQType())){//单选题
			qv = new QuestionSingleChoice();
			BeanUtils.copyProperties(qv,question);
			char op_alisa = 'A';
			for(String op_text : question.get_options()){
				//处理富文本中的特殊字符，比如小于号，在浏览器中显示不正常，让html代码原样输出
				op_text = "<![CDATA[" + op_text + "]]>";
				((QuestionSingleChoice)qv).addOption(new Option(String.valueOf(op_alisa),op_text));
				op_alisa++;
			}
		} else if("2".equals(question.getQType())){//多选题
            if(question.getQKey()!=null)
                question.setQKey(StringUtils.join(question.getQKey().split(","),""));
            qv = new QuestionMultipleChoice();
            BeanUtils.copyProperties(qv,question);
            char op_alisa = 'A';
            for(String op_text : question.get_options()){
				//处理富文本中的特殊字符，比如小于号，在浏览器中显示不正常，让html代码原样输出
            	op_text = "<![CDATA[" + op_text + "]]>";
                ((QuestionMultipleChoice)qv).addOption(new Option(String.valueOf(op_alisa),op_text));
                op_alisa++;
            }
		} else if("3".equals(question.getQType())){//判断题
			qv = new QuestionJudgment();
			BeanUtils.copyProperties(qv,question);
		} else if("4".equals(question.getQType())){//填空题
			qv = new QuestionBlankFill();
			BeanUtils.copyProperties(qv,question);
			String[] blankids = (String[])question.get_advOptions().get("q_blankids");
			String[] blanks = (String[])question.get_advOptions().get("q_blanks");

			for(int i=0;i<blankids.length;i++){
				int bid = Integer.parseInt(blankids[i]);
				blanks[i] = "<![CDATA[" + blanks[i] + "]]>";
				((QuestionBlankFill)qv).addBlank(bid,"BLANK"+bid,blanks[i]);
			}
			boolean isComplex = false;
			if(null!=question.get_advOptions().get("q_iscomplex"))
				isComplex = "Y".equals(((String[])question.get_advOptions().get("q_iscomplex"))[0].toString());
			((QuestionBlankFill)qv).setComplex(isComplex);
		} else if("5".equals(question.getQType())){//问答题
			qv = new QuestionEssay();
			BeanUtils.copyProperties(qv,question);
		} else if("6".equals(question.getQType())){//计算题
			qv = new QuestionEssay();
			BeanUtils.copyProperties(qv,question);
		}
		question.setQData(XStreamUtility.toXml(qv));
	}

	public QuestionVO getQuestion(String qid) {
		String cacheName = "QuestionCache";
		String cacheKey = "Q" + qid;
		QuestionVO qv = (QuestionVO) EhCacheUtils.get(cacheName, cacheKey);
		if(qv == null) {
			try {
				Question question = this.get(qid);
				if(question == null) {
					logger.warn("QID=" + qid + "的试题不存在");
					return null;
				}

				String questionData = question.getQData();
				String questionType = question.getQType();
				XStream xStream = new XStream();
				qv = (QuestionVO) xStream.fromXML(questionData);
				if(qv != null) {
//					BeanUtils.copyProperties(question,qv);
					qv.setQContent(question.getQContent());
					EhCacheUtils.put(cacheName, cacheKey, qv);
				}
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		}

		return qv;
	}

	public List<QuestionVO> getRandomQuestions(PaperSection section) {
		ArrayList<QuestionVO> qvos = new ArrayList<QuestionVO>();

		try {
			Page<Question> page = new Page<Question>();
			page.setOrderBy("RAND()");
			page.setPageSize(section.getRnum());

			Question param = new Question();
			param.setQDbid(section.getRdbid());
			param.setSubject(section.getSubject());
			param.setTopic(section.getTopic());
			param.setPost(section.getPost());
			param.setQType(section.getRtype());
			param.setQLevel(section.getRlevel());
			param.setQStatus("1");//只查已审核的试题
			param.setDelFlag("0");
			List<Question> list = super.findPage(page,param).getList();
			if(list != null && list.size() > 0) {
				for(Question q : list){
					q.setQScore(section.getRscore());
					XStream xStream = new XStream();
					QuestionVO qv = (QuestionVO)xStream.fromXML(q.getQData());
					BeanUtils.copyProperties(qv,q);
					qvos.add(qv);
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
		}

		return qvos;
	}

	public Page findUserQuestionPage(Page page, Question question) {
		question.setPage(page);
		page.setList(dao.findUserQuestionList(question));
		List<QuestionVO> qvoList = new ArrayList<QuestionVO>();
		if(page.getList()!=null) {
			for (int i = 0; i < page.getList().size();i++) {
				Question q = (Question) page.getList().get(i);
				q.setQContent(HtmlUtils.Html2TextFormat(q.getQContent()));
				QuestionVO vo = this.getQuestion(q.getId());
				vo.setUserQuestion(q.getUserQuestion());
				qvoList.add(vo);
			}
			page.setList(qvoList);
		}
		return page;
	}

	/**
	 * 前端智能组卷按条件统计试题数量
	 * @param question 条件
	 * @return
	 */
	public List countQuestionNums(Question question){
		return dao.countQuestionNums(question);
	}
}