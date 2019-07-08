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
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/swiper-3.4.2.min.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/animate.min.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/flexible.css${v}">

	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/header.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/practice/knowledgeList.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/confirm.css${v}">

	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>
</head>
<body>
	<div class="shade"></div>
	<header class="bg1 color1 flex_center">
		<i class="icon iconfont icon-jt-left" onclick="window.location.href='../home.html';"></i>
		<span>知识点练习</span>
	</header>
	<div class="head_size"></div>
	
	<section class="container_body">
		<ul class="konw_container">

		</ul>
	</section>
	
	<div class="foot_size pos"></div>
	<footer class="bg1">
		<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/home.html" data-bg="/"><i class="icon iconfont icon-index"></i><br>首页</a>
		<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/practice/knowledgeList.html" data-bg="practice"><i class="icon iconfont icon-lianxi"></i><br>练习</a>
		<a class="text_login_btn" data-href="${ctxRoot}/course/showcoulist" data-bg="course"><i class="icon iconfont icon-spzx"></i><br>视频</a>
		<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/userCenter/userCenter.html" data-bg="userCenter"><i class="icon iconfont icon-grzx"></i><br>我的</a>
	</footer>

	<!-- 列表模板 -->
	<script id="knowledge_model" type="text/template">
		<li>
			<div class="know_title " onclick="toggerFun(this)">
				<div class="know_name">
					<span class=""><i class="icon iconfont icon-{{font}}"></i>{{topic}} {{topicname}}</span>
				</div>
				<div class="know_btn" data-topic='{{topic}}'>
					<span><b class="color3">已做{{unum}}</b>，<b class="color4">共{{qnum}}题</b></span>
					<span class="take_ques bgclick" onclick="goTestFun(event,this,'{{id}}','{{unum}}','{{qnum}}','{{topicname}}')"><i class="icon iconfont icon-biji"></i> 做题</span>
				</div>
			</div>
			<ol>
				{{children}}
			</ol>
		</li>
	</script>
	<!-- 弹出框模板 -->
	<script id="confirm_model" type="text/template">
		<div class="confirm_prictice animated">
			<h3 class="textc"><i class="icon iconfont icon-xiaolian1"></i><br>每次固定只抽取20道题，抽完为止！</h3>
			<h4 class="textc">（选择重新做题，您之前已做题的记录将被删除）</h4>
			<div class="flex">
				<a href="{{url}}" onclick="$('.confirm_prictice').remove()">开始做题</a>
				<a class="{{classbj}}" href="{{reseturl}}" onclick="$('.confirm_prictice').remove()">重新做题</a>
			</div>
			<span class="confirm_qx textc" onclick="confirmQx(this)">×</span>
		</div>
	</script>

	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/swiper-3.4.2.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/practice/knowledgeList.js${v}"></script>

</body>
</html>