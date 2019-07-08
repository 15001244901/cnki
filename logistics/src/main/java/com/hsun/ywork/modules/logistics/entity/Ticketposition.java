/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.entity;

import org.hibernate.validator.constraints.Length;

import com.hsun.ywork.common.persistence.DataEntity;

/**
 * 订票铺位Entity
 * @author 白云飞
 * @version 2018-06-29
 */
public class Ticketposition extends DataEntity<Ticketposition> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 铺位名称
	private String sort;		// 排序
	
	public Ticketposition() {
		super();
	}

	public Ticketposition(String id){
		super(id);
	}

	@Length(min=0, max=100, message="铺位名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=4, message="排序长度必须介于 1 和 4 之间")
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
}