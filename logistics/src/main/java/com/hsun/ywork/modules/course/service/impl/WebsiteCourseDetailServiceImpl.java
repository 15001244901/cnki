package com.hsun.ywork.modules.course.service.impl;

import com.hsun.ywork.common.utils.EhCacheUtils;
import com.hsun.ywork.modules.common.constants.CacheConstants;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.dao.WebsiteCourseDetailDao;
import com.hsun.ywork.modules.course.entity.WebsiteCourseDetail;
import com.hsun.ywork.modules.course.entity.WebsiteCourseDetailDTO;
import com.hsun.ywork.modules.course.service.WebsiteCourseDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 推荐课程关联接口实现
 * @author GeCoder
 */
@Service("websiteCourseDetailService")
public class WebsiteCourseDetailServiceImpl implements WebsiteCourseDetailService {
	@Autowired
	private WebsiteCourseDetailDao websiteCourseDetailDao;
	
	public void createWebsiteCourseDetail(String detail) {
		websiteCourseDetailDao.createWebsiteCourseDetail(detail);
		EhCacheUtils.remove(CacheConstants.RECOMMEND_COURSE);
	}

	
	public List<WebsiteCourseDetailDTO> queryCourseDetailPage(WebsiteCourseDetailDTO dto, PageEntity page) {
		return websiteCourseDetailDao.queryCourseDetailPage(dto, page);
	}

	
	public void deleteDetailById(int id) {
		websiteCourseDetailDao.deleteDetailById(id);
		EhCacheUtils.remove(CacheConstants.RECOMMEND_COURSE);
	}

	
	public void updateSort(int id, int sort) {
		Map<String,Integer> map =new HashMap<String, Integer>();
		map.put("id", id);
		map.put("sort", sort);
		websiteCourseDetailDao.updateSort(map);
		EhCacheUtils.remove(CacheConstants.RECOMMEND_COURSE);
	}

	
	public List<WebsiteCourseDetail> queryDetailListByrecommendId(int recommendId) {
		return websiteCourseDetailDao.queryDetailListByrecommendId(recommendId);
	}
}