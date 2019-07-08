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
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css${v}">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/usercenter/css/center.css${v}">
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/usercenter/css/icon.css${v}">
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/usercenter/css/center2.css${v}">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/usercenter/css/exam_record.css${v}">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/usercenter/css/index.css${v}">

	</head>
	<style>
		.search-list-right .noshow{
			color: #999;
		}
		.icona-time3{
			background-position: -427px -133px;
		}
		.bo_search{
			margin-right: 0;
			margin-top:1px;
		}
	</style>
	<body>
		<div id="divcontent">
			<div class="divtitle">
				<span>考试记录</span>
				<div class="bo_search">
					<div>
						<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
						<span class="spansearch"><a href="javascript:;" onclick="testRecords.searchContent();"><i class="fa fa-search fa-lg"></i></a></span>
					</div>
				</div>
			</div>
			<div class="section">
				<%--<div class="search" style="text-align: left;">--%>
					<%--<span class="spanpapername">试卷名称： --%>
						<%--<input type="text" id="keyword" style="width: 118px; height: 30px;border-radius: 3px;border: 1px solid #979797;"/>--%>
					<%--</span>--%>
					<%--<span>试卷类型：--%>
							<%--<select id="paperType" name="type" style="width: 118px; height: 30px; border-radius: 3px;border: 1px solid #979797;">--%>
								<%--<option value="">不限</option>--%>
								<%--<option value="0">模式一</option>--%>
								<%--<option value="2">模式二</option>--%>
								<%--<option value="3">模式三</option>--%>
							<%--</select>--%>
						<%--</span>--%>
					<%--<span onclick="testRecords.searchContent()" class="four">搜索</span>--%>
				<%--</div>--%>
				<div class="user-con" style="padding:0;">
					<div class="userzj-list">
						<ul class="f-cb" id="tableContent">
						    <!-- <li>
							    <div class="search-list-left">
								    <div class="test-pic">
									    <i class="icona-test"></i>
								    </div>
								    <div class="test-txt">
									    <p class="test-txt-p1"><a href="" target="_blank" data-cut="30">标准编号：GB/T3715-2007</a></p>
									    <p>
									    	<span><i class="icona-leixing"></i>标准名称：煤质及煤分析有关术语</span>
										    <span><i class="icona-time2"></i>实施日期 : 2008-06-01</span>
									    </p>
								    </div>
							    </div>
							    <div class="search-list-right">
									<a href="" target="_blank"><i class="icona-ceshi"></i>开始阅读</a>
								    <a href="javascript:;" class="download-btn" onclick="paper.download(162366)"><i class="icona-download1"></i>下载</a>
							    </div>
						    </li> -->
						</ul>	
					</div>
				</div>
				<div class="divPage" id="tableContentPage">
				</div>
				<input type="hidden" id="pageNo" value="1" />
			</div>
		</div>

	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/jquery.min.js${v}"></script>
<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/exam_record.js${v}"></script>