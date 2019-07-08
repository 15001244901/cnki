package com.hsun.ywork.modules.qa.web;

import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.web.BaseController;
import com.hsun.ywork.modules.qa.entity.Praise;
import com.hsun.ywork.modules.qa.service.PraiseService;
import com.hsun.ywork.modules.qa.utils.SingletonLoginUtils;
import com.hsun.ywork.modules.sys.entity.User;
import com.hsun.ywork.modules.sys.utils.UserUtils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 点赞controller
 * @author GeCoder
 */
@Controller
@RequestMapping("/qa")
public class PraiseController extends BaseController {
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(PraiseController.class);
	
	@Autowired
	private PraiseService praiseService;

	public String setExceptionRequest(HttpServletRequest request, Exception e) {
		logger.error(request.getContextPath(), e);
		StackTraceElement[] messages = e.getStackTrace();
		if(messages != null && messages.length > 0) {
			StringBuffer buffer = new StringBuffer();
			buffer.append(e.toString()).append("<br/>");

			for(int i = 0; i < messages.length; ++i) {
				buffer.append(messages[i].toString()).append("<br/>");
			}

			request.setAttribute("myexception", buffer.toString());
		}

		return "/common/error";
	}

	public Map<String, Object> setAjaxException(Map<String, Object> map) {
		map.put("success", Boolean.valueOf(false));
		map.put("message", "系统繁忙，请稍后再操作！");
		map.put("entity", (Object)null);
		return map;
	}

	public Map<String, Object> setJson(boolean success, String message, Object entity) {
		HashMap json = new HashMap();
		json.put("success", Boolean.valueOf(success));
		json.put("message", message);
		json.put("entity", entity);
		return json;
	}

	@InitBinder({"praise"})
	public void initBinderPraise(WebDataBinder binder){
		binder.setFieldDefaultPrefix("praise.");
	}
	
	/**
	 * 添加点赞记录
	 */
	@RequestMapping("/praise/ajax/add")
	@ResponseBody
	public Object addPraise(HttpServletRequest request, @ModelAttribute("praise")Praise praise){
		Map<String,Object> json = new HashMap<String,Object>();
		try{
			User user = UserUtils.getUser();
			if (StringUtils.isEmpty(user.getId())) {
				json = this.setJson(false, "请先登录", "");
				return json;
			}
			//查询是否点赞 过
			praise.setUserId(user.getId());
			int praiseCount=praiseService.queryPraiseCount(praise);
			if(praiseCount>0){
				json = this.setJson(false, "您已赞过", "");
				return json;
			}
			
			//添加点赞记录
			praise.setAddTime(new Date());
			praiseService.addPraise(praise);//在service 中    根据点赞目标 type 修改相应的 点赞总数

			json = this.setJson(true, "", "");
		}catch (Exception e) {
			logger.error("PraiseController.addPraise()---error",e);
			json = this.setJson(false, "系统错误,请稍后重试", "");
		}
		return json;
	}
}
