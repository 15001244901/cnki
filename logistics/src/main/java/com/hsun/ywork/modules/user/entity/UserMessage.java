/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.user.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hsun.ywork.common.persistence.DataEntity;
import com.hsun.ywork.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import java.util.Date;
import java.util.List;

/**
 * 即时消息Entity
 * @author GeCoder
 * @version 2017-06-21
 */
public class UserMessage extends DataEntity<UserMessage> {
	
	private static final long serialVersionUID = 1L;
	private String senderid;		// 发送者id
	private String sendername;		// 发送者姓名
	private String recieverid;		// 接收着id
	private String recievername;		// 接收者姓名
	private String msgtype;		// 消息类型（0用户消息，1系统消息）
	private Date senddate;		// 发送时间
	private String content;		// 消息内容
	private String isread;		// 0已读，1未读

	private List<User> list;
	
	public UserMessage() {
		super();
	}

	public UserMessage(String id){
		super(id);
	}

	@Length(min=0, max=64, message="发送者id长度必须介于 0 和 64 之间")
	public String getSenderid() {
		return senderid;
	}

	public void setSenderid(String senderid) {
		this.senderid = senderid;
	}
	
	@Length(min=0, max=40, message="发送者姓名长度必须介于 0 和 40 之间")
	public String getSendername() {
		return sendername;
	}

	public void setSendername(String sendername) {
		this.sendername = sendername;
	}
	
	@Length(min=0, max=64, message="接收着id长度必须介于 0 和 64 之间")
	public String getRecieverid() {
		return recieverid;
	}

	public void setRecieverid(String recieverid) {
		this.recieverid = recieverid;
	}
	
	@Length(min=0, max=40, message="接收者姓名长度必须介于 0 和 40 之间")
	public String getRecievername() {
		return recievername;
	}

	public void setRecievername(String recievername) {
		this.recievername = recievername;
	}
	
	@Length(min=0, max=1, message="消息类型（0用户消息，1系统消息）长度必须介于 0 和 1 之间")
	public String getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSenddate() {
		return senddate;
	}

	public void setSenddate(Date senddate) {
		this.senddate = senddate;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIsread() {
		return isread;
	}

	public void setIsread(String isread) {
		this.isread = isread;
	}

	public List<User> getList() {
		return list;
	}

	public void setList(List<User> list) {
		this.list = list;
	}
}