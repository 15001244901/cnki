<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>批改试卷</title>
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.min.css${v}" >

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

	<script src="${ctxStatic}/jquery/jquery-1.9.1.js${v}" type="text/javascript" charset="utf-8"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

	<!--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />-->
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}">
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

	<script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/Grading_papers_two.css${v}" />

</head>
<body>
	<div id="divheader"></div>
	<div id="exam_cont">
		<div id="exam_name"></div>
		<div id="exam_infor">
			<div id="startime">开始时间：<b>2017-06-16 09:39:13</b></div>
			<div id="endtime">结束时间：<b>2017-06-16 09:39:13</b></div>
			<div id="during">考试时间：<b>100分钟</b></div>
			<div id="total">卷面总分：<b>100分（及格分数60分）</b></div>
		</div>
		<div id="exam_list">
			<div class="panel panel-default">
			  <!-- Default panel contents -->
				<div class="panel-heading">
				  	<div class="row">
					  <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
					    <div class="input-group">
					      <input id="uname" type="text" name="urealname" class="form-control" placeholder="请输入关键字">
					      <span class="input-group-btn">
					        <button id="reseach" class="btn btn-default" type="button">搜索</button>
					      </span>
					    </div><!-- /input-group -->
					  </div><!-- /.col-lg-6 -->
					  <div class="col-lg-8">
					    <!-- 批改进度 -->
						<%--<table id="progress" width="230" border="0" cellpadding="0" cellspacing="0">--%>
							<%--<tr>--%>
								<%--<td>批改进度 : </td>--%>
								<%--<td>--%>
									<%--<div style="width:100px; height:15px; background:#ddd; font-size:1px">--%>
										<%--<div id="percent" style="float:left; background:#0f0; width:20px; font-size:1px; height:15px"></div>--%>
									<%--</div>--%>
								<%--</td>--%>
								<%--<td id="percentage">100%</td>--%>
							<%--</tr>--%>
						<%--</table>--%>
						  <div class="progress" style="">
							  <div id="percent" class="progress-bar progress-bar-blue progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100">
								  <span  id="percentage">0% </span>
							  </div>
						  </div>
						  <span class="progress_title" >批改进度  </span>

					  </div><!-- /.col-lg-6 -->
					</div><!-- /.row -->
				</div>

			  <!-- Table -->
			  <table id="usersTable" class="table table-hover">
			  	<thead>
		          <tr>
		            <th>用户名</th>
		            <th>部门</th>
		            <th>考试时间</th>
		            <th>耗时</th>
		            <th>批改状态</th>
		            <th>得分</th>
		            <th>来源</th>
		            <th>操作</th>
		          </tr>
		        </thead>
		        <tbody>

		        </tbody>
				<tfoot>

				</tfoot>
			  </table>
			</div>

		</div>
		<div class="goback">
			<a id="back" href="../grading_papers.html">返回上一页面</a>
		</div>
	</div>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/Test_report/Grading_papers_two.js${v}"></script>
</body>
</html>