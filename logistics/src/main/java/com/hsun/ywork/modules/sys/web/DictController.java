/**
 *
 */
package com.hsun.ywork.modules.sys.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.modules.sys.entity.Dict;
import com.hsun.ywork.modules.sys.service.DictService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;

/**
 * 字典Controller
 * @author GeCoder
 * @version 2014-05-16
 */
// TODO: 2017-08-10  暂时关闭权限验证
@Controller
@RequestMapping(value = "${adminPath}/sys/dict")
public class DictController extends BaseController {

	@Autowired
	private DictService dictService;
	
	@ModelAttribute
	public Dict get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return dictService.get(id);
		}else{
			return new Dict();
		}
	}
	
//	@RequiresPermissions("sys:dict:view")
    @RequiresPermissions("user")
	@RequestMapping(value = {"list", ""})
	public String list(Dict dict, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<String> typeList = dictService.findTypeList();
		model.addAttribute("typeList", typeList);
        Page<Dict> page = new Page<Dict>(request, response);
		page.setPageSize(100000);
		page = dictService.findPage(page, dict);
        model.addAttribute("page", page);
		return "modules/sys/dictList";
	}

//	@RequiresPermissions("sys:dict:view")
    @RequiresPermissions("user")
	@RequestMapping(value = "form")
	public String form(Dict dict, Model model) {

		Dict parentDict = null;
		if (dict.getParentId()!=null && StringUtils.isNotBlank(dict.getParentId())){
			parentDict = dictService.get(dict.getParentId());
		}
		if (dict.getSort() == null){
			dict.setSort(30);
		}
		model.addAttribute("parentDict", parentDict);
		model.addAttribute("dict", dict);
		return "modules/sys/dictForm";
	}

//	@RequiresPermissions("sys:dict:view")
    @RequiresPermissions("user")
	@RequestMapping(value = "formSimple")
	public String formSimple(Dict dict, Model model) {

		Dict parentDict = null;
		if (dict.getParentId()!=null && StringUtils.isNotBlank(dict.getParentId())){
			parentDict = dictService.get(dict.getParentId());
		}
		if (dict.getSort() == null){
			dict.setSort(30);
		}
		model.addAttribute("parentDict", parentDict);
		model.addAttribute("dict", dict);
		return "modules/sys/dictFormSimple";
	}

//	@RequiresPermissions("sys:dict:edit")
    @RequiresPermissions("user")
	@RequestMapping(value = "save")//@Valid 
	public String save(Dict dict, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/dict/?repage&type="+dict.getType();
		}
		if (!beanValidator(model, dict)){
			return form(dict, model);
		}
		if(StringUtils.isEmpty(dict.getParentId()))
		    dict.setParentId("0");
		dictService.save(dict);
		addMessage(redirectAttributes, "保存字典'" + dict.getLabel() + "'成功");
		return "redirect:" + adminPath + "/sys/dict/?repage&type="+dict.getType();
	}


//	@RequiresPermissions("sys:dict:edit")
    @RequiresPermissions("user")
	@RequestMapping(value = "delete")
	public String delete(Dict dict, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/dict/?repage";
		}
		dictService.delete(dict);
		addMessage(redirectAttributes, "删除字典成功");
		return "redirect:" + adminPath + "/sys/dict/?repage&type="+dict.getType();
	}
	
	@ResponseBody
	@RequestMapping(value = {"treeData","treeData.jhtml"})
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String type, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Dict dict = new Dict();
		dict.setType(type);
		List<Dict> list = dictService.findList(dict);
		for (int i=0; i<list.size(); i++){
			Dict e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", e.getParentId());
			map.put("name", StringUtils.replace(e.getLabel(), " ", ""));
			map.put("code", e.getValue());
			mapList.add(map);
		}
		return mapList;
	}

	/**
	 * 前端获取字典的json数据接口
	 * @param type
	 * @param parentId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "listData.jhtml")
	public Object listData(@RequestParam(required=false) String type , @RequestParam(required=false) String parentId , HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			Dict dict = new Dict();
			dict.setType(type);
			dict.setParentId(parentId);
			dict.setDelFlag("0");
			ret.put("success",true);
			ret.put("data",dictService.findList(dict));
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

}
