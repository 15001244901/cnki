/**
 *
 */
package com.hsun.ywork.modules.sys.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.modules.sys.entity.Office;
import com.hsun.ywork.modules.sys.entity.Role;
import com.hsun.ywork.modules.sys.service.OfficeService;
import com.hsun.ywork.modules.sys.service.SystemService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.utils.DictUtils;

import static oracle.net.aso.C05.e;
import static org.apache.shiro.web.filter.mgt.DefaultFilter.user;

/**
 * 机构Controller
 * @author GeCoder
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/office")
public class OfficeController extends BaseController {

	@Autowired
	private OfficeService officeService;

	@Autowired
	private SystemService systemService;
	
	@ModelAttribute("office")
	public Office get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return officeService.get(id);
		}else{
			return new Office();
		}
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {""})
	public String index(Office office, Model model) {
//        model.addAttribute("list", officeService.findAll());
		return "modules/sys/officeIndex";
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {"list"})
	public String list(Office office, Model model) {
        model.addAttribute("list", officeService.findList(office));
		model.addAttribute("office",office);
		return "modules/sys/officeList";
	}
	
	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = "form")
	public String form(Office office, Model model) {
		User user = UserUtils.getUser();
		if (office.getParent()==null || office.getParent().getId()==null){
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		if (office.getArea()==null){
			office.setArea(user.getOffice().getArea());
		}
		// 自动获取排序号
		if (StringUtils.isBlank(office.getId())&&office.getParent()!=null){
			int size = 0;
			List<Office> list = officeService.findAll();
			for (int i=0; i<list.size(); i++){
				Office e = list.get(i);
				if (e.getParent()!=null && e.getParent().getId()!=null
						&& e.getParent().getId().equals(office.getParent().getId())){
					size++;
				}
			}
			office.setCode(office.getParent().getCode() + StringUtils.leftPad(String.valueOf(size > 0 ? size+1 : 1), 3, "0"));
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "save")
	public String save(Office office, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/";
		}
		if (!beanValidator(model, office)){
			return form(office, model);
		}
		officeService.save(office);
		
		if(office.getChildDeptList()!=null){
			Office childOffice = null;
			for(String id : office.getChildDeptList()){
				childOffice = new Office();
				childOffice.setName(DictUtils.getDictLabel(id, "sys_office_common", "未知"));
				childOffice.setParent(office);
				childOffice.setArea(office.getArea());
				childOffice.setType("2");
				childOffice.setGrade(String.valueOf(Integer.valueOf(office.getGrade())+1));
				childOffice.setUseable(Global.YES);
				officeService.save(childOffice);
			}
		}
		
		addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
		String id = "0".equals(office.getParentId()) ? "" : office.getParentId();
		return "redirect:" + adminPath + "/sys/office/list?id="+id+"&parentIds="+office.getParentIds();
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete")
	public String delete(Office office, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/list";
		}
//		if (Office.isRoot(id)){
//			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
//		}else{
		User userParam = new User();
		userParam.setOffice(office);
		office.setUsers(systemService.findUserNoDsf(userParam));
		if(office.getUsers()!=null&&office.getUsers().size()>0) {
			addMessage(redirectAttributes, "该机构下已有用户，请删除用户后，再操作！");
		} else {
			officeService.delete(office);
			addMessage(redirectAttributes, "删除机构成功");
		}
//		}
		return "redirect:" + adminPath + "/sys/office/list";
	}

	/**
	 * 获取机构JSON数据。
	 * @param extId 排除的ID
	 * @param type	类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade 显示级别
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, @RequestParam(required=false) String type,
			@RequestParam(required=false) Long grade, @RequestParam(required=false) Boolean isAll, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Office> list = officeService.findList(isAll);
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			if ((StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && (type.equals("1") ? type.equals(e.getType()) : true)))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& Global.YES.equals(e.getUseable())){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				if (type != null && "3".equals(type)){
					map.put("isParent", true);
				}
				mapList.add(map);
			}
		}
		return mapList;
	}

	//-------------- 前端维护接口 ------------------

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "listOffices4Manager.jhtml")
	public Object listOffices4Manager(HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			User currentUser = UserUtils.getUser();
			Office office = new Office();

			for(Role role : currentUser.getRoleList()) {
				if(Role.DATA_SCOPE_ALL.equals(role.getDataScope())) {
					office.setParentIds("0,"+UserUtils.getUser().getCompany().getId()+",");
				}
			}

			List<Office> officeList = officeService.findList(office);
			for(Office o : officeList){
				User userParam = new User();
				userParam.setOffice(o);
                o.setUsers(systemService.findUserByOfficeId(o.getId()));
			}

            // TODO: 2018-01-23 当前用户为注册用户或者公司领导（有“监管领导”角色）则标记JGLD=true
            boolean JGLD = false;
            for(Role role : UserUtils.getRoleList()){
                if(Role.DATA_SCOPE_COMPANY_AND_CHILD.equals(role.getDataScope())) {
                    JGLD = true;
                }
            }

            ret.put("JGLD",JGLD);
			ret.put("company",currentUser.getCompany());
			ret.put("data", officeList);
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

	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "save.jhtml")
	@ResponseBody
	public Object save(Office office, Model model, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			if (!beanValidator(model, office)){
				ret.put("msg", "数据格式校验错误");
				ret.put("success", false);
			} else {
				office.setUseable("1");
				officeService.save(office);

				if(office.getChildDeptList()!=null){
					Office childOffice = null;
					for(String id : office.getChildDeptList()){
						childOffice = new Office();
						childOffice.setName(DictUtils.getDictLabel(id, "sys_office_common", "未知"));
						childOffice.setParent(office);
						childOffice.setArea(office.getArea());
						childOffice.setType("2");
						childOffice.setGrade(String.valueOf(Integer.valueOf(office.getGrade())+1));
						childOffice.setUseable(Global.YES);
						officeService.save(childOffice);
					}
				}
				ret.put("msg", "保存机构'" + office.getName() + "'成功");
				ret.put("success", true);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统忙...");
			e.printStackTrace();
		} finally {
			return this.getJSONOrJSONPString(request, ret);
		}
	}

	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete.jhtml")
	@ResponseBody
	public Object delete(Office office, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			User userParam = new User();
			userParam.setOffice(office);
			office.setUsers(systemService.findUserNoDsf(userParam));
			if(office.getUsers()!=null&&office.getUsers().size()>0) {
				ret.put("msg", "该机构下已有用户，请删除用户后，再操作！");
				ret.put("success", false);
			} else {
				officeService.delete(office);
				ret.put("msg", "删除机构成功！");
				ret.put("success", true);
			}
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
