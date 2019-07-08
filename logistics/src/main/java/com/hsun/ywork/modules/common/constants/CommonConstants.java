package com.hsun.ywork.modules.common.constants;


import com.hsun.ywork.modules.qa.utils.PropertyUtil;

/**
 * 常量
 * @author GeCoder
 */
public class CommonConstants {

//	public static String propertyFile = "project";
//	public static PropertyUtil propertyUtil = PropertyUtil.getInstance(propertyFile);
	public static String contextPath = "";
	public static String staticServer = "";
	public static String uploadImageServer = "";
	public static String staticImage = "";
	public static String projectName = "";
	public static final String MYDOMAIN = "";

	/** 邮箱正则表达式 */
	public static String emailRegex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
	/** 电话号码正则表达式 */
	public static String telRegex = "^1[0-9]{10}$";
	/** 后台用户登录名正则表达式 */
	public static String loginRegex = "^(?=.*[a-zA-Z])[a-zA-Z0-9]{6,20}$";
	/** 图片验证码Session的K */
	public static final String RAND_CODE = "COMMON_RAND_CODE";
}
