package com.hsun.ywork.modules.exam.entity;

import com.hsun.ywork.common.persistence.DataEntity;

import java.util.Date;

/**
 * Created by GeCoder on 2017-03-01 .
 * 考试与随机试卷对照
 */
public class PaperRandom extends DataEntity<PaperRandom> {
    private String uid;
    private String pid;
    private String detail;
    private Date createdate;

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public PaperRandom() {
    }

    public PaperRandom(String uid, String pid, String detail) {
        this.uid = uid;
        this.pid = pid;
        this.detail = detail;
    }
}
