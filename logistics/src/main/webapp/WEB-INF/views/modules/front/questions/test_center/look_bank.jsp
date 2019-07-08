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
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="divtop">
				<div class="divtitle">
					<div id="spanQType"></div>
					<div onclick="window.location.href='text_center.html'" id="goback"><i class="fa fa-share"></i>&nbsp;&nbsp;返回</div>

				</div>
				<div class="divcon">
					<%--<div class="divquestiontype" id="spanQType"></div>--%>
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
					<!--<div class="divvideo">
						<div class="image">
							<img src="${ctxStatic}/hsun/front/img/videopic.jpg" />
						</div>
						<div class="computer">求视频</div>
					</div>-->

				</div>
				<div class="divnodetitle" style="clear: both;">
					<span class="spannodeone" onclick="lookBank.nodesClick()">做笔记</span>
					<span class="spantotalnodes">共有<span id="spannodes">0</span>条公开笔记</span>
					<!--<span class="spanques">还是不懂？提问</span>-->
				</div>
				<div id="nodesDiv">
					<div>
						<%--<div style="margin-left: 50px;margin-top: 20px;">我的笔记</div>--%>
						<div class="nodes_cont">
							<textarea id="nodesContent"></textarea>
						</div>
						<div class="nodes_sub">
							<div class="nodes_sub_inp">
								<input type="text" name="text" maxlength="5" placeholder="验证码" id="inp_text">
								<span id="fault" class="color4 fz12 fault"></span>
								<img style="clear: both;" src="${ctxRoot}/servlet/validateCodeServlet" onclick="$('.validateCodeRefresh').click();" alt="" id="inp_img" class="mid validateCode" height="29">

								<a href="javascript:" onclick="$('.validateCode').attr('src','${ctxRoot}/servlet/validateCodeServlet?'+new Date().getTime());" class="mid validateCodeRefresh" >看不清</a>

								<span class="show_eye"><label for="chkpublic" style="position: relative;top: 1px;">公开</label><input type="checkbox" id="chkpublic" name="chkpublic"/></span>
							</div>
							<div class="nodes_sub_btn">
								<input type="button" id="save_btn" onclick="lookBank.submitNodes()" value="提交" />
							</div>
						</div>
					</div>
					<div class="nodes">
						<div style="margin-left: 50px;margin-top: 20px;">试题笔记</div>
						<div style="margin: 10px 50px;">
							<table cellpadding="0" cellspacing="0" id="nodesTable">

							</table>
						</div>
						<div class="divPage" id="pagehtml">
							<a class="next" href="javascript:" onclick="page();">加载更多</a>
						</div>
						<div class="divPage" id="pagehtml_all" style="display: none;">
							<a class="next" href="javascript:">已加载全部</a>
						</div>
					</div>
					<!--试题ID-->
					<input type="hidden" id="hidQid" />
					<!--当前页-->
					<input type="hidden" id="pageNo" value="1" />
					<!-- 总页数-->
					<input type="hidden" id="totalPageCount" value="1" />
				</div>
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_center/lookBank.js${v}"></script>