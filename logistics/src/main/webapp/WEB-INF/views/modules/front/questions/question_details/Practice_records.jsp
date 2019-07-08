<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<title>地理云课堂</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		
		<link href="${ctxStatic}/hsun/front/css/question_details/Practice_records.css${v}" type="text/css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="divtitle">
				练习纪录
			</div>
			<div class="divcontent2">
				<!--<div class="divcontent2_1">
					<span onclick="skip('0','JKDiv_',2)" class="spanpractice">练习历史</span>
					<span onclick="skip('1','JKDiv_',2)" class="mynode">我的笔记</span>
					<span onclick="skip('2','JKDiv_',2)" class="othernode">采的笔记</span>
				</div>-->
				<div id="JKDiv_0">
					<div style="min-height: 400px;">
						<table cellpadding="0" cellspacing="0" id="tableContent">

						</table>
					</div>

					<div class="divPage" id="tableContentPage">
					</div>
					<input type="hidden" id="pageNo" value="1" />
				</div>
				<div id="JKDiv_1">
					<div class="mynodes">我的笔记</div>

				</div>
				<div id="JKDiv_2">
					<div class="mynodes">采的笔记</div>
				</div>
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/question_details/Practice_records.js${v}"></script>