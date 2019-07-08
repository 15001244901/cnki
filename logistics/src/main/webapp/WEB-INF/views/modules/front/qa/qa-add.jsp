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
	<title>地理云课堂-提问题</title>
	<meta name="author" content="FYJCKT" />
	<meta name="keywords" content="地理,在线教育,网络教育,远程教育,云网校,在线学习,在线考试" />
	<meta name="description" content="" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta content="telephone=no" name="format-detection" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<%--<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />--%>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/reset.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/theme.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/global.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/web.css${v}">
	<link href="${ctxStatic}/hsun/front/qa/css/mw_320_768.css" rel="stylesheet" type="text/css" media="screen and (min-width: 320px) and (max-width: 768px)">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/mobile_reset.css${v}">
	<!--[if lt IE 9]><script src="${ctxStatic}/hsun/front/qa/js/html5.js${v}"></script><![endif]-->
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/jquery-1.7.2.min.js${v}"></script>
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
					<section class="mr30">
						<header class="comm-title all-article-title">
							<h2 class="fl tac">
								<span class="c-333">提问题</span>
							</h2>
							<section class="c-tab-title">
								<a href="javascript: void(0)">&nbsp;</a>
							</section>
						</header>
						<!-- /提问题 开始 -->
						<div class="q-c-list">
							<dl>
								<dt>
									<span class="c-999 fsize14">分类：</span>
								</dt>
								<dd class="of">
									<section class="q-sort-wrap">
										<span class="current" name="1">学习问答</span> <span name="2">学习分享</span>
									</section>
								</dd>
							</dl>
							<dl>
								<dt>
									<span class="c-999 fsize14">标题：</span>
								</dt>
								<dd class="pr">
									<label class=""><input type="text" name="questions.title" placeholder="问题标题不少于16个字" onkeyup="checkTitleLength(this)" value=""></label>
									<aside class="q-c-jy"></aside>
								</dd>
							</dl>
							<dl>
								<dt>
									<span class="c-999 fsize14">内容：</span>
								</dt>
								<dd class="pr">
									<textarea name="questions.content" placeholder="简洁，明了，能引起思考和讨论的知识性的内容。" onkeyup="checkQuestionContent(this)"></textarea>
									<aside class="q-c-jy"></aside>
								</dd>
							</dl>
							<dl>
								<dt>
									<span class="c-999 fsize14">标签：</span>
								</dt>
								<dd class="pr">
									<div class="tags-content" id="tags-content">
										<span id="label-default" class="f-fA">请选择标签，最多选3个标签哦</span>
									</div>
									<aside class="q-c-jy"></aside>
								</dd>
							</dl>
							<dl>
								<dt>
									<span class="c-999 fsize14">&nbsp;</span>
								</dt>
								<dd>
									<div class="taglist clearfix" id="js-tags">
										<input type="hidden" name="questionsTag" id="questionsTag" value="">
										<c:forEach items="${questionsTagList }" var="questionsTag">
											<a title="${questionsTag.questionsTagName }" data-id="${questionsTag.questionsTagId }" class="list-tag" href="javascript:;">${questionsTag.questionsTagName }</a>
										</c:forEach>
									</div>
									<!-- /标签集 -->
								</dd>
							</dl>
							<dl>
								<dt>
									<span class="c-999 fsize14">&nbsp;</span>
								</dt>
								<dd class="pr">
									<label class=""><input type="text" style="width: 80px;" name="randomCode" placeholder="输入验证码" value="" onkeyup='$(this).parent().next().next().html("<img width=\"16\" height=\"16\" alt=\"正确\" src=\"${ctxStatic}/hsun/front/qa/img/d-icon.png\">")'></label>
									<div class="v-code-pic">
										<img src="${ctxRoot}/qa/ran/random" alt="验证码，点击图片更换" onclick="this.src='${ctxRoot}/qa/ran/random?random='+Math.random();" width="80" height="34" class="vam">
										<span class="c-999">看不清</span>
										<a href="javascript:void(0)" onclick="$(this).prev().prev().click();" title="" class="c-green"> 换一换 </a>
									</div>
									<aside class="q-c-jy"></aside>
								</dd>
							</dl>
							<dl>
								<dt>
									<span class="c-999 fsize14">&nbsp;</span>
								</dt>
								<dd>
									<section class="pt10">
										<a href="javascript:void(0)" onclick="addQuestions()" title="" class="comm-btn c-btn-4 bg-orange">提 问</a>
									</section>
								</dd>
							</dl>
						</div>
						<!-- /提问题 结束 -->
					</section>
				</div>
				<aside class="fl col-3">
					<div class="mt30 pl10">
						<section class="q-tip-pic col-3">
							<img src="${ctxStatic}/hsun/front/qa/img/tipQe.png" width="100%" alt="亲，您要提问吧？">
						</section>
						<h5 class="pt10">
							<span class="fsize18 c-333 vam">亲，您要提问吧？<br>
							<br>要知道这些哦！
							</span>
						</h5>
						<div class="clear"></div>
						<dl class="mt20">
							<dt>
								<h6>
									<strong class="fsize14 c-666">一、需要了解的事情：</strong>
								</h6>
							</dt>
							<dd class="pl10">
								<p class="c-999 mt10">1、您是想来吐槽的吧，没事，随便发吧。有人会跟你一起吐槽的。</p>
								<p class="c-999 mt10">2、您是来解决问题？请先搜索是否已经有同类问题吧。这样您就省心少打字。</p>
								<p class="c-999 mt10">3、没找到是么？就在发问题时精确描述你的问题，不要写与问题无关的内容哟。</p>
								<p class="c-999 mt10">4、地理云课堂问答更热衷于解答能引起思考和讨论的知识性问题；</p>
							</dd>
						</dl>
						<dl class="mt20">
							<dt>
								<h6>
									<strong class="fsize14 c-666">二、要注意的事情：</strong>
								</h6>
							</dt>
							<dd class="pl10">
								<p class="c-999 mt10">1、禁止发布求职、交易、推广、广告类等信息，与问答无关信息将一律清理。</p>
								<p class="c-999 mt10">2、尽可能详细描述您的问题，如标题与内容不符，或与问答无关的信息将被关闭。</p>
								<p class="c-999 mt10">3、问答刷屏用户一律冻结帐号。</p>
							</dd>
						</dl>
					</div>
				</aside>
				<div class="clear"></div>
			</section>
		</section>
		<!-- /提问题 结束 -->
		</div>
	</div>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/questions_add.js${v}"></script>
</body>
</html>