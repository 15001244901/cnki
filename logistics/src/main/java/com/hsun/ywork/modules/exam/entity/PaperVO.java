/**
 *
 */
package com.hsun.ywork.modules.exam.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 试卷Entity
 * @author GeCoder
 * @version 2017-01-17
 */
public class PaperVO {

	private String id;
	private String name;		// 试卷名称
	private String cid;		// 试卷分类
	private int status;		// 试卷状态
	private Date starttime;		// 开考时间
	private Date endtime;		// 结束时间
	private int duration;		// 考试时长
	private Date showtime;		// 成绩公布时间
	private int totalscore;		// 卷面总分
	private int passscore;		// 及格分数
	private int ordertype;		// 试题排列顺序
	private int papertype;		// 试卷类型
	private String remark;		// 试卷说明
	private String data;		// 试题设置
	private int showkey;		// 公布答案
	private int showmode;		// 显示形式

	private List<PaperSection> sections;
	private List<String> departments;

	public PaperVO() {
		super();
	}

	public PaperVO(String id){
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	
	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getShowtime() {
		return showtime;
	}

	public void setShowtime(Date showtime) {
		this.showtime = showtime;
	}
	
	public int getTotalscore() {
		return totalscore;
	}

	public void setTotalscore(int totalscore) {
		this.totalscore = totalscore;
	}
	
	public int getPassscore() {
		return passscore;
	}

	public void setPassscore(int passscore) {
		this.passscore = passscore;
	}
	
	public int getOrdertype() {
		return ordertype;
	}

	public void setOrdertype(int ordertype) {
		this.ordertype = ordertype;
	}
	
	public int getPapertype() {
		return papertype;
	}

	public void setPapertype(int papertype) {
		this.papertype = papertype;
	}
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
	public int getShowkey() {
		return showkey;
	}

	public void setShowkey(int showkey) {
		this.showkey = showkey;
	}
	
	public int getShowmode() {
		return showmode;
	}

	public void setShowmode(int showmode) {
		this.showmode = showmode;
	}

	public List<PaperSection> getSections() {
		return sections;
	}

	public void setSections(List<PaperSection> sections) {
		this.sections = sections;
	}

	public List<String> getDepartments() {
		return departments;
	}

	public void setDepartments(List<String> departments) {
		this.departments = departments;
	}

	public void addSection(PaperSection section) {
		if(this.sections == null) {
			this.sections = new ArrayList();
		}

		this.sections.add(section);
	}
}