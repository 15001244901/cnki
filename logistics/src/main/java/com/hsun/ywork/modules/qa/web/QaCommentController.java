package com.hsun.ywork.modules.qa.web;

import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.qa.entity.Qa;
import com.hsun.ywork.modules.qa.entity.QaComment;
import com.hsun.ywork.modules.qa.service.QaCommentService;
import com.hsun.ywork.modules.qa.service.QaService;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.service.SystemService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.*;
import java.util.List;

/**
 * 问答评论 Controller
 * @author GeCoder
 */
@Controller
@RequestMapping("/qa")
public class QaCommentController extends BaseController {
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(QaCommentController.class);
	
	@Autowired
	private QaService questionsService;
	@Autowired
	private QaCommentService questionsCommentService;
	@Autowired
	private SystemService userService;
	
	//问答详情 评论列表页面
	private static final String questionscommentlist = getViewPath("/qacomment-ajax-list");
	//子评论
	private static final String questionscommentreplist=getViewPath("/qacomment-ajax-listreply");
	//所有子评论
	private static final String questionscommentreplistall=getViewPath("/qacomment-ajax-listreply_all");

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
	
	@InitBinder({"questionsComment"})
	public void initBinderQuestionsComment(WebDataBinder binder){
		binder.setFieldDefaultPrefix("questionsComment.");
	}

	@InitBinder({"page"})
	public void initBinderPage(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	/**
	 * 问答详情 问答回复列表
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping("/questionscomment/ajax/list")
	public ModelAndView getQuestionsCommentList(HttpServletRequest request, @ModelAttribute("questionsComment")QaComment questionsComment, @ModelAttribute("page") PageEntity page){
		ModelAndView model = new ModelAndView(questionscommentlist);
		try{
			Qa questions=questionsService.getQuestionsById(questionsComment.getQuestionId());
			model.addObject("questions", questions);
			
			page.setPageSize(3);
			List<QaComment> questionsCommentList = questionsCommentService.queryQuestionsCommentListByQuestionsId(questionsComment, page);
			model.addObject("questionsCommentList", questionsCommentList);
			model.addObject("page", page);
			
			User user= UserUtils.getUser();
			model.addObject("user", user);
			
			//查询最佳答案
			if(questions.getStatus()==1){//已采纳最佳答案
				questionsComment=new QaComment();
				//查找最佳回答回复
				questionsComment.setIsBest(1);//已采纳
				questionsComment.setQuestionId(questions.getId());
				questionsComment.setLimitSize(1);
				questions.setQuestionsCommentList(questionsCommentService.getQuestionsCommentList(questionsComment));
			}
		}catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("getQuestionsCommentList()---error",e);
		}
		return model;
	}
	
	/**
	 * 添加回答回复
	 */
	@RequestMapping("/questionscomment/ajax/add")
	@ResponseBody
	public Object addQuestionsComment(HttpServletRequest request, @ModelAttribute("questionsComment")QaComment questionsComment){
		Map<String,Object> json = new HashMap<String,Object>();
		try{
			String userId = UserUtils.getUser().getId();
			if (StringUtils.isEmpty(userId)) {
				json = this.setJson(false, "请先登录", "");
				return json;
			}
			questionsComment.setCusId(userId);
			questionsComment.setAddTime(new Date());
			questionsComment.setIsBest(0);
			questionsComment.setReplyCount(0);
			questionsComment.setPraiseCount(0);
			questionsComment.setCommentId(0L);
			questionsCommentService.addQuestionsComment(questionsComment);
			
			//修改问答的评论数
			Qa questions=questionsService.getQuestionsById(questionsComment.getQuestionId());
			questions.setReplyCount(questions.getReplyCount()+1);
			questionsService.updateQuestions(questions);
			json = this.setJson(true, "", "");
		}catch (Exception e) {
			json = this.setJson(false, "系统错误,请稍后重试", "");
			logger.error("addQuestionsComment()---error",e);
		}
		return json;
	}
	
	/**
	 * 添加回答 回复 评论
	 */
	@RequestMapping("/questionscomment/ajax/addReply")
	@ResponseBody
	public Object addQuestionsCommentReply(HttpServletRequest request, @ModelAttribute("questionsComment")QaComment questionsComment){
		Map<String,Object> json = new HashMap<String,Object>();
		try{
			String userId = UserUtils.getUser().getId();
			if (StringUtils.isEmpty(userId)) {
				json = this.setJson(false, "请先登录", "");
				return json;
			}
			questionsComment.setCusId(userId);
			questionsComment.setAddTime(new Date());
			questionsComment.setIsBest(0);
			questionsComment.setReplyCount(0);
			questionsComment.setPraiseCount(0);
			questionsComment.setQuestionId(0L);
			questionsCommentService.addQuestionsComment(questionsComment);
			
			//修改问答回复的评论数
			questionsComment=questionsCommentService.getQuestionsCommentById(questionsComment.getCommentId());
			questionsComment.setReplyCount(questionsComment.getReplyCount()+1);
			questionsCommentService.updateQuestionsComment(questionsComment);
			json = this.setJson(true, "", "");
		}catch (Exception e) {
			json = this.setJson(false, "系统错误,请稍后重试", "");
			logger.error("addQuestionsCommentReply()---error",e);
		}
		return json;
	}
	
	/**
	 * 采纳问答回复 为最佳答案
	 */
	@RequestMapping("/questionscomment/ajax/acceptComment")
	@ResponseBody
	public Object acceptComment(HttpServletRequest request, @ModelAttribute("questionsComment")QaComment questionsComment){
		Map<String,Object> json = new HashMap<String,Object>();
		try{
			String userId = UserUtils.getUser().getId();
			if (StringUtils.isEmpty(userId)) {
				json = this.setJson(false, "请先登录", "");
				return json;
			}
			//查询问答
			Qa questions=questionsService.getQuestionsById(questionsComment.getQuestionId());
			if (questions.getStatus()==1) {
				json = this.setJson(false, "该问答已采纳最佳答案", "");
				return json;
			}
			if(!userId.equals(questions.getCusId())){
				json = this.setJson(false, "您不是该问答的创建者,无权操作!", "");
				return json;
			}
			//查询问答回复评论
			questionsComment=questionsCommentService.getQuestionsCommentById(questionsComment.getCommentId());
			if(questionsComment.getCusId()==questions.getCusId()){
				json = this.setJson(false, "您自己发表的问答回复,不能采纳!", "");
				return json;
			}
			//修改问答回复为最佳答案状态
			questionsComment.setIsBest(1);
			questionsCommentService.updateQuestionsComment(questionsComment);
			//修改问答的状态未 已采纳最佳答案
			questions.setStatus(1);
			questionsService.updateQuestions(questions);
			json = this.setJson(true, "", "");
		}catch (Exception e) {
			json = this.setJson(false, "系统错误,请稍后重试", "");
			logger.error("acceptComment()---error",e);
		}
		return json;
	}
	
	/**
	 * 根据问答回复id  获取子评论 
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping("/questionscomment/ajax/getCommentById/{commentId}")
	public ModelAndView getQuestionsCommentById(HttpServletRequest request, @PathVariable("commentId")Long commentId){
		ModelAndView model = new ModelAndView(questionscommentreplist);
		try{
			QaComment questionsComment=new QaComment();
			questionsComment.setOrderFlag("new");
			//查找该评论下的子评论
			questionsComment.setCommentId(commentId);
			questionsComment.setLimitSize(9);
			List<QaComment> questionsCommentRepList=questionsCommentService.getQuestionsCommentList(questionsComment);
			model.addObject("questionsCommentRepList", questionsCommentRepList);
		}catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("getQuestionsCommentById()---error",e);
		}
		return model;
	}
	
	/**
	 * 根据问答回复id  获取所有子评论 
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping("/questionscommentall/ajax/getCommentById/{commentId}")
	public ModelAndView getAllQuestionsCommentById(HttpServletRequest request, @PathVariable("commentId")Long commentId){
		ModelAndView model = new ModelAndView(questionscommentreplistall);
		try{
			QaComment questionsComment=new QaComment();
			questionsComment.setOrderFlag("new");
			//查找该评论下的子评论
			questionsComment.setCommentId(commentId);
			List<QaComment> questionsCommentRepList=questionsCommentService.getQuestionsCommentList(questionsComment);
			model.addObject("questionsCommentRepList", questionsCommentRepList);
			
			questionsComment=questionsCommentService.getQuestionsCommentById(commentId);
			model.addObject("questionsComment",questionsComment);
		}catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("getAllQuestionsCommentById()---error",e);
		}
		return model;
	}


	@RequestMapping({"/ran/random"})
	public void genericRandomCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setHeader("Cache-Control", "private,no-cache,no-store");
		response.setContentType("image/png");
		HttpSession session = request.getSession();
		byte width = 85;
		byte height = 28;
		BufferedImage image = new BufferedImage(width, height, 2);
		Graphics2D g = image.createGraphics();
		g.setComposite(AlphaComposite.getInstance(3, 1.0F));
		Random random = new Random();
		g.setColor(new Color(231, 231, 231));
		g.fillRect(0, 0, width, height);
		g.setFont(new Font("Microsoft YaHei", 2, 24));
		String sRand = "";

		for(int var12 = 0; var12 < 4; ++var12) {
			String rand = String.valueOf(random.nextInt(10));
			sRand = sRand + rand;
			g.setColor(new Color(121, 143, 96));
			g.drawString(rand, 13 * var12 + 16, 23);
		}

		session.setAttribute("COMMON_RAND_CODE", sRand);
		g.dispose();
		ServletOutputStream sos = response.getOutputStream();
		ImageIO.write(image, "png", sos);
		sos.close();
	}
}
