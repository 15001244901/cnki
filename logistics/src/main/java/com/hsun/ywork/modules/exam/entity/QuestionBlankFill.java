package com.hsun.ywork.modules.exam.entity;

import com.hsun.ywork.common.utils.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by GeCoder on 2016-12-29 .
 */
public class QuestionBlankFill extends QuestionVO{
    private List<QBlank> blanks;
    private boolean isComplex = false;

    public QuestionBlankFill() {
        this.setQType("4");
    }

    public List<QBlank> getBlanks() {
        return this.blanks;
    }

    public void setBlanks(List<QBlank> blanks) {
        this.blanks = blanks;
    }

    public void addBlank(int id, String key, String value) {
        if(this.blanks == null) {
            this.blanks = new ArrayList();
        }

        this.blanks.add(new QBlank(id, key, value));
    }

    public boolean isComplex() {
        return this.isComplex;
    }

    public void setComplex(boolean isComplex) {
        this.isComplex = isComplex;
    }

    public String getQKey() {
        String qKey = super.getQKey();
        if(StringUtils.isEmpty(qKey)) {
            qKey = "";
            if (this.blanks != null && this.blanks.size() > 0) {
                for (QBlank b : blanks) {
                    qKey += "【" + b.getValue()+"】";
                }
            }
        }
        return qKey;
    }
}
