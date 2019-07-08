package com.hsun.ywork.modules.exam.entity;

/**
 * Created by GeCoder on 2016-12-27 .
 */
public class Option {
    private String alisa;
    private String text;

    public Option() {
    }

    public Option(String alisa, String text) {
        this.alisa = alisa;
        this.text = text;
    }

    public String getAlisa() {
        return this.alisa;
    }

    public void setAlisa(String alisa) {
        this.alisa = alisa;
    }

    public String getText() {
        return this.text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
