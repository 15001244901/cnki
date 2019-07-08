/**
 *
 */
package com.hsun.ywork.modules.doc.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.hsun.ywork.common.persistence.DataEntity;
import com.hsun.ywork.common.utils.excel.annotation.ExcelField;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Max;
import java.util.Date;

/**
 * 文档维护Entity
 * @author GeCoder
 * @version 2016-11-11
 */
public class DocInfo extends DataEntity<DocInfo> {
	
	private static final long serialVersionUID = 1L;
	private Integer doctype;	// 文库分类（1知识文库，2内部文库，3认证认可）
	private String title;		// 文档标题
	private String domain;		// 所属科目
	private DocInfoDirectory directory;	//所属章节
	private String summary;		// 摘要
	private String keywords;		// 关键字
	private String filesize;		// 文档大小
	private String showtype;	// 展现方式（file/html）
	private String content;		// 正文（文档类型为html时启用）
	private String files;		// 附件（存放文件相对路径）
	private Integer pvcount;		// 浏览量
	private Integer downloadcount;		// 下载量

    // 认证认可相关字段
    private String fileno;      // 文件编号
    private String edition;     // 版次
    private Date publicdate;    // 颁布日期

	
	public DocInfo() {
		super();
	}

	public DocInfo(String id){
		super(id);
	}

	public Integer getDoctype() {
		return doctype;
	}

	public void setDoctype(Integer doctype) {
		this.doctype = doctype;
	}

	@Length(min=0, max=300, message="文档标题长度必须介于 0 和 300 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=50, message="文档分类长度必须介于 0 和 50 之间")
	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	@JsonIgnore
	@ExcelField(title="所属章节", align=2, sort=50)
	public DocInfoDirectory getDirectory() {
		return directory;
	}

	public void setDirectory(DocInfoDirectory directory) {
		this.directory = directory;
	}

	@Length(min=0, max=300, message="摘要长度必须介于 0 和 300 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	@Length(min=0, max=50, message="关键字长度必须介于 0 和 50 之间")
	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	
	@Length(min=0, max=20, message="文档大小长度必须介于 0 和 20 之间")
	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
	@Length(min=0, max=2000, message="附件（存放文件相对路径）长度必须介于 0 和 2000 之间")
	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	public Integer getPvcount() {
		return pvcount==null?0:pvcount;
	}

	public void setPvcount(Integer pvcount) {
		this.pvcount = pvcount;
	}
	
	public Integer getDownloadcount() {
		return downloadcount==null?0:downloadcount;
	}

	public void setDownloadcount(Integer downloadcount) {
		this.downloadcount = downloadcount;
	}

	@Length(min=0, max=10, message="展现方式长度必须介于 0 和 10 之间")
	public String getShowtype() {
		return showtype;
	}

	public void setShowtype(String showtype) {
		this.showtype = showtype;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

    public String getFileno() {
        return fileno;
    }

    public void setFileno(String fileno) {
        this.fileno = fileno;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getPublicdate() {
        return publicdate;
    }

    public void setPublicdate(Date publicdate) {
        this.publicdate = publicdate;
    }
}