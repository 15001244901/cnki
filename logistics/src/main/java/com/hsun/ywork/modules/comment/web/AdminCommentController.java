package com.hsun.ywork.modules.comment.web;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.comment.entity.Comment;
import com.hsun.ywork.modules.comment.service.CommentService;
import com.hsun.ywork.modules.common.entity.PageEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 后台评论模块
 * @author GeCoder
 */
@Controller
@RequestMapping("${adminPath}/comment")
public class AdminCommentController extends BaseController {
	private static Logger logger = LoggerFactory.getLogger(AdminCommentController.class);
	// 评论列表
	private static String queryComment = getViewPath("/comment/comment-list");
	// 回复列表
	private static String queryCommentReply = getViewPath("/comment/comment-reply-list");
	// 回复详情
	private static String queryCommentInfo = getViewPath("/comment/comment_info");
	
	
	@Autowired
	private CommentService commentService;

	@InitBinder({"page"})
	public void initBinderPage(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	/**
	 * 查询评论
	 */
	@RequestMapping("/query")
	public String queryComment(HttpServletRequest request, @ModelAttribute("page") PageEntity page, Comment comment) {
		try {
			page.setPageSize(10);
			//查询评论一级
			comment.setPCommentId(0);
			List<Comment> commentList = commentService.getCommentByPage(comment, page);// 查询评论
			request.setAttribute("commentList", commentList);// 评论list
			request.setAttribute("comment", comment);// 查询评论条件
			request.setAttribute("page", page);
		} catch (Exception e) {
			logger.error("queryComment()--error", e);
		}
		return queryComment;
	}
	
	/**
	 * 查询评论回复
	 */
	@RequestMapping("/reply/query")
	public String queryCommentReply(HttpServletRequest request, @ModelAttribute("page") PageEntity page, Comment comment) {
		try {
			page.setPageSize(10);
			List<Comment> commentList = commentService.getCommentByPage(comment, page);// 查询评论
			request.setAttribute("commentList", commentList);// 评论list
			request.setAttribute("comment", comment);// 查询评论条件
			request.setAttribute("page", page);
		} catch (Exception e) {
			logger.error("queryComment()--error", e);
		}
		return queryCommentReply;
	}
	/**
	 * 删除评论 或者 评论回复
	 */
	@RequestMapping("/del/{commentId}")
	@ResponseBody
	public Map<String, Object>  delComment(HttpServletRequest request, @ModelAttribute("page") PageEntity page, @PathVariable("commentId") int commentId) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			commentService.delComment(commentId);
			setJson(true, "", "");
		} catch (Exception e) {
			this.setAjaxException(json);
			logger.error("queryComment()--error", e);
			setJson(false, "", "");
		}
		return json;
	}
	
	/**
	 * 查询评论详情
	 */
	@RequestMapping("/reply/info/{commentId}")
	public String queryCommentInfo(HttpServletRequest request, @PathVariable("commentId") int commentId) {
		try {
			//查询评论
			Comment comment = new Comment();
			comment.setCommentId(commentId);
			comment = commentService.queryComment(comment);
			request.setAttribute("comment", comment);// 评论
		} catch (Exception e) {
			logger.error("queryCommentInfo()--error", e);
		}
		return queryCommentInfo;
	}
	/**
	 * 更新评论
	 */
	@RequestMapping("/reply/update")
	public String updateCommentInfo(HttpServletRequest request, Comment comment) {
		try {
			//更新评论
			commentService.updateComment(comment);
			request.setAttribute("comment", comment);// 评论
		} catch (Exception e) {
			logger.error("updateCommentInfo()--error", e);
		}
		return "redirect:" + Global.getAdminPath() + "/comment/query";
	}
}
