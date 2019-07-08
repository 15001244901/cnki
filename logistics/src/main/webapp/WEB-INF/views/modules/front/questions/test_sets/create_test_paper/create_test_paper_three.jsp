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
		<%--<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />--%>
		<%--<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">--%>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>


		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/create_test_paper/create_test_paper_three.css${v}" />

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
		<div id="border">
			<div class="divtitle">
				<div class="divtitle_name">请选择试卷</div>
				<div class="bo_search">
					<div>
						<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
						<span class="spansearch"><a href="javascript:;" onclick="createTestPaperThree.searchContent();"><i class="fa fa-search "></i></a></span>
					</div>
				</div>
			</div>


			<%--<div class="divtitlename">--%>
				<%--<span class="one2">试卷名称</span>--%>
				<%--<span class="divsearch">--%>
					<%--<input type="text" style="clear: both;" name="" id="keyword" class="input" placeholder="请输入试卷名称"/>--%>
					<%--<i class="fa  fa-search" onclick="createTestPaperThree.searchContent()"></i>--%>
				<%--</span>--%>
			<%--</div>--%>
			<div class="divcontent">
				<div style="min-height: 400px;">
					<div id="tableContent" >

					</div>
				</div>
				<div class="divPage" id="tableContentPage">

				</div>
				<input type="hidden" name="hidQuestionId" id="hidQuestionId" />
				<%--<div id="div5">--%>
					<%--<h1>请输入试卷名称</h1>--%>
					<%--<input type="text" name="questionName" id="questionName" value="" class="input" />--%>
					<%--<input type="hidden" name="hidQuestionId" id="hidQuestionId" />--%>
					<%--<div class="one5">--%>
						<%--<a href="javascript:;" onclick="createTestPaperThree.saveQuestionThree()">确定</a>--%>
						<%--<a href="javascript:;" id="CloseDiv" onclick="createTestPaperThree.CloseDiv('div5')">关闭</a>--%>
					<%--</div>--%>
				<%--</div>--%>
			</div>
			<input type="hidden" id="pageNo" value="1" />

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
					<a href="javascript:;" id="btn_a"  class="active" onclick="createTestPaperThree.saveQuestionThree()">创建试卷</a>
				</div>
			</form>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/create_test_paper/create_test_paper_three.js${v}"></script>