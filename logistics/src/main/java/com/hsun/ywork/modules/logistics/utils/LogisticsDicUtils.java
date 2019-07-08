/**
 *
 */
package com.hsun.ywork.modules.logistics.utils;

import com.hsun.ywork.common.utils.CacheUtils;
import com.hsun.ywork.common.utils.SpringContextHolder;
import com.hsun.ywork.modules.logistics.dao.GoodaddrDao;
import com.hsun.ywork.modules.logistics.dao.TicketpositionDao;
import com.hsun.ywork.modules.logistics.entity.Goodaddr;
import com.hsun.ywork.modules.logistics.entity.Ticketposition;
import org.apache.commons.lang3.StringUtils;

import java.util.List;

/**
 * 物流地址工具类
 * @author GeCoder
 * @version 2018-4-9
 */
public class LogisticsDicUtils {
	
	private static GoodaddrDao goodaddrDao = SpringContextHolder.getBean(GoodaddrDao.class);

	private static TicketpositionDao ticketpositionDao = SpringContextHolder.getBean(TicketpositionDao.class);

	public static final String CACHE_GADDR_LIST = "goodaddrList";
	public static final String CACHE_TPOSITION_LIST = "ticketpositionList";
	
	public static String getAddrName(String value, String defaultValue){
		if (StringUtils.isNotBlank(value)){
			for (Goodaddr addr : getGoodaddrList()){
				if (value.equals(addr.getId())){
					return addr.getAddr();
				}
			}
		}
		return defaultValue;
	}

	public static String getGoodaddrValue(String label, String defaultLabel){
		if (StringUtils.isNotBlank(label)){
			for (Goodaddr addr : getGoodaddrList()){
				if (label.equals(addr.getAddr())){
					return addr.getId();
				}
			}
		}
		return defaultLabel;
	}

	public static List<Goodaddr> getGoodaddrList(){
		List<Goodaddr> list = (List<Goodaddr>)CacheUtils.get(CACHE_GADDR_LIST);
		if (list==null){
			CacheUtils.put(CACHE_GADDR_LIST, goodaddrDao.findAllList(new Goodaddr()));
		}
		return list;
	}

	public static List<Ticketposition> getTicketpositionList(){
		List<Ticketposition> list = (List<Ticketposition>)CacheUtils.get(CACHE_TPOSITION_LIST);
		if (list==null){
			CacheUtils.put(CACHE_TPOSITION_LIST, ticketpositionDao.findAllList(new Ticketposition()));
		}
		return list;
	}
}
