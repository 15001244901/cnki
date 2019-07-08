/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.entity;

import org.hibernate.validator.constraints.Length;

import com.hsun.ywork.common.persistence.DataEntity;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * 收货地址管理Entity
 * @author 白云飞
 * @version 2018-04-08
 */
public class Goodaddr extends DataEntity<Goodaddr> {
	
	private static final long serialVersionUID = 1L;
	private String addr;		// 地址简称
	private String addrdesc;		// 详细地址
	private String wlgroup;		// 分组
	private String sort;		// 排序
	
	public Goodaddr() {
		super();
	}

	public Goodaddr(String id){
		super(id);
	}

	@Length(min=0, max=60, message="地址简称长度必须介于 0 和 60 之间")
	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	@Length(min=0, max=300, message="详细地址长度必须介于 0 和 300 之间")
	public String getAddrdesc() {
		return addrdesc;
	}

	public void setAddrdesc(String addrdesc) {
		this.addrdesc = addrdesc;
	}
	
	@Length(min=0, max=4, message="排序长度必须介于 0 和 4 之间")
	public String getSort() {
		return sort;
	}

	@NotEmpty
	public String getWlgroup() {
		return wlgroup;
	}

	public void setWlgroup(String wlgroup) {
		this.wlgroup = wlgroup;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
}