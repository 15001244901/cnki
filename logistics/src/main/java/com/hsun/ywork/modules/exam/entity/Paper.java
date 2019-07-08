/**
 *
 */
package com.hsun.ywork.modules.exam.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hsun.ywork.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 试卷Entity
 * @author GeCoder
 * @version 2017-01-17
 */
public class Paper extends DataEntity<Paper> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 试卷名称
	private String cid;		// 试卷分类
    private Integer category;   //试卷分类（1考试试卷，2成套试卷）
	private Integer status;		// 试卷状态
	private Date starttime;		// 开考时间
	private Date endtime;		// 结束时间
	private Integer duration;		// 考试时长
	private Date showtime;		// 成绩公布时间
	private Integer totalscore;		// 卷面总分
	private Integer passscore;		// 及格分数
	private Integer ordertype;		// 试题排列顺序
	private Integer papertype;		// 试卷类型
	private String remark;		// 试卷说明
	private String data;		// 试题设置
	private Integer showkey;		// 公布答案
	private Integer showmode;		// 显示形式
	private Integer iscomplete;		// 是否完成（0为完成，1已完成）
	private Integer isoffline;	// 是否线下（0为线上，1为线下）

	private List<PaperSection> sections;	//段落列表
	private List<String> departments;		//试卷指定部门列表
	private List<String> users;		//指定考试人员列表

	private Map opt;						//字段扩展

	
	public Paper() {
		super();
	}

	public Paper(String id){
		super(id);
	}

	@Length(min=0, max=100, message="试卷名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=64, message="试卷分类长度必须介于 0 和 64 之间")
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
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
	
	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getShowtime() {
		return showtime;
	}

	public void setShowtime(Date showtime) {
		this.showtime = showtime;
	}
	
	public Integer getTotalscore() {
		return totalscore;
	}

	public void setTotalscore(Integer totalscore) {
		this.totalscore = totalscore;
	}
	
	public Integer getPassscore() {
		return passscore;
	}

	public void setPassscore(Integer passscore) {
		this.passscore = passscore;
	}
	
//	@Max(value=2,message = "试题排列顺序只能为1或者2")
	public Integer getOrdertype() {
		return ordertype;
	}

	public void setOrdertype(Integer ordertype) {
		this.ordertype = ordertype;
	}
	
	public Integer getPapertype() {
		return papertype;
	}

	public void setPapertype(Integer papertype) {
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
	
	public Integer getShowkey() {
		return showkey;
	}

	public void setShowkey(Integer showkey) {
		this.showkey = showkey;
	}
	
	public Integer getShowmode() {
		return showmode;
	}

	public void setShowmode(Integer showmode) {
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

	public Map getOpt() {
		return opt;
	}

	public void setOpt(Map opt) {
		this.opt = opt;
	}

    public Integer getCategory() {
    	if(category == null)
			category = 1;
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
		if(this.category == null)
			this.category = 1;
    }

	public Integer getIscomplete() {
		return iscomplete==null?0:iscomplete;
	}

	public void setIscomplete(Integer iscomplete) {
		this.iscomplete = iscomplete;
	}

	public Integer getIsoffline() {
		return isoffline;
	}

	public void setIsoffline(Integer isoffline) {
		this.isoffline = isoffline;
	}

	public List<String> getUsers() {
		return users;
	}

	public void setUsers(List<String> users) {
		this.users = users;
	}
}