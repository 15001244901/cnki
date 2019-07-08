<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<title>地理云课堂</title>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/usercenter/css/index.css${v}">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/usercenter/css/test_collection.css${v}">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	</head>

	<body style="overflow:hidden;">
		
		<div id="divcontent">
			<div class="divtitle">
				错题纪录
			</div>
			<div class="divcollectioncontent">
				<div id="JKDiv_0">
					<div class="search-type">
						<%--<div class="type-items">--%>
							<%--<div class="type-tit">科目：</div>--%>
							<%--<div class="type-conbox">--%>
								<%--<div class="type-con">--%>
									<%--<div class="con-items" id="subjectDiv">--%>
									   							<%----%>
									<%--</div>--%>
								<%--</div>			--%>
							<%--</div>--%>
						<%--</div>--%>
						<div class="type-items">
							<div class="type-tit">题型：</div>
							<div class="type-conbox">
								<div class="type-con">
									<div class="con-items" id="questionTypeDiv">
									    <!-- <a href="javascript::void(0)">小学</a>								
									    <a href="javascript::void(0)" class="type-active">初中</a>								
									    <a href="javascript::void(0)">高中</a>	 -->							
									</div>
								</div>			
							</div>
						</div>
					</div>
					
					<!--知识点列表-->
					<div style="min-height: 400px;" id="loreContent">

					</div>
					<!--知识点分页-->
					<div class="divPage" id="loreContentPage">

					</div>
				</div>


				<!--知识点-->
				<input type="hidden" id="subjectType" />
				<!--题型-->
				<input type="hidden" id="questionType" />

				<!--页面类型-->
				<!--0代表知识点1代表题库-->
				<input type="hidden" id="hidType" value="0" />

				<!--知识点当前页列表-->
				<input type="hidden" id="pageNo" value="1" />
				<!--题库当前页-->
				<input type="hidden" id="pageNoQuestion" value="1" />
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/jquery.min.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/error_collection.js${v}"></script>
