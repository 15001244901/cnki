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
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css">
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/grading_papers.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

	<%--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />--%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

	</head>

	<body>
		<div id="divheader"></div>
		<div id="border">
			<div id="section">

				<span class="pigai"><i class="fa fa-pencil" style="padding-right:10px;"></i>试卷批改</span>
				<%--<div style="width: 50%;float: right;margin-top: 8px;">--%>
					<%--<div class="panel-heading" >--%>
						<%--<div class="row">--%>
							<%--<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4"></div>--%>
							<%--<div class="col-lg-8">--%>
								<%--<div class="input-group">--%>
									<%--<input id="keyword" type="text" name="urealname" class="form-control" placeholder="请输入关键字">--%>
									<%--<span class="input-group-btn">--%>
										<%--<button onclick="gradingPapers.searchContent()" class="btn btn-default" type="button">搜索</button>--%>
									  <%--</span>--%>
								<%--</div>--%>
							<%--</div>--%>
						<%--</div>--%>
					<%--</div>--%>
				<%--</div>--%>
				<%--搜索--%>
				<div class="bo_search">
					<div>
						<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
						<span class="spansearch"><a href="javascript:;" onclick="gradingPapers.searchContent();"><i class="fa fa-search fa-lg"></i></a></span>
					</div>
				</div>

			</div>
			<div class="section">
				<div class="search">
					<%--<span class="one"><input type="text" id="keyword" class="input" placeholder="请输入试卷名称"/></span>--%>
					<%--<span onclick="gradingPapers.searchContent()" class="four">搜索</span>--%>
					<%--<div class="panel-heading">--%>
						<%--<div class="row">--%>
							<%--<div class="col-lg-4">--%>
								<%--<div class="input-group">--%>
									<%--<input id="keyword" type="text" name="urealname" class="form-control" placeholder="请输入关键字">--%>
									<%--<span class="input-group-btn">--%>
										<%--<button onclick="gradingPapers.searchContent()" class="btn btn-default" type="button">搜索</button>--%>
									  <%--</span>--%>
								<%--</div><!-- /input-group -->--%>
							<%--</div><!-- /.col-lg-6 -->--%>
						<%--</div><!-- /.row -->--%>
					<%--</div>--%>
				</div>
				<div>
					<!--<div class="contentTitle" style="">
						<span class="span1">试卷名称</span>
						<span class="span2">试卷状态</span>
						<span class="span3">考试时间</span>
						<span class="span4">考试时长</span>
						<span class="span5">卷面总分</span>
						<span class="span6">及格分数</span>
						<span class="span7">操作</span>
					</div>-->
					<!--<table style="font-size: 14px;width: 1140px; margin: 0 auto;" id="tableContent">

					</table>-->
					<ul id="tableContent">
						<%--<img style="margin: 60px auto 0;display: block" src="${ctxStatic}/hsun/front/usercenter/images/loading.gif" alt="">--%>
						<!--<li class="table_list">
							<div class="table_fr">
								<p>神华集团2016年测试题</p>
								<div class="table_list_gai">
									<a href=""><i></i><span>批改试卷</span></a>
								</div>
								<div class="table_list_infor">
									<i class="begin_time"></i><span>考试时间：2017-4-18</span>
									<i class="over_time"></i><span>公布成绩考试时间：2017-4-18</span>
									<i class="men_num"></i><span>参考人数：100</span>
								</div>
							</div>
						</li>-->
					</ul>
				</div>
				<div class="divPage" id="pagehtml">

				</div>
				<input type="hidden" id="pageNo" value="1" />
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/grading_papers.js${v}"></script>