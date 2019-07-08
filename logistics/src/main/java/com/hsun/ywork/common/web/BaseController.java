/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/jywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.common.web;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;
import javax.validation.ValidationException;
import javax.validation.Validator;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.hsun.ywork.common.beanvalidator.BeanValidators;
import com.hsun.ywork.common.mapper.JsonMapper;
import com.hsun.ywork.common.utils.DateUtils;
import com.hsun.ywork.common.utils.StringUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.UnauthenticatedException;
import org.apache.shiro.authz.UnauthorizedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 控制器支持类
 * @author GeCoder
 * @version 2013-3-23
 */
public abstract class BaseController {

	/**
	 * 日志对象
	 */
	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 管理基础路径
	 */
	@Value("${adminPath}")
	protected String adminPath;
	
	/**
	 * 前端基础路径
	 */
	@Value("${frontPath}")
	protected String frontPath;
	
	/**
	 * 前端URL后缀
	 */
	@Value("${urlSuffix}")
	protected String urlSuffix;
	
	/**
	 * 验证Bean实例对象
	 */
	@Autowired
	protected Validator validator;

	/**
	 * 服务端参数有效性验证
	 * @param object 验证的实体对象
	 * @param groups 验证组
	 * @return 验证成功：返回true；严重失败：将错误信息添加到 message 中
	 */
	protected boolean beanValidator(Model model, Object object, Class<?>... groups) {
		try{
			BeanValidators.validateWithException(validator, object, groups);
		}catch(ConstraintViolationException ex){
			List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
			list.add(0, "数据验证失败：");
			addMessage(model, list.toArray(new String[]{}));
			return false;
		}
		return true;
	}

	/**
	 * 服务端参数有效性验证
	 * @param object 验证的实体对象
	 * @param groups 验证组
	 * @return 验证成功：返回true；严重失败：将错误信息添加到 message 中
	 */
	protected boolean beanValidator(Map msg, Object object, Class<?>... groups) {
		try{
			BeanValidators.validateWithException(validator, object, groups);
		}catch(ConstraintViolationException ex){
			List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
			list.add(0, "数据验证失败：");

			StringBuilder sb = new StringBuilder();
			String[] messages = list.toArray(new String[]{});
			for (String message : messages){
				sb.append(message).append(messages.length>1?"<br/>":"");
			}
			msg.put("message", sb.toString());
			return false;
		}
		return true;
	}
	
	/**
	 * 服务端参数有效性验证
	 * @param object 验证的实体对象
	 * @param groups 验证组
	 * @return 验证成功：返回true；严重失败：将错误信息添加到 flash message 中
	 */
	protected boolean beanValidator(RedirectAttributes redirectAttributes, Object object, Class<?>... groups) {
		try{
			BeanValidators.validateWithException(validator, object, groups);
		}catch(ConstraintViolationException ex){
			List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
			list.add(0, "数据验证失败：");
			addMessage(redirectAttributes, list.toArray(new String[]{}));
			return false;
		}
		return true;
	}
	
	/**
	 * 服务端参数有效性验证
	 * @param object 验证的实体对象
	 * @param groups 验证组，不传入此参数时，同@Valid注解验证
	 * @return 验证成功：继续执行；验证失败：抛出异常跳转400页面。
	 */
	protected void beanValidator(Object object, Class<?>... groups) {
		BeanValidators.validateWithException(validator, object, groups);
	}
	
	/**
	 * 添加Model消息
	 * @param messages
	 */
	protected void addMessage(Model model, String... messages) {
		StringBuilder sb = new StringBuilder();
		for (String message : messages){
			sb.append(message).append(messages.length>1?"<br/>":"");
		}
		model.addAttribute("message", sb.toString());
	}
	
	/**
	 * 添加Flash消息
	 * @param messages
	 */
	protected void addMessage(RedirectAttributes redirectAttributes, String... messages) {
		StringBuilder sb = new StringBuilder();
		for (String message : messages){
			sb.append(message).append(messages.length>1?"<br/>":"");
		}
		redirectAttributes.addFlashAttribute("message", sb.toString());
	}
	
	/**
	 * 客户端返回JSON字符串
	 * @param response
	 * @param object
	 * @return
	 */
	protected String renderString(HttpServletResponse response, Object object) {
		return renderString(response, JsonMapper.toJsonString(object), "application/json");
	}
	
	/**
	 * 客户端返回字符串
	 * @param response
	 * @param string
	 * @return
	 */
	protected String renderString(HttpServletResponse response, String string, String type) {
		try {
			response.reset();
	        response.setContentType(type);
	        response.setCharacterEncoding("utf-8");
			response.getWriter().print(string);
			return null;
		} catch (IOException e) {
			return null;
		}
	}

	/**
	 * 参数绑定异常
	 */
	@ExceptionHandler({BindException.class, ConstraintViolationException.class, ValidationException.class})
    public String bindException() {  
        return "error/400";
    }
	
	/**
	 * 初始化数据绑定
	 * 1. 将所有传递进来的String进行HTML编码，防止XSS攻击
	 * 2. 将字段中Date类型转换为String类型
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		// String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
//		binder.registerCustomEditor(String.class, new PropertyEditorSupport() {
//			@Override
//			public void setAsText(String text) {
//				setValue(text == null ? null : StringEscapeUtils.escapeHtml4(text.trim()));
//			}
//			@Override
//			public String getAsText() {
//				Object value = getValue();
//				return value != null ? value.toString() : "";
//			}
//		});
		// Date 类型转换
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				setValue(DateUtils.parseDate(text));
			}
//			@Override
//			public String getAsText() {
//				Object value = getValue();
//				return value != null ? DateUtils.formatDateTime((Date)value) : "";
//			}
		});
	}

	public Object getJSONOrJSONPString(HttpServletRequest request , Object data) {
		String callback = request.getParameter("callback");
		if (StringUtils.isNotBlank(callback)) {
			MappingJacksonValue json = new MappingJacksonValue(data);
			json.setJsonpFunction(callback);
			return json;
		} else {
			return data;
		}
	}

	/**
	 * 登录认证异常
	 */
	@ExceptionHandler({ UnauthenticatedException.class, AuthenticationException.class })
	public String authenticationException(HttpServletRequest request, HttpServletResponse response) {
		if (this.isAjaxRequest(request)) {
			// 输出JSON
//			Map map = new HashMap();
//			map.put("code", "401");
//			map.put("message", "未登录");
//			writeJson(map, request , response);
			throw new RuntimeException("未登录");
		} else {
			return "error/403";
		}
	}

	/**
	 * 权限异常
	 */
	@ExceptionHandler({ UnauthorizedException.class, AuthorizationException.class })
	public String authorizationException(HttpServletRequest request, HttpServletResponse response) {
		if (this.isAjaxRequest(request)) {
			throw new RuntimeException("无操作权限！");
			//writeJson(map, request,response);
		} else {
			return "error/403";
		}
	}

	/**
	 * 输出JSON
	 *
	 * @param response
	 * @author SHANHY
	 * @create 2017年4月4日
	 */
	public void writeJson(Object obj, HttpServletRequest request , HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json; charset=utf-8");
			out = response.getWriter();
			String callback = request.getParameter("callback");
			if (StringUtils.isNotBlank(callback)) {
				out.write(callback+"("+JSONObject.toJSONString(obj)+")");
			} else {
				out.write(JSONObject.toJSONString(obj));
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	/**
	 * 是否是Ajax请求
	 *
	 * @param request
	 * @return
	 * @author SHANHY
	 * @create 2017年4月4日
	 */
	public boolean isAjaxRequest(HttpServletRequest request) {
		String requestedWith = request.getHeader("x-requested-with");
		if (requestedWith != null && requestedWith.equalsIgnoreCase("XMLHttpRequest")) {
			return true;
		} else {
			return false;
		}
	}

	public static Gson gson = (new GsonBuilder()).setDateFormat("yyyy-MM-dd HH:mm:ss").create();

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

		return "error/500";
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

	public static String getViewPath(String path) {
		return path != null && !path.trim().equals("")?"modules" + path:"";
	}
}
