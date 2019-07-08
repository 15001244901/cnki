/**
 *
 */
package com.hsun.ywork.modules.sys.utils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.hsun.ywork.common.mapper.JsonMapper;
import com.hsun.ywork.common.utils.CacheUtils;
import com.hsun.ywork.common.utils.SpringContextHolder;
import com.hsun.ywork.modules.standard.dao.YWStandardDao;
import com.hsun.ywork.modules.standard.entity.YWStandard;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * 标准工具类
 * @author GeCoder
 * @version 2017-1-9
 */
public class StandardUtils {
	
	private static YWStandardDao standardDao = SpringContextHolder.getBean(YWStandardDao.class);

	public static final String CACHE_STANDARD_MAP = "standardMap";
	
	public static String getStandardName(String id, String category, String defaultValue){
		if (StringUtils.isNotBlank(category) && StringUtils.isNotBlank(id)){
			for (YWStandard std : getStandardList(category)){
				if (category.equals(std.getCategory()+"") && id.equals(std.getId())){
					return std.getName();
				}
			}
		}
		return defaultValue;
	}
	
	public static String getStandardNames(String ids, String category, String defaultValue){
		if (StringUtils.isNotBlank(category) && StringUtils.isNotBlank(ids)){
			List<String> idList = Lists.newArrayList();
			for (String id : StringUtils.split(ids, ",")){
				idList.add(getStandardName(id, category, defaultValue));
			}
			return StringUtils.join(idList, ",");
		}
		return defaultValue;
	}

	public static String getStandardId(String name, String category, String defaultLabel){
		if (StringUtils.isNotBlank(category) && StringUtils.isNotBlank(name)){
			for (YWStandard std : getStandardList(category)){
				if (category.equals(std.getCategory()) && name.equals(std.getName())){
					return std.getId();
				}
			}
		}
		return defaultLabel;
	}
	
	public static List<YWStandard> getStandardList(String category){
		@SuppressWarnings("unchecked")
		Map<String, List<YWStandard>> standardMap = (Map<String, List<YWStandard>>)CacheUtils.get(CACHE_STANDARD_MAP);
		if (standardMap==null){
			standardMap = Maps.newHashMap();
			for (YWStandard std : standardDao.findAllList(new YWStandard())){
				std.setName("【"+std.getSno()+"】"+std.getName());
				List<YWStandard> standardList = standardMap.get(std.getCategory()+"");
				if (standardList != null){
					standardList.add(std);
				}else{
					standardMap.put(std.getCategory()+"", Lists.newArrayList(std));
				}
			}
			CacheUtils.put(CACHE_STANDARD_MAP, standardMap);
		}
		List<YWStandard> standardList = standardMap.get(category);
		if (standardList == null){
			standardList = Lists.newArrayList();
		}
		return standardList;
	}
	
	/**
	 * 返回字典列表（JSON）
	 * @param category
	 * @return
	 */
	public static String getStandardListJson(String category){
		return JsonMapper.toJsonString(getStandardList(category));
	}

	public static String getStandardSno(String id, String category, String defaultValue){
		if (StringUtils.isNotBlank(category) && StringUtils.isNotBlank(id)){
			for (YWStandard std : getStandardList(category)){
				if (category.equals(std.getCategory()+"") && id.equals(std.getId())){
					return std.getSno();
				}
			}
		}
		return defaultValue;
	}
}
