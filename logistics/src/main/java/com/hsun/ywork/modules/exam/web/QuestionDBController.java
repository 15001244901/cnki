/**
 *
 */
package com.hsun.ywork.modules.exam.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.modules.exam.service.QuestionDBService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.exam.entity.QuestionDB;

/**
 * 题库Controller
 * @author GeCoder
 * @version 2017-01-17
 */
@Controller
@RequestMapping(value = "${adminPath}/exam/questionDB")
public class QuestionDBController extends BaseController {

	@Autowired
	private QuestionDBService questionDBService;
	
	@ModelAttribute
	public QuestionDB get(@RequestParam(required=false) String id) {
		QuestionDB entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = questionDBService.get(id);
		}
		if (entity == null){
			entity = new QuestionDB();
		}
		return entity;
	}
	
	@RequiresPermissions("exam:questionDB:view")
	@RequestMapping(value = {"list", ""})
	public String list(QuestionDB questionDB, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<QuestionDB> page = questionDBService.findPage(new Page<QuestionDB>(request, response), questionDB); 
		model.addAttribute("page", page);
		return "modules/exam/questionDBList";
	}

	@RequiresPermissions("exam:questionDB:view")
	@RequestMapping(value = "form")
	public String form(QuestionDB questionDB, Model model) {
		model.addAttribute("questionDB", questionDB);
		return "modules/exam/questionDBForm";
	}

	@RequiresPermissions("exam:questionDB:edit")
	@RequestMapping(value = "save")
	public String save(QuestionDB questionDB, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, questionDB)){
			return form(questionDB, model);
		}
		questionDBService.save(questionDB);
		addMessage(redirectAttributes, "保存题库成功");
		return "redirect:"+ Global.getAdminPath()+"/exam/questionDB/?repage";
	}
	
	@RequiresPermissions("exam:questionDB:edit")
	@RequestMapping(value = "delete")
	public String delete(QuestionDB questionDB, RedirectAttributes redirectAttributes) {
		questionDBService.delete(questionDB);
		addMessage(redirectAttributes, "删除题库成功");
		return "redirect:"+Global.getAdminPath()+"/exam/questionDB/?repage";
	}

}