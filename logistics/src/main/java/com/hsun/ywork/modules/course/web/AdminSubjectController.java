package com.hsun.ywork.modules.course.web;

import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.course.entity.QuerySubject;
import com.hsun.ywork.modules.course.entity.Subject;
import com.hsun.ywork.modules.course.service.SubjectService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
 * 专业 Controller
 * @author GeCoder
 */
@Controller
@RequestMapping("${adminPath}/course/subj")
public class AdminSubjectController extends BaseController {
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(AdminSubjectController.class);
	@Autowired
	private SubjectService subjectService;

	// 返回路径
	private String toSubjectList = getViewPath("/course/subjectList");// 专业列表

	// 绑定变量名字和属性，参数封装进类
	@InitBinder("subject")
	public void initBinderSubject(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("subject.");
	}

	/**
	 * 删除专业
	 */
	@ResponseBody
	@RequestMapping({"/{subjectId}/delete.jhtml","/deleteSubject/{subjectId}}"})
	@RequiresPermissions("course:subject:edit")
	public Map<String, Object> deleteSubject(@PathVariable("subjectId") int subjectId) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			subjectService.deleteSubject(subjectId);
			json = this.setJson(true, null, null);
		} catch (Exception e) {
			this.setAjaxException(json);
			logger.error("deleteSubject()--error", e);
		}
		return json;
	}

	/**
	 * 修改文件名
	 */
	@RequestMapping({"/updatename.jhtml","/updatesubjectName"})
	@ResponseBody
	@RequiresPermissions("course:subject:edit")
	public Map<String, Object> updateSubjectName(@ModelAttribute("subject") Subject subject) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			subjectService.updateSubject(subject);
			json = this.setJson(true, null, null);
		} catch (Exception e) {
			this.setAjaxException(json);
			logger.error("updateSubjectName()--error", e);
		}
		return json;
	}
	/**
	 * 修改排序
	 */
	@RequestMapping({"/updatesort.jhtml","/updatesort"})
	@ResponseBody
	@RequiresPermissions("course:subject:edit")
	public Map<String, Object> updateSort(@ModelAttribute("subject") Subject subject) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			subjectService.updateSubjectSort(subject);
			json = this.setJson(true, null, null);
		} catch (Exception e) {
			this.setAjaxException(json);
			logger.error("updateSort()--error", e);
		}
		return json;
	}
	
	/**
	 * 修改专业父ID
	 */
	@RequestMapping({"/{parentId}/{subjectId}/updatepid.jhtml","/updateparentid/{parentId}/{subjectId}"})
	@ResponseBody
	@RequiresPermissions("course:subject:edit")
	public Map<String, Object> updateParentId(@PathVariable("parentId") int parentId, @PathVariable("subjectId") int subjectId) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			subjectService.updateSubjectParentId(subjectId, parentId);
			json = this.setJson(true, null, null);
		} catch (Exception e) {
			this.setAjaxException(json);
			logger.error("updateParentId()---error", e);
		}
		return json;
	}

	/**
	 * 创建专业
	 */
	@RequestMapping({"/create.jhtml","/createSubject"})
	@ResponseBody
	@RequiresPermissions("course:subject:edit")
	public Map<String, Object> createSubject(@ModelAttribute("subject") Subject subject) {
		Map<String,Object> json = new HashMap<String,Object>();
		try {
			subject.setCreateTime(new Date());
			subjectService.createSubject(subject);
			json = this.setJson(true, null, subject);
		} catch (Exception e) {
			this.setAjaxException(json);
			logger.error("createSubject()---error", e);
		}
		return json;
	}

	/**
	 * 到专业列表页面
	 */
	@RequestMapping("/toSubjectList")
	public ModelAndView toSubjectList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView();
		try {
			model.setViewName(toSubjectList);
			QuerySubject querySubject = new QuerySubject();
			List<Subject> subjectList = subjectService.getSubjectList(querySubject);
			model.addObject("subjectList", gson.toJson(subjectList).toString());
		} catch (Exception e) {
			model.setViewName(this.setExceptionRequest(request, e));
			logger.error("toSubjectList()---error", e);
		}
		return model;
	}

	//--------------------- 前后端分离模式接口部分----------------------------------
	/**
	 * 到专业列表页面
	 */
	@RequestMapping("/toList.jhtml")
	@RequiresPermissions("course:subject:view")
	public String toList(HttpServletRequest request, HttpServletResponse response) {
		return toSubjectList;
	}

	/**
	 * 专业列表
	 */
	@ResponseBody
	@RequestMapping("/list.jhtml")
	@RequiresPermissions("course:subject:view")
	public Object listAjax(HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			QuerySubject querySubject = new QuerySubject();
			List<Subject> subjectList = subjectService.getSubjectList(querySubject);
			ret.put("data", subjectList);
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
