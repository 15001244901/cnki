package com.hsun.ywork.modules.course.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author GeCoder
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CourseKpointDto extends CourseKpoint{
	private static final long serialVersionUID = -5911245722257969805L;
	private String teacherName;
}
