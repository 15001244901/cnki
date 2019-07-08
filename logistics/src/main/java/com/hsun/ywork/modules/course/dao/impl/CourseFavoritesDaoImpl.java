package com.hsun.ywork.modules.course.dao.impl;

import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.dao.CourseFavoritesDao;
import com.hsun.ywork.modules.course.entity.CourseFavorites;
import com.hsun.ywork.modules.course.entity.FavouriteCourseDTO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 *
 * CourseFavorites
 * @author GeCoder
 */
 @Repository("courseFavoritesDao")
public class CourseFavoritesDaoImpl extends GenericDaoImpl implements CourseFavoritesDao {

	
	public void createCourseFavorites(CourseFavorites cf) {
		this.insert("CourseFavoritesMapper.createCourseFavorites", cf);
		
	}

	
	public void deleteCourseFavoritesById(String ids) {
		this.delete("CourseFavoritesMapper.deleteCourseFavoritesById", ids);
	}

	
	public int checkFavorites(Map<String, Object> map) {
		return this.selectOne("CourseFavoritesMapper.checkFavorites", map);
	}

	
	public List<FavouriteCourseDTO> queryFavoritesPage(String userId, PageEntity page) {
		return this.queryForListPage("CourseFavoritesMapper.queryFavoritesPage", userId, page);
	}

    
}
