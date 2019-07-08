package com.hsun.ywork.modules.course.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
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
public class Subject implements Serializable {
    private static final long serialVersionUID = -1912600357482790771L;
    private int subjectId; // 专业id
    private String subjectName;// 专业名称
    private int status;// 状态
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;// 创建时间
    private int parentId;// 父节点
    private int sort;//排序字段
}
