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
import com.hsun.ywork.modules.logistics.entity.Ticketposition;
import com.hsun.ywork.modules.logistics.service.TicketpositionService;

import java.util.HashMap;
import java.util.Map;

/**
 * 订票铺位Controller
 * @author 白云飞
 * @version 2018-06-29
 */
@Controller
@RequestMapping(value = "${adminPath}/logistics/ticketposition")
public class TicketpositionController extends BaseController {

	@Autowired
	private TicketpositionService ticketpositionService;
	
	@ModelAttribute
	public Ticketposition get(@RequestParam(required=false) String id) {
		Ticketposition entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ticketpositionService.get(id);
		}
		if (entity == null){
			entity = new Ticketposition();
		}
		return entity;
	}
	
	@RequiresPermissions("logistics:ticketposition:view")
	@RequestMapping(value = {"list", ""})
	public String list(Ticketposition ticketposition, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Ticketposition> page = ticketpositionService.findPage(new Page<Ticketposition>(request, response), ticketposition); 
		model.addAttribute("page", page);
		return "modules/logistics/ticketpositionList";
	}

	@RequiresPermissions("logistics:ticketposition:view")
	@RequestMapping(value = "form")
	public String form(Ticketposition ticketposition, Model model) {
		model.addAttribute("ticketposition", ticketposition);
		return "modules/logistics/ticketpositionForm";
	}

	@RequiresPermissions("logistics:ticketposition:edit")
	@RequestMapping(value = "save")
	public String save(Ticketposition ticketposition, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, ticketposition)){
			return form(ticketposition, model);
		}
		ticketpositionService.save(ticketposition);
		addMessage(redirectAttributes, "保存铺位成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/ticketposition/?repage";
	}
	
	@RequiresPermissions("logistics:ticketposition:edit")
	@RequestMapping(value = "delete")
	public String delete(Ticketposition ticketposition, RedirectAttributes redirectAttributes) {
		ticketpositionService.delete(ticketposition);
		addMessage(redirectAttributes, "删除铺位成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/ticketposition/?repage";
	}

	//------------------------------ 以下为前后端分离接口部分 --------------------------------

	@RequiresPermissions("logistics:ticketposition:view")
	@RequestMapping(value = "index")
	public String index() {
		return "modules/logistics/ticketpositionIndex";
	}

	@RequestMapping("/list.jhtml")
	@ResponseBody
	public Object listJSON(Ticketposition ticketposition , HttpServletRequest request , HttpServletResponse response) {
		Map ret = new HashMap();
		try {
			Page<Ticketposition> page = ticketpositionService.findPage(new Page<Ticketposition>(request, response), ticketposition);
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

	@RequiresPermissions("logistics:ticketposition:edit")
	@RequestMapping(value = "save.jhtml")
	@ResponseBody
	public Object save(Ticketposition ticketposition, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			if (beanValidator(ret, ticketposition)){
				this.ticketpositionService.save(ticketposition);
				ret.put("data", ticketposition);
				ret.put("msg","保存铺位成功");
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

	@RequiresPermissions("logistics:ticketposition:edit")
	@RequestMapping(value = "delete.jhtml")
	@ResponseBody
	public Object delete(Ticketposition ticketposition, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			ticketpositionService.delete(ticketposition);
			ret.put("msg", "删除铺位成功");
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
	public Object fetch(Ticketposition ticketposition, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			ret.put("data", ticketposition);
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