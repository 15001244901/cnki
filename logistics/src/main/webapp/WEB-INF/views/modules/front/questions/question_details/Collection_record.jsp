<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<title>地理云课堂</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>


		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/question_details/Collection_records.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="divtitle">
				收藏纪录
			</div>
			<div class="divcollectioncontent">
				<!--<div style="line-height: 50px;">
					<span onclick="collectionRecord.toDivLore()" class="one1">知识点</span>
					<span onclick="collectionRecord.toDivQuestions()" class="one2">&nbsp;&nbsp;题型&nbsp;&nbsp;</span>
				</div>-->
				<div id="JKDiv_0">
					<!--知识点-->
					<div class="divlore" id="subjectDiv">

					</div>
					<div class="divlore" id="questionTypeDiv">

					</div>
					<!--知识点列表-->
					<div style=" background: white;min-height: 400px;width: 1160px;margin: 0px 20px;" id="loreContent">
						<!--<table style="" cellpadding="0" cellspacing="0" id="loreContent">

						</table>-->
					</div>
					<!--知识点分页-->
					<div class="divPage" id="loreContentPage">

					</div>
				</div>
				<!--<div id="JKDiv_1">
					<div class="divquestions" id="questionTypeDiv">

					</div>
					<div style=" background: white;min-height: 400px;width: 1160px;margin: 0px 20px;" id="questionsContent">
						
					</div>
					<div class="divPage" id="questionsContentPage">

					</div>
				</div>-->

				<!--知识点-->
				<input type="hidden" id="subjectType" />
				<!--题型-->
				<input type="hidden" id="questionType" />

				<!--页面类型-->
				<!--0代表知识点1代表题库-->
				<input type="hidden" id="hidType" value="0" />

				<!--知识点当前页列表-->
				<input type="hidden" id="pageNo" value="1" />
				<!--题库当前页-->
				<input type="hidden" id="pageNoQuestion" value="1" />
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/question_details/Collection_record.js${v}"></script>
<!--<script type="text/javascript">
	
</script>-->