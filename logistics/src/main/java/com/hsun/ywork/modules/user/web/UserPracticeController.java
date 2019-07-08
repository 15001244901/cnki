/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.bean.BaseMessage;
import com.hsun.ywork.common.bean.BaseUrl;
import com.hsun.ywork.common.utils.CacheUtils;
import com.hsun.ywork.common.utils.DateUtils;
import com.hsun.ywork.modules.exam.entity.*;
import com.hsun.ywork.modules.exam.service.PaperService;
import com.hsun.ywork.modules.exam.service.QuestionDBService;
import com.hsun.ywork.modules.exam.service.QuestionService;
import com.hsun.ywork.modules.sys.entity.Dict;
import com.hsun.ywork.modules.sys.service.DictService;
import com.hsun.ywork.modules.sys.utils.DictUtils;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.modules.user.entity.UserQuestion;
import com.hsun.ywork.modules.user.service.UserQuestionService;
import com.thoughtworks.xstream.XStream;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.user.entity.UserPractice;
import com.hsun.ywork.modules.user.service.UserPracticeService;

import java.util.*;

import static com.sun.tools.javac.jvm.ByteCodes.ret;
import static oracle.net.aso.C01.i;
import static oracle.net.aso.C05.e;
import static org.bouncycastle.asn1.x500.style.RFC4519Style.uid;

/**
 * 模拟练习Controller
 * @author GeCoder
 * @version 2017-03-15
 */
@Controller
@RequestMapping(value = "/user/practice")
public class UserPracticeController extends BaseController {

	@Autowired
	private UserPracticeService userPracticeService;

	@Autowired
	private PaperService paperService;

	@Autowired
	private QuestionDBService questionDBService;
	
	@ModelAttribute
	public UserPractice get(@RequestParam(required=false) String id) {
		UserPractice entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userPracticeService.get(id);
		}
		if (entity == null){
			entity = new UserPractice();
		}
		return entity;
	}
	
	@RequiresPermissions("user:userPractice:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserPractice userPractice, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserPractice> page = userPracticeService.findPage(new Page<UserPractice>(request, response), userPractice); 
		model.addAttribute("page", page);
		return "modules/user/practice/list";
	}

	@RequiresPermissions("user:userPractice:view")
	@RequestMapping(value = "form")
	public String form(UserPractice userPractice, Model model) {
		model.addAttribute("userPractice", userPractice);
		return "modules/user/practice/form";
	}

	@RequiresPermissions("user:userPractice:edit")
	@RequestMapping(value = "save")
	public String save(UserPractice userPractice, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userPractice)){
			return form(userPractice, model);
		}
		userPracticeService.save(userPractice);
		addMessage(redirectAttributes, "保存模拟练习成功");
		return "redirect:/user/practice/?repage";
	}
	
	@RequiresPermissions("user:userPractice:edit")
	@RequestMapping(value = "delete")
	public String delete(UserPractice userPractice, RedirectAttributes redirectAttributes) {
		userPracticeService.delete(userPractice);
		addMessage(redirectAttributes, "删除模拟练习成功");
		return "redirect:/user/practice/history?repage";
	}

	@RequiresPermissions("user")
	@RequestMapping("new")
	public String newPractice(HttpServletRequest request , HttpServletResponse response , Model model){
		int ptype = 2;
		if(StringUtils.isNotEmpty(request.getParameter("ptype")))
			ptype = Integer.valueOf(request.getParameter("ptype"));
		Map ret = (Map)this.practice(ptype,request,response);
		// TODO: 2017-03-15  允许用户模拟练习参数暂时写死，将来配置在数据库中
		model.addAllAttributes(ret);
		if(ptype == 1) {
			return "modules/user/practice/new_mode1";
		} else if(ptype == 3) {
			model.addAttribute("page", ret.get("data"));
			return "modules/user/practice/new_mode3";
		} else {
			model.addAttribute("qdbs", ((Map) ret.get("data")).get("qdbs"));
			return "modules/user/practice/new";
		}
	}

	@RequiresPermissions("user")
	@RequestMapping("newdetail")
	public String newPracticeDetail(HttpServletRequest request , HttpServletResponse response , Model model){
		// TODO: 2017-03-15  暂时简单处理，以后需要加入判断是否允许用户模拟练习，及异常处理机制。
		int ptype = 2;
		if(StringUtils.isNotEmpty(request.getParameter("ptype")))
			ptype = Integer.valueOf(request.getParameter("ptype"));
		Map ret = (Map)this.startPractice(ptype,request,response);
		model.addAttribute("paper",ret.get("data"));
		return "modules/user/practice/newdetail";
	}

	@RequestMapping({"submit"})
	public String submit(HttpServletRequest request, Model model) {
		int i = this.userPracticeService.saveTestPaper(request);
		BaseMessage message = null;
		if(i == 1) {
			message = new BaseMessage(true, "成功提交试卷");
		} else {
			message = new BaseMessage(false, "提交试卷发生异常，请返回稍后再试");
		}

		message.addUrl(new BaseUrl("模拟练习", request.getContextPath()+"/user/practice/new"));
		message.addUrl(new BaseUrl("练习记录", request.getContextPath()+"/user/practice/history"));
		model.addAttribute("message", message);
		return "common/message";
	}

	@RequiresPermissions("user")
	@RequestMapping("history")
	public String history(UserPractice param , HttpServletRequest request , HttpServletResponse response , Model model) {
	    Map ret = (Map)this.history(param,request,response);
        if((Boolean)ret.get("success")) {
            model.addAttribute("page", ret.get("data"));
            return "modules/user/practice/history";
        } else {
            BaseMessage bm = new BaseMessage();
            bm.setMessage(ret.get("msg").toString());
            bm.setSuccess(((Boolean) ret.get("success")).booleanValue());
            model.addAttribute("message",bm);
            return "common/message";
        }
    }

    @RequiresPermissions("user")
    @RequestMapping("historydetail")
    public String historyDetail(@RequestParam String id , HttpServletRequest request , Model model) {
        Map ret = (Map)this.historyDetail(id,request);
        if((Boolean)ret.get("success")) {
            model.addAttribute("paper", ret.get("paper"));
            model.addAttribute("detail", ret.get("detail"));
            model.addAttribute("check", ret.get("check"));
            model.addAttribute("answer", ret.get("answer"));
            return "modules/user/practice/historydetail";
        } else {
            BaseMessage bm = new BaseMessage();
            bm.setMessage(ret.get("msg").toString());
            bm.setSuccess(((Boolean) ret.get("success")).booleanValue());
            model.addAttribute("message",bm);
            return "common/message";
        }
    }

    //----------前端json、jsonp接口部分----------------

	@Autowired
	private UserQuestionService userQuestionService;

	@Autowired
	private QuestionService questionService;

	@Autowired
	private DictService dictService;

	/**
	 * 模拟练习（3中模式统一接口）
	 * @param ptype
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping("practice.jhtml")
	public Object practice(@RequestParam int ptype , HttpServletRequest request , HttpServletResponse response){
		Map ret = new HashMap();
		try {
			if(ptype == 1) {
				//按知识点练习
				String uid = UserUtils.getUser().getId();
				ret.put("data",userQuestionService.countPractice(uid));
			} else if(ptype == 2) {
				//智能组卷练习
				Map data = new HashMap();
				data.put("qdbs",this.questionDBService.findList(new QuestionDB()));
				Dict dictQS = new Dict();
				dictQS.setType("dic_exam_questionsubject");
				data.put("subjects",dictService.findList(dictQS));

				Dict dictTopic = new Dict();
				dictTopic.setType("dic_exam_questiontopic");
				data.put("topics",dictService.findList(dictTopic));

				Dict dictQC = new Dict();
				dictQC.setType("dic_exam_papercontent");
				data.put("contents",dictService.findList(dictQC));

				Dict dictQT = new Dict();
				dictQT.setType("dic_exam_questiontype");
				data.put("types",dictService.findList(dictQT));

				Dict dictQL = new Dict();
				dictQL.setType("dic_exam_questionlevel");
				data.put("levels",dictService.findList(dictQL));
				ret.put("data",data);
			} else if(ptype == 3) {
				//套题练习
				Paper paper = new Paper();
				paper.setCategory(2);
				ret.put("data",paperService.findPage(new Page(request,response),paper));
			}
			ret.put("success",true);
			ret.put("sys_allow_test","allow");// TODO: 2017-03-15  允许用户模拟练习参数暂时写死，将来配置在数据库中
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
			e.printStackTrace();
		} finally {
			String callback = request.getParameter("callback");
			if(StringUtils.isNotBlank(callback)){
				MappingJacksonValue json = new MappingJacksonValue(ret);
				json.setJsonpFunction(callback);
				return json;
			} else {
				return ret;
			}
		}
	}

	/**
	 * 开始模拟练习：1按知识点、2智能组卷、3套题练习、4每日一练4种模式统一接口
	 * @param ptype
	 * @param request
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping("startPractice.jhtml")
	public Object startPractice(@RequestParam(required = true) int ptype , HttpServletRequest request , HttpServletResponse response){
		Map ret = new HashMap();
		try {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			if(ptype == 1) {
				//开始按知识点练习
				String topic = request.getParameter("topic");
				String topicname = request.getParameter("topicname");
				Question qp = new Question();
				qp.setTopic(topic);//指定知识点
				qp.setQStatus("1");//只能练习已审核试题

				// TODO: 2017-08-22  按知识点练习每次只取未做过的30道试题
				Page<Question> page = new Page<Question>(request,response);
//				page.setPageSize(1);
				qp.setPage(page);
				//排除当前用户做过的题
				UserQuestion uq = new UserQuestion();
				uq.setUid(UserUtils.getUser().getId());
				qp.setUserQuestion(uq);

				String restart = request.getParameter("restart");
				if(StringUtils.isNotEmpty(restart)) {
					//如果选择重新做题，则删除当前知识点练习记录
					uq.setTopic(topic);
					uq.setDtype(2);
					userQuestionService.deleteUserQuestion(uq);
				}

				List<Question> qList = userQuestionService.findUserNotPracticeList(qp);

				List<QuestionVO> qvList = new ArrayList<QuestionVO>();
				for(Question q : qList){
					QuestionVO qv = questionService.getQuestion(q.getId());
					qvList.add(qv);
				}
				Paper paper = new Paper();
				PaperSection section = new PaperSection();
				List<PaperSection> sections = new ArrayList<PaperSection>();
				paper.setName("知识点："+topicname+" 模拟练习"+ DateUtils.getDate("yyyyMMddHHmmss"));
				paper.setDuration(99999999);
				section.setRnum(qvList.size());
				section.setName(topicname+" (共"+section.getRnum()+"题)");
				section.setTopic(topic);
				section.setRscore(0);//TODO 按知识点练习是否要设置分值
				section.setQuestions(qvList);
				sections.add(section);
				paper.setSections(sections);
				paper.setData(xstream.toXML(paper));
				String uid = UserUtils.getUser().getId();
				String cacheName = "UserTestPaperCache";
				String cacheKey = "UTP" + uid;
				logger.info(String.format("用户创建自测试卷...uid=%s", new Object[]{uid}));
				CacheUtils.put(cacheName, cacheKey, paper);
				ret.put("data",paper);
			} else if(ptype == 2) {
				Paper paper = this.userPracticeService.buildTestPaper(request);
				logger.debug(String.format("模拟试卷xml数据:\r\n%s",new Object[]{paper.getData()}));
				ret.put("data",paper);
			} else if(ptype == 3) {
				String copyid = request.getParameter("copyid");
				String copyname = request.getParameter("copyname");
				if(StringUtils.isEmpty(copyname))
					copyname = "整卷模拟"+DateUtils.getDate("yyyyMMddHHmmss");
				Paper paper = userPracticeService.copy(copyid,copyname);
				paper.setStarttime(null);
				paper.setEndtime(null);
				paper.setDuration(99999999);
				paper.setData(xstream.toXML(paper));
				String uid = UserUtils.getUser().getId();
				String cacheName = "UserTestPaperCache";
				String cacheKey = "UTP" + uid;
				logger.info(String.format("用户创建自测试卷...uid=%s", new Object[]{uid}));
				CacheUtils.put(cacheName, cacheKey, paper);
				ret.put("data",paper);
			} else if(ptype == 4) {
				//每日一练组卷
				//抓题
				String uid = UserUtils.getUser().getId();
				Question question = userQuestionService.getUserDayQuestion(uid);
				if(question==null) {
					userQuestionService.deleteUserDayQuestion(uid);
					question = userQuestionService.getUserDayQuestion(uid);
					ret.put("clearUserQuestion",true);
				}

				UserQuestion uq = new UserQuestion();
				uq.setUid(uid);
				uq.setQid(question.getId());
				uq.setDtype(4);
				userQuestionService.save(uq);

				//转换为VO便于前端处理
				List<QuestionVO> qvList = new ArrayList<QuestionVO>();
				QuestionVO qv = questionService.getQuestion(question.getId());
				qvList.add(qv);

				//组卷
				Paper paper = new Paper();
				PaperSection section = new PaperSection();
				List<PaperSection> sections = new ArrayList<PaperSection>();
				paper.setName("每日一练（"+DateUtils.getDate("yyyy-MM-dd")+"）");
				paper.setDuration(99999999);
				section.setRnum(1);
				section.setName(DictUtils.getDictLabel(qv.getQType(),"dic_exam_questiontype","综合")+"题 (共"+section.getRnum()+"题)");
				section.setTopic(question.getTopic());
				section.setRscore(0);//TODO 每日一练是否要设置分值
				section.setQuestions(qvList);
				sections.add(section);
				paper.setSections(sections);
				paper.setData(xstream.toXML(paper));
				String cacheName = "UserTestPaperCache";
				String cacheKey = "UTP" + uid;
				logger.info(String.format("用户创建每日一练试卷...uid=%s", new Object[]{uid}));
				CacheUtils.put(cacheName, cacheKey, paper);
				ret.put("data",paper);
			}
			ret.put("success",true);
			ret.put("showmode",request.getParameter("showmode"));
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
			e.printStackTrace();
		} finally {
			String callback = request.getParameter("callback");
			if(StringUtils.isNotBlank(callback)){
				MappingJacksonValue json = new MappingJacksonValue(ret);
				json.setJsonpFunction(callback);
				return json;
			} else {
				return ret;
			}
		}
	}

	/**
	 * 模拟练习交卷接口
	 * @param request
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping("submit.jhtml")
	public Object submit(HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			int i = this.userPracticeService.saveTestPaper(request);
			ret.put("success",true);
			ret.put("msg","模拟练习提交成功！");
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
			e.printStackTrace();
		} finally {
			String callback = request.getParameter("callback");
			if(StringUtils.isNotBlank(callback)){
				MappingJacksonValue json = new MappingJacksonValue(ret);
				json.setJsonpFunction(callback);
				return json;
			} else {
				return ret;
			}
		}
	}

	/**
	 * 个人练习记录接口
	 * @param param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
    @RequestMapping("history.jhtml")
	public Object history(UserPractice param , HttpServletRequest request , HttpServletResponse response) {
	    Map ret = new HashMap();
        try {
            param.setUid(UserUtils.getUser().getId());
            Page<UserPractice> page = this.userPracticeService.findPage(new Page<UserPractice>(request,response),param);
            ret.put("success",true);
            ret.put("data",page);
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
			e.printStackTrace();
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

	/**
	 * 个人练习记录明细接口
	 * @param id
	 * @param request
	 * @return
	 */
	@RequiresPermissions("user")
    @ResponseBody
    @RequestMapping("historydetail.jhtml")
    public Object historyDetail(@RequestParam String id , HttpServletRequest request) {
        Map ret = new HashMap();
        try {
            UserPractice detail = this.userPracticeService.get(id);
            XStream xStream = new XStream();
            Paper paper = (Paper)xStream.fromXML(detail.getPaper());
            ret.put("success",true);
            ret.put("paper",paper);
            ret.put("detail",detail);
            ret.put("check", JSONObject.fromObject(detail.getCheck()));
            ret.put("answer",JSONObject.fromObject(detail.getAnswer()));
        } catch (Exception e) {
            logger.error(e.getMessage());
            ret.put("success",false);
            ret.put("msg","系统忙...");
        } finally {
            String callback = request.getParameter("callback");
            if(StringUtils.isNotBlank(callback)){
                MappingJacksonValue json = new MappingJacksonValue(ret);
                json.setJsonpFunction(callback);
                return json;
            } else {
                return ret;
            }
        }
    }

	/**
	 * 从缓存中加载模拟试卷信息，依赖于前一步创建模拟试卷，不可单独使用
	 * @param request
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping("findPracticePaper.jhtml")
    public Object findPracticePaper(HttpServletRequest request){
    	Map ret = new HashMap();
		try {
			String uid = UserUtils.getUser().getId();
			String cacheName = "UserTestPaperCache";
			String cacheKey = "UTP" + uid;
			logger.info(String.format("获取用户自测试卷...uid=%s", new Object[]{uid}));
			Paper paper = (Paper)CacheUtils.get(cacheName, cacheKey);
			ret.put("data",paper);
			ret.put("success",true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
		} finally {
			String callback = request.getParameter("callback");
			if(StringUtils.isNotBlank(callback)){
				MappingJacksonValue json = new MappingJacksonValue(ret);
				json.setJsonpFunction(callback);
				return json;
			} else {
				return ret;
			}
		}
	}

	/**
	 * 前端删除练习记录的接口
	 * @param userPractice
	 * @param request
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping("delete.jhtml")
	public Object delete(UserPractice userPractice , HttpServletRequest request){
		Map ret = new HashMap();
		try {
			userPracticeService.delete(userPractice);
			ret.put("msg", "成功删除练习记录！");
			ret.put("success", true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统忙...");
			e.printStackTrace();
		} finally {
			return this.getJSONOrJSONPString(request, ret);
		}
	}
}