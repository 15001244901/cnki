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
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/online_test.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/json2.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<style>

		</style>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="div">
			<div style="height: 1px;"></div>
			<%--<div id="section">--%>
				<%--<span>在线考试</span>--%>
			<%--</div>--%>
			<div id="section_title">
				<span class="colorblur">将要开始</span>
				<span>已经过期</span>
				<div id="bottom"></div>
			</div>
			<%--<div class="abc">--%>
				<%--<span class="paper">在线考试</span>--%>
			<%--</div>--%>



			<div id="number2-1">
				<%--<div id="one">--%>
					<%--<span class="td11">课程</span>--%>
					<%--<span class="td22">时间</span>--%>
					<%--<span class="td33">分数</span>--%>
					<%--<span class="td44">操作</span>--%>
				<%--</div>--%>
				<div id="table">

				</div>
				<div class="divPage" id="pagehtml">

				</div>



				<input type="hidden" id="pageNo" value="1" />
				<input type="hidden" id="pageStype" value="0">
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/Start_the_test/online_test.js${v}"></script>