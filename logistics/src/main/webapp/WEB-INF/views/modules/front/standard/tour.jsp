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
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/standard/tour.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}"></script>
		<script src="${ctxStatic}/hsun/front/js/json2.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pdf/pdfobject.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="divtitle">
				<div class="divsno">
					<span>标准号：</span>
					<span id="spanSno">GB/T32217-2016</span>
				</div>
				<div class="divstandard">
					<span id="spanName">煤炭制样标准</span>
				</div>
				<div class="divdetail">
					<a href="${ctxRoot}/page/standard/nationalstandard.html" title="返回上一页" ><i class="fa fa-share "></i></a>
					<span><a href="javascript:;" title="查看标准详情" class="fa fa-list-ul" onclick="tour.standardDetail()"></a></span>
					<span id="full_screen" title="全屏查看"><i class="fa fa-arrows-alt"></i></span>
				</div>
			</div>

			<input type="hidden" id="standardid" />
			<div id="pdfDiv">
				<div class="no_data" style="display:none;padding-top:1px;opacity:0.5;background:url('${ctxStatic}/hsun/front/img/nodata.png') no-repeat center 50px;height:100%;">
				</div>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/standard/tour.js${v}"></script>