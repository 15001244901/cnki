/**
 *
 */
package com.hsun.ywork.modules.user.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hsun.ywork.common.persistence.DataEntity;
import com.hsun.ywork.common.utils.excel.annotation.ExcelField;
import com.hsun.ywork.modules.doc.entity.DocInfoDirectory;
import org.hibernate.validator.constraints.Length;

/**
 * 用户文档收藏Entity
 * @author GeCoder
 * @version 2016-11-11
 */
public class UserDocInfo extends DataEntity<UserDocInfo> {

	private static final long serialVersionUID = 1L;

	private String uid;	//用户编号
	private String did;	//文档目录编号

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getDid() {
		return did;
	}

	public void setDid(String did) {
		this.did = did;
	}

	public UserDocInfo(){

	}

	public UserDocInfo(String id){

	}

	public UserDocInfo(String uid, String did) {
		this.uid = uid;
		this.did = did;
	}
}