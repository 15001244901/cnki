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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/In_the_test2.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>--%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

		<%--编辑器--%>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/ckeditor/css/question-answer.css${v}" />
		<style type="text/css">
			* {
				moz-user-select: -moz-none;
				-moz-user-select: none;
				-o-user-select: none;
				-khtml-user-select: none;
				-webkit-user-select: none;
				-ms-user-select: none;
				user-select: none;
			}
			/*编辑器隐藏工具栏*/
			.cke_chrome .cke_inner{
				display: none;
			}

		</style>

	</head>

	<body>
		<div id="divheader"></div>
		<div id="div">
			<div>
				<div class="one" id="divName"></div>
				<div class="twos">
					<span style="display: none;">姓名：<input type="text" id="txtName" class="style" value="" /></span>
					<span>总分值：<input type="text" id="txtTotalScore" class="style" value="" disabled/></span>
					<span>题目数量：<input type="text" id="txtCount" class="style" value="" disabled/></span>
					<span>时间（分钟）：<input type="text" id="txtDuration" class="style" value="" disabled/></span>
				</div>
			</div>
			<div>
				<form>
					<div class="left">

						<div class="one2">
							<%--<i class="fa fa-clock-o" id="style3"></i><br />--%>
							<%--<span id="spanTime">00:00:00</span>--%>
							<span id="spanHour">00</span>
							<span id="spanMinute">00</span>
							<span id="spanSecond">00</span>
							<i>小时</i>
							<i>分钟</i>
							<i>秒</i>

						</div>
						<%--<div class="one3">--%>
							<%--<i class="fa fa-building-o" id="style3"></i><br />--%>
							<%--<span>计算器</span>--%>
						<%--</div>--%>
						<div class="one4">
							<div class="two2" id="questionCard">
								<!--<span class="yesAnswer" onclick="anchorPosition(1)">01</span> 
								<span class="notAnswer" onclick="anchorPosition(2)">02</span> 
								<span class="notAnswer" onclick="anchorPosition(3)">03</span> 
								<span class="notAnswer" onclick="anchorPosition(4)">04</span> 
								<span class="notAnswer" onclick="anchorPosition(5)">05</span>-->
							</div>
							<div class="two5">
								<span>未答 </span><i class="fa fa-stop" style="color: #a3bcc9;"></i>
								<span>已答 </span><i class="fa fa-stop" style="color: #db856d;"></i>
								<span>正在答 </span><i class="fa fa-stop" style="color: #2F96E9;"></i>
							</div>
						</div>
						<div class="div3" onclick="InTheTestTwo.spanPause()">
							<i class="fa fa-pause" id="style3"></i><br />
							<span>暂停做题</span>
						</div>
						<!--<div class="div4" onclick="savaSchedule()">
							<i class="fa fa-save" id="style3"></i><br />
							<span>保存进度</span>
						</div>-->
						<div class="div5" onclick="InTheTestTwo.savaQuestions()">
							<i class="fa fa-cloud-upload" id="style3"></i><br />
							<span>我要交卷</span>
						</div>

					</div>

					<div class="right" id="divContent">

					</div>
					<input type="hidden" id="hidID" name="pid" />
				</form>
			</div>
		</div>
		<%--公式编辑器--%>
		<div id="formula-wrap" style="width: 560px; height: 420px;">
			<div class="formula-tit">地理云课堂    - 公式编辑器</div>
			<div class="formula-iframe">
				<iframe frameborder="0" width="100%" height="320"></iframe>
			</div>
			<button type="button" class="close" id="J_FormulaClose">关 闭</button>
			<button type="button" class="submit" id="J_FormulaOk">确 定</button>
		</div>

		<div class="q-res">
			<div class="edit-wrap2">
				<div contenteditable="true" class="fill-edit txt-field edit-line  cke_editable cke_editable_inline cke_contents_ltr done-textarea"></div>
			</div>
		</div>
	</body>

</html>
<style type="text/css">
	.layui-layer-btn {
		text-align: center;
	}
	
	.layui-layer-content {
		text-align: center;
	}
</style>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/Start_the_test/In_the_test2.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/ckeditor/ckeditor.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/js/jquery-ui-1.9.2.custom.min.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/js/texzilla.js${v}"></script>