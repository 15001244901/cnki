package com.hsun.ywork.modules.logistics.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.logistics.entity.Gooddatesum;
import com.hsun.ywork.modules.logistics.service.GooddatesumService;

/**
 * 货物按日期汇总controller
 * @author yp
 *
 */
@Controller
//前端页面请求路径{adminPath}/logistics/goodDateSum
@RequestMapping(value= "${adminPath}/logistics/gooddatesum")
public class GooddatesumController extends BaseController{
	@Autowired
	private GooddatesumService gooddatesumService;

	@RequiresPermissions("logistics:gooddatesum:view")
	@RequestMapping(value = {"list", "","search"})
	public String list(Gooddatesum gooddatesum, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Gooddatesum> page = gooddatesumService.findPage(new Page<Gooddatesum>(request, response), gooddatesum); 
		model.addAttribute("page", page);	
		return "modules/logistics/gooddatesumList";
	}
}
