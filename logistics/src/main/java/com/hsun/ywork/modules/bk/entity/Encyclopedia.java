/**
 * Copyright &copy; 2016-2020 <a href="https://github.com/hsun/ywork">YWork</a> All rights reserved.
 */
package com.hsun.ywork.modules.bk.entity;


import com.hsun.ywork.common.persistence.DataEntity;

/**
 * 百科Entity
 * @author GeCoder
 * @version 2017-08-10
 */
public class Encyclopedia extends DataEntity<Encyclopedia> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 百科词条
	private String keywords;	// 关键字
	private String content;		// 百科内容
	
	public Encyclopedia() {
		super();
	}

	public Encyclopedia(String id){
		super(id);
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}