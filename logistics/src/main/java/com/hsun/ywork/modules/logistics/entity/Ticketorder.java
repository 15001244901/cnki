/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.logistics.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.hsun.ywork.common.persistence.DataEntity;

/**
 * 订票订单Entity
 * @author 白云飞
 * @version 2018-06-29
 */
public class Ticketorder extends DataEntity<Ticketorder> {
	
	private static final long serialVersionUID = 1L;
	private String tno;		// 车号
	private Date tdate;		// 乘车时间
	private String tname;		// 乘车人姓名
	private String tlink;		// 联系方式
	private Ticketposition tposition;		// 铺位
	private String sort;		// 排序
	
	public Ticketorder() {
		super();
	}

	public Ticketorder(String id){
		super(id);
	}

	@Length(min=0, max=100, message="车号长度必须介于 0 和 100 之间")
	public String getTno() {
		return tno;
	}

	public void setTno(String tno) {
		this.tno = tno;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTdate() {
		return tdate;
	}

	public void setTdate(Date tdate) {
		this.tdate = tdate;
	}
	
	@Length(min=0, max=60, message="乘车人姓名长度必须介于 0 和 60 之间")
	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}
	
	@Length(min=0, max=60, message="联系方式长度必须介于 0 和 60 之间")
	public String getTlink() {
		return tlink;
	}

	public void setTlink(String tlink) {
		this.tlink = tlink;
	}
	
	public Ticketposition getTposition() {
		return tposition;
	}

	public void setTposition(Ticketposition tposition) {
		this.tposition = tposition;
	}
	
	@Length(min=1, max=4, message="排序长度必须介于 1 和 4 之间")
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
}