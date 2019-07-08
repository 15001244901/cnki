/**
 *
 */
package com.hsun.ywork.modules.sys.security;

/**
 * 用户和密码（包含验证码）令牌类
 * @author GeCoder
 * @version 2013-5-19
 */
public class UsernamePasswordToken extends org.apache.shiro.authc.UsernamePasswordToken {

	private static final long serialVersionUID = 1L;

	private String captcha;
	private boolean mobileLogin;
	private boolean loginConsole;
	private String backURL;
	
	public UsernamePasswordToken() {
		super();
	}

	public UsernamePasswordToken(String username, char[] password,
			boolean rememberMe, String host, String captcha, boolean mobileLogin, boolean loginConsole, String backURL) {
		super(username, password, rememberMe, host);
		this.captcha = captcha;
		this.mobileLogin = mobileLogin;
		this.loginConsole = loginConsole;
		this.backURL = backURL;
	}

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public boolean isMobileLogin() {
		return mobileLogin;
	}

	public boolean isLoginConsole() {
		return loginConsole;
	}

	public void setLoginConsole(boolean loginConsole) {
		this.loginConsole = loginConsole;
	}

	public String getBackURL() {
		return backURL;
	}

	public void setBackURL(String backURL) {
		this.backURL = backURL;
	}
}