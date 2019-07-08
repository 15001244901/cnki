package com.hsun.ywork.modules.course.service.impl;

import com.hsun.ywork.modules.course.dao.CourseKpointDao;
import com.hsun.ywork.modules.course.entity.CourseKpoint;
import com.hsun.ywork.modules.course.entity.CourseKpointDto;
import com.hsun.ywork.modules.course.service.CourseKpointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CourseKpoint 课程章节 管理接口
 * @author GeCoder
 */
@Service("courseKpointService")
public class CourseKpointServiceImpl implements CourseKpointService {

 	@Autowired
    private CourseKpointDao courseKpointDao;
 	
    public int addCourseKpoint(CourseKpoint courseKpoint){
    	return courseKpointDao.addCourseKpoint(courseKpoint);
    }

	
	public List<CourseKpoint> queryCourseKpointByCourseId(int courseId) {
		return courseKpointDao.queryCourseKpointByCourseId(courseId);
	}

	
	public CourseKpointDto queryCourseKpointById(int kpointId) {
		return courseKpointDao.queryCourseKpointById(kpointId);
	}

	
	public void updateKpoint(CourseKpoint kpoint) {
		courseKpointDao.updateKpoint(kpoint);
	}

	
	public void deleteKpointByIds(String ids) {
		if(ids!=null && ids.trim().length()>0){
			if(ids.trim().endsWith(",")){
				ids = ids.trim().substring(0,ids.trim().length()-1);
			}
			courseKpointDao.deleteKpointByIds(ids);
		}
	}

	
	public void updateKpointParentId(int kpointId, int parentId) {
		Map<String,Integer> map = new HashMap<String, Integer>();
		map.put("kpointId", kpointId);
		map.put("parentId", parentId);
		courseKpointDao.updateKpointParentId(map);
		
	}


	@Override
	public int getSecondLevelKpointCount(Long courseId) {
		return courseKpointDao.getSecondLevelKpointCount(courseId);
	}
    
}