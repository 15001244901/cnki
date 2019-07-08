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
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<%--<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />--%>
		<%--<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">--%>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/create_test_paper/edit_item_page/select_panel.css${v}" />
		<script src="${ctxStatic}/jquery/jquery-1.8.3.js${v}" type="text/javascript" charset="utf-8"></script>
		<script src="${ctxStatic}/hsun/front/js/xml2json/jquery.xml2json.js${v}" type="text/javascript"></script>
		<script src="${ctxStatic}/hsun/front/js/json2.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

		<style>	
			body{
				background: #fff;
			}	
		</style>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="swit" class="basket-tit">
			知识点
		</div>
		<div id="bo_fl" class="bo_fl state">
			<div class="sel">
				<div class="sel_title">
					选择知识点 <span class="gohide">收起</span>
				</div>
				<div class="slide_up_topic">
					<ul class="one_section dash_line">
						<!--<li><a href="javascript:void(0);">煤炭采样</a></li>-->
					</ul>
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
						<%--<ul id="ulSubject">--%>
						<%--</ul>--%>
					<%--</div>--%>
				<%--</div>--%>
				<%--<div class="divquestion">--%>
					<%--<div class="subject">--%>
						<%--<div>--%>
							<%--<p class="fs14">题型：</p>--%>
						<%--</div>--%>
						<%--<ul id="ulQuestion">--%>
						<%--</ul>--%>
					<%--</div>--%>
				<%--</div>--%>
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
					<span class="spanmodel"><i class="fa fa-book" style="color: #FE8922; font-size: 20px;"></i> &nbsp;&nbsp;&nbsp;模式：列表</span>
					
					<div class="bo_search" style="float: right;position: relative;top:-9px;">
						<input type="text" name="style" class="style" id="keyword" placeholder="请输入关键字搜索"/>
						<a href="javascript:;" onclick="textCenter.searchLibrary();"><i class="fa fa-search" id="style1"></i></a>
					</div>
				</div>
				<div id="divlist">
					<div id="questionListDiv" style="min-height: 400px;">
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
		</div>

		<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/jquery.slimscroll.min.js${v}" type="text/javascript"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/edit_item_page/select_panel.js${v}"></script>
	</body>

</html>
