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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/create_test_paper/create_test_paper.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<!--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />-->
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	</head>
	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="divtitle">
				<span>创建试卷</span>
			</div>
			<form>
				<div class="divvalue">
					<ul>
						<li>
							<span>试卷名称：</span>
							<input type="text" class="txtinput" id="txtName" name="name" />
						</li>
						<li>
							<span>题目数量：</span>
							<input type="text" class="txtinput" id="pnums" />
						</li>
						<li>
							<span>总分值：</span>
							<input type="text" class="txtinput" id="txtTotalScore" />
						</li>
						<li>
							<span>及格分值：</span>
							<input type="text" class="txtinput" id="txtPassScore" />
						</li>
						<li>
							<span>答题时间(分钟)：</span>
							<input type="text" class="txtinput" id="txtDuration" />
						</li>
					</ul>
					<!--<div>
						<div class="divpost">
							<div class="divposttitle">岗位选择：</div>
							<div class="divpostvalue" id="divPost">
							</div>
						</div>
					</div>-->
					<div class="footer">
						<span class="act"><a href="javascript:;" onclick="createTestpaper.spanReset()">&nbsp;&nbsp;&nbsp;&nbsp;重置&nbsp;&nbsp;&nbsp;&nbsp;</a></span>
						<span><a href="javascript:;"  class="active" onclick="createTestpaper.submitPaper()">创建试卷</a></span>
					</div>
				</div>
			</form>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/create_test_paper/create_test_paper.js${v}"></script>