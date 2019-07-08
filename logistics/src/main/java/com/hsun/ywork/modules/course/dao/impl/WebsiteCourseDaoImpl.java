package com.hsun.ywork.modules.course.dao.impl;

import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.course.dao.WebsiteCourseDao;
import com.hsun.ywork.modules.course.entity.WebsiteCourse;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 推荐课程分类
 * @author GeCoder
 */
 @Repository("websiteCourseDao")
public class WebsiteCourseDaoImpl extends GenericDaoImpl implements WebsiteCourseDao {
    /**
     * 推荐课程分类列表
     */
    public List<WebsiteCourse> queryWebsiteCourseList(){
    	return this.selectList("WebsiteCourseMapper.queryWebsiteCourseList",0);
    }
    /**
     * 查询推荐课程分类
     */
    public WebsiteCourse queryWebsiteCourseById(int id){
    	return this.selectOne("WebsiteCourseMapper.getWebsiteCourseById", id);
    }
    /**
     * 修改推荐课程分类
     */
    public void updateWebsiteCourseById(WebsiteCourse websiteCourse){
    	this.update("WebsiteCourseMapper.updateWebsiteCourse", websiteCourse);
    }
    /**
     * 添加推荐课程分类
     */
    public void addWebsiteCourse(WebsiteCourse websiteCourse){
    	this.insert("WebsiteCourseMapper.createWebsiteCourse", websiteCourse);
    }
    /**
     * 删除推荐课程分类及分类下推荐课程
     */
    public void deleteWebsiteCourseDetailById(int id){
    	this.delete("WebsiteCourseMapper.deleteWebsiteCourseById", id);
    	this.delete("WebsiteCourseDetailMapper.delWebsiteCourseDetails", id);
    }
}
