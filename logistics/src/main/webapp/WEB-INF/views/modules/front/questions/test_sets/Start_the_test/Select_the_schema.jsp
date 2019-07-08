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

		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/Select_the_schema.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="div">
			<div class="div1">
				<span>选择模式</span>
			</div>
			<div class="div2">
				<a href="../create_test_paper/create_test_paper.html">
					<div>
						<span id="style">选题 <span class="model1">模式1</span></span><br />
						<span id="style1">手动逐一选题</span>
					</div>
				</a>
				<a href="../create_test_paper/create_test_paper_two.html">
					<div>
						<span id="style">选题 <span class="model">模式 2</span></span><br />
						<span id="style1">自动随机选题</span>
					</div>
				</a>
				<a href="../create_test_paper/create_test_paper_three.html">
					<div>
						<span id="style">选题 <span class="model">模式 3</span></span><br />
						<span id="style1">选择历史套题</span>
					</div>
				</a>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript">
	$(function() {
		$("#divheader").load(projectname+"/page/include/headerquestion.html");
	});
</script>