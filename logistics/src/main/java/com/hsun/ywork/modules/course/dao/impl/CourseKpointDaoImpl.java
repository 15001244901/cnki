package com.hsun.ywork.modules.course.dao.impl;


import com.hsun.ywork.modules.common.dao.impl.GenericDaoImpl;
import com.hsun.ywork.modules.course.dao.CourseKpointDao;
import com.hsun.ywork.modules.course.entity.CourseKpoint;
import com.hsun.ywork.modules.course.entity.CourseKpointDto;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 *
 * CourseKpoint
 * @author GeCoder
 */
 @ToString
 @Repository("courseKpointDao")
public class CourseKpointDaoImpl extends GenericDaoImpl implements CourseKpointDao {

    public int addCourseKpoint(CourseKpoint courseKpoint) {
    	this.insert("CourseKpointMapper.createCourseKpoint",courseKpoint);
        return courseKpoint.getKpointId();
    }

	
	public List<CourseKpoint> queryCourseKpointByCourseId(int courseId) {
		return this.selectList("CourseKpointMapper.queryCourseKpointByCourseId", courseId);
	}

	
	public CourseKpointDto queryCourseKpointById(int kpointId) {
		return this.selectOne("CourseKpointMapper.queryCourseKpointById", kpointId);
	}

	
	public void updateKpoint(CourseKpoint kpoint) {
		this.update("CourseKpointMapper.updateKpoint", kpoint);
		
	}

	
	public void deleteKpointByIds(String ids) {
		this.delete("CourseKpointMapper.deleteKpointByIds", ids);
		
	}

	
	public void updateKpointParentId(Map<String, Integer> map) {
		this.update("CourseKpointMapper.updateKpointParentId", map);
	}


	@Override
	public int getSecondLevelKpointCount(Long courseId) {
		return this.selectOne("CourseKpointMapper.getSecondLevelKpointCount", courseId);
	}

}
