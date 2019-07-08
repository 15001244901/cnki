package com.hsun.ywork.modules.course.service;

import com.hsun.ywork.modules.course.entity.WebsiteProfile;

import java.util.Map;

/**
 * service
 * @author GeCoder
 */
public interface WebsiteProfileService {
	/**
	 * 修改WebsiteProfile
	 */
	public void updateWebsiteProfile(WebsiteProfile websiteProfile) throws Exception;

	/**
	 * 查询所有网站配置
	 */
	public Map<String, Object> getWebsiteProfileList() throws Exception;
	/**
	 * 根据type查询网站配置
	 */
	public Map<String,Object> getWebsiteProfileByType(String type);

}