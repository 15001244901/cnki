package com.hsun.ywork.modules.exam.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by GeCoder on 2016-12-29 .
 */
public class QuestionMultipleChoice extends QuestionVO {
    private List<Option> options;

    public QuestionMultipleChoice() {
        this.setQType("2");
    }

    public List<Option> getOptions() {
        return this.options;
    }

    public void setOptions(List<Option> options) {
        this.options = options;
    }

    public void addOption(Option option) {
        if(this.options == null) {
            this.options = new ArrayList();
        }

        this.options.add(option);
    }
}
