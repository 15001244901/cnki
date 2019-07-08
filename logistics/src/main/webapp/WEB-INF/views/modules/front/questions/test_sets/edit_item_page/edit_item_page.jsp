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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/test_center/hangModell.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<script src="${ctxStatic}/hsun/front/js/xml2json/jquery.xml2json.js${v}" type="text/javascript"></script>
		<script src="${ctxStatic}/hsun/front/js/json2.js${v}"></script>

		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

		<style>

		</style>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="container">

			<div id="bo_fl" class=" state">
				<div class="sel">
					<div class="sel_title">
						选择知识点
					</div>
					<div class="slide_up_topic">
						<ul class="one_section dash_line">
							<!--<li><a href="javascript:void(0);">煤炭采样</a></li>-->
						</ul>
					</div>
				</div>
				<div style="clear: both;"></div>
				<div class="basket active" id="J_Basket">
					<div class="basket-head">
						<span class="sel_title_num">共计：（<span id="totalnum">0</span>）道题</span>
					</div>
					<div class="basket-tit">
						<p><i class="icona-gouwulan "></i><em>试题篮</em></p>
						<span onclick="textCenter.basketHide()"><i class="icona-gouwuleft"></i></span>
					</div>
					<div class="basket-con">
						<div class="basket-count">
							<%--<div class="basket-head">--%>
								<%--共计：（<span id="totalnum" style="color: #ff1c1c;">0</span>）道题--%>
							<%--</div>--%>
							<div class="baskrt-list">
								<!--<p title="单选题">单选题：<span>2</span>道<i class="icona-del1 f-fr" onclick="basket.removeAll('单选题', 2791066,2791065)"></i></p>-->
							</div>
						</div>
						<div class="basket-foot">
							<form id="formList" onsubmit="return false">
								<input id="txtDuration" name="duration" type="hidden" /></span>
								<input id="txtTotalScore" name="totalscore" type="hidden"/></span>
								<input id="txtPassScore" name="passscore" type="hidden"/></span>
								<ul id="basket">
									<ul>
										<li id="basket_style_1">
										</li>
										<ol id="basket_id_1">
										</ol>
									</ul>
									<ul>
										<li id="basket_style_2">
										</li>
										<ol id="basket_id_2">
										</ol>
									</ul>
									<ul>
										<li id="basket_style_3">
										</li>
										<ol id="basket_id_3">
										</ol>
									</ul>
									<ul>
										<li id="basket_style_4">
										</li>
										<ol id="basket_id_4">
										</ol>
									</ul>
									<ul>
										<li id="basket_style_5">
										</li>
										<ol id="basket_id_5">
										</ol>
									</ul>
									<ul>
										<li id="basket_style_6">
										</li>
										<ol id="basket_id_6">
										</ol>
									</ul>
								</ul>
								<input type="hidden" id="hidID" name="id" />
								<input type="hidden" id="hidName" name="name" />
								<input type="hidden" name="starttime" />
								<input type="hidden" name="endtime" />
								<input type="hidden" name="showtime" />
								<input type="hidden" id="hidOrderType" name="ordertype" />
								<input type="hidden" id="hidPaperType" name="papertype" />
								<input type="hidden" name="remark" />
								<button type="submit" onclick="textCenter.savaChoose()" id="to-paper-edit" data-method="post" class="basket-btn">生成试卷</button>
							</form>
							<!--<a id="to-paper-edit" data-method="post" class="basket-btn" href="javascript:void(0);" style="">生成试卷</a>-->
						</div>
					</div>
				</div>
			</div>
			<div id="divcontent">
				<div id="divcontainer">
					<%--<div class="divsubject">--%>
						<%--<div class="subject">--%>
							<%--<div>--%>
								<%--<p class="fs14">科目：</p>--%>
							<%--</div>--%>
							<%--<ul>--%>
							<%--</ul>--%>
						<%--</div>--%>
					<%--</div>--%>
					<div class="divquestion">
						<div class="subject">
							<div>
								<p class="fs14">题型：</p>
							</div>
							<ul id="ulQuestion">
							</ul>
						</div>
					</div>
					<div class="divlevel">
						<div class="subject">
							<div>
								<p class="fs14">难度：</p>
							</div>
							<ul id="ulLevel">
							</ul>
						</div>
					</div>
					<div class="divpost">
						<div class="subject">
							<div>
								<p class="fs14">岗位：</p>
							</div>
							<ul id="ulPost">
							</ul>
						</div>
					</div>
				</div>
				<div class="divlistmodel">
					<div class="divtotal">
						<span class="spanmodel"><i class="fa fa-book" style="color: #FE8922; font-size: 20px;"></i> &nbsp;&nbsp;&nbsp;试题列表</span>
						<div class="bo_search" style="float: right;position: relative;top:-9px;left:25px;">
							<input type="text" name="style" class="style" id="keyword" placeholder="请输入关键字搜索"/>
							<a href="javascript:;" onclick="textCenter.searchLibrary();"><i class="fa fa-search" id="style1"></i></a>
						</div>
					</div>
					<div id="divlist">
						<!--<span class="two9">单选题</span><br />-->
						<div id="questionListDiv" style="min-height: 800px;">
							<!--<table id="tableContent" cellpadding="0" cellspacing="0">
							</table>-->
						</div>
						<div class="divPage" id="pagehtml">
	
						</div>
					</div>
					<div id="divview">
						<div id="questionSingle">
							
						</div>
						<div class="divPage" id="pagehtmlSingle">
	
						</div>
					</div>
	
				</div>
				<!--科目-->
				<input type="hidden" id="subjectType" />
				<!--题型-->
				<input type="hidden" id="questionType" />
				<!--难度-->
				<input type="hidden" id="levelType" />
				<!--岗位-->
				<input type="hidden" id="postType" />
				<%--知识点--%>
				<input type="hidden" id="topictValue">
				<!--页面类型-->
				<!--0代表列表模式1代表逐题模式-->
				<input type="hidden" id="hidType" value="0" />
	
				<!--当前页列表-->
				<input type="hidden" id="pageNo" value="1" />
				<!--当前页逐题-->
				<input type="hidden" id="pageNoSingle" value="1" />
				<!--当前页逐题总页数-->
				<input type="hidden" id="totalPageCount" value="1" />
				<!--当前题id-->
				<!--<input type="hidden" id="hidquestionid" value="1" />-->
				<%--左侧边栏的初始坐标--%>
				<input type="hidden" id="get_left">
			</div>
		</div>
		<div style="clear: both;"></div>

		<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/jquery.slimscroll.min.js${v}" type="text/javascript"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/edit_item_page/edit_item_page.js${v}"></script>
	</body>

</html>
