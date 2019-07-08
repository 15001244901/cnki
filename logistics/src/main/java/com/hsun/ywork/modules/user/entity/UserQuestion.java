/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.entity;

import com.hsun.ywork.modules.exam.entity.Question;
import org.hibernate.validator.constraints.Length;

import com.hsun.ywork.common.persistence.DataEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户试题收藏Entity
 * @author GeCoder
 * @version 2017-03-16
 */
public class UserQuestion extends DataEntity<UserQuestion> {
	
	private static final long serialVersionUID = 1L;
	private Integer dtype;	// 记录类型（1收藏记录，2练习记录（试题级别），3考试记录（试题级别），4每日一练，5试题篮）
	private Integer wtype;	// 错题标记（0正常，1错误）
	private String uid;		// 用户编号
	private String qid;		// 试题编号
	private String ukey;	// 用户答案
	private String qtype;	// 试题类型
	private String topic;	// 试题知识点
	private String bizid;	// 考试试卷id或练习试卷id

	private Question question;//完整试题对象

	private List<String> topicList = new ArrayList<String>();
	
	public UserQuestion() {
		super();
	}

	public UserQuestion(String id){
		super(id);
	}

	@Length(min=0, max=64, message="用户编号长度必须介于 0 和 64 之间")
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}
	
	@Length(min=0, max=64, message="试题编号长度必须介于 0 和 64 之间")
	public String getQid() {
		return qid;
	}

	public void setQid(String qid) {
		this.qid = qid;
	}

	public Integer getDtype() {
		return dtype;
	}

	public void setDtype(Integer dtype) {
		this.dtype = dtype;
	}

	public String getUkey() {
		return ukey;
	}

	public void setUkey(String ukey) {
		this.ukey = ukey;
	}

	public Integer getWtype() {
		return wtype;
	}

	public void setWtype(Integer wtype) {
		this.wtype = wtype;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public String getQtype() {
		return qtype;
	}

	public void setQtype(String qtype) {
		this.qtype = qtype;
	}

	public String getTopic() {
		topicList.clear();
		if(topic!=null) {
			if(topic.indexOf(",")>0) {
				for(String s : topic.split(",")) {
					topicList.add(s);
				}
			} else {
				topicList.add(topic);
			}
		}
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getBizid() {
		return bizid;
	}

	public void setBizid(String bizid) {
		this.bizid = bizid;
	}

	public List<String> getTopicList() {
		return topicList;
	}

	public void setTopicList(List<String> topicList) {
		this.topicList = topicList;
	}
}