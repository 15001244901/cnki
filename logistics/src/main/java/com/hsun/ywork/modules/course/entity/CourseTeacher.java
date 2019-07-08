package com.hsun.ywork.modules.course.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * @author GeCoder
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CourseTeacher implements Serializable{
	private static final long serialVersionUID = 1L;
	private int id;
    private Integer courseId;
    private Integer teacherId;
}
