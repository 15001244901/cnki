/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.hsun.ywork.common.persistence.DataEntity;

/**
 * 模拟练习Entity
 * @author GeCoder
 * @version 2017-03-15
 */
public class UserPractice extends DataEntity<UserPractice> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 试卷名称
	private Integer duration;		// 考试时长
	private String uid;		// 用户ID
	private Integer totalscore;		// 卷面总分
	private Integer userscore;		// 考试得分
	private String paper;		// 试卷xml数据
	private String answer;		// 用户答案
	private String check;		// 判分结果
	private Date testdate;		// 练习时间
	private Integer timecost;		// 耗时
	
	public UserPractice() {
		super();
	}

	public UserPractice(String id){
		super(id);
	}

	@Length(min=0, max=50, message="试卷名称长度必须介于 0 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getDuration() {
		return duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}
	
	@Length(min=0, max=50, message="用户ID长度必须介于 0 和 50 之间")
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}
	
	public Integer getTotalscore() {
		return totalscore;
	}

	public void setTotalscore(Integer totalscore) {
		this.totalscore = totalscore;
	}
	
	public Integer getUserscore() {
		return userscore;
	}

	public void setUserscore(Integer userscore) {
		this.userscore = userscore;
	}
	
	public String getPaper() {
		return paper;
	}

	public void setPaper(String paper) {
		this.paper = paper;
	}
	
	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	public String getCheck() {
		return check;
	}

	public void setCheck(String check) {
		this.check = check;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTestdate() {
		return testdate;
	}

	public void setTestdate(Date testdate) {
		this.testdate = testdate;
	}
	
	public Integer getTimecost() {
		return timecost;
	}

	public void setTimecost(Integer timecost) {
		this.timecost = timecost;
	}
	
}