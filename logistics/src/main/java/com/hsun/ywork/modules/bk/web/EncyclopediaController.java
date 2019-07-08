/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.bk.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.bk.entity.Encyclopedia;
import com.hsun.ywork.modules.bk.service.EncyclopediaService;

import java.util.HashMap;
import java.util.Map;

/**
 * 百科Controller
 * @author GeCoder
 * @version 2017-08-10
 */
@Controller
@RequestMapping(value = "${adminPath}/bk/encyclopedia")
public class EncyclopediaController extends BaseController {

	@Autowired
	private EncyclopediaService encyclopediaService;
	
	@ModelAttribute
	public Encyclopedia get(@RequestParam(required=false) String id) {
		Encyclopedia entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = encyclopediaService.get(id);
		}
		if (entity == null){
			entity = new Encyclopedia();
		}
		return entity;
	}
	
	@RequiresPermissions("bk:encyclopedia:view")
	@RequestMapping(value = {"list", ""})
	public String list(Encyclopedia encyclopedia, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Encyclopedia> page = encyclopediaService.findPage(new Page<Encyclopedia>(request, response), encyclopedia); 
		model.addAttribute("page", page);
		return "modules/bk/encyclopediaList";
	}

	@RequiresPermissions("bk:encyclopedia:view")
	@RequestMapping(value = "form")
	public String form(Encyclopedia encyclopedia, Model model) {
		model.addAttribute("encyclopedia", encyclopedia);
		return "modules/bk/encyclopediaForm";
	}

	@RequiresPermissions("bk:encyclopedia:edit")
	@RequestMapping(value = "save")
	public String save(Encyclopedia encyclopedia, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, encyclopedia)){
			return form(encyclopedia, model);
		}
		encyclopediaService.save(encyclopedia);
		addMessage(redirectAttributes, "保存百科词条成功");
		return "redirect:"+Global.getAdminPath()+"/bk/encyclopedia/?repage";
	}
	
	@RequiresPermissions("bk:encyclopedia:edit")
	@RequestMapping(value = "delete")
	public String delete(Encyclopedia encyclopedia, RedirectAttributes redirectAttributes) {
		encyclopediaService.delete(encyclopedia);
		addMessage(redirectAttributes, "删除百科词条成功");
		return "redirect:"+Global.getAdminPath()+"/bk/encyclopedia/?repage";
	}

	@RequestMapping("list.jhtml")
	@ResponseBody
	public Object list(Encyclopedia encyclopedia , HttpServletRequest request , HttpServletResponse response) {
		Map ret = new HashMap();
		try {
			ret.put("data", encyclopediaService.findPage(new Page<Encyclopedia>(request, response), encyclopedia));
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