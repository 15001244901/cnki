/**
 *
 */
package com.hsun.ywork.modules.doc.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.doc.entity.DocInfoDirectory;
import com.hsun.ywork.modules.doc.service.DocInfoDirectoryService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.hsun.ywork.common.utils.StringUtils;

import static com.sun.tools.javac.jvm.ByteCodes.ret;

/**
 * 文档目录Controller
 * @author GeCoder
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/doc/docInfoDirectory")
public class DocInfoDirectoryController extends BaseController {

	@Autowired
	private DocInfoDirectoryService docInfoDirectoryService;
	
	@ModelAttribute
	public DocInfoDirectory get(@RequestParam(required=false) String id) {
		DocInfoDirectory entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = docInfoDirectoryService.get(id);
		}
		if (entity == null){
			entity = new DocInfoDirectory();
		}
		return entity;
	}

	@RequiresPermissions("doc:docInfoDirectory:view")
	@RequestMapping(value = {"index"})
	public String index(DocInfoDirectory docInfoDirectory, Model model) {
		model.addAttribute("docInfoDirectory",docInfoDirectory);
		return "modules/doc/docInfoIndex";
	}
	
	@RequiresPermissions("doc:docInfoDirectory:view")
	@RequestMapping(value = {"list", ""})
	public String list(DocInfoDirectory docInfoDirectory, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<DocInfoDirectory> list = docInfoDirectoryService.findList(docInfoDirectory); 
		model.addAttribute("list", list);
		return "modules/doc/docInfoDirectoryList";
	}

	@RequiresPermissions("doc:docInfoDirectory:view")
	@RequestMapping(value = "form")
	public String form(DocInfoDirectory docInfoDirectory, Model model) {
		if (docInfoDirectory.getParent()!=null && StringUtils.isNotBlank(docInfoDirectory.getParent().getId())){
			docInfoDirectory.setParent(docInfoDirectoryService.get(docInfoDirectory.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(docInfoDirectory.getId())){
				DocInfoDirectory docInfoDirectoryChild = new DocInfoDirectory();
				docInfoDirectoryChild.setParent(new DocInfoDirectory(docInfoDirectory.getParent().getId()));
				List<DocInfoDirectory> list = docInfoDirectoryService.findList(docInfoDirectory); 
				if (list.size() > 0){
					docInfoDirectory.setSort(list.get(list.size()-1).getSort());
					if (docInfoDirectory.getSort() != null){
						docInfoDirectory.setSort(docInfoDirectory.getSort() + 1);
					}
				}
			}
		}
		if (docInfoDirectory.getSort() == null){
			docInfoDirectory.setSort(1);
		}
		model.addAttribute("docInfoDirectory", docInfoDirectory);
		return "modules/doc/docInfoDirectoryForm";
	}

	@RequiresPermissions("doc:docInfoDirectory:edit")
	@RequestMapping(value = "save")
	public String save(DocInfoDirectory docInfoDirectory, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, docInfoDirectory)){
			return form(docInfoDirectory, model);
		}
		if(StringUtils.isNotEmpty(docInfoDirectory.getParentId())) {
			DocInfoDirectory parent = docInfoDirectoryService.get(docInfoDirectory.getParent().getId());
			docInfoDirectory.setDtype(parent.getDtype());
			docInfoDirectory.setRtype(parent.getRtype());

			// 文库类型“认证认可”的下级目录标记为章
			if(docInfoDirectory.getDtype()==3)
				docInfoDirectory.setType("1");
			else
				docInfoDirectory.setType("2");

		}
		docInfoDirectoryService.save(docInfoDirectory);
		addMessage(redirectAttributes, "保存文档目录成功");
		return "redirect:"+ Global.getAdminPath()+"/doc/docInfoDirectory/?repage&dtype="+docInfoDirectory.getDtype();
	}
	
	@RequiresPermissions("doc:docInfoDirectory:edit")
	@RequestMapping(value = "delete")
	public String delete(DocInfoDirectory docInfoDirectory, RedirectAttributes redirectAttributes) {
		docInfoDirectoryService.delete(docInfoDirectory);
		addMessage(redirectAttributes, "删除文档目录成功");
		return "redirect:"+Global.getAdminPath()+"/doc/docInfoDirectory/?repage";
	}

	@ResponseBody
	@RequestMapping(value = "treeData")
	public List treeData(DocInfoDirectory con , @RequestParam(required=false) String extId) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		try {
			List<DocInfoDirectory> list = docInfoDirectoryService.findList(con);
			for (int i=0; i<list.size(); i++){
				DocInfoDirectory e = list.get(i);
				if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
					Map<String, Object> map = Maps.newHashMap();
					map.put("id", e.getId());
					map.put("pId", e.getParentId());
					map.put("name", e.getName());
					map.put("docId",e.getDocId());
					mapList.add(map);
				}
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		} finally {
			return mapList;
		}
	}


	//-----------------以下为前端调用接口----------------
	/**
	 * 文档目录树前端加载
	 * @param rtype
	 * @param extId
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "treeData.jhtml")
	public Object treeData(@RequestParam(required=false) int dtype , @RequestParam(required=false) String rtype , @RequestParam(required=false) String extId,HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			List<Map<String, Object>> mapList = Lists.newArrayList();
			DocInfoDirectory con = new DocInfoDirectory();
			con.setDtype(dtype);
			con.setRtype(rtype);
			con.setUid(UserUtils.getUser().getId());
			List<DocInfoDirectory> list = docInfoDirectoryService.findList(con);
			for (int i=0; i<list.size(); i++){
				DocInfoDirectory e = list.get(i);
				if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
					Map<String, Object> map = Maps.newHashMap();
					map.put("id", e.getId());
					map.put("pId", e.getParentId());
					map.put("name", e.getName());
					map.put("docId",e.getDocId());
					map.put("iscollected",e.getIscollected());
					mapList.add(map);
				}
			}
			ret.put("success",true);
			ret.put("data",mapList);
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
	 * 用户收藏文档目录树前端加载
	 * @param rtype
	 * @param extId
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "userTreeData.jhtml")
	public Object userTreeData(@RequestParam(required=false) int dtype , @RequestParam(required=false) String rtype , @RequestParam(required=false) String extId,HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			List<Map<String, Object>> mapList = Lists.newArrayList();
			DocInfoDirectory con = new DocInfoDirectory();
			con.setDtype(dtype);
			con.setRtype(rtype);
			con.setUid(UserUtils.getUser().getId());
			List<DocInfoDirectory> list = docInfoDirectoryService.findListByUser(con);
			for (int i=0; i<list.size(); i++){
				DocInfoDirectory e = list.get(i);
				if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
					Map<String, Object> map = Maps.newHashMap();
					map.put("id", e.getId());
					map.put("pId", e.getParentId());
					map.put("name", e.getName());
					map.put("docId",e.getDocId());
					map.put("iscollected",e.getIscollected());
					mapList.add(map);
				}
			}
			ret.put("success",true);
			ret.put("data",mapList);
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