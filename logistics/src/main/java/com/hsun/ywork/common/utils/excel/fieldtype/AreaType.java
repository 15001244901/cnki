/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/jywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.common.utils.excel.fieldtype;

import com.hsun.ywork.modules.sys.utils.UserUtils;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.sys.entity.Area;

/**
 * 字段类型转换
 * @author GeCoder
 * @version 2013-03-10
 */
public class AreaType {

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		for (Area e : UserUtils.getAreaList()){
			if (StringUtils.trimToEmpty(val).equals(e.getName())){
				return e;
			}
		}
		return null;
	}

	/**
	 * 获取对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null && ((Area)val).getName() != null){
			return ((Area)val).getName();
		}
		return "";
	}
}
