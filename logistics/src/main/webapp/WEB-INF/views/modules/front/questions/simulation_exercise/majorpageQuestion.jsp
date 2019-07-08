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

		<link href="${ctxStatic}/hsun/front/css/questions/simulation_exercise/majorpage.css${v}" type="text/css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<!--导航栏功能-->
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/question_details/swiper.min.css${v}" />
		<!--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />-->
		<script src="${ctxStatic}/hsun/front/js/jquery/idangerous.swiper.min.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
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
		</style>
		<style>
			.layui-layer-title{
				padding-right:20px;
				background: #3db06e;
			}
			#form_hand_test,#form_auto_test{
				padding-top:20px;
				width: 100%;
				/*height:1px;*/
			}
			#form_hand_test li,#form_auto_test li{
				line-height: 40px;
				text-align: left;
				padding: 5px 30px;
			}
			#form_hand_test li input,#form_auto_test li input{
				width:100%;
				padding:8px 5px !important;
				line-height: 20px;
				height:38px;
				border-radius: 3px;
				outline: none;

			}
			#btn_hand_test,#btn_auto_test{
				margin-top:40px;
			}
			#btn_hand_test a,#btn_auto_test a{
				padding:7px 20px;
				background: #3db06e;
				color: #fff;
				border-radius: 3px;
				font-size: 14px;
			}
			.txtinput{
				color: #888;
				border:1px solid #C5C5C5;
			}
			.txtinput:focus{
				border:1px solid #3db06e;
			}
		</style>
	</head>

	<body>
		<div id="divheader"></div>
		<div class="navigation_bar">
			<span onclick="majorpageQuestion.skip('0')">&nbsp;&nbsp;按知识点练习&nbsp;&nbsp;</span>
			<span onclick="majorpageQuestion.skip('1')">&nbsp;&nbsp;智能组卷练习&nbsp;&nbsp;</span>
			<span onclick="majorpageQuestion.skip('2')" class="spansubjecttitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;套题练习&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		</div>

		<!--套题练习-->
		<div id="JKDiv_2">
			<div class="tree_paper_title">

			</div>
			<%--<div id="select">--%>
				<%--<span>试卷名称：<input type="text" id="txtPaperName" class="isAudit"/> </span>--%>

				<%--<span>--%>
                                                            <%--试卷类型：--%>
					<%--<select class="isAudit" id="selPaperType" style="border: 1px solid #979797 !important;">--%>
			              <%--<option value="">不限</option>--%>
			              <%--<option value="0">模式一</option>--%>
			              <%--<option value="2">模式二</option>--%>
			              <%--<option value="3">模式三</option>--%>
			         <%--</select>--%>
        		<%--</span>--%>
				<%--<span>--%>
					<%--<input type="button" value="提交" class="button1" onclick="majorpageQuestion.searchPaper()"/>--%>
				<%--</span>--%>
			<%--</div>--%>
			<!--表格-->

			<div>
				<div style="min-height: 400px;">
					<div id="table3" class="">

					</div>

				</div>
				<div class="divPage" id="tableContentPage">

				</div>
				<input type="hidden" id="pageNo" value="1" />
			</div>
			<input type="hidden" name="hidQuestionId" id="hidQuestionId" />
			<%--<div class="divPaperName" id="divPaperName">--%>
				<%--<h1>请输入试卷名称</h1>--%>
				<%--<input type="text" name="questionName" id="questionName" value="" class="input" />--%>
				<%--<input type="hidden" name="hidQuestionId" id="hidQuestionId" />--%>
				<%--<div class="one5">--%>
					<%--<a href="javascript:;" onclick="majorpageQuestion.saveQuestionThree()">确定</a>--%>
					<%--<a href="#" id="CloseDiv" onclick="majorpageQuestion.CloseDiv()">关闭</a>--%>
				<%--</div>--%>
			<%--</div>--%>

		</div>

		<%--组卷窗口--%>
		<div id="hand_test" style="display: none">
			<form id="form_hand_test">
				<ul>
					<li>
						<%--<span>试卷名称：</span>--%>
						<input type="text" class="txtinput" id="questionName" name="name" value="请输入试卷名称"
							   onfocus="if(value=='请输入试卷名称'){value='';style.color='#333'}"
							   onblur="if(value==''){value='请输入试卷名称';style.color='#888'}"
						/>
					</li>
				</ul>
				<div id="btn_hand_test">
					<a href="javascript:;" id="btn_a"  class="active" onclick="majorpageQuestion.saveQuestionThree()">创建试卷</a>
				</div>
			</form>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/simulation_exercise/majorpageQuestion.js${v}"></script>