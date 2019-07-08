package com.hsun.ywork.modules.course.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * @author GeCoder
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CourseFavorites implements Serializable{
	private static final long serialVersionUID = 5055812991457774890L;
	private int id;
    private int courseId;
    private String userId;
    private Date addTime;
}
