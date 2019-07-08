package com.hsun.ywork.modules.course.service;

import com.hsun.ywork.modules.common.entity.PageEntity;
import com.hsun.ywork.modules.course.entity.CourseFavorites;
import com.hsun.ywork.modules.course.entity.FavouriteCourseDTO;

import java.util.List;

/**
 * CourseFavorites 课程收藏 管理接口
 * @author GeCoder
 */
public interface CourseFavoritesService {
	/**
	 * 添加课程收藏
	 * @param cf
	 */
	public void createCourseFavorites(CourseFavorites cf);
	
	/**
	 * 删除课程收藏
	 * @param ids
	 */
	public void deleteCourseFavoritesById(String ids);
	
	/**
	 * 检测用户是否收藏过
	 * @param userId 用户ID
	 * @param courseId 课程ID
	 * @return true收藏过 ，false未收藏
	 */
	public boolean checkFavorites(String userId, int courseId);
	
	/**
	 * 分页查询用户收藏列表
	 * @param userId 用户ID
	 * @param page 分页条件
	 * @return List<FavouriteCourseDTO>
	 */
	public List<FavouriteCourseDTO> queryFavoritesPage(String userId, PageEntity page);
}