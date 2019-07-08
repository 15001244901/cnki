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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/standard/quality.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css">

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	</head>

	<body>
		<div id="divheader"></div>

		<div class="divcontent">
			<div id="title_search">
				<div class="divtitle">
					<span class="one1"><a href="nationalstandard.html">国家标准</a></span>
					<span class="active"><a href="quality.html">质量体系</a></span>
					<div id="bottom_line"></div>
				</div>
				<%--搜索--%>
				<div class="bo_search">
					<div>
						<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
						<span class="spansearch"><a href="javascript:;" onclick="standard.searchLibrary();"><i class="fa fa-search fa-lg"></i></a></span>
					</div>
				</div>
			</div>

			<div class="divsearch">
				<div style="">科目：</div>
				<ul id="typeul">
				</ul>
			</div>
			<div class="divmodel">
				<span class="spanview">视图:</span>
				<span id="spanSummary" class="active" onclick="standard.todivlist()"><i class="fa  fa-file-text-o" style="font-size: 14px;"></i> &nbsp;摘要模式</span>
				<span id="spanList" class="two2" onclick="standard.todivview()"><i class="fa  fa-reorder" style="font-size: 14px;"></i> &nbsp;列表模式</span>

			</div>
		</div>
		<div id="divcontent" class="divcontent">
			<div id="divlist">
				<div id="table">
					<span  class="span_title"> &nbsp;<i class="fa fa-book" style="font-size: 20px; color: #FE8922;"></i><span id="spanType">综合利用</span></span>
				</div>
				<div class="content">
					<div>
						<ul class="menu-one" id="contents">
							
						</ul>
					</div>
				</div>
				<div class="divPage" id="pageSinglehtml">
				</div>
			</div>
			<div class="list" id="divview" style="display: none;">
				<table cellspacing="0" cellpadding="0" id="tbNationlstandard">

				</table>
				<div class="divPage" id="pagehtml">

				</div>
			</div>

			<input type="hidden" id="pageNo" value="1" />
			<input type="hidden" id="pageNoList" value="1" />
			<!--0代表摘要模式1代表列表模式-->
			<input type="hidden" id="hidType" value="0" />
		</div>
	</body>

</html>

<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/standard/quality.js${v}"></script>