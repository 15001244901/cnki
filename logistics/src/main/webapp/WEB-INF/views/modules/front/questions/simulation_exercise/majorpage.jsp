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
		<%--<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/question_details/swiper.min.css${v}" />--%>
		<!--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />-->
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
	</head>

	<body>
		<div id="divheader"></div>
		<div class="navigation_bar">
			<span onclick="majorpage.skip('0')" class="spansubjecttitle" id="button_0">&nbsp;&nbsp;按知识点练习&nbsp;&nbsp;</span>
			<span onclick="majorpage.skip('1')">&nbsp;&nbsp;智能组卷练习&nbsp;&nbsp;</span>
			<span onclick="majorpage.skip('2')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;套题练习&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		</div>

		<!--按知识点练习-->
		<div id="JKDiv_0">
			<div id="number2-1">
				<div class="tree_paper_list">
					<div class="tree_paper_title">

					</div>
					<ul class="tree_paper_cont">
						<img id="load_img" style="margin: 140px auto 0;display: block;" src="${ctxRoot}/static/hsun/front/usercenter/images/loading.gif" alt="">
						<%--<li>--%>
							<%--<div class="one_list">--%>
								<%--<span class="_cont_name"><i class="fa fa-list ml30 fz20"></i>第一知识点</span>--%>
								<%--<span class="_cont_num"><em>10</em> / 333</span>--%>
								<%--<span class="_cont_btn">--%>
									<%--<a href="javascript:void(0);">开始做题</a><a href="javascript:void(0);">重新做题</a>--%>
								<%--</span>--%>
							<%--</div>--%>
							<%--<ul>--%>
								<%--<li>--%>
									<%--<div class="one_list">--%>
										<%--<span class="_cont_name"><i class="fa fa-list ml60 fz16 posr"></i>第一知识点</span>--%>
										<%--<span class="_cont_num"><em>10</em> / 333</span>--%>
										<%--<span class="_cont_btn">--%>
											<%--<a href="javascript:void(0);">开始做题</a><a href="javascript:void(0);">重新做题</a>--%>
										<%--</span>--%>
									<%--</div>--%>
									<%--<ul>--%>
										<%--<li>--%>
											<%--<div class="one_list">--%>
												<%--<span class="_cont_name"><i class="fa fa-dot-circle-o ml90 fz16 posr"></i>第一知识点</span>--%>
												<%--<span class="_cont_num"><em>10</em> / 333</span>--%>
												<%--<span class="_cont_btn">--%>
													<%--<a href="javascript:void(0);">开始做题</a><a href="javascript:void(0);">重新做题</a>--%>
												<%--</span>--%>
											<%--</div>--%>
										<%--</li>--%>
										<%--<li>--%>
											<%--<div class="one_list">--%>
												<%--<span class="_cont_name"><i class="fa fa-dot-circle-o ml90 fz16 posr"></i>第一知识点</span>--%>
												<%--<span class="_cont_num"><em>10</em> / 333</span>--%>
												<%--<span class="_cont_btn">--%>
													<%--<a href="javascript:void(0);">开始做题</a><a href="javascript:void(0);">重新做题</a>--%>
												<%--</span>--%>
											<%--</div>--%>
										<%--</li>--%>
									<%--</ul>--%>
								<%--</li>--%>
								<%--<li>--%>
									<%--<div class="one_list">--%>
										<%--<span class="_cont_name"><i class="fa fa-dot-circle-o ml60 fz16 posr"></i>第一知识点</span>--%>
										<%--<span class="_cont_num"><em>10</em> / 333</span>--%>
										<%--<span class="_cont_btn">--%>
											<%--<a href="javascript:void(0);">开始做题</a><a href="javascript:void(0);">重新做题</a>--%>
										<%--</span>--%>
									<%--</div>--%>
								<%--</li>--%>
							<%--</ul>--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<div class="one_list">--%>
								<%--<span class="_cont_name"><i class="fa fa-dot-circle-o ml30 fz20"></i>第一知识点</span>--%>
								<%--<span class="_cont_num"><em>10</em> / 333</span>--%>
								<%--<span class="_cont_btn">--%>
									<%--<a href="javascript:void(0);">开始做题</a><a href="javascript:void(0);">重新做题</a>--%>
								<%--</span>--%>
							<%--</div>--%>
						<%--</li>--%>
					</ul>
				</div>

			</div>
		</div>

		<div id="this_alert">
			<div class="this_alert t_scale01">
				<div class="this_alert_title">
					<i></i>温馨提示
				</div>
				<p>
					每次固定只抽取20道题，抽完为止
				</p>
				<a class="this_alert_btn" href="javscript:void(0);">
					继续
				</a>
				<div id="this_alert_close">
					×
				</div>
			</div>
		</div>
	</body>

</html>

<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/simulation_exercise/majorpage.js${v}"></script>