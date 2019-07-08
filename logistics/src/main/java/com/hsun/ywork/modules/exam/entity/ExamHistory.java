/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.exam.entity;

import com.hsun.ywork.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.hsun.ywork.common.persistence.DataEntity;

/**
 * 考生考试记录Entity
 * @author GeCoder
 * @version 2017-02-14
 */
public class ExamHistory extends DataEntity<ExamHistory> {
	
	private static final long serialVersionUID = 1L;
	private String pid;		// 考试试卷
	private String uid;		// 考试人
	private Date starttime;		// 考试开始时间
	private Date endtime;		// 考试结束时间
	private String ip;		// IP地址
	private String score;		// 得分
	private String status;		// 考试状态
	private String data;		// 考试详情
	private String checks;		// 批改结果

	private String timecost;	//虚拟字段：考试耗时（分钟）
	private String urealname;	//虚拟字段：考试姓名
	private String uname;		//虚拟字段：考生用户名
	private String uno;			//虚拟字段：工号
	private Office office;		//虚拟字段：所属部门
	private int checknums;		//虚拟字段：批改数量
	private String showscore;	//虚拟字段：根据成绩公布时间显示考试详情y/n
	private String papername;	//虚拟字段：为方便起见，直接取Paper表的name字段

	private Paper paper;		//关联表：试卷
	
	public ExamHistory() {
		super();
	}

	public ExamHistory(String id){
		super(id);
	}

	public ExamHistory(String pid, String uid) {
		this.pid = pid;
		this.uid = uid;
	}

	@Length(min=0, max=64, message="考试试卷长度必须介于 0 和 64 之间")
	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}
	
	@Length(min=0, max=64, message="考试人长度必须介于 0 和 64 之间")
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
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
	
	@Length(min=0, max=50, message="IP地址长度必须介于 0 和 50 之间")
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	
	@Length(min=0, max=4, message="得分长度必须介于 0 和 4 之间")
	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	
	@Length(min=0, max=2, message="考试状态长度必须介于 0 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getTimecost() {
		return timecost;
	}

	public void setTimecost(String timecost) {
		this.timecost = timecost;
	}

	public String getUrealname() {
		return urealname;
	}

	public void setUrealname(String urealname) {
		this.urealname = urealname;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getUno() {
		return uno;
	}

	public void setUno(String uno) {
		this.uno = uno;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public int getChecknums() {
		return checknums;
	}

	public void setChecknums(int checknums) {
		this.checknums = checknums;
	}

	public String getShowscore() {
		return showscore;
	}

	public void setShowscore(String showscore) {
		this.showscore = showscore;
	}

	public String getPapername() {
		return papername;
	}

	public void setPapername(String papername) {
		this.papername = papername;
	}

	public Paper getPaper() {
		return paper;
	}

	public void setPaper(Paper paper) {
		this.paper = paper;
	}
}