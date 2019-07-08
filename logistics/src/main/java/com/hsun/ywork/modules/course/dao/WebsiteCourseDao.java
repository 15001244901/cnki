package com.hsun.ywork.modules.course.dao;

import com.hsun.ywork.modules.course.entity.WebsiteCourse;
import java.util.List;

/**
 * WebsiteCourse管理接口
 * @author GeCoder
 */
public interface WebsiteCourseDao {

    /**
     * 推荐课程分类列表
     */
    public List<WebsiteCourse> queryWebsiteCourseList();

    /**
     * 查询推荐课程分类
     */
    public WebsiteCourse queryWebsiteCourseById(int id);
    /**
     * 修改推荐课程分类
     */
    public void updateWebsiteCourseById(WebsiteCourse websiteCourse);
    /**
     * 添加推荐课程分类
     */
    public void addWebsiteCourse(WebsiteCourse websiteCourse);

    /**
     * 删除推荐课程分类及分类下推荐课程
     */
    public void deleteWebsiteCourseDetailById(int id);
}