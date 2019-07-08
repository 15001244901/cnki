<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<meta content="yes" name="apple-mobile-web-app-capable"> 
	<meta content="yes" name="apple-touch-fullscreen"> 
	<meta content="telephone=no,email=no" name="format-detection">
	<!-- UC强制全屏 -->
	<meta name="full-screen" content="yes">
	<!-- QQ强制全屏 -->
	<meta name="x5-fullscreen" content="true">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/font/iconfont.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/animate.min.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/flexible.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/header.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/userCenter/practiceRecord.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>

</head>
<body>
	<div class="body_container">
		<header class="bg1 color1 flex_center ">
			<i class="icon iconfont icon-jt-left" onclick="window.history.go(-1);"></i>
			<span>考试记录</span>
		</header>
		<div class="head_size"></div>
		
		<section class="container_body">
			<div class="record_list">
				<ul>
				</ul>
			</div>
		</section>
		
		<div class="page_size pos"></div>
		<div class="shade"></div>
		<section class="page">
			<div class="page_html">
				<div class="page_btnl bgclick">上一页</div>
				<div class="page_btnnum bgclick"><i class="now_page_num">1</i>/<i class="total_page_num"></i><i></i></div>
				<div class="page_btnr bgclick">下一页</div>
			</div>
			<div class="page_num">
				<div>
					<ul class="page_num_list">
						
					</ul>
				</div>
			</div>
		</section>
		<div class="foot_size pos"></div>
		<footer class="bg1">
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/home.html" data-bg="/"><i class="icon iconfont icon-index"></i><br>首页</a>
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/practice/knowledgeList.html" data-bg="practice"><i class="icon iconfont icon-lianxi"></i><br>练习</a>
			<a class="text_login_btn" data-href="${ctxRoot}/course/showcoulist" data-bg="course"><i class="icon iconfont icon-spzx"></i><br>视频</a>
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/userCenter/userCenter.html" data-bg="userCenter"><i class="icon iconfont icon-grzx"></i><br>我的</a>
		</footer>
	</div>

	<!-- 列表模板 -->
	<script id="list_model" type="text/template">
		<li class="flex" id="item_{{id}}" >
			<div class="flex exam_infor" data-id="{{id}}" data-bj="{{bj}}" data-pid="{{pid}}">
				<!-- <div class="exam_logo">
					<i class="icon iconfont icon-lianxi"></i>
				</div> -->
				<div>
					<div class="exam_title">{{papername}}</div>
					<div class="exam_data">考试成绩：<em class="{{classname}}">{{score}}</em></div>
					<div class="exam_data">{{papertype}}</div>
					<div class="exam_data">考试日期：{{starttime}}</div>
					<div class="exam_data">{{opentime}}</div>
				</div>
			</div>
		</li>
	</script>

	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/userCenter/examRecord.js${v}"></script>
</body>
</html>