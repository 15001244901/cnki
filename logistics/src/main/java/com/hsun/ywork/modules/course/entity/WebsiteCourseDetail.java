package com.hsun.ywork.modules.course.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * @description 推荐课程
 * @author GeCoder
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class WebsiteCourseDetail implements Serializable {
	private static final long serialVersionUID = 7475674095165175841L;

	private int id;// 主键
	private int recommendId;// 分类id
	private int courseId;// 课程id
	private int orderNum;// 排序值
}
