/**
 *
 */
package com.hsun.ywork.modules.exam.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.utils.UserAgentUtils;
import com.hsun.ywork.common.utils.word.WordGeneratorWithFreemarker;
import com.hsun.ywork.modules.exam.entity.PaperSection;
import com.hsun.ywork.modules.exam.service.QuestionDBService;
import com.hsun.ywork.modules.exam.entity.QuestionDB;
import com.hsun.ywork.modules.sys.entity.Office;
import com.hsun.ywork.modules.sys.entity.Role;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.service.OfficeService;
import com.hsun.ywork.modules.sys.service.SystemService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.thoughtworks.xstream.XStream;
import freemarker.core.ParseException;
import freemarker.template.MalformedTemplateNameException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.exam.entity.Paper;
import com.hsun.ywork.modules.exam.service.PaperService;

import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.hsun.ywork.common.utils.UserAgentUtils.getBrowser;
import static com.hsun.ywork.modules.sys.utils.UserUtils.getRoleList;
import static java.lang.System.out;
import static oracle.net.aso.C01.m;
import static oracle.net.aso.C05.e;

/**
 * 试卷Controller
 * @author GeCoder
 * @version 2017-01-17
 */
@Controller
@RequestMapping(value = "${adminPath}/exam/paper")
public class PaperController extends BaseController {

	@Autowired
	private PaperService paperService;

	@Autowired
	private QuestionDBService questionDBService;

	@Autowired
	private OfficeService officeService;

    @Autowired
    private SystemService systemService;
	
	@ModelAttribute
	public Paper get(@RequestParam(required=false) String id) {
		Paper entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = paperService.get(id);
		}
		if (entity == null){
			entity = new Paper();
		}
		return entity;
	}
	
	@RequiresPermissions("exam:paper:view")
	@RequestMapping(value = {"list", ""})
	public String list(Paper paper, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Paper> page = paperService.findPage(new Page<Paper>(request, response), paper); 
		model.addAttribute("page", page);
		return "modules/exam/paperList";
	}

	@RequiresPermissions("exam:paper:view")
	@RequestMapping(value = "form")
	public String form(Paper paper, Model model) {
		model.addAttribute("paper", paper);
		Office office = new Office();
		office.setType("2");
		office.setParentIds(UserUtils.getUser().getOffice().getParentIds());
		model.addAttribute("offices",officeService.findList(office));
		return "modules/exam/paperForm";
	}

	@RequiresPermissions("exam:paper:edit")
	@RequestMapping(value = "save")
	public String save(Paper paper, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, paper)){
			return form(paper, model);
		}
//		//指定试卷考试部门
//		String[] offices = request.getParameterValues("departments");
//		for(String o : offices){
//			paper.getDepartments().add(o);
//		}
		paperService.save(paper);
		addMessage(redirectAttributes, "保存试卷成功");
		return "redirect:"+ Global.getAdminPath()+"/exam/paper/?repage&category="+paper.getCategory();
	}
	
	@RequiresPermissions("exam:paper:edit")
	@RequestMapping(value = "delete")
	public String delete(Paper paper, RedirectAttributes redirectAttributes) {
		paperService.delete(paper);
		addMessage(redirectAttributes, "删除试卷成功");
		return "redirect:"+Global.getAdminPath()+"/exam/paper/?repage&category="+paper.getCategory();
	}

	@RequiresPermissions("exam:paper:edit")
	@RequestMapping(value = "detail",method = RequestMethod.GET)
	public String loadDetail(Paper paper, Model model, RedirectAttributes redirectAttributes) {
		model.addAttribute("qdbs",questionDBService.findList(new QuestionDB()));
		model.addAttribute("paper", paper);
		Paper paperx = null;
		if(StringUtils.isNotEmpty(paper.getData())){
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			paperx = (Paper)xstream.fromXML(paper.getData());
			model.addAttribute("paperx",paperx);
		}
        //不同的试卷类型返回不同的视图：1随机试卷，2智能组卷，0&null普通试卷
		if(paper.getPapertype()==1)
			return "modules/exam/paperDetailRandom";
		else if(paper.getPapertype()==2)
			return "modules/exam/paperDetailAuto";
		else
            return "modules/exam/paperDetailNormal";
	}

	@RequiresPermissions("exam:paper:edit")
	@RequestMapping(value = "detail",method = RequestMethod.POST)
	public String updateDetail(HttpServletRequest request , Paper paper, Model model, RedirectAttributes redirectAttributes) {
		try {
			int i = this.paperService.updatePaperDetail(paper,request);
		} catch (Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
//		if(paper.getPapertype() == 1)
//			return "redirect:"+Global.getAdminPath()+"/exam/paper/detail?id="+paper.getId();
		return "redirect:"+Global.getAdminPath()+"/exam/paper/?repage&category="+paper.getCategory();
	}

	//-------------------对外json、jsonp接口部分---------------------

	/**
	 * 试卷列表接口
	 * @param paper
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("exam:paper:view")
	@ResponseBody
	@RequestMapping("list.jhtml")
	public Object list(Paper paper, HttpServletRequest request, HttpServletResponse response) {
		Map ret = new HashMap();
		try {
			if(2!=paper.getCategory())
				paper.setCreateBy(UserUtils.getUser());
			Page<Paper> page = paperService.findPage(new Page<Paper>(request, response), paper);
			ret.put("data",page);
			ret.put("success",true);
		} catch (Exception e) {
			logger.error(e.getMessage());
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
     * 查看试卷、进入发起考试的接口
     * @param id
     * @param request
     * @return
     */
	@RequiresPermissions("exam:paper:view")
	@ResponseBody
	@RequestMapping(value={"view.jhtml","start.jhtml"})
	public Object view(@RequestParam(required=false) String id , HttpServletRequest request){
		Map ret = new HashMap();
		try {
			Paper paper = paperService.getPaper(id);
//			if(StringUtils.isNotEmpty(paper.getData())){
//				XStream xstream = new XStream();
//				xstream.autodetectAnnotations(true);
//				paper = (Paper)xstream.fromXML(paper.getData());
//			}
			ret.put("data",paper);

            Office office = new Office();
            office.setType("2");

			for(Role role : UserUtils.getUser().getRoleList()) {
				if(Role.DATA_SCOPE_ALL.equals(role.getDataScope()) || Role.DATA_SCOPE_COMPANY_AND_CHILD.equals(role.getDataScope())) {
					office.setParentIds("0,"+UserUtils.getUser().getCompany().getId()+",");
				}
			}

            List<Office> officeList = officeService.findList(office);
            for(Office o : officeList){
                User userParam = new User();
                userParam.setOffice(o);
                o.setUsers(systemService.findUserByOfficeId(o.getId()));
            }
            ret.put("offices",officeList);
			ret.put("success",true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
			e.printStackTrace();
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
	 * 试卷基本信息保存接口
	 * @param paper
	 * @param request
	 * @param model
	 * @return
	 */
	@RequiresPermissions("exam:paper:edit")
	@ResponseBody
	@RequestMapping(value = "save.jhtml")
	public Object save(Paper paper, HttpServletRequest request, Model model) {
		Map ret = new HashMap();
		try {
			if (!beanValidator(model, paper)){
				ret.put("success",false);
				ret.put("msg","试卷信息录入不正确，请重新录入！");
			} else {
				paperService.save(paper);
				ret.put("success",true);
				ret.put("msg","保存试卷成功！");
				ret.put("data",paper);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
			e.printStackTrace();
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
	 * 试卷试题配置信息查看接口
	 * @param paper
	 * @param request
	 * @return
	 */
	@RequiresPermissions("exam:paper:edit")
	@ResponseBody
	@RequestMapping(value = "loaddetail.jhtml",method = RequestMethod.GET)
	public Object loadDetail(Paper paper,HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			ret.put("qdbs",questionDBService.findList(new QuestionDB()));
			ret.put("paper", paper);
			Paper paperx = null;
			if(StringUtils.isNotEmpty(paper.getData())){
				XStream xstream = new XStream();
				xstream.autodetectAnnotations(true);
				paperx = (Paper)xstream.fromXML(paper.getData());
				ret.put("paperx",paperx);
			}
			ret.put("success",true);
			ret.put("msg","加载成功！");
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success", false);
			ret.put("msg", "系统忙...");
			e.printStackTrace();
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
	 * 试卷明细配置保存接口
	 * @param request
	 * @param paper
	 * @return
	 */
	@RequiresPermissions("exam:paper:edit")
	@ResponseBody
	@RequestMapping(value = "detail.jhtml")
	public Object updateDetail(HttpServletRequest request , Paper paper) {
		Map ret = new HashMap();
		try {
			int i = this.paperService.updatePaperDetail(paper,request);
			ret.put("success",true);
			ret.put("data",paper);
			ret.put("msg","试卷配置成功！");
		} catch (Exception e){
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
			e.printStackTrace();
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
     * 确定开始考试接口
     * @param param
     * @param request
     * @param model
     * @return
     */
	@RequiresPermissions("exam:paper:edit")
	@ResponseBody
    @RequestMapping("startexam.jhtml")
	public Object startexam(Paper param , HttpServletRequest request , Model model) {
	    Paper paper = this.get(param.getId());
        paper.setStarttime(param.getStarttime());
        paper.setEndtime(param.getEndtime());
        paper.setShowtime(param.getShowtime());//成绩公布时间
        paper.setShowkey(param.getShowkey());//是否公布答案和解析
        paper.setShowmode(param.getShowmode());//答题模式
        paper.setDepartments(param.getDepartments());//指定部门
		paper.setUsers(param.getUsers());
        paper.setStatus(1);//开放试题
		paper.setIsoffline(param.getIsoffline());//区分线下考试还是线上考试
        return this.save(paper,request,model);
    }

	/**
	 * 成套卷出卷接口
	 * @param copyid
	 * @param copyname
	 * @param request
	 * @param model
	 * @return
	 */
	@RequiresPermissions("exam:paper:edit")
	@ResponseBody
	@RequestMapping("copypaper.jhtml")
	public Object copyPaper(@RequestParam String copyid , @RequestParam String copyname , HttpServletRequest request , Model model){
		Map ret = new HashMap();
		try {
			int category = 1;//1代表成套试卷转换为考试试卷，2代表考试试卷转换为成套试卷
			if(StringUtils.isNotEmpty(request.getParameter("category")))
				category = Integer.parseInt(request.getParameter("category"));
			Paper paper = paperService.copy(copyid,copyname,category);
			ret.put("success",true);
			ret.put("data",paper);
			ret.put("msg","操作成功！");
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("success",false);
			ret.put("msg","系统忙...");
			e.printStackTrace();
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

	@RequiresPermissions("exam:paper:edit")
	@ResponseBody
	@RequestMapping("delete.jhtml")
	public Object delete(Paper paper , HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			paperService.delete(paper);
			ret.put("msg", "删除试卷成功!");
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

	@RequestMapping("exportWord.jhtml")
	public void exportWord(Paper paper , HttpServletRequest request , HttpServletResponse response) {
		String paperHtml = request.getParameter("paperHtml");
		String paperSize = request.getParameter("paperSize");
		if(StringUtils.isEmpty(paperSize))
			paperSize = "a4";

		Map<String,Object> tmpData = null;
		OutputStream out;
		try {
			tmpData = WordGeneratorWithFreemarker.createTemplateData(paperHtml,paperSize);
			out = response.getOutputStream();
			String filename = paper.getName()+".doc";
			String browserName = UserAgentUtils.getBrowser(request).getName();
			if(browserName.indexOf("Firefox")>=0)
				filename = new String(filename.getBytes("utf-8"),"ISO-8859-1");
			else
				filename = URLEncoder.encode(filename, "UTF8");
			response.setContentType("application/x-msdownload;charset=utf-8");
			response.addHeader("Content-Disposition", "attachment; filename="+filename);
			response.setCharacterEncoding("UTF-8");
			WordGeneratorWithFreemarker.createDoc(tmpData, "modules/exam/paperExport_"+paperSize+".ftl", out);
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}