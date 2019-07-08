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

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/test_center/look_bank.css${v}" />
	<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
	<script src="${ctxStatic}/hsun/front/js/xml2json/jquery.xml2json.js${v}" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>--%>

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

</head>

<body>

<div id="divcontent" style="width: 96%;">
	<div class="divtop">
		<div class="divtitle">
			<div id="spanQType"></div>
		</div>
		<div class="divcon">
			<div class="divQContent" id="divQContent">
			</div>
			<div class="divQContent" id="divAlisa">
			</div>

		</div>
	</div>
	<div class="divbotton">
		<div class="divanswer">
			<p><b>正确答案 :</b>&nbsp;<span class="spananswer" id="spantrueAnswered"></span></p>
			<!--<p style="margin-left: 5px;">本题正确率：<span class="results"> 81.49%</span></p>
            <p style="margin-left: 30px;">此题被引用次数：<span class="results">2014次</span></p>-->
		</div>
		<div class="divan">
			<div style="margin-bottom: 10px;">答案解析：</div>
			<div style="font-weight:normal;" id="divAnswered">

			</div>
		</div>
	</div>
</div>
</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_center/lookBank.js${v}"></script>