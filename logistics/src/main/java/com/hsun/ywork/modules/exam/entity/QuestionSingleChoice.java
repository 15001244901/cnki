package com.hsun.ywork.modules.exam.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by GeCoder on 2016-12-27 .
 * 单选题
 */
public class QuestionSingleChoice extends QuestionVO {
    private List<Option> options;

    public QuestionSingleChoice() {
        this.setQType("1");
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

    @Override
    public String toString() {
        return "QuestionSingleChoice{" +
                "options=" + options +
                '}';
    }
}
