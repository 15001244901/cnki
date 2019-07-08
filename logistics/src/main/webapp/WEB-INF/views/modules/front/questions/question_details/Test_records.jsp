<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<title>地理云课堂</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/question_details/Test_records.css${v}" />
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
				<span>考试记录</span>
			</div>
			<div class="section">
				<div class="search" style="text-align: left;">
					<span class="spanpapername">试卷名称： 
						<input type="text" id="keyword" style="width: 118px; height: 30px;border-radius: 3px;border: 1px solid #979797;"/>
					</span>

					<%--<span>试卷类型： --%>
							<%--<select id="paperType" name="type" style="width: 118px; height: 30px; border-radius: 3px;border: 1px solid #979797;">--%>
								<%--<option value="">不限</option>--%>
								<%--<option value="0">模式一</option>--%>
								<%--<option value="2">模式二</option>--%>
								<%--<option value="3">模式三</option>--%>
							<%--</select>--%>
						<%--</span>--%>
					<span onclick="testRecords.searchContent()" class="four">搜索</span>
				</div>
				<div class="divsubcontent">
					<table cellpadding="0" cellspacing="0" id="tableContent">

					</table>
				</div>
				<div class="divPage" id="tableContentPage">
				</div>
				<input type="hidden" id="pageNo" value="1" />
			</div>
		</div>

	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/question_details/Test_records.js${v}"></script>