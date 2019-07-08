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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.logistics.entity.Ticketorder;
import com.hsun.ywork.modules.logistics.service.TicketorderService;

import java.util.HashMap;
import java.util.Map;

/**
 * 订票订单Controller
 * @author 白云飞
 * @version 2018-06-29
 */
@Controller
@RequestMapping(value = "${adminPath}/logistics/ticketorder")
public class TicketorderController extends BaseController {

	@Autowired
	private TicketorderService ticketorderService;
	
	@ModelAttribute
	public Ticketorder get(@RequestParam(required=false) String id) {
		Ticketorder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ticketorderService.get(id);
		}
		if (entity == null){
			entity = new Ticketorder();
		}
		return entity;
	}
	
	@RequiresPermissions("logistics:ticketorder:view")
	@RequestMapping(value = {"list", ""})
	public String list(Ticketorder ticketorder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Ticketorder> page = ticketorderService.findPage(new Page<Ticketorder>(request, response), ticketorder); 
		model.addAttribute("page", page);
		return "modules/logistics/ticketorderList";
	}

	@RequiresPermissions("logistics:ticketorder:view")
	@RequestMapping(value = "form")
	public String form(Ticketorder ticketorder, Model model) {
		model.addAttribute("ticketorder", ticketorder);
		return "modules/logistics/ticketorderForm";
	}

	@RequiresPermissions("logistics:ticketorder:edit")
	@RequestMapping(value = "save")
	public String save(Ticketorder ticketorder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ticketorder)){
			return form(ticketorder, model);
		}
		ticketorderService.save(ticketorder);
		addMessage(redirectAttributes, "保存订票订单成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/ticketorder/?repage";
	}
	
	@RequiresPermissions("logistics:ticketorder:edit")
	@RequestMapping(value = "delete")
	public String delete(Ticketorder ticketorder, RedirectAttributes redirectAttributes) {
		ticketorderService.delete(ticketorder);
		addMessage(redirectAttributes, "删除订票订单成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/ticketorder/?repage";
	}

	//------------------------------ 以下为前后端分离接口部分 --------------------------------

	@RequiresPermissions("logistics:ticketorder:view")
	@RequestMapping(value = "index")
	public String index() {
		return "modules/logistics/ticketorderIndex";
	}

	@RequestMapping("/list.jhtml")
	@ResponseBody
	public Object listJSON(Ticketorder ticketorder , HttpServletRequest request , HttpServletResponse response) {
		Map ret = new HashMap();
		try {
			Page<Ticketorder> page = ticketorderService.findPage(new Page<Ticketorder>(request, response), ticketorder);
			ret.put("data", page);
			ret.put("success", true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统繁忙，请稍后再试...");
			e.printStackTrace();
		} finally {
			return this.getJSONOrJSONPString(request, ret);
		}
	}

//	@RequiresPermissions("logistics:ticketorder:edit")
	@RequestMapping(value = "save.jhtml")
	@ResponseBody
	public Object save(Ticketorder ticketorder, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			if (beanValidator(ret, ticketorder)){
				this.ticketorderService.save(ticketorder);
				ret.put("data", ticketorder);
				ret.put("msg","保存订票订单成功");
				ret.put("success", true);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统繁忙，请稍后再试...");
			e.printStackTrace();
		} finally {
			return this.getJSONOrJSONPString(request, ret);
		}
	}

//	@RequiresPermissions("logistics:ticketorder:edit")
	@RequestMapping(value = "delete.jhtml")
	@ResponseBody
	public Object delete(Ticketorder ticketorder, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			ticketorderService.delete(ticketorder);
			ret.put("msg", "删除订票订单成功");
			ret.put("success", true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统繁忙，请稍后再试...");
			e.printStackTrace();
		} finally {
			return this.getJSONOrJSONPString(request, ret);
		}
	}

	// 暂时不做权限控制，方便前端调用
	@RequestMapping(value = "fetch.jhtml")
	@ResponseBody
	public Object fetch(Ticketorder ticketorder, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			ret.put("data", ticketorder);
			ret.put("msg","获取数据成功！");
			ret.put("success", true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统繁忙，请稍后再试...");
			e.printStackTrace();
		} finally {
			return this.getJSONOrJSONPString(request, ret);
		}
	}
}