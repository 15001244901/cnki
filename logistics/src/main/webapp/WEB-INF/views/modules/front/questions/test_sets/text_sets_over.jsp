<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<title>地理云课堂</title>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/text_sets.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<!--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />-->
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	</head>

	<body>
		<div id="divheader"></div>
		<div id="border">
			<div class="sets">
				<div id="section">
					<span>历史组卷</span>
					<!--<span class="active"><a href="text_sets.html">试卷管理</a></span>-->
					<!--<span class="title"><a href="grading_papers.html">批改试卷</a></span>-->
				</div>
				<div class="button">
					<%--<span><a href="Start_the_test/Select_the_schema.html"><i class="fa fa-plus-circle"></i>&nbsp;&nbsp;创建试卷</a></span>--%>
				</div>
				<div class="content" id="contents">
					<img style="margin: 60px auto 0;display: block" src="${ctxStatic}/hsun/front/usercenter/images/loading.gif" alt="">
				</div>

				<div class="divPage" id="pagehtml">

				</div>
				<!--当前页码-->
				<input type="hidden" id="pageNo" value="1" />
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/text_sets_over.js${v}"></script>