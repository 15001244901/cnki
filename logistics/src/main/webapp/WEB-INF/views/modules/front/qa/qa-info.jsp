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
	<title>地理云课堂-问答详情</title>
	<meta name="author" content="FYJCKT" />
	<meta name="keywords" content="地理,在线教育,网络教育,远程教育,云网校,在线学习,在线考试" />
	<meta name="description" content="" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta content="telephone=no" name="format-detection" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/reset.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/theme.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/global.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/web.css${v}">
	<link href="${ctxStatic}/hsun/front/qa/css/mw_320_768.css" rel="stylesheet" type="text/css" media="screen and (min-width: 320px) and (max-width: 768px)">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/mobile_reset.css${v}">
	<!--[if lt IE 9]><script src="${ctxStatic}/hsun/front/qa/js/html5.js"></script><![endif]-->
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/webutils.js${v}"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>--%>
	<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>--%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/common.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_public.js${v}"></script>

	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
</head>
<body>
	<div id="divheader"></div>
	<div class="bg-fa of">
		<div id="qa_container">
		<section class="container">
			<section class="i-question">
				<div class="fl col-7">
					<section class="mr30 pt10">
						<section class="path-wrap txtOf hLh30">
							<%--<a href="${ctxRoot}" title="" class="c-999 fsize14">首页</a>--%>
							<%--\--%>
							<a href="${ctxRoot}/qa/questions/list" title="" class="c-999 fsize14">问答首页</a>
							\ <span class="c-333 fsize14">${questions.title }</span>
						</section>
						<!-- /问题详情 开始 -->
						<div>
							<section class="q-infor-box">
								<div class="pr">
									<aside class="q-head-pic">
										<c:choose>
											<c:when test="${not empty questions.picImg }">
												<img src="${questions.picImg }" alt="">
											</c:when>
											<c:otherwise>
												<img src="${ctxStatic}/hsun/front/qa/img/avatar-boy.gif" alt="">
											</c:otherwise>
										</c:choose>
										<p class="hLh30 txtOf"></p>
									</aside>
									<section class="q-txt-box">
										<aside class="q-share">
											<span class="fl" title="分享到："><em class="icon14 q-share-icon mt5">&nbsp;</em></span>
											<div class="fl ml10" style="width: 95px;">
												<div class="bdsharebuttonbox bdshare-button-style0-16" id="bdshare" data-bd-bind="1443601302583" style="right: -160px;">
													<a title="分享到新浪微博" href="#" class="bds_tsina" data-cmd="tsina"></a>
													<a title="分享到微信" href="#" class="bds_weixin" data-cmd="weixin"></a>
													<a title="分享到QQ空间" href="#" class="bds_qzone" data-cmd="qzone"></a>
													<a title="分享到腾讯微博" href="#" class="bds_tqq" data-cmd="tqq"></a>
												</div>
												<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
											</div>
											<div class="clear"></div>
										</aside>
										<h3 class="hLh30 txtOf">
											<em class="icon16 q-tw">&nbsp;</em> <span class="c-blue fsize14"> <c:if test="${empty questions.showName }">${questions.email }</c:if> <c:if test="${not empty questions.showName }">${questions.showName }</c:if>
											</span> <span class="c-999 fsize14"> <c:if test="${questions.type==1 }">学习提问</c:if> <c:if test="${questions.type==2 }">学习分享</c:if>
											</span>
										</h3>
									</section>
									<section class="ml50 pl10">
										<div class="mt20">
											<h3 class="hLh30 txtOf">
												<span class="fsize18 c-333 vam">${questions.title }</span>
											</h3>
										</div>
										<div class="i-q-txt mt15">
											
												<span class="c-999 f-fA"><c:out value="${questions.content}"></c:out></span>
											
										</div>
										<div class="mt20 pr10">
											<section class="fr">
												<span> <a href="#i-art-comment" title="评论" class="noter-dy vam">
														<em class="icon18">&nbsp;</em>(<span id="questionsReplyCount">${questions.replyCount }</span>)
													</a> <tt class="noter-zan vam ml10 f-fM" title="赞一下" onclick="addPraise(${questions.id },1,this)">
														<em class="icon18">&nbsp;</em>(<span>${questions.praiseCount }</span>)
													</tt>
												</span>
											</section>
											<span class="c-ccc fl vam starttime">${questions.modelTime }</span>
											<section class="fl ml20 pt10">
												<div class="taglist clearfix">
													<c:forEach items="${questions.questionsTagRelationList }" var="questionsTag">
														<a title="${questionsTag.tagName }" data-id="${questionsTag.questionsTagId }" onclick="submitForm('${questionsTag.questionsTagId }','questionsTagId')" class="list-tag" href="javascript:;">${questionsTag.tagName }</a>
													</c:forEach>
												</div>
											</section>
											<div class="clear"></div>
										</div>
									</section>
								</div>
								<span id="questionsCommentSpan"></span>
							</section>
						</div>
						<!-- /问题列表 结束 -->
					</section>
				</div>
				<aside class="fl col-3">
					<div class="mt30 pl10 qa_infor_ask">
						<section class="pt10">
							<a href="javascript:void(0)" onclick="toAddQuestions()" title="我要提问" class="comm-btn c-btn-5">我要提问</a>
						</section>
						<section class="pt20">
							<div class="taglist clearfix">
								<form action="${ctxRoot}/qa/questions/list" id="searchForm" method="post">
									<input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
									<input type="hidden" name="questions.orderFalg" value="${questions.orderFalg}" />
									<input type="hidden" name="questions.type" value="${questions.type}" />
									<input type="hidden" name="questions.status" value="${questions.status}" />
									<input type="hidden" name="questions.questionsTagId" value="${questions.questionsTagId}" />
								</form>
								<c:forEach items="${questionsTagList }" var="questionsTag">
									<a title="${questionsTag.questionsTagName }" data-id="${questionsTag.questionsTagId }" class="list-tag" href="javascript:;" onclick="submitForm('${questionsTag.questionsTagId }','questionsTagId')">${questionsTag.questionsTagName }</a>
								</c:forEach>
							</div>
						</section>
						<!-- /标签云 -->
						<section class="mt30">
							<section class="c-infor-tabTitle c-tab-title">
								<a href="javascript: void(0)" title="热门问答推荐">热门问答推荐</a>
							</section>
							<div class="q-r-rank-list">
								<ul id="hotQuestions">
									<section class="no-data-wrap">
										<em class="icon30 no-data-ico">&nbsp;</em> <span class="c-666 fsize14 ml10 vam">没有相关数据，小编正在努力整理中...</span>
									</section>
								</ul>
							</div>
						</section>
						<!-- /热门问答排行 -->
					</div>
				</aside>
				<div class="clear"></div>
			</section>
		</section>
		<!-- /提问题 结束 -->
		</div>
	</div>
	<script>
	var questionsId="${questions.id}";
    var is_user_id = "${fns:getUser().id}";
	</script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/questions_info.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/questions.js${v}"></script>
</body>
</html>