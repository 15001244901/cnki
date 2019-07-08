package com.hsun.ywork.modules.exam.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by GeCoder on 2017-01-18 .
 */
public class PaperSection {
    private String name;    //段落名称
    private String remark;  //段落描述
    private String id;      //段落id
    private List<QuestionVO> questions;//段落试题列表
    private int rnum;       //试题数量
    private String rtype;      //试题类型
    private String rlevel;     //试题难度
    private String rdbid;   //试题题库
    private int rscore;     //每题分值
    private String subject; //试题科目
    private String topic;   //知识点
    private String post;    //试题所属岗位

    public PaperSection() {
    }

    public PaperSection(String id, String name, String remark) {
        this.id = id;
        this.name = name;
        this.remark = remark;
    }

    public PaperSection(String name, String remark, List<QuestionVO> questions) {
        this.name = name;
        this.remark = remark;
        this.questions = questions;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return this.remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<QuestionVO> getQuestions() {
        return this.questions;
    }

    public void setQuestions(List<QuestionVO> questions) {
        this.questions = questions;
    }

    public void addQuestion(QuestionVO question) {
        if(this.questions == null) {
            this.questions = new ArrayList();
        }

        this.questions.add(question);
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getRnum() {
        return this.rnum;
    }

    public void setRnum(int rnum) {
        this.rnum = rnum;
    }

    public String getRtype() {
        return this.rtype;
    }

    public void setRtype(String rtype) {
        this.rtype = rtype;
    }

    public String getRlevel() {
        return this.rlevel;
    }

    public void setRlevel(String rlevel) {
        this.rlevel = rlevel;
    }

    public String getRdbid() {
        return this.rdbid;
    }

    public void setRdbid(String rdbid) {
        this.rdbid = rdbid;
    }

    public int getRscore() {
        return this.rscore;
    }

    public void setRscore(int rscore) {
        this.rscore = rscore;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }
}
