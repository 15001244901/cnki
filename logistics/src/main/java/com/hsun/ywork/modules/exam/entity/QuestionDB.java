/**
 *
 */
package com.hsun.ywork.modules.exam.entity;

import com.hsun.ywork.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 题库Entity
 * @author GeCoder
 * @version 2017-01-17
 */
public class QuestionDB extends DataEntity<QuestionDB> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 题库名称
	private String logo;		// 题库图标
	private String status;		// 题库状态
	private int questionNums;	// 试题数量
	private String remark;		// 题库说明
	
	public QuestionDB() {
		super();
	}

	public QuestionDB(String id){
		super(id);
	}

	@Length(min=0, max=100, message="题库名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=100, message="题库图标长度必须介于 0 和 100 之间")
	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}
	
	@Length(min=0, max=2, message="题库状态长度必须介于 0 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=200, message="题库说明长度必须介于 0 和 200 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getQuestionNums() {
		return questionNums;
	}

	public void setQuestionNums(int questionNums) {
		this.questionNums = questionNums;
	}
}