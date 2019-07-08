/**
 *
 */
package com.hsun.ywork.modules.standard.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.FileUtils;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.standard.entity.YWStandard;
import com.hsun.ywork.modules.standard.service.YWStandardService;
import com.hsun.ywork.modules.sys.service.SystemService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import static oracle.net.aso.C01.r;

/**
 * 标准管理Controller
 * @author GeCoder
 * @version 2016-11-23
 */
@Controller
@RequestMapping(value = "${adminPath}/standard/yWStandard")
public class YWStandardController extends BaseController {

	@Autowired
	private YWStandardService yWStandardService;

	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public YWStandard get(@RequestParam(required=false) String id) {
		YWStandard entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = yWStandardService.get(id);
		}
		if (entity == null){
			entity = new YWStandard();
		}
		return entity;
	}
	
	@RequiresPermissions("standard:yWStandard:view")
	@RequestMapping(value = {"list", ""})
	public String list(YWStandard yWStandard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<YWStandard> page = yWStandardService.findPage(new Page<YWStandard>(request, response), yWStandard);
		model.addAttribute("page", page);
		return "modules/standard/yWStandardList";
	}

	@RequiresPermissions("standard:yWStandard:view")
	@RequestMapping(value = "form")
	public String form(YWStandard yWStandard, Model model) {
		model.addAttribute("yWStandard", yWStandard);
		return "modules/standard/yWStandardForm";
	}

	@RequiresPermissions("standard:yWStandard:edit")
	@RequestMapping(value = "save")
	public String save(YWStandard yWStandard, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, yWStandard)){
			return form(yWStandard, model);
		}
		yWStandardService.save(yWStandard);
		addMessage(redirectAttributes, "保存标准管理成功");
		return "redirect:"+ Global.getAdminPath()+"/standard/yWStandard/?repage&category="+yWStandard.getCategory();
	}
	
	@RequiresPermissions("standard:yWStandard:edit")
	@RequestMapping(value = "delete")
	public String delete(YWStandard yWStandard, RedirectAttributes redirectAttributes) {
		yWStandardService.delete(yWStandard);
		addMessage(redirectAttributes, "删除标准管理成功");
		return "redirect:"+Global.getAdminPath()+"/standard/yWStandard/?repage&category="+yWStandard.getCategory();
	}

	@RequiresPermissions("standard:yWStandard:view")
	@RequestMapping(value = "attachPreview")
	public String attachPreview(HttpServletRequest req ,
								HttpServletResponse resp ,
								String fileURL ,
								String showType ,
								Model model){
		if(showType==null)
			showType = "pdf";
		String targetFileURL = fileURL.substring(0,fileURL.lastIndexOf(".")+1)+showType;
		String fileName = null;
		fileURL = fileURL.replaceAll(req.getContextPath(),"");
		String filePath = req.getSession().getServletContext().getRealPath(fileURL.substring(0,fileURL.lastIndexOf("/")));
		String exePath = req.getSession().getServletContext().getRealPath("/static/flash");
		try {
			fileName = URLDecoder.decode(fileURL.substring(fileURL.lastIndexOf("/")+1),"UTF-8");
			String targetFileRealPath = systemService.getTargetFilePath(filePath,fileName,"swf".equals(showType)?exePath:null);
			model.addAttribute("fileSize", FileUtils.getFileSize(targetFileRealPath));
			targetFileURL = URLDecoder.decode(targetFileURL,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		model.addAttribute("targetFileURL",targetFileURL);
		model.addAttribute("showType",showType);
		return "modules/standard/stdAttachPreview";
	}

	@RequiresPermissions("standard:yWStandard:view")
	@RequestMapping(value = "{showType}/preview")
	public String preview(HttpServletRequest req ,
						  HttpServletResponse resp ,
						  @PathVariable String showType ,
						  YWStandard ywStandard,
						  Model model){
		String fileURL = null;
		model.addAttribute("showType",showType);
		if(ywStandard.getFiles()!=null){
			String[] urls = ywStandard.getFiles().split("\\|");
			for(String url : urls){
				if(!"".equals(url)) {
					fileURL = url;//如果有多个附件，目前只取第一个
					break;
				}
			}
		}

		if(fileURL != null)
			this.attachPreview(req,resp,fileURL,showType,model);
		else {
			model.addAttribute("error","文档筹备中...");
			//找不到文件附件时，将错误信息返回到错误页面，或者定位到一个固定的PDF文件中，显示错误信息
		}


		model.addAttribute("m",ywStandard);
		if("swf".equals(showType))
			return "modules/standard/stdSwfPreview";
		else
			return "modules/standard/stdPdfPreview";
	}

	@RequiresPermissions("standard:yWStandard:view")
	@RequestMapping(value = {"listf"})
	public String listInFront(YWStandard ywStandard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<YWStandard> page = new Page<YWStandard>(request, response);
		page.setPageSize(5);
		page = yWStandardService.findPage(page, ywStandard);
		page.setPageStyle(2);
		model.addAttribute("page", page);
		return "modules/standard/stdListInFront";
	}


	//----------------以下为前端调用json接口，暂时关闭权限验证--------------

	/**
	 * 前端访问标准列表页json数据接口
	 * @param yWStandard
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "list.jhtml")
	@ResponseBody
	public Object list(YWStandard yWStandard, HttpServletRequest request, HttpServletResponse response) {
		Map ret = new HashMap();
		try {
			Page<YWStandard> page = new Page<YWStandard>(request, response);
			page.setPageSize(10);
			page = yWStandardService.findPage(page, yWStandard);
			page.setPageStyle(2);
			ret.put("success",true);
			ret.put("data",page);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
		} finally {
			String callback = request.getParameter("callback");
			if(StringUtils.isNotBlank(callback)){
				MappingJacksonValue json = new MappingJacksonValue(ret);
				json.setJsonpFunction(callback);
				return json;
			} else {
				return ret;
			}
		}
	}


	/**
	 * 前端访问标准内容页的json数据接口
	 * @param showType
	 * @param ywStandard
	 * @return
	 */
	@RequestMapping(value = "{showType}/preview.jhtml")
	@ResponseBody
	public Object preview(@PathVariable String showType ,
						  YWStandard ywStandard , HttpServletRequest request){
		Map ret = new HashMap();
		try {
//			ywStandard.setFiles(URLDecoder.decode(ywStandard.getFiles(),"UTF-8"));
			ret.put("success",true);
			ret.put("data",ywStandard);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
		} finally {
			ret.put("showType",showType);
			String callback = request.getParameter("callback");
			if(StringUtils.isNotBlank(callback)){
				MappingJacksonValue json = new MappingJacksonValue(ret);
				json.setJsonpFunction(callback);
				return json;
			} else {
				return ret;
			}
		}
	}
}