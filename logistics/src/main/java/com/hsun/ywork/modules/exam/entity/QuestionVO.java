package com.hsun.ywork.modules.exam.entity;

import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.common.xstream.XStreamCDATA;
import com.hsun.ywork.modules.sys.utils.DictUtils;
import com.hsun.ywork.modules.user.entity.UserQuestion;

/**
 * Created by GeCoder on 2016-12-29 .
 */
public class QuestionVO {
    private String id;          // ID
    private Integer qno;        // 试题编号
    private String qType;		// 试题类型
    private String qLevel;		// 试题难度
    private String qFrom;		// 试题来源
    private String qStatus;		// 试题状态
    @XStreamCDATA
    private String qContent;	// 试题提干
    @XStreamCDATA
    private String qKey;		// 试题选项
    @XStreamCDATA
    private String qResolve;	// 试题解析
    private int qScore;
    private String subject;     // 所属科目
    private String topic;       // 知识点
    private String post;		// 所属岗位
    private String isbasket;   // 是否已加入试题篮（0未加入，1已加入）

    private String typeName;	// 试题题型
    private String levelName;	// 试题难度
    private String subjectName; // 所属科目
    private String topicName;   // 知识点
    private String postName;    // 所属岗位

    private UserQuestion userQuestion;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getQno() {
        return qno;
    }

    public void setQno(Integer qno) {
        this.qno = qno;
    }

    public String getQType() {
        return qType;
    }

    public void setQType(String qType) {
        this.qType = qType;
    }

    public String getQLevel() {
        return qLevel;
    }

    public void setQLevel(String qLevel) {
        this.qLevel = qLevel;
    }

    public String getQFrom() {
        return qFrom;
    }

    public void setQFrom(String qFrom) {
        this.qFrom = qFrom;
    }

    public String getQStatus() {
        return qStatus;
    }

    public void setQStatus(String qStatus) {
        this.qStatus = qStatus;
    }

    public String getQContent() {
        return qContent;
    }

    public void setQContent(String qContent) {
        this.qContent = qContent;
    }

    public String getQKey() {
        return qKey;
    }

    public void setQKey(String qKey) {
        this.qKey = qKey;
    }

    public String getQResolve() {
        return qResolve;
    }

    public void setQResolve(String qResolve) {
        this.qResolve = qResolve;
    }

    public int getQScore() {
        return qScore;
    }

    public void setQScore(int qScore) {
        this.qScore = qScore;
    }

    public UserQuestion getUserQuestion() {
        return userQuestion;
    }

    public void setUserQuestion(UserQuestion userQuestion) {
        this.userQuestion = userQuestion;
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

    public String getTypeName() {
        return DictUtils.getDictLabel(qType,"dic_exam_questiontype","");
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getLevelName() {
        return DictUtils.getDictLabel(qLevel,"dic_exam_questionlevel","");
    }

    public void setLevelName(String levelName) {
        this.levelName = levelName;
    }

    public String getSubjectName() {
        return DictUtils.getDictLabel(subject,"dic_exam_questionsubject","");
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getTopicName() {
        return DictUtils.getDictLabel(topic,"dic_exam_questiontopic","");
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public String getPostName() {
        postName = "";
        if(StringUtils.isNotEmpty(post)) {
            String[] post_arr = post.split(",");
            for(String key : post_arr) {
                postName += ","+DictUtils.getDictLabel(key,"dic_exam_questionpost","");
            }
            postName = postName.replaceFirst(",","");
        } else {
            postName = DictUtils.getDictLabel(post,"dic_exam_questionpost","");
        }
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getIsbasket() {
        return isbasket;
    }

    public void setIsbasket(String isbasket) {
        this.isbasket = isbasket;
    }
}
