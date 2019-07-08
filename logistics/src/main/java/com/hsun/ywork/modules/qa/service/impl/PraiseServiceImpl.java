package com.hsun.ywork.modules.qa.service.impl;

import com.hsun.ywork.modules.comment.service.CommentService;
import com.hsun.ywork.modules.qa.dao.PraiseDao;
import com.hsun.ywork.modules.qa.entity.Praise;
import com.hsun.ywork.modules.qa.entity.Qa;
import com.hsun.ywork.modules.qa.entity.QaComment;
import com.hsun.ywork.modules.qa.service.PraiseService;
import com.hsun.ywork.modules.qa.service.QaCommentService;
import com.hsun.ywork.modules.qa.service.QaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * 点赞服务接口实现
 *@author GeCoder
 */
@Service("praiseService")
public class PraiseServiceImpl implements PraiseService {

	@Autowired
	private PraiseDao praiseDao;
	@Autowired
	private QaService questionsService;
	@Autowired
	private QaCommentService questionsCommentService;
	@Autowired
	private CommentService commentService;

	@Override
	public Long addPraise(Praise praise) {
		//根据点赞目标 type 修改相应的 点赞总数
		//点赞类型 1问答点赞 2问答评论点赞
		int type=praise.getType();
		if(type==1){
			Qa questions=questionsService.getQuestionsById(praise.getTargetId());
			questions.setPraiseCount(questions.getPraiseCount()+1);
			questionsService.updateQuestions(questions);
		}else if (type==2) {
			QaComment questionsComment=questionsCommentService.getQuestionsCommentById(praise.getTargetId());
			questionsComment.setPraiseCount(questionsComment.getPraiseCount()+1);
			questionsCommentService.updateQuestionsComment(questionsComment);
		}
//		//点赞类型为3的是文章点赞
//		if(type==3){
//			Map<String,String> map = new HashMap<String,String>();
//			map.put("num","+1");
//			map.put("type", "praiseCount");
//			map.put("articleId", praise.getTargetId()+"");
//			articleService.updateArticleNum(map);
//		}
		//点赞类型为4的是评论点赞
		if(type==4){
			Map<String,String> map = new HashMap<String,String>();
			map.put("num","+1");
			map.put("type", "praiseCount");
			map.put("commentId", praise.getTargetId()+"");
			commentService.updateCommentNum(map);
		}
		return praiseDao.addPraise(praise);
	}

	@Override
	public int queryPraiseCount(Praise praise) {
		return praiseDao.queryPraiseCount(praise);
	}

}
