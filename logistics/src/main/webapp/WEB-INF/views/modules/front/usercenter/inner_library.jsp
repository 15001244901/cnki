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
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/usercenter/css/library_collection.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/usercenter/css/index.css${v}">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/usercenter/css/totalIcon.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

	</head>

	<body>
		<!--内容部分-->
		<div class="divcontent">
			<div id="section">
				<span class="title"><a class="library_center" href="library_collection.html">知识文库</a></span>
				<span class="active"><a class="library_center" href="inner_library.html">内部文库</a></span>
			</div>

			<div id="divsearch">
				<div style="text-align: left;float: left;margin-left: 10px;margin-top: 19px;font-weight: 200;font-size: 14px;color: #333;">科目:</div>
				<ul id="typeul" style="margin-top: 10px;margin-bottom: 10px;">

				</ul>
			</div>
			<%--<div id="table">--%>
				<%--<div>--%>
					<%--<span class="spantitle"><i class="fa fa-book"></i>&nbsp;&nbsp;<span id="spanType">基础知识</span></span>--%>
					<%--<div class="bo_search" style="float:right;position: relative;display: inline-block;left: -15px;top:-7px;">--%>
						<%--<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">--%>
						<%--<span class="spansearch"><a href="javascript:;" onclick="library.searchLibrary();"><i class="fa fa-search"></i></a></span>--%>
					<%--</div>--%>
					<%----%>
				<%--</div>--%>
			<%--</div>--%>
			<div class="content">
				<div>
					<ul class="menu-one" id="contents">

					</ul>
				</div>
			</div>
		</div>
		

	</body>
	
</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/jquery.min.js${v}"></script>
<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/inner_library.js${v}"></script>
