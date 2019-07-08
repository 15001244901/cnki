/**
 *
 */
package com.hsun.ywork.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.persistence.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.sys.entity.Log;
import com.hsun.ywork.modules.sys.service.LogService;

/**
 * 日志Controller
 * @author GeCoder
 * @version 2013-6-2
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/log")
public class LogController extends BaseController {

	@Autowired
	private LogService logService;
	
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = {"list", ""})
	public String list(Log log, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Log> page = logService.findPage(new Page<Log>(request, response), log);
        model.addAttribute("page", page);
		return "modules/sys/logList";
	}

}
