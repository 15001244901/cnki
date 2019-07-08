/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.web;

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
import com.hsun.ywork.modules.logistics.entity.Goodaddr;
import com.hsun.ywork.modules.logistics.service.GoodaddrService;

import java.util.HashMap;
import java.util.Map;

/**
 * 收货地址管理Controller
 * @author 白云飞
 * @version 2018-04-08
 */
@Controller
@RequestMapping(value = "${adminPath}/logistics/goodaddr")
public class GoodaddrController extends BaseController {

	@Autowired
	private GoodaddrService goodaddrService;
	
	@ModelAttribute
	public Goodaddr get(@RequestParam(required=false) String id) {
		Goodaddr entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodaddrService.get(id);
		}
		if (entity == null){
			entity = new Goodaddr();
		}
		return entity;
	}
	
	@RequiresPermissions("logistics:goodaddr:view")
	@RequestMapping(value = {"list", ""})
	public String list(Goodaddr goodaddr, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Goodaddr> page = goodaddrService.findPage(new Page<Goodaddr>(request, response), goodaddr); 
		model.addAttribute("page", page);
		return "modules/logistics/goodaddrList";
	}

	@RequiresPermissions("logistics:goodaddr:view")
	@RequestMapping(value = "form")
	public String form(Goodaddr goodaddr, Model model) {
		model.addAttribute("goodaddr", goodaddr);
		return "modules/logistics/goodaddrForm";
	}

	@RequiresPermissions("logistics:goodaddr:edit")
	@RequestMapping(value = "save")
	public String save(Goodaddr goodaddr, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodaddr)){
			return form(goodaddr, model);
		}
		goodaddrService.save(goodaddr);
		addMessage(redirectAttributes, "保存收货地址成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/goodaddr/?repage";
	}
	
	@RequiresPermissions("logistics:goodaddr:edit")
	@RequestMapping(value = "delete")
	public String delete(Goodaddr goodaddr, RedirectAttributes redirectAttributes) {
		goodaddrService.delete(goodaddr);
		addMessage(redirectAttributes, "删除收货地址成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/goodaddr/?repage";
	}

	@ResponseBody
	@RequestMapping("list.jhtml")
	public Object list(Goodaddr goodaddr , HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			ret.put("data", this.goodaddrService.findList(goodaddr));
			ret.put("success", true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统繁忙！请稍后再试...");
			e.printStackTrace();
		} finally {
			return this.getJSONOrJSONPString(request, ret);
		}
	}

}