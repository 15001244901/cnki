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
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/userCenter/userCenter.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>
</head>
<body>
	<div class="body_container">
		<div class="shade"></div>
		<header class="bg1 color1 flex_center">
			<i class="icon iconfont icon-jt-left" onclick="window.location.href='../home.html';"></i>
			<span>个人中心</span>
		</header>
		<div class="head_size"></div>
		
		<section class="container_body">
			<div class="user_infor flex">
				<div class="user_photo">
					<c:set var="userphoto" value="${ctxStatic}/images/userphoto.jpg"/>
					<c:if test="${not empty fns:getUser().photo}">
						<c:set var="userphoto" value="${fns:getUser().photo}"/>
					</c:if>
					<img src="${userphoto}" alt="">
				</div>
				<div class="user_name flex">
					<h3>${fns:getUser().name}</h3>
					<p>当前积分：403</p>
				</div>
			</div>

			<div class="user_manage_list">
				<div class="manage_item">
					<div class="manage_item_title">
						<span><i class="icon iconfont icon-shezhi"></i>个人设置</span>
						<i class="icon iconfont"></i>
					</div>
					<ul class="hide">
						<li class="manage_item_title" data-url="${ctx}/sys/user/info"><a class="flex flex-rols-between">·&nbsp;&nbsp;个人信息<i class="icon iconfont icon-centerright"></i></a></li>
						<li class="manage_item_title" data-url="${ctx}/sys/user/modifyPwd"><a class="flex flex-rols-between">·&nbsp;&nbsp;安全管理<i class="icon iconfont icon-centerright"></i></a></li>
					</ul>
				</div>
				<div class="manage_item">
					<div class="manage_item_title">
						<span><i class="icon iconfont icon-wodekecheng"></i>我的课程</span>
						<i class="icon iconfont"></i>
					</div>
					<ul class="hide">
						<li class="manage_item_title" data-url="${ctxRoot}/course/myCourses"><a class="flex flex-rols-between" >·&nbsp;&nbsp;在学视频<i class="icon iconfont icon-centerright"></i></a></li>
						<li class="manage_item_title" data-url="${ctxRoot}/course/myFavourites"><a class="flex flex-rols-between" >·&nbsp;&nbsp;课程收藏<i class="icon iconfont icon-centerright"></i></a></li>
					</ul>
				</div>

				<div class="sign_out bg_danger textc bgclick">退出地理云课堂</div>
			</div>
		</section>
		
		<div class="foot_size pos"></div>
		<footer class="bg1">
			<a class="text_login_btn" data-href="${ctxRoot}/course/showcoulist" data-bg="video"><i class="icon iconfont icon-spzx"></i><br>课程</a>
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/userCenter/userCenter.html" data-bg="userCenter"><i class="icon iconfont icon-grzx"></i><br>我的</a>
		</footer>
	</div>

	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/swiper-3.4.2.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/userCenter/userCenter.js${v}"></script>
</body>
</html>