package com.hsun.ywork.modules.course.service.impl;

import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.dao.CourseFavoritesDao;
import com.hsun.ywork.modules.course.entity.CourseFavorites;
import com.hsun.ywork.modules.course.entity.FavouriteCourseDTO;
import com.hsun.ywork.modules.course.service.CourseFavoritesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CourseFavorites 课程收藏 管理接口
 * @author GeCoder
 */
@Service("courseFavoritesService")
public class CourseFavoritesServiceImpl implements CourseFavoritesService {

	@Autowired
	private CourseFavoritesDao courseFavoritesDao;
	
	public void createCourseFavorites(CourseFavorites cf) {
		courseFavoritesDao.createCourseFavorites(cf);
	}
	
	public void deleteCourseFavoritesById(String ids) {
		courseFavoritesDao.deleteCourseFavoritesById(ids);
	}

	
	public boolean checkFavorites(String userId, int courseId) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("courseId", courseId);
		int count = courseFavoritesDao.checkFavorites(map);
		if(count>0){
			return true;
		}
		return false;
	}

	
	public List<FavouriteCourseDTO> queryFavoritesPage(String userId, PageEntity page) {
		return courseFavoritesDao.queryFavoritesPage(userId, page);
	}
    

}