<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<!--[if lt IE 7]>      <html class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no,minimal-ui">
	<title>地理云课堂-问答列表</title>
	<meta name="author" content="FYJCKT" />
	<meta name="keywords" content="地理,在线教育,网络教育,远程教育,云网校,在线学习,在线考试" />
	<meta name="description" content="" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta content="telephone=no" name="format-detection" />

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/reset.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/theme.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/global.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/web.css">
	<link href="${ctxStatic}/hsun/front/qa/css/mw_320_768.css" rel="stylesheet" type="text/css" media="screen and (min-width: 320px) and (max-width: 768px)">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/mobile_reset.css${v}">
	<!--[if lt IE 9]><script src="${ctxStatic}/hsun/front/qa/js/html5.js"></script><![endif]-->
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/webutils.js"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/common.js"></script>

	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_public.js${v}"></script>

<head>
<title>我的提问</title>
</head>
<body>
	<article class="">
		<div class="" style="padding:10px;">
			<%--<div class="u-r-cont">--%>
			<section>
				<div class="mobile_hide">
					<span class="fr"><a href="${ctxRoot}/qa/questions/toadd" target="_blank" class="comm-btn c-btn-6" style="font-size: 16px; height: 22px; line-height: 22px; padding: 0 20px;">去提问</a></span>
					<section class="c-infor-tabTitle c-tab-title cnew-tab-title">
						<%--<a href="javascript: void(0)" title="我的问答" style="cursor: default;">我的问答</a>--%>
						<a href="${ctxRoot}/qa/myqa/list" title="我的提问" class="current">我的提问</a>
						<a href="${ctxRoot}/qa/myrepqa/list" title="我的回答">我的回答</a>
					</section>
				</div>
				<div class="mt40 mobile_top0">
					<c:if test="${empty questionsList }">
						<!-- /无数据提示 开始-->
						<section class="no-data-wrap">
							<em class="icon30 no-data-ico">&nbsp;</em> <span class="c-666 fsize14 ml10 vam">亲，您还没有提过问题，快去提问吧！</span>
						</section>
						<!-- /无数据提示 结束-->
					</c:if>
					<c:if test="${not empty questionsList }">
						<div class="u-question-wrap">
							<section class="q-all-list">
								<ul>
									<c:forEach items="${questionsList }" var="question">
										<li>
											<aside class="q-head-pic">
												<c:choose>
													<c:when test="${not empty question.picImg }">
														<img src="${question.picImg }" alt="">
													</c:when>
													<c:otherwise>
														<img src="${ctxStatic}/hsun/front/qa/img/avatar-boy.gif" alt="">
													</c:otherwise>
												</c:choose>
												<p class="hLh30 txtOf">
													<span class="c-999"> <c:if test="${empty question.showName }">${question.email }</c:if> <c:if test="${not empty question.showName }">${question.showName }</c:if>
													</span>
												</p>
											</aside>
											<section class="q-txt-box">
												<a class="replyBrowseNum" href="${ctxRoot}/qa/questions/info/${question.id }" title="" target="_blank">
													<div class="replyNum">
														<span class="r-b-num">${question.replyCount }</span>
														<p class="hLh30">
															<span class="c-999 f-fA">回答数</span>
														</p>
													</div>
													<div class="browseNum">
														<span class="r-b-num">${question.browseCount }</span>
														<p class="hLh30">
															<span class="c-999 f-fA">浏览数</span>
														</p>
													</div>
												</a>
												<h3 class="hLh30 txtOf">
													<em class="icon16 q-tw">&nbsp;</em>
													<a href="${ctxRoot}/qa/questions/info/${question.id }" title="" class="fsize16 c-333 vam" target="_blank">${question.title }</a>
												</h3>
												<h3 class="hLh30 txtOf mt5">
													<em class="icon16 q-hd">&nbsp;</em>
													<c:if test="${empty question.questionsCommentList }">
														<span class="fsize12 c-999 vam">哈~~~ 此问题大家还有苦思冥想中...</span>
														<!-- 没有回答时的内容 -->
													</c:if>
													<c:if test="${not empty question.questionsCommentList }">
														<c:if test="${question.status==0 }">
															<span class="fsize12 c-999 vam"> <tt class="c-ccc f-fM mr5">[最新回答]</tt> 
																	<c:forEach items="${question.questionsCommentList }" var="questionsComment">
																		<c:out value="${questionsComment.content }"></c:out>
																	</c:forEach>
															</span>
															<!-- 有回答时显示最新一条的回答内容 -->
														</c:if>

														<c:if test="${question.status==1 }">
															<span class="fsize12 c-999 vam"> <tt class="c-green f-fM mr5">[最佳回答]</tt> 
																	<c:forEach items="${question.questionsCommentList }" var="questionsComment">
																		<c:out value="${questionsComment.content }"></c:out>
																	</c:forEach>
															</span>
															<!-- 采纳最佳显示最佳答案内容 -->
														</c:if>
													</c:if>
												</h3>
												<div class="mt15">
													<span class="c-ccc fl vam">时间：${question.modelTime }</span>
													<section class="fl ml20 pt10">
														<div class="taglist clearfix">
															<c:forEach items="${question.questionsTagRelationList }" var="questionsTag">
																<a title="${questionsTag.tagName }" data-id="${questionsTag.questionsTagId }" class="list-tag" href="${ctxRoot}/qa/questions/list?questions.questionsTagId=${questionsTag.questionsTagId }" target="_blank">${questionsTag.tagName }</a>
															</c:forEach>
														</div>
													</section>
													<div class="clear"></div>
												</div>
											</section>
										</li>
									</c:forEach>
								</ul>
							</section>
						</div>
					</c:if>
					<!-- 公共分页 开始 -->
					<jsp:include page="/WEB-INF/views/modules/front/qa/front_page.jsp" />
					<!-- 公共分页 结束 -->
					<form action="${ctxRoot}/qa/myqa/list" id="searchForm" method="post">
						<input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
					</form>
				</div>
			</section>
			<!-- /Wo的消息 -->
		</div>
	</article>
	<script type="text/javascript">
		if(top.hei){
			top.hei()
		}
	</script>
</body>
</html>