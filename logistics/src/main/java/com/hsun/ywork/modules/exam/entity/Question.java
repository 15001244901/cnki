/**
 *
 */
package com.hsun.ywork.modules.exam.entity;

import com.hsun.ywork.common.persistence.DataEntity;
import com.hsun.ywork.common.utils.StringUtils;
import com.hsun.ywork.modules.sys.utils.DictUtils;
import com.hsun.ywork.modules.sys.utils.StandardUtils;
import com.hsun.ywork.modules.user.entity.UserQuestion;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 试题管理Entity
 * @author GeCoder
 * @version 2016-12-23
 */
public class Question extends DataEntity<Question> {
	
	private static final long serialVersionUID = 1L;
	private Integer qno;		// 试题编号
	private String qDbid;		// 题库ID
	private String qType;		// 试题题型
	private String qLevel;		// 试题难度
	private String qFrom;		// 试题来源
	private String qStatus;		// 试题状态
	private String qContent;	// 试题提干
	private String qKey;		// 试题选项
	private String qResolve;	// 试题解析
	private String qData;		// 试题内容
	private String qKeyword;	// 关键字
	private String qStdid;		// 依据标准
	private String qRemark;		// 备注
	private String subject;		// 所属科目
	private String topic;		// 知识点
	private String post;		// 所属岗位

	private String typeName;	// 试题题型
	private String levelName;	// 试题难度
	private String subjectName; // 所属科目
	private String topicName;	// 知识点
	private String postName;    // 所属岗位
	private String isbasket;	// 是否已加入试题篮（0未加入，记录数据id则已加入）
	private String iscollected;	// 是否已收藏(0未收藏，记录数据id则已收藏)

	private String stdNo;		// 虚拟字段：依据标准编号

	private UserQuestion userQuestion;//关联用户试题记录表，为查询用户收藏或错题记录方便


	private int qScore;

    private String[] _options;

	private Map<String,Object> _advOptions;

	private List<String> topicList = new ArrayList<String>();
	
	public Question() {
		super();
	}

	public Question(String id){
		super(id);
	}

	public Integer getQno() {
		return qno;
	}

	public void setQno(Integer qno) {
		this.qno = qno;
	}

	@Length(min=0, max=64, message="题库ID长度必须介于 0 和 64 之间")
	public String getQDbid() {
		return qDbid;
	}

	public void setQDbid(String qDbid) {
		this.qDbid = qDbid;
	}
	
	@Length(min=0, max=2, message="试题类型长度必须介于 0 和 2 之间")
	public String getQType() {
		return qType;
	}

	public void setQType(String qType) {
		this.qType = qType;
	}
	
	@Length(min=0, max=2, message="试题难度长度必须介于 0 和 2 之间")
	public String getQLevel() {
		return qLevel;
	}

	public void setQLevel(String qLevel) {
		this.qLevel = qLevel;
	}
	
	@Length(min=0, max=50, message="试题来源长度必须介于 0 和 50 之间")
	public String getQFrom() {
		return qFrom;
	}

	public void setQFrom(String qFrom) {
		this.qFrom = qFrom;
	}
	
	@Length(min=0, max=2, message="试题状态长度必须介于 0 和 2 之间")
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
	
	public String getQData() {
		return qData;
	}

	public void setQData(String qData) {
		this.qData = qData;
	}
	
	@Length(min=0, max=50, message="关键字长度必须介于 0 和 50 之间")
	public String getQKeyword() {
		return qKeyword;
	}

	public void setQKeyword(String qKeyword) {
		this.qKeyword = qKeyword;
	}
	
	@Length(min=0, max=300, message="依据标准长度必须介于 0 和 300 之间")
	public String getQStdid() {
		return qStdid;
	}

	public void setQStdid(String qStdid) {
		this.qStdid = qStdid;
	}
	
	@Length(min=0, max=200, message="备注长度必须介于 0 和 200 之间")
	public String getQRemark() {
		return qRemark;
	}

	public void setQRemark(String qRemark) {
		this.qRemark = qRemark;
	}

	@Length(min=0, max=2, message="所属知识点长度必须介于 0 和 2 之间")
	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	@Length(min=0, max=100, message="知识点长度必须介于 0 和 100 之间")
	public String getTopic() {
		topicList.clear();
		if(topic!=null) {
			if(topic.indexOf(",")>0) {
				for(String s : topic.split(",")) {
					topicList.add(s);
				}
			} else {
				topicList.add(topic);
			}
		}
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	@Length(min=0, max=100, message="所属岗位长度必须介于 0 和 100 之间")
	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public int getQScore() {
		return qScore;
	}

	public void setQScore(int qScore) {
		this.qScore = qScore;
	}

	public String[] get_options() {
        return _options;
    }

    public void set_options(String[] _options) {
        this._options = _options;
    }

	public Map<String, Object> get_advOptions() {
		return _advOptions;
	}

	public void set_advOptions(Map<String, Object> _advOptions) {
		this._advOptions = _advOptions;
	}

	public UserQuestion getUserQuestion() {
		return userQuestion;
	}

	public void setUserQuestion(UserQuestion userQuestion) {
		this.userQuestion = userQuestion;
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

	public String getIscollected() {
		return iscollected;
	}

	public void setIscollected(String iscollected) {
		this.iscollected = iscollected;
	}

	public List<String> getTopicList() {
		return topicList;
	}

	public void setTopicList(List<String> topicList) {
		this.topicList = topicList;
	}

	public String getStdNo() {
		if(StringUtils.isNotEmpty(qStdid)) {
			stdNo = "";
			String[] _arr = qStdid.split(",");
			for(String key : _arr) {
				stdNo += "、"+ StandardUtils.getStandardSno(key,"1","");
			}
			stdNo = stdNo.replaceFirst("、","");
		}
		return stdNo;
	}

	public void setStdNo(String stdNo) {
		this.stdNo = stdNo;
	}

	@Override
	public String toString() {
		return "Question{" +
				"qDbid='" + qDbid + '\'' +
				", qType='" + qType + '\'' +
				", qLevel='" + qLevel + '\'' +
				", qFrom='" + qFrom + '\'' +
				", qStatus='" + qStatus + '\'' +
				", qContent='" + qContent + '\'' +
				", qKey='" + qKey + '\'' +
				", qResolve='" + qResolve + '\'' +
				", qData='" + qData + '\'' +
				", qKeyword='" + qKeyword + '\'' +
				", qStdid='" + qStdid + '\'' +
				", subject='" + subject + '\'' +
				", topic='" + topic + '\'' +
				", post='" + post + '\'' +
				", qRemark='" + qRemark + '\'' +
				'}';
	}
}