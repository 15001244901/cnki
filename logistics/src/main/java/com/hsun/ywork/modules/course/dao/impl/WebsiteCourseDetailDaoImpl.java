package com.hsun.ywork.modules.course.dao.impl;


import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.dao.WebsiteCourseDetailDao;
import com.hsun.ywork.modules.course.entity.WebsiteCourseDetail;
import com.hsun.ywork.modules.course.entity.WebsiteCourseDetailDTO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 *
 * 推荐课程关联Dao层
 * @author GeCoder
 */
 @Repository("websiteCourseDetailDao")
public class WebsiteCourseDetailDaoImpl extends GenericDaoImpl implements WebsiteCourseDetailDao {

	
	public void createWebsiteCourseDetail(String detail) {
		this.insert("WebsiteCourseDetailMapper.createWebsiteCourseDetail", detail);
	}

	
	public List<WebsiteCourseDetailDTO> queryCourseDetailPage(WebsiteCourseDetailDTO dto, PageEntity page) {
		return this.queryForListPage("WebsiteCourseDetailMapper.queryCourseDetailPage", dto, page);
	}

	
	public void deleteDetailById(int id) {
		this.delete("WebsiteCourseDetailMapper.deleteDetailById", id);
	}

	
	public void updateSort(Map<String, Integer> map) {
		this.update("WebsiteCourseDetailMapper.updateSort", map);
	}

	
	public List<WebsiteCourseDetail> queryDetailListByrecommendId(int recommendId) {
		return this.selectList("WebsiteCourseDetailMapper.queryDetailListByrecommendId", recommendId);
	}
}
