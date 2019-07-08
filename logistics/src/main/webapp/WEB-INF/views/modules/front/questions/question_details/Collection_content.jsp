<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<title>地理云课堂</title>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		<script src="${ctxStatic}/hsun/front/js/jquery/jquery-1.11.0.min.js${v}" type="text/javascript" charset="utf-8"></script>
		<script src="${ctxStatic}/hsun/front/js/xml2json/jquery.xml2json.js${v}" type="text/javascript"></script>

		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
		
		
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/question_details/Collection_content.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />


		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

	</head>

	<body>
		<div id="divheader"></div>
		<!--内容部分-->
		<div id="divbody">
			<div>
				<div class="divtitle">试题查看</div>
			</div>
			<div>
				<div class="left">
					<div>
						<div class="divcalculator" onclick="collectionContent.Calculator()">
							<i class="fa fa-clock-o" id="style3"></i><br />
							<span>计算器</span>
						</div>
					</div>
				</div>
				<div class="right">

					<div id="divContent">
						<div class="divContent_2">
							<div class="one1">
								<div class="one2">
								</div>
							</div>
							<div class="divQContent" id="divQContent">

							</div>
							<div class="divQContent" id="divAlisa">

							</div>
						</div>
					</div>
					<div class="right2">
						<div class="div5">
							<p style="width: 460px;">正确答案&nbsp;<span class="results1" id="spantrueAnswered"></span></p>
							<p style="margin-left: 5px;width: 180px;">本题正确率：<span class="results"> 81.49%</span></p>
							<p style="margin-left: 30px;" class=" p6">此题被引用次数：<span class="results">2014次</span></p>
						</div>
						<div class="div6">
							<div style="float: left; width: 650px;">
								<div>答案解析</div>
								<div style="font-weight:normal;margin: 10px auto;" id="divAnswered">

								</div>
							</div>
							<!--<div class="div7_1">
								<div class="image">
									<img src="${ctxStatic}/hsun/front/img/videopic.jpg" />
								</div>
								<div class="computer">求视频</div>
							</div>-->

						</div>
						<div class="div8" style="clear: both;">
							<span class="one4" onclick="collectionContent.nodesClick()">做笔记</span>
							<span class="one5">共有<span id="spannodes" style="margin-right: 0px;">0</span>条公开笔记</span>
							<!--<span class="one6">还是不懂？提问</span>-->
						</div>
						<div style="width: 100%;display: none;" id="nodesDiv">
							<div>
								<div style="margin-left: 50px;margin-top: 20px;">我的笔记</div>
								<div style="margin: 10px 50px;">
									<textarea id="nodesContent" style="width: 100%; height: 120px;"></textarea>
								</div>
								<div style="padding: 0 50px;height: 36px;">
									<div style="float: left;width: 500px;">
										<input style="height: 30px;vertical-align: top;" type="text" name="text" maxlength="5" placeholder="验证码" id="inp_text">
										<span id="fault" class="color4 fz12 fault"></span>
										<img style="clear: both;" src="${ctxRoot}/servlet/validateCodeServlet" onclick="$('.validateCodeRefresh').click();" alt="" id="inp_img" class="mid validateCode" height="32">

										<a style="margin-left: 10px;position: absolute;margin-top: 6px;text-decoration: none;color: #007AFF;" href="javascript:" onclick="$('.validateCode').attr('src','${ctxRoot}/servlet/validateCodeServlet?'+new Date().getTime());" class="mid validateCodeRefresh" style="">看不清</a>

										<span style="margin-top: 5px;position: absolute;margin-left: 100px;">公开<input type="checkbox" id="chkpublic" /></span>
									</div>
									<div style="float: right;">
										<input type="button" style="padding: 6px 16px;background: #2F96E9;border: 0px;color: white;border-radius: 4px;" onclick="collectionContent.submitNodes()" value="提交" />
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
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/question_details/Collection_content.js${v}"></script>