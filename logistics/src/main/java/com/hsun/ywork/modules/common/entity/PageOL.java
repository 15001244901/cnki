package com.hsun.ywork.modules.common.entity;

/**
 * Created by GeCoder on 2017-07-26 .
 */
public class PageOL {
    private int offsetPara = 0;
    private int limitPara = 10;

    public PageOL() {
    }

    public int getOffsetPara() {
        return this.offsetPara;
    }

    public void setOffsetPara(int offsetPara) {
        this.offsetPara = offsetPara;
    }

    public int getLimitPara() {
        return this.limitPara;
    }

    public void setLimitPara(int limitPara) {
        this.limitPara = limitPara;
    }
}
