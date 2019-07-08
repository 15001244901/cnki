package com.hsun.ywork.modules.course.service.impl;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.hsun.ywork.common.utils.EhCacheUtils;
import com.hsun.ywork.modules.common.constants.CacheConstants;
import com.hsun.ywork.modules.course.dao.WebsiteProfileDao;
import com.hsun.ywork.modules.course.entity.WebsiteProfile;
import com.hsun.ywork.modules.course.service.WebsiteProfileService;
import com.hsun.ywork.modules.qa.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 网站管理配置service
 * @author GeCoder
 */
@Service("websiteProfileService")
public class WebsiteProfileServiceImpl implements WebsiteProfileService {

	@Autowired
	private WebsiteProfileDao websiteProfileDao;
	private Gson gson=new Gson();

	
	public void updateWebsiteProfile(WebsiteProfile websiteProfile) throws Exception {
		Map<String, Object> map = getWebsiteProfileByType(websiteProfile.getType());
		//如果不存在则添加
		if(ObjectUtils.isNull(map)){
			websiteProfile.setExplain(websiteProfile.getType());
			websiteProfileDao.addWebsiteProfileByType(websiteProfile);
		}
		websiteProfileDao.updateWebsiteProfile(websiteProfile);
		EhCacheUtils.remove(CacheConstants.WEBSITE_PROFILE+websiteProfile.getType());
	}
	
	
	public Map<String, Object> getWebsiteProfileList() throws Exception {
		//获得所有配置
		@SuppressWarnings("unchecked")
		List<String> websitesStr=(List<String>) EhCacheUtils.get(CacheConstants.WEBSITE_PROFILE);
		if(ObjectUtils.isNull(websitesStr)||websitesStr.size()==0){
			List<WebsiteProfile> websiteProfiles=websiteProfileDao.getWebsiteProfileList();
			for(WebsiteProfile websiteProfile:websiteProfiles){
				//转json字符串
				websitesStr.add(gson.toJson(websiteProfile));
			}
			EhCacheUtils.set(CacheConstants.WEBSITE_PROFILE, websitesStr, CacheConstants.WEBSITE_PROFILE_TIME);
		}
		Map<String,Object> webSiteMap = new HashMap<String,Object>();
		if(ObjectUtils.isNotNull(websitesStr)&&websitesStr.size()>0){
			for(String websiteStr:websitesStr){
				//转回对象
				WebsiteProfile websiteProfile = gson.fromJson(websiteStr,WebsiteProfile.class);
				String desciption=websiteProfile.getDesciption();
				Map<String,Object> map1=gson.fromJson(checkString(desciption), new TypeToken<Map<String, Object>>() {}.getType());
				map1.put("explain", websiteProfile.getExplain());//描述
				webSiteMap.put(websiteProfile.getType(),map1);
			}
		}
		return webSiteMap;
	}
	/**
	 * 检查字符串空的方法
	 */
	private String checkString(Object str) { 
		if (ObjectUtils.isNotNull(str) && !"null".equals(str.toString())) {
			return str.toString();
		} else {
			return "";
		}
	}
	
	
	public Map<String, Object> getWebsiteProfileByType(String type) {
		//根据类型获得数据 从cache获取
		String websiteProfileStr=(String) EhCacheUtils.get(CacheConstants.WEBSITE_PROFILE+type);
		if(ObjectUtils.isNull(websiteProfileStr)){//cache为空查询数据库
			WebsiteProfile websiteProfile=websiteProfileDao.getWebsiteProfileByType(type);
			websiteProfileStr=gson.toJson(websiteProfile);//websiteProfileStr json串
			EhCacheUtils.set(CacheConstants.WEBSITE_PROFILE+type, websiteProfileStr, CacheConstants.WEBSITE_PROFILE_TIME);//设置key 时间一天
		}
		WebsiteProfile websiteProfile=gson.fromJson(websiteProfileStr, WebsiteProfile.class);//转回对象

		if(ObjectUtils.isNull(websiteProfile)){
			return new HashMap<String,Object>();
		}
		String desciption=websiteProfile.getDesciption();
		//把json数据转化为Map
		Map<String,Object> map1=gson.fromJson(checkString(desciption), new TypeToken<Map<String, Object>>() {}.getType());
		Map<String,Object> webSiteMap = new HashMap<String,Object>();
		webSiteMap.put(websiteProfile.getType(), map1);
		return webSiteMap;
	}
}