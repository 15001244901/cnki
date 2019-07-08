package com.hsun.ywork.modules.qa.web;

import com.hsun.ywork.common.utils.EhCacheUtils;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.common.constants.CacheConstants;
import com.hsun.ywork.modules.common.constants.CommonConstants;
import com.hsun.ywork.modules.qa.entity.*;
import com.hsun.ywork.modules.qa.service.QaCommentService;
import com.hsun.ywork.modules.qa.service.QaService;
import com.hsun.ywork.modules.qa.service.QaTagRelationService;
import com.hsun.ywork.modules.qa.service.QaTagService;
import com.hsun.ywork.modules.qa.utils.ObjectUtils;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.service.SystemService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 问答 Controller
 * @author GeCoder
 */
@Controller
@RequestMapping("/qa")
public class QaController extends BaseController {
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(QaController.class);

	@Autowired
	private QaService questionsService;
	@Autowired
	private SystemService userService;
	@Autowired
	private QaCommentService questionsCommentService;
	@Autowired
	private QaTagRelationService questionsTagRelationService;
	@Autowired
	private QaTagService questionsTagService;

	// 问答列表
	private static final String questionslist = getViewPath("/qa-list");
	// 添加问答页面
	private static final String questionsadd = getViewPath("/qa-add");
	// 问答详情页面
	private static final String questionsinfo = getViewPath("/qa-info");
	// 我的问答列表
	private static final String myquestionslist = "modules/front/usercenter/qa-mylist";
	// 问答 我的回答列表
	private static final String myrepquestionslist = "modules/front/usercenter/qa-myreplist";

	public static String getViewPath(String path) {
		return path != null && !path.trim().equals("")?"modules/front/qa" + path:"";
	}

	public String setExceptionRequest(HttpServletRequest request, Exception e) {
		logger.error(request.getContextPath(), e);
		StackTraceElement[] messages = e.getStackTrace();
		if(messages != null && messages.length > 0) {
			StringBuffer buffer = new StringBuffer();
			buffer.append(e.toString()).append("<br/>");

			for(int i = 0; i < messages.length; ++i) {
				buffer.append(messages[i].toString()).append("<br/>");
			}

			request.setAttribute("myexception", buffer.toString());
		}

		return "/common/error";
	}

	public Map<String, Object> setAjaxException(Map<String, Object> map) {
		map.put("success", Boolean.valueOf(false));
		map.put("message", "系统繁忙，请稍后再操作！");
		map.put("entity", (Object)null);
		return map;
	}

	public Map<String, Object> setJson(boolean success, String message, Object entity) {
		HashMap json = new HashMap();
		json.put("success", Boolean.valueOf(success));
		json.put("message", message);
		json.put("entity", entity);
		return json;
	}

	@InitBinder({ "questions" })
	public void initBinderQuestions(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("questions.");
	}

	@InitBinder({"page"})
	public void initBinderPage(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	/**
	 * 问答列表
	 * 
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping("/questions/list")
	public ModelAndView getQuestionsList(HttpServletRequest request, @ModelAttribute("questions") Qa questions, @ModelAttribute("page") PageEntity page) {
		ModelAndView model = new ModelAndView(questionslist);
		try {
			page.setPageSize(8);
			List<Qa> questionsList = questionsService.getQuestionsList(questions, page);
			// 查询该问答的标签
			QaTagRelation questionsTagRelation = new QaTagRelation();
			if (questionsList != null && questionsList.size() > 0) {
				QaComment questionsComment = new QaComment();
				for (Qa questionsTemp : questionsList) {
					questionsTagRelation.setQuestionsId(questionsTemp.getId());
					questionsTemp.setQuestionsTagRelationList(questionsTagRelationService.queryQuestionsTagRelation(questionsTagRelation));

					if (questionsTemp.getReplyCount() > 0) {// 问答评论不为空
						questionsComment.setQuestionId(questionsTemp.getId());
						questionsComment.setLimitSize(1);// 一条
						if (questionsTemp.getStatus() == 1) {// 已采纳最佳答案
							// 查找最佳回答回复
							questionsComment.setIsBest(1);// 已采纳
							questionsTemp.setQuestionsCommentList(questionsCommentService.getQuestionsCommentList(questionsComment));
						} else {
							// 查找最新回答回复
							questionsComment.setIsBest(-1);
							questionsComment.setOrderFlag("new");// 最新
							questionsTemp.setQuestionsCommentList(questionsCommentService.getQuestionsCommentList(questionsComment));
						}
					}
				}
			}
			model.addObject("questionsList", questionsList);
			model.addObject("page", page);

			// 查询所有的问答标签
			QaTag questionsTag = new QaTag();
			List<QaTag> questionsTagList = questionsTagService.getQuestionsTagList(questionsTag);
			model.addObject("questionsTagList", questionsTagList);
		} catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("QuestionsController.getQuestionsList()---error", e);
		}
		return model;
	}

	/**
	 * 到添加问答页面
	 */
	@RequestMapping("/questions/toadd")
	public ModelAndView toQuestionsAdd(HttpServletRequest request) {
		ModelAndView model = new ModelAndView(questionsadd);
		try {
			// 查询所有问答标签
			QaTag questionsTag = new QaTag();
			List<QaTag> questionsTagList = questionsTagService.getQuestionsTagList(questionsTag);
			model.addObject("questionsTagList", questionsTagList);
		} catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("QuestionsController.toQuestionsAdd()---error", e);
		}
		return model;
	}

	/**
	 * 添加问答
	 */
	@RequestMapping("/questions/ajax/add")
	@ResponseBody
	public Object addQuestions(HttpServletRequest request, @ModelAttribute("questions") Qa questions) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			String randomCode = request.getParameter("randomCode");
			if (StringUtils.isEmpty(randomCode) || request.getSession().getAttribute(CommonConstants.RAND_CODE) == null || !randomCode.equalsIgnoreCase(request.getSession().getAttribute(CommonConstants.RAND_CODE).toString())) {
				json = this.setJson(false, "验证码错误", null);
				return json;
			}
			String userId = UserUtils.getUser().getId();
			if (StringUtils.isEmpty(userId)) {
				json = this.setJson(false, "请先登录", "");
				return json;
			}
			questions.setCusId(userId);
			questions.setAddTime(new Date());
			questionsService.addQuestions(questions);

			// 保存该问答的 问答标签(多个)
			String questionsTag = request.getParameter("questionsTag");
			if (ObjectUtils.isNotNull(questionsTag)) {
				questionsTag = questionsTag.substring(1);
				String questionsTagArr[] = questionsTag.split(",");
				for (int i = 0; i < questionsTagArr.length; i++) {
					QaTagRelation questionsTagRelation = new QaTagRelation();
					questionsTagRelation.setQuestionsId(questions.getId());
					questionsTagRelation.setQuestionsTagId(Long.valueOf(questionsTagArr[i]));
					questionsTagRelationService.addQuestionsTagRelation(questionsTagRelation);
				}
			}
			json = this.setJson(true, "", questions.getId());
		} catch (Exception e) {
			logger.error("QuestionsController.addQuestions()---error", e);
			json = this.setJson(false, "系统错误,请稍后重试", "");
		}
		return json;
	}

	/**
	 * 到问答详情
	 */
	@RequestMapping("/questions/info/{id}")
	public ModelAndView toQuestionsInfo(HttpServletRequest request, @PathVariable("id") Long id) {
		ModelAndView model = new ModelAndView(questionsinfo);
		try {
			Qa questions = questionsService.getQuestionsById(id);
			// 更新问答的浏览数 +1
			questions.setBrowseCount(questions.getBrowseCount() + 1);
			questionsService.updateQuestions(questions);

			// 查询该问答的标签
			QaTagRelation questionsTagRelation = new QaTagRelation();
			questionsTagRelation.setQuestionsId(questions.getId());
			questions.setQuestionsTagRelationList(questionsTagRelationService.queryQuestionsTagRelation(questionsTagRelation));
			model.addObject("questions", questions);

			User user = UserUtils.getUser();
			model.addObject("user", user);

			// 热门问答
			List<Qa> hotQuestionsList = questionsService.queryQuestionsOrder(8);
			model.addObject("hotQuestionsList", hotQuestionsList);

			// 查询所有的问答标签
			QaTag questionsTag = new QaTag();
			List<QaTag> questionsTagList = questionsTagService.getQuestionsTagList(questionsTag);
			model.addObject("questionsTagList", questionsTagList);
		} catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("QuestionsController.toQuestionsInfo()---error", e);
		}
		return model;
	}

	/**
	 * 我的问答列表
	 * 
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping("/myqa/list")
	public ModelAndView getMyQuestionsList(HttpServletRequest request, @ModelAttribute("questions") Qa questions, @ModelAttribute("page") PageEntity page) {
		ModelAndView model = new ModelAndView(myquestionslist);
		try {
			page.setPageSize(4);
			String userId = UserUtils.getUser().getId();
			questions.setCusId(userId);
			List<Qa> questionsList = questionsService.getQuestionsList(questions, page);
			// 查询该问答的问答标签
			QaTagRelation questionsTagRelation = new QaTagRelation();
			if (questionsList != null && questionsList.size() > 0) {
				QaComment questionsComment = new QaComment();
				for (Qa questionsTemp : questionsList) {
					questionsTagRelation.setQuestionsId(questionsTemp.getId());
					questionsTemp.setQuestionsTagRelationList(questionsTagRelationService.queryQuestionsTagRelation(questionsTagRelation));

					if (questionsTemp.getReplyCount() > 0) {// 问答评论不为空
						questionsComment.setQuestionId(questionsTemp.getId());
						questionsComment.setLimitSize(1);// 一条
						if (questionsTemp.getStatus() == 1) {// 已采纳最佳答案
							// 查找最佳回答回复
							questionsComment.setIsBest(1);// 已采纳
							questionsTemp.setQuestionsCommentList(questionsCommentService.getQuestionsCommentList(questionsComment));
						} else {
							// 查找最新回答回复
							questionsComment.setIsBest(-1);
							questionsComment.setOrderFlag("new");// 最新
							questionsTemp.setQuestionsCommentList(questionsCommentService.getQuestionsCommentList(questionsComment));
						}
					}
				}
			}
			model.addObject("questionsList", questionsList);
			model.addObject("page", page);
		} catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("QuestionsController.getMyQuestionsList()---error", e);
		}
		return model;
	}

	/**
	 * 问答 我的回答列表
	 * 
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping("/myrepqa/list")
	public ModelAndView getMyRepQuestionsList(HttpServletRequest request, @ModelAttribute("questions") Qa questions, @ModelAttribute("page") PageEntity page) {
		ModelAndView model = new ModelAndView(myrepquestionslist);
		try {
			page.setPageSize(4);
			String userId = UserUtils.getUser().getId();
			questions.setCommentUserId(userId);
			List<Qa> questionsList = questionsService.getQuestionsList(questions, page);
			// 查询该问答的标签
			QaTagRelation questionsTagRelation = new QaTagRelation();
			if (questionsList != null && questionsList.size() > 0) {
				QaComment questionsComment = new QaComment();
				for (Qa questionsTemp : questionsList) {
					questionsTagRelation.setQuestionsId(questionsTemp.getId());
					questionsTemp.setQuestionsTagRelationList(questionsTagRelationService.queryQuestionsTagRelation(questionsTagRelation));

					if (questionsTemp.getReplyCount() > 0) {// 问答评论不为空
						questionsComment.setQuestionId(questionsTemp.getId());
						questionsComment.setLimitSize(1);// 一条
						if (questionsTemp.getStatus() == 1) {// 已采纳最佳答案
							// 查找最佳回答回复
							questionsComment.setIsBest(1);// 已采纳
							questionsTemp.setQuestionsCommentList(questionsCommentService.getQuestionsCommentList(questionsComment));
						} else {
							// 查找最新回答回复
							questionsComment.setIsBest(-1);
							questionsComment.setOrderFlag("new");// 最新
							questionsTemp.setQuestionsCommentList(questionsCommentService.getQuestionsCommentList(questionsComment));
						}
					}
				}
			}
			model.addObject("questionsList", questionsList);
			model.addObject("page", page);
		} catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("QuestionsController.getMyRepQuestionsList()---error", e);
		}
		return model;
	}
	
	/**
	 * 热门问答 推荐
	 */
	@RequestMapping("/questions/ajax/hotRecommend")
	@ResponseBody
	public Object hotQuestionsRecommend(HttpServletRequest request, @ModelAttribute("questions") Qa questions) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			List<Qa> hotQuestionsList=(List<Qa>) EhCacheUtils.get(CacheConstants.QUESTIONS_HOT_RECOMMEND);
//			if(hotQuestionsList==null||hotQuestionsList.size()==0){//暂时先不用缓存
				hotQuestionsList = questionsService.queryQuestionsOrder(8);
				EhCacheUtils.put(CacheConstants.QUESTIONS_HOT_RECOMMEND, hotQuestionsList);
//			}
			json = this.setJson(true, "", hotQuestionsList);
		} catch (Exception e) {
			logger.error("QuestionsController.hotQuestionsRecommend()---error", e);
			json = this.setJson(false, "系统错误,请稍后重试", "");
		}
		return json;
	}

	@RequestMapping("/getloginUser")
	@ResponseBody
	public Map<String,Object> getLoginUser(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> json = new HashMap<String,Object>();
		try{
			User user = UserUtils.getUser();
			if(StringUtils.isEmpty(user.getId())){
				json = this.setJson(false, null, null);
			}else{
				json = this.setJson(true, null, user);
			}
		}catch (Exception e) {
			this.setAjaxException(json);
			logger.error("getLoginUser()---error",e);
		}
		return json;
	}
}
