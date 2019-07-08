package com.hsun.ywork.modules.qa.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * 问答和 问答标签的 关联表
 *@author GeCoder
 */
@Data
public class QaTagRelation implements Serializable{
	private static final long serialVersionUID = 7687324559966427231L;
	private Long id;//id
	private Long questionsId;//问答id
	private Long questionsTagId;//问答标签id
	
	private String tagName;//问答标签名
}
