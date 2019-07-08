package com.hsun.ywork.modules.logistics.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hsun.ywork.common.persistence.DataEntity;
import com.hsun.ywork.modules.sys.entity.Dict;

public class Gooddatesum extends DataEntity<Gooddatesum>{
	public Gooddatesum() {
		super();
	}

	public Gooddatesum(String id){
		super(id);
	}
	private static final long serialVersionUID = 1L;
	/*private String gno;		// 货单号
	private String gname;		// 货物名称
	private Goodaddr gaddr;		// 收货地址
	private Date gfhrq;		// 发货日期
*/	
	
	private String gffxf;		// 发放小费
	private String gwbjs;		// 物包件数
	/*private String gfklx;*/		// 付款类型
	private String gysje;		// 已收费用
	private String gdfje;		// 对付费用
	/*private String gsfzt;	*/	// 是否自提
	private String gdkje;		// 贷款金额
	private String gdianfu;		// 垫付金额
	private String gbjed;		// 保价额度
	private String gsxf;		// 手续费
	private String gbjf;		// 保价费
	/*private String glxdh;*/		// 联系电话
	private String gthje;		// 退货金额
	private String gssje;		// 少收金额
	/*private String gstatus;		// 货物状态
	private String sort;		// 排序
	private String datatype;	// 数据类型(0:app录入,1:微信录入)
	private String isread;		// 是否已读(0:已读,1:未读)，用于app推送物流消息
	private Dict gfz;			// 发货站点
	private String gfhr;*/		// 发货人
	private String months;
	public String getMonths() {
		return months;
	}

	public void setMonths(String months) {
		this.months = months;
	}

	/*@Length(min=0, max=100, message="货单号长度必须介于 0 和 100 之间")
	public String getGno() {
		return gno;
	}

	public void setGno(String gno) {
		this.gno = gno;
	}
	
	@Length(min=0, max=200, message="货物名称长度必须介于 0 和 200 之间")
	public String getGname() {
		return gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}
	
	public Goodaddr getGaddr() {
		return gaddr;
	}

	public void setGaddr(Goodaddr gaddr) {
		this.gaddr = gaddr;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getGfhrq() {
		return gfhrq;
	}

	public void setGfhrq(Date gfhrq) {
		this.gfhrq = gfhrq;
	}*/
	
	public String getGffxf() {
		return "".equals(gffxf)?null:gffxf;
	}

	public void setGffxf(String gffxf) {
		this.gffxf = gffxf;
	}
	
	@Length(min=0, max=4, message="物包件数长度必须介于 0 和 4 之间")
	public String getGwbjs() {
		return "".equals(gwbjs)?null:gwbjs;
	}

	public void setGwbjs(String gwbjs) {
		this.gwbjs = gwbjs;
	}
	
	/*@Length(min=0, max=20, message="付款类型长度必须介于 0 和 20 之间")
	public String getGfklx() {
		return gfklx;
	}

	public void setGfklx(String gfklx) {
		this.gfklx = gfklx;
	}*/
	
	public String getGysje() {
		return "".equals(gysje)?null:gysje;
	}

	public void setGysje(String gysje) {
		this.gysje = gysje;
	}
	
	public String getGdfje() {
		return "".equals(gdfje)?null:gdfje;
	}

	public void setGdfje(String gdfje) {
		this.gdfje = gdfje;
	}
	
	/*@Length(min=0, max=1, message="是否自提长度必须介于 0 和 1 之间")
	public String getGsfzt() {
		return gsfzt;
	}

	public void setGsfzt(String gsfzt) {
		this.gsfzt = gsfzt;
	}*/
	
	public String getGdkje() {
		return "".equals(gdkje)?null:gdkje;
	}

	public void setGdkje(String gdkje) {
		this.gdkje = gdkje;
	}
	
	public String getGdianfu() {
		return "".equals(gdianfu)?null:gdianfu;
	}

	public void setGdianfu(String gdianfu) {
		this.gdianfu = gdianfu;
	}

	public String getGbjed() {
		return "".equals(gbjed)?null:gbjed;
	}

	public void setGbjed(String gbjed) {
		this.gbjed = gbjed;
	}

	public String getGsxf() {
		return "".equals(gsxf)?null:gsxf;
	}

	public void setGsxf(String gsxf) {
		this.gsxf = gsxf;
	}
	
	public String getGbjf() {
		return "".equals(gbjf)?null:gbjf;
	}

	public void setGbjf(String gbjf) {
		this.gbjf = gbjf;
	}
	
	/*@Length(min=0, max=30, message="联系电话长度必须介于 0 和 30 之间")
	public String getGlxdh() {
		return glxdh;
	}

	public void setGlxdh(String glxdh) {
		this.glxdh = glxdh;
	}*/
	
	public String getGthje() {
		return "".equals(gthje)?null:gthje;
	}

	public void setGthje(String gthje) {
		this.gthje = gthje;
	}
	
	public String getGssje() {
		return "".equals(gssje)?null:gssje;
	}

	public void setGssje(String gssje) {
		this.gssje = gssje;
	}
	
	/*@Length(min=0, max=20, message="货物状态长度必须介于 0 和 20 之间")
	public String getGstatus() {
		return gstatus;
	}

	public void setGstatus(String gstatus) {
		this.gstatus = gstatus;
	}
	
	@Length(min=1, max=4, message="排序长度必须介于 1 和 4 之间")
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public String getIsread() {
		return isread;
	}

	public void setIsread(String isread) {
		this.isread = isread;
	}

	public Dict getGfz() {
		return gfz;
	}

	public void setGfz(Dict gfz) {
		this.gfz = gfz;
	}

	public String getGfhr() {
		return gfhr;
	}

	public void setGfhr(String gfhr) {
		this.gfhr = gfhr;
	}*/
}
