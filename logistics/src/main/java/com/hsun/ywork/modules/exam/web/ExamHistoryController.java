/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.exam.web;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.hsun.ywork.common.bean.BaseMessage;
import com.hsun.ywork.common.bean.BaseUrl;
import com.hsun.ywork.common.config.Global;
import com.hsun.ywork.common.persistence.Page;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.exam.entity.ExamHistory;
import com.hsun.ywork.modules.exam.entity.Paper;
import com.hsun.ywork.modules.exam.service.ExamHistoryService;
import com.hsun.ywork.modules.exam.service.PaperService;
import com.hsun.ywork.modules.sys.entity.Office;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.service.OfficeService;
import com.hsun.ywork.modules.sys.service.SystemService;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.thoughtworks.xstream.XStream;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.sun.tools.javac.jvm.ByteCodes.ret;

/**
 * 考生考试记录Controller
 * @author GeCoder
 * @version 2017-02-14
 */
@Controller
@RequestMapping(value = "${adminPath}/exam/examHistory")
public class ExamHistoryController extends BaseController {

	@Autowired
	private ExamHistoryService examHistoryService;

	@Autowired
	private PaperService paperService;

	@Autowired
	private SystemService systemService;

	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute
	public ExamHistory get(@RequestParam(required=false) String id) {
		ExamHistory entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = examHistoryService.get(id);
		}
		if (entity == null){
			entity = new ExamHistory();
		}
		return entity;
	}
	
	@RequiresPermissions("exam:examHistory:view")
	@RequestMapping(value = {"list/{pid}", "{pid}"})
	public String list(@PathVariable("pid") String pid , ExamHistory examHistory, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ExamHistory> page = new Page<ExamHistory>(request, response);
		if(page.getPageSize()==1)
			page.setPageSize(30);
		examHistory.setPid(pid);
		page = examHistoryService.findPage(page, examHistory);
		model.addAttribute("page", page);
		model.addAttribute("pid",pid);
		model.addAttribute("paper",paperService.get(pid));
		model.addAttribute("progress",examHistoryService.getPaperCheckProgress(pid));

		Office office = new Office();
		office.setType("2");
		office.setParentIds(UserUtils.getUser().getOffice().getParentIds());
		model.addAttribute("offices",officeService.findList(office));
		return "modules/exam/examHistoryList";
	}

	@RequiresPermissions("exam:examHistory:view")
	@RequestMapping(value = "form")
	public String form(ExamHistory examHistory, Model model) {
		model.addAttribute("examHistory", examHistory);
		return "modules/exam/examHistoryForm";
	}

	@RequiresPermissions("exam:examHistory:edit")
	@RequestMapping(value = "save")
	public String save(ExamHistory examHistory, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, examHistory)){
			return form(examHistory, model);
		}
		examHistoryService.save(examHistory);
		addMessage(redirectAttributes, "保存考试记录成功");
		return "redirect:"+Global.getAdminPath()+"/exam/examHistory/?repage";
	}
	
	@RequiresPermissions("exam:examHistory:edit")
	@RequestMapping(value = "delete")
	public String delete(ExamHistory examHistory, RedirectAttributes redirectAttributes) {
		examHistoryService.delete(examHistory);
		addMessage(redirectAttributes, "删除考试记录成功");
		return "redirect:"+Global.getAdminPath()+"/exam/examHistory/"+examHistory.getPid()+"?repage";
	}

	@RequiresPermissions("exam:examHistory:edit")
	@RequestMapping(value = "clear/{pid}")
	public String clear(@PathVariable("pid") String pid, RedirectAttributes redirectAttributes) {
		examHistoryService.deleteAllByPid(pid);
		addMessage(redirectAttributes, "清除考试记录成功");
		return "redirect:"+Global.getAdminPath()+"/exam/examHistory/"+pid+"?repage";
	}

	@RequiresPermissions("exam:examHistory:edit")
	@RequestMapping(value = "detail")
	public String detail(HttpServletRequest request , Model model , RedirectAttributes redirectAttributes){
		String uid = UserUtils.getUser().getId();
		String pid = request.getParameter("pid");
		String id = request.getParameter("eid");

		ExamHistory detail = examHistoryService.get(id);
		User user = systemService.getUser(uid);
		Paper paper = paperService.getPaper(uid,pid);
//		if(paper.getData()!=null){
//			XStream xstream = new XStream();
//			xstream.autodetectAnnotations(true);
//			paper = (Paper)xstream.fromXML(paper.getData());
//		}
		model.addAttribute("detail",detail);
		model.addAttribute("paper",paper);
		model.addAttribute("user",user);

		try {
			Gson gson = new Gson();
			String data = detail.getData();
			String check = detail.getChecks();
			model.addAttribute("data",gson.fromJson(data,new HashMap<String,String>().getClass()));
//			model.addAttribute("check",gson.fromJson(check,new HashMap<String,String>().getClass()));
            model.addAttribute("check", JSONObject.parse(check));

		} catch (Exception e) {
			BaseMessage message = new BaseMessage(false,"对不起，目标文件或数据不存在。");
			model.addAttribute("message",message);
			model.addAttribute(new BaseUrl("创建试卷","exam/paper/form"));
			model.addAttribute(new BaseUrl("试卷管理","exam/paper/list"));
			return "common/message";
		}

		return "modules/exam/examHistoryDetail";
	}

    @RequiresPermissions("exam:examHistory:edit")
    @RequestMapping(value = "check")
	@ResponseBody
	public String checkPaperQuestion(HttpServletRequest request){
        //开始写判分逻辑
        JSONObject json = new JSONObject();
        try {
            String eid = request.getParameter("eid");
            String qid = request.getParameter("qid");
            int score = Integer.parseInt(request.getParameter("score"));
            this.examHistoryService.checkOneQuestion(eid,qid,score);
            json.put("code","ok");
        } catch (Exception e){
            logger.error(e.getMessage());
            json.put("code","err");
        }
        return json.toString();
    }

    @ResponseBody
    @RequestMapping("autoCheck")
    public BaseMessage autoCheck(){
    	BaseMessage bm = new BaseMessage();
		bm.setSuccess(true);
		int row = paperService.doCheckPaperQueue();
		if(row<1){
			bm.setMessage("当前没有要批改的试卷");
		}
		return bm;
	}

	//---------前端接口部分------------

	/**
	 * 查询考试记录接口
	 * @param pid
	 * @param examHistory
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping("list.jhtml")
	public Object list(@RequestParam(required = true) String pid , ExamHistory examHistory, HttpServletRequest request, HttpServletResponse response) {
		Map ret = new HashMap();
		try {
			Page<ExamHistory> page = new Page<ExamHistory>(request, response);
			if(page.getPageSize()==1)
				page.setPageSize(30);
			examHistory.setPid(pid);
			page = examHistoryService.findPage(page, examHistory);
			ret.put("data",page);
			ret.put("pid",pid);
			ret.put("paper",paperService.get(pid));
			ret.put("progress",examHistoryService.getPaperCheckProgress(pid));

			Office office = new Office();
			office.setType("2");
			office.setParentIds(UserUtils.getUser().getOffice().getParentIds());
			List<Office> officeList = officeService.findList(office);
			for(Office o : officeList){
				User userParam = new User();
				userParam.setOffice(o);
				o.setUsers(systemService.findUser(userParam));
			}
			ret.put("offices",officeList);
			ret.put("success",true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("msg","系统忙...");
			ret.put("success",false);
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

	//http://localhost:8181/ywork/a/exam/examHistory/detail.jhtml?eid=d39d8ab8f4fb4b3d8c18f0db16b021c0&pid=49d540c623124cc786d7df2150ae26b2

	/**
	 * 考试记录明细接口
	 * @param request
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "detail.jhtml")
	public Object detail(HttpServletRequest request){
		Map ret = new HashMap();
		try {
			String uid = UserUtils.getUser().getId();
			String pid = request.getParameter("pid");
			String id = request.getParameter("eid");

			ExamHistory detail = examHistoryService.get(id);
			User user = systemService.getUser(uid);
			Paper paper = paperService.getPaper(uid,pid);
			ret.put("detail",detail);
			ret.put("paper",paper);
			ret.put("user",user);

			Gson gson = new Gson();
			String data = detail.getData();
			String check = detail.getChecks();
			ret.put("data",gson.fromJson(data,new HashMap<String,String>().getClass()));
			ret.put("check", JSONObject.parse(check));
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("msg","系统忙...");
			ret.put("success",false);
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
	 * 单独给分接口
	 * @param request
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "check.jhtml")
	@ResponseBody
	public Object checkQuestion(HttpServletRequest request){
		Map ret = new HashMap();
		try {
			String eid = request.getParameter("eid");
			String qid = request.getParameter("qid");
			int score = Integer.parseInt(request.getParameter("score"));
			this.examHistoryService.checkOneQuestion(eid,qid,score);
			ret.put("msg","试题批改成功！");
			ret.put("success",true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("msg","系统忙...");
			ret.put("success",false);
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

	@RequiresPermissions("exam:examHistory:edit")
	@RequestMapping(value = "delete.jhtml")
	@ResponseBody
	public Object delete(ExamHistory examHistory, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			examHistoryService.delete(examHistory);
			ret.put("msg","删除考试记录成功！");
			ret.put("success",true);
		} catch (Exception e) {
			logger.error(e.getMessage());
			ret.put("msg","系统忙...");
			ret.put("success",false);
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

	@RequiresPermissions("exam:examHistory:edit")
	@RequestMapping("save.jhtml")
	@ResponseBody
	public Object save(ExamHistory examHistory, HttpServletRequest request) {
		Map ret = new HashMap();
		try {
			examHistoryService.save(examHistory);
			ret.put("success", true);
			ret.put("msg","保存考试结果成功！");
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