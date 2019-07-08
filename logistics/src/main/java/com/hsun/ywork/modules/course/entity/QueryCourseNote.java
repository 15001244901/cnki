package com.hsun.ywork.modules.course.entity;

import com.hsun.ywork.common.utils.StringUtils;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 
 * @ClassName com.inxedu.os.edu.entity.course.QueryCourseNote
 * @description
 * @author GeCoder
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class QueryCourseNote implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6304788895712532361L;
	private Long id;// id
	private Long kpointId;// 节点id
	private Long userId;// 用户id
	private String content;// 笔记内容
	private java.util.Date updateTime;// 修改时间
	private int status;//状态 0显示 1隐藏
	private String nickname;//用戶名
	private String email;//邮箱
	private String keyword;//关键字
	private String pointName;//节点名
	private String startDate;//开始时间
	private String endDate;//结束时间
	private String shortContent;
	private Long courseId;//课程id
	private String courseName;//课程名字
	
	public String getShortContent(){
		//去除html
		shortContent= StringUtils.replaceTagHTML(content);
		//截取50个字
		shortContent = StringUtils.getLength(shortContent, 50);
		return shortContent;
	}
}
