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
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/library/library.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/library/totalIcon.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css">
	</head>

	<body>
		<div id="divheader"></div>
		<%--搜索--%>
		<%--<div class="bo_search">--%>
			<%--<div>--%>
				<%--<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">--%>
				<%--<span class="spansearch"><a href="javascript:;" onclick="library.searchLibrary();"><i class="fa fa-search fa-lg"></i></a></span>--%>
			<%--</div>--%>
		<%--</div>--%>
		<!--分类部分-->
		<div class="divcontent">
			<div id="title_search">
				<div id="section">
					<span class="active"><a href="${ctxRoot}/page/library/knowledge_library.html">文库</a></span>
					<span><a href="${ctxRoot}/page/baike/baike.html">百科</a></span>
					<%--<span><a href="${ctxRoot}/page/attestation/attestation.html">认证认可</a></span>--%>
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
				<div>科目：</div>
				<ul id="typeul" style="margin-top: 8px;margin-bottom: 8px;">

				</ul>
			</div>
		</div>
		<!--内容部分-->
		<div class="divcontent">
			<div id="table">
				<div>
					<span class="spantitle"><i class="fa fa-book"></i>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanType">基础知识</span></span>
				</div>
			</div>
			<div class="content">
				<div>
					<ul class="menu-one" id="contents">
						<%--<li class="search_list">--%>
							<%--<div class="search_list_img">--%>
								<%--<img src="/ywork/static/hsun/front/img/zhaiyao.png" alt="">--%>
							<%--</div>--%>
							<%--<div class="search_list_infor">--%>
								<%--<p class="search_list_infor_name">第一节成煤植物及其有机组成</p>--%>
								<%--<p class="search_list_infor_type"><span>章节：煤的生成</span><span>科目：基础知识</span><span>分类：知识文库</span></p>--%>
							<%--</div>--%>
						<%--</li>--%>
					</ul>

				</div>
			</div>
		</div>

		<input type="hidden" value="5" id="knowledge_style">
	</body>
	
</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/library/knowledge_library.js${v}"></script>
