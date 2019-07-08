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
import com.hsun.ywork.modules.logistics.entity.Goodinfo;
import com.hsun.ywork.modules.logistics.service.GoodinfoService;

import java.util.HashMap;
import java.util.Map;

import static java.awt.SystemColor.info;

/**
 * 货物信息Controller
 * @author 白云飞
 * @version 2018-04-09
 */
@Controller
@RequestMapping(value = "${adminPath}/logistics/goodinfo")
public class GoodinfoController extends BaseController {

	@Autowired
	private GoodinfoService goodinfoService;
	
	@ModelAttribute
	public Goodinfo get(@RequestParam(required=false) String id) {
		Goodinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodinfoService.get(id);
		}
		if (entity == null){
			entity = new Goodinfo();
		}
		/*System.out.println(entity.getGaddr());
		System.out.println(entity.getDelFlag());
		System.out.println(entity.getGdfje());
		System.out.println(entity.getGfhr());
		System.out.println(entity.getGlxdh());
		System.out.println(entity.getGssje());
		System.out.println("??????????????????????");*/
		return entity;
	}
	
	@RequiresPermissions("logistics:goodinfo:view")
	@RequestMapping(value = {"list", ""})
	//@ResponseBody
	public String list(Goodinfo goodinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
	/*	System.out.println(goodinfo.getGffxf());
		System.out.println(goodinfo.getGfhrq());
		System.out.println(goodinfo.getGdianfu());
		System.out.println(goodinfo.getGbjed());
		System.out.println(goodinfo.getGname());
		System.out.println(goodinfo.getGno());
		System.out.println(goodinfo.getGsfzt());
		System.out.println(goodinfo.getGstatus());
		System.out.println("?????????????????////");*/
		Page<Goodinfo> page = goodinfoService.findPage(new Page<Goodinfo>(request, response), goodinfo); 
		model.addAttribute("page", page);
		
		return "modules/logistics/goodinfoList";
	}

	@RequiresPermissions("logistics:goodinfo:view")
	@RequestMapping(value = "form")
	public String form(Goodinfo goodinfo, Model model) {
		if(StringUtils.isEmpty(goodinfo.getId())) {
			goodinfo.setIsread("0");
			goodinfo.setDatatype("0");
			goodinfo.setGfklx("1");
			goodinfo.setGsfzt("0");
			goodinfo.setGstatus("1");
		}
		model.addAttribute("goodinfo", goodinfo);
		return "modules/logistics/goodinfoForm";
	}

	@RequiresPermissions("logistics:goodinfo:edit")
	@RequestMapping(value = "save")
	public String save(Goodinfo goodinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodinfo)){
			return form(goodinfo, model);
		}
		goodinfoService.save(goodinfo);
		addMessage(redirectAttributes, "保存货物信息成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/goodinfo/?repage";
	}
	
	@RequiresPermissions("logistics:goodinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(Goodinfo goodinfo, RedirectAttributes redirectAttributes) {
		goodinfoService.delete(goodinfo);
		addMessage(redirectAttributes, "删除货物信息成功");
		return "redirect:"+Global.getAdminPath()+"/logistics/goodinfo/?repage";
	}
//=================================================================================================
//	@RequiresPermissions("logistics:goodinfo:edit")
	@RequestMapping(value = "save.jhtml")
	@ResponseBody
	public Object save(Goodinfo goodinfo, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			if (beanValidator(ret, goodinfo)){
				this.goodinfoService.save(goodinfo);
				ret.put("entity", goodinfo);
				ret.put("msg","保存货物信息成功！");
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

	@RequestMapping("list.jhtml")
	@ResponseBody
	public Object list(Goodinfo goodinfo, HttpServletRequest request, HttpServletResponse response) {
		Map ret = new HashMap();
		try {
			Page<Goodinfo> page = new Page<Goodinfo>(request, response);
            //page.setPageSize(5);
            goodinfoService.findPage(page, goodinfo);
			ret.put("data", page.getList());
			ret.put("msg","请求数据成功！");
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

//	@RequiresPermissions("logistics:goodinfo:view")
	@RequestMapping(value = "fetch.jhtml")
	@ResponseBody
	public Object fetch(Goodinfo goodinfo, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
		    if(StringUtils.isNotEmpty(goodinfo.getGno()))
		        goodinfo = goodinfoService.getByGno(goodinfo.getGno());
			if(goodinfo == null)
				goodinfo = new Goodinfo();
			ret.put("entity", goodinfo);
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

//	@RequiresPermissions("logistics:goodinfo:edit")
	@RequestMapping(value = "updatestatus.jhtml")
	@ResponseBody
	public Object updateStatus(Goodinfo goodinfo, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			if (beanValidator(ret, goodinfo)){
				this.goodinfoService.updateStatus(goodinfo);
				ret.put("msg","货物信息状态更新成功！");
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

	//	@RequiresPermissions("logistics:goodinfo:edit")
	@RequestMapping(value = "delete.jhtml")
	@ResponseBody
	public Object delete(Goodinfo goodinfo, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			this.goodinfoService.delete(goodinfo);
			ret.put("msg","货物信息删除成功！");
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

	/**
	 * 更新物流数据是否被读取的状态（isread:0未读，1已读）
	 * @param goodinfo
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "updateIsread.jhtml")
	@ResponseBody
	public Object updateIsread(Goodinfo goodinfo, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			if (beanValidator(ret, goodinfo)){
				this.goodinfoService.updateIsread(goodinfo);
				ret.put("msg","货物信息读取状态更新成功！");
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

	@RequestMapping("listWxNoRead.jhtml")
	@ResponseBody
	public Object listWxNoRead(Goodinfo goodinfo, HttpServletRequest request, HttpServletResponse response) {
		// 查询是微信录入并且未读的物流记录
		goodinfo.setDatatype("1");
		goodinfo.setIsread("1");
		return list(goodinfo,request,response);
	}

	//	@RequiresPermissions("logistics:goodinfo:edit")
	@RequestMapping(value = "saveWxData.jhtml")
	@ResponseBody
	public Object saveWxData(Goodinfo goodinfo, HttpServletRequest request) {

		// TODO: 2018-06-29  这里可以为微信小程序界面中没有的字段设定默认值
		// 保存微信录入的数据并标记为未读
		goodinfo.setDatatype("1");
		goodinfo.setIsread("1");
		goodinfo.setGfklx("1");
		goodinfo.setGsfzt("0");
		goodinfo.setGstatus("1");
		return this.save(goodinfo,request);
	}

}