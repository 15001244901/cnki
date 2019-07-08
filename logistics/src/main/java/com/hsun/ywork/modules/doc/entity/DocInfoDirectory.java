/**
 *
 */
package com.hsun.ywork.modules.doc.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.hsun.ywork.common.persistence.TreeEntity;

/**
 * 文档目录Entity
 * @author GeCoder
 * @version 2016-12-21
 */
public class DocInfoDirectory extends TreeEntity<DocInfoDirectory> {
	
	private static final long serialVersionUID = 1L;
	private DocInfoDirectory parent;		// 父级编号
	private String parentIds;		// 所有父级编号
	private String name;		// 目录名称
	private String rtype;		// 所属科目
	private String type;		// 目录类型（章/节）
	private Integer sort;		// 排序
	private Integer dtype;		// 文库类型（1知识文库，2内部文库，3认证认可）

	private String docId;		// 自定义字段 获取唯一文档ID
	private String uid;

	private String iscollected;	//虚拟字段：是否收藏（0未收藏，记录id为已收藏）
	
	public DocInfoDirectory() {
		super();
	}

	public DocInfoDirectory(String id){
		super(id);
	}

	@JsonBackReference
	@NotNull(message="父级编号不能为空")
	public DocInfoDirectory getParent() {
		return parent;
	}

	public void setParent(DocInfoDirectory parent) {
		this.parent = parent;
	}
	
	@Length(min=1, max=2000, message="所有父级编号长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=100, message="目录名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=20, message="资料类型长度必须介于 1 和 20 之间")
	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}
	
	@Length(min=1, max=20, message="目录类型（章/节）长度必须介于 1 和 20 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@NotNull(message="排序不能为空")
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}

	public Integer getDtype() {
		return dtype;
	}

	public void setDtype(Integer dtype) {
		this.dtype = dtype;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getIscollected() {
		return iscollected;
	}

	public void setIscollected(String iscollected) {
		this.iscollected = iscollected;
	}
}