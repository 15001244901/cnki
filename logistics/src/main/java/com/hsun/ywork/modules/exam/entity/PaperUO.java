package com.hsun.ywork.modules.exam.entity;

import com.hsun.ywork.common.persistence.DataEntity;

/**
 * Created by Administrator on 2017-03-07 .
 */
public class PaperUO extends DataEntity<PaperUO> {
    private String pid;     //试卷ID
    private String ouid;    //用户或部门ID
    private Integer ltype;  //1部门关系，0用户关系

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getOuid() {
        return ouid;
    }

    public void setOuid(String ouid) {
        this.ouid = ouid;
    }

    public Integer getLtype() {
        return ltype;
    }

    public void setLtype(Integer ltype) {
        this.ltype = ltype;
    }

    @Override
    public String toString() {
        return "PaperUO{" +
                "pid='" + pid + '\'' +
                ", ouid='" + ouid + '\'' +
                ", ltype=" + ltype +
                '}';
    }
}
