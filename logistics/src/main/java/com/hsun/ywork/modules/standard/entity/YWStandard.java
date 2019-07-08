/**
 *
 */
package com.hsun.ywork.modules.standard.entity;

import com.hsun.ywork.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

import java.net.URLDecoder;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 标准管理Entity
 * @author GeCoder
 * @version 2016-11-23
 */
public class YWStandard extends DataEntity<YWStandard> {
	
	private static final long serialVersionUID = 1L;
	private int category;		// 管理类型（1国家标准;2质量体系）
	private String typesys;		// 标准分类
	private String subtype;		// 标准子类
	private String sno;		// 标准号
	private String name;		// 中文名称
	private String enname;		// 英文名称
	private String yearno;		// 年代号
	private String status;		// 标准状态
	private String ics;		// ICS分类
	private String typeorg;		// 组织类别
	private String typezh;		// 中标分类
	private String typeno;		// 标准分类编号
	private String pagenum;		// 页数
	private Date issuedate;		// 发布日期
	private Date executedate;		// 实施日期
	private Date canceldate;		// 作废日期
	private String replacedby;		// 被替代标准
	private String replacestd;		// 替代标准
	private String citestd;		// 引用标准（多个标准用英文分号分割）
	private String usestd;		// 采用标准
	private String draftcompany;		// 起草单位（多个标准用英文分号分割）
	private String gkcompany;		// 归口单位
	private String title;		// 原文标题
	private String recheckresult;		// 复核结果
	private String according;		// 标引依据
	private String supplement;		// 补充修订
	private String stdrange;		// 范围
	private String hasfile;		// 有/无文件
	private String remark;		// 备注
	private String files;		//文件路径
	private String thumbnail;	//缩略图
	
	public YWStandard() {
		super();
	}

	public YWStandard(String id){
		super(id);
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	@Length(min=0, max=50, message="标准分类长度必须介于 0 和 50 之间")
	public String getTypesys() {
		return typesys;
	}

	public void setTypesys(String typesys) {
		this.typesys = typesys;
	}
	
	@Length(min=0, max=50, message="标准子类长度必须介于 0 和 50 之间")
	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}
	
	@Length(min=0, max=50, message="标准号长度必须介于 0 和 50 之间")
	public String getSno() {
		return sno;
	}

	public void setSno(String sno) {
		this.sno = sno;
	}
	
	@Length(min=0, max=200, message="中文名称长度必须介于 0 和 200 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=300, message="英文名称长度必须介于 0 和 300 之间")
	public String getEnname() {
		return enname;
	}

	public void setEnname(String enname) {
		this.enname = enname;
	}
	
	@Length(min=0, max=20, message="年代号长度必须介于 0 和 20 之间")
	public String getYearno() {
		return yearno;
	}

	public void setYearno(String yearno) {
		this.yearno = yearno;
	}
	
	@Length(min=0, max=20, message="标准状态长度必须介于 0 和 20 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=50, message="ICS分类长度必须介于 0 和 50 之间")
	public String getIcs() {
		return ics;
	}

	public void setIcs(String ics) {
		this.ics = ics;
	}
	
	@Length(min=0, max=50, message="组织类别长度必须介于 0 和 50 之间")
	public String getTypeorg() {
		return typeorg;
	}

	public void setTypeorg(String typeorg) {
		this.typeorg = typeorg;
	}
	
	@Length(min=0, max=50, message="中标分类长度必须介于 0 和 50 之间")
	public String getTypezh() {
		return typezh;
	}

	public void setTypezh(String typezh) {
		this.typezh = typezh;
	}
	
	@Length(min=0, max=20, message="标准分类编号长度必须介于 0 和 20 之间")
	public String getTypeno() {
		return typeno;
	}

	public void setTypeno(String typeno) {
		this.typeno = typeno;
	}
	
	@Length(min=0, max=10, message="页数长度必须介于 0 和 10 之间")
	public String getPagenum() {
		return pagenum;
	}

	public void setPagenum(String pagenum) {
		this.pagenum = pagenum;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getIssuedate() {
		return issuedate;
	}

	public void setIssuedate(Date issuedate) {
		this.issuedate = issuedate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getExecutedate() {
		return executedate;
	}

	public void setExecutedate(Date executedate) {
		this.executedate = executedate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCanceldate() {
		return canceldate;
	}

	public void setCanceldate(Date canceldate) {
		this.canceldate = canceldate;
	}
	
	@Length(min=0, max=200, message="被替代标准长度必须介于 0 和 200 之间")
	public String getReplacedby() {
		return replacedby;
	}

	public void setReplacedby(String replacedby) {
		this.replacedby = replacedby;
	}
	
	@Length(min=0, max=200, message="替代标准长度必须介于 0 和 200 之间")
	public String getReplacestd() {
		return replacestd;
	}

	public void setReplacestd(String replacestd) {
		this.replacestd = replacestd;
	}
	
	@Length(min=0, max=2000, message="引用标准（多个标准用英文分号分割）长度必须介于 0 和 2000 之间")
	public String getCitestd() {
		return citestd;
	}

	public void setCitestd(String citestd) {
		this.citestd = citestd;
	}
	
	@Length(min=0, max=200, message="采用标准长度必须介于 0 和 200 之间")
	public String getUsestd() {
		return usestd;
	}

	public void setUsestd(String usestd) {
		this.usestd = usestd;
	}
	
	@Length(min=0, max=200, message="起草单位（多个标准用英文分号分割）长度必须介于 0 和 200 之间")
	public String getDraftcompany() {
		return draftcompany;
	}

	public void setDraftcompany(String draftcompany) {
		this.draftcompany = draftcompany;
	}
	
	@Length(min=0, max=100, message="归口单位长度必须介于 0 和 100 之间")
	public String getGkcompany() {
		return gkcompany;
	}

	public void setGkcompany(String gkcompany) {
		this.gkcompany = gkcompany;
	}
	
	@Length(min=0, max=200, message="原文标题长度必须介于 0 和 200 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=100, message="复核结果长度必须介于 0 和 100 之间")
	public String getRecheckresult() {
		return recheckresult;
	}

	public void setRecheckresult(String recheckresult) {
		this.recheckresult = recheckresult;
	}
	
	@Length(min=0, max=100, message="标引依据长度必须介于 0 和 100 之间")
	public String getAccording() {
		return according;
	}

	public void setAccording(String according) {
		this.according = according;
	}
	
	@Length(min=0, max=100, message="补充修订长度必须介于 0 和 100 之间")
	public String getSupplement() {
		return supplement;
	}

	public void setSupplement(String supplement) {
		this.supplement = supplement;
	}

    @Length(min=0, max=100, message="范围长度必须介于 0 和 100 之间")
    public String getStdrange() {
        return stdrange;
    }

    public void setStdrange(String stdrange) {
        this.stdrange = stdrange;
    }

    @Length(min=0, max=50, message="有/无文件长度必须介于 0 和 50 之间")
	public String getHasfile() {
		return hasfile;
	}

	public void setHasfile(String hasfile) {
		this.hasfile = hasfile;
	}

	@Length(min=0, max=500, message="文件路径长度必须介于 0 和 500 之间")
	public String getFiles() {
		try {
			if(files!=null)
				files = URLDecoder.decode(files,"UTF-8");
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			return files;
		}
	}

	public void setFiles(String files) {
		this.files = files;
	}

	@Length(min=0, max=200, message="备注长度必须介于 0 和 200 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Length(min=0, max=200, message="缩略图长度必须介于 0 和 200 之间")
	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
}