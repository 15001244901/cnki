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
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/library/knowledge_library.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/library/totalIcon.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}"></script>
		<script src="${ctxStatic}/hsun/front/js/json2.js${v}" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css">
	</head>

	<body>
		<div id="divheader"></div>
		<%--搜索--%>

		<!--内容部分-->
		<div class="divcontent">
			<div id="title_search">
				<div id="section">
					<span class="title"><a href="knowledge_library.html">知识文库</a></span>
					<span class="active"><a href="inside_library.html">内部文库</a></span>
					<div id="bottom_line"></div>
				</div>
				<div class="bo_search">
					<div>
						<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
						<span class="spansearch"><a href="javascript:;" onclick="library.searchLibrary();"><i class="fa fa-search fa-lg"></i></a></span>
					</div>
				</div>
			</div>

			<div id="divsearch">
				<div style="">科目：</div>
				<ul id="typeul" style="margin-top: 10px;margin-bottom: 10px;">
				</ul>
			</div>
		</div>
		<div class="divcontent">
			<div id="table">
				<div>
					<span class="spantitle"><i class="fa fa-book"></i>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanType">基础知识</span></span>
				</div>
			</div>
			<div class="content">
				<div>
					<ul class="menu-one" id="contents">

					</ul>
				</div>
			</div>
		</div>
		<input type="hidden" value="5" id="knowledge_style">
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/library/insideLibrary.js${v}"></script>