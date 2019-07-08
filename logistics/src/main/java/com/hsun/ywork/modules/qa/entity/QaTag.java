package com.hsun.ywork.modules.qa.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * 问答标签
 *@author GeCoder
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class QaTag implements Serializable {
    private static final long serialVersionUID = -1912600357482790771L;
    private int questionsTagId; // 专业id
    private String questionsTagName;// 专业名称
    private int status;// 状态
    private Date createTime;// 创建时间
    private int parentId;// 父节点
}
