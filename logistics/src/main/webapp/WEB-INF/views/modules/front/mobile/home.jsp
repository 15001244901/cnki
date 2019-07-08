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
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/flexible.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/head.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/home.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>

</head>
<body>
	<div class="body_container">
		<header class="bg1 color1 top_header">
			<i class="icon iconfont icon-jinru" style="font-size: 0.6rem;" onclick="window.location.href='http://www.fyketang.com'"></i>
			<span>地理云课堂</span>
		</header>
		
		<section class="sec_body top_sec1" id="mycontainer">
			<div class="banner">
				<img src="${ctxStatic}/hsun/front/mobile/images/banner.png" alt="">
			</div>
		
			<div class="model_name">
				<div class="model_title "><span class="bwid">学习工具</span></div>
				
				<div class="model_name_list" data-href="${ctxRoot}/page/mobile/quesCenter.html" <shiro:hasPermission name="exam:question:view"> data-power="1" </shiro:hasPermission>>
					<i class="icon iconfont icon-mingxiaoshiti"></i>
					<p>题库中心</p>
				</div>
				<div class="model_name_list" data-href="${ctxRoot}/page/mobile/practice/knowledgeList.html" data-power="2">
					<i class="icon iconfont icon-lianxijilu"></i>
					<p>模拟练习</p>
				</div>
				<div class="model_name_list" data-href="${ctxRoot}/page/mobile/practice/dailyPractice.html" data-power="2">
					<i class="icon iconfont icon-meiriyilian"></i>
					<p>每日一练</p>
				</div>
				<div class="model_name_list" data-href="${ctxRoot}/page/mobile/exam/examList.html" data-power="2">
					<i class="icon iconfont icon-exam"></i>
					<p>在线考试</p>
				</div>
				<div class="model_name_list" data-href="${ctxRoot}/page/mobile/userCenter/examRecord.html" data-power="2">
					<i class="icon iconfont icon-guoqiweiwanjieshijian"></i>
					<p>考试记录</p>
				</div>
				<div class="model_name_list" data-href="${ctxRoot}/course/showcoulist" data-power="2">
					<i class="icon iconfont icon-spzx"></i>
					<p>视频课程</p>
				</div>
				<div class="model_name_list" data-href="${ctxRoot}/qa/questions/list" data-power="2">
					<i class="icon iconfont icon-iconfontwenda"></i>
					<p>学习问答</p>
				</div>
				<div class="model_name_list" data-href="${ctxRoot}/page/mobile/userCenter/userCenter.html" data-power="2">
					<i class="icon iconfont icon-gerenzhongxin"></i>
					<p>个人中心</p>
				</div>
				<%--<div class="model_name_list" data-href="${ctxRoot}/page/mobile/baike/baike.html">--%>
					<%--<i class="icon iconfont icon-zhishi"></i>--%>
					<%--<p>知识百科</p>--%>
				<%--</div>--%>

			</div>

			<div class="model_name">
				<div class="model_title "><span class="bwid">考试提醒</span></div>
				<ul class="last_exam">
					<!-- <li class="no_exam">
						<i class="icon iconfont icon-zanwu"></i>
						<p>暂无待考试卷</p>
					</li> -->
				</ul>
			</div>
		</section>
		
		<footer class="bg1 top_footer">
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/home.html" data-bg="/"><i class="icon iconfont icon-index"></i><br>首页</a>
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/practice/knowledgeList.html" data-bg="practice"><i class="icon iconfont icon-lianxi"></i><br>练习</a>
			<a class="text_login_btn" data-href="${ctxRoot}/course/showcoulist" data-bg="course"><i class="icon iconfont icon-spzx"></i><br>视频</a>
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/userCenter/userCenter.html" data-bg="userCenter"><i class="icon iconfont icon-grzx"></i><br>我的</a>
		</footer>
	</div>


	<!-- 待考试卷模板 -->
	<script id="no_last_exam" type="text/template">
		<li class="no_exam">
			<i class="icon iconfont icon-zanwu"></i>
			<p>暂无待考试卷</p>
		</li>
	</script>
	<!-- 暂无大考试卷模板 -->
	<script id="last_exam" type="text/template">
		<li class="bwid" data-bj="{{bj}}" data-id="{{id}}">
			<div>
				<h3>试卷：{{name}}</h3>
				<div class="flex">
					<div>
						<i class="icon iconfont icon-shalou1"></i>
					</div>
					<div class="last_exam_time">
						<p>考试时间：{{starttime}}</p>
						<p>结束时间：{{endtime}}</p>
					</div>
				</div>
				
			</div>
		</li>
	</script>
	
	
	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/home.js${v}"></script>
</body>
</html>