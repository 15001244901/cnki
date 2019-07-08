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
	
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/head.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/confirm.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/dailyPractice.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/userCenter/practiceContent.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>
</head>
<body>
	<div class="body_container">
		<header class="bg1 color1 top_header">
			<i class="icon iconfont icon-jt-left" onclick="window.location.href='examList.html';"></i>
			<span class="exam_time flex flex-center"><em class="hour">00</em>:<em class="minute">00</em>:<em class="second">00</em></span>
		</header>
		<section class="daily_pra_title flex pl_r15">
			<span>题型：<em id="ques_type_name"></em></span>
			<span><b id="pagesize">1</b> / <i id="totalsize">20</i></span>
		</section>

		<section class="sec_body" id="mycontainer">
			<form id="practice_form">
				<div class="pt1 daily_pra_body swiper-container">
					<div class="swiper-wrapper">
						

					</div>
				</div>
			</form>
		</section>


		<section class="page">
			<div class="page_html">
				<div class="page_list page_btnl color_default"><i class="icon iconfont icon-practive-left"></i></div>
				<div class="page_list page_table"><i class="icon iconfont icon-datiqia"></i><i>答题卡</i></div>
				<div class="page_list page_answer"><i class="icon iconfont icon-zanting"></i><i>暂停</i></div>
				<div class="page_list page_btnr"><i class="icon iconfont icon-practive-right"></i></div>
			</div>
		</section>
	</div>
	<!-- 答题卡 -->
	<section class="question_table flex_table">
		<header class="bg1 color1">
			<i class="icon iconfont icon-jt-left ques_table_hide"></i>
			<span class="model_name">答题卡</span>
		</header>
		<section class="question_table_infor">
			<div class="question_table_infor_cont">
				<div class="table_infor_list flex"><em>试卷名称：</em><span class="exam_name"></span></div>
				
				<div class="table_infor_list"><em>开考时间：</em><span class="exam_begintime"></span></div>
				<div class="table_infor_list"><em>交卷时间：</em><span class="exam_endtime"></span></div>
				<div class="table_infor_list">
					<em>试卷总分：</em><span class="exam_totalscore wid10"></span>
					<em>试卷时长：</em><span class="exam_totaltime"></span>
				</div>
				
			</div>
		</section>
		<section class="question_table_list flex_main">
			<div class="flex flex-wrap card_container">

			</div>
		</section>
		<section class="table_warn textc">
			<span><i class="bg_selected"></i>已答</span>
			<span><i class=""></i>未答</span>
			<span><i class="now_pos"></i>当前题</span>
			<!-- <span><i class="bg_default"></i>主观题</span> -->
		</section>
		<footer>
			<div class="flex flex-center bg_warn ques_table_hide">退出题卡</div>
			<div class="flex flex-center bg_danger save_btn">结束作答</div>
		</footer>
	</section>

	
	<!-- 选择题模板 -->
	<script id="qtype1" type="text/template">
		<div class="swiper-slide" data-qtype="{{qtype}}">
			<div class="daily_ques">
	        	<div class="question_cont pl_r15">
				{{qcontent}}
				</div>
				<div class="question_option type_{{qtype}} pl_r15" data-qtype="{{qtype}}">
					{{options}}
				</div>
			</div>
		</div>
	</script>
	<!-- 选项模板 -->
	<script id="options_model" type="text/template">
		<div class="question_option_item flex selects">
			<label onclick="selectQuesFun(this,'{{qid}}')" class="bg_default flex">{{alisa}}<input class="hide selinput" type="{{inptype}}" name="Q-{{qid}}" value="{{alisa}}"></label><span class="flex">{{text}}</span>
		</div>
	</script>
	<!-- 判断题模板 -->
	<script id="qtype3" type="text/template">
		<div class="swiper-slide" data-qtype="{{qtype}}">
			<div class="daily_ques">
	        	<div class="question_cont pl_r15">
				{{qcontent}}
				</div>
				<div class="question_option pl_r15" data-qtype="{{qtype}}">
					<div class="question_option_item flex">
						<label onclick="selectQuesFun(this,'{{id}}')" class="bg_default flex">Y<input class="hide selinput" type="radio" name="Q-{{id}}" value="Y"></label><span class="flex">正确</span>
					</div>
					<div class="question_option_item flex">
						<label onclick="selectQuesFun(this,'{{id}}')" class="bg_default flex">N<input class="hide selinput" type="radio" name="Q-{{id}}" value="N"></label><span class="flex">错误</span>
					</div>
				</div>
			</div>
			
		</div>
	</script>
	<!-- 填空题 -->
	<script id="qtype4" type="text/template">
		<div class="swiper-slide" data-qtype="{{qtype}}">
			<div class="daily_ques">
	        	<div class="question_cont pl_r15">
				{{qcontent}}
				</div>
				<div class="question_option  pl_r15">
					{{input}}
				</div>
			</div>
		</div>
	</script>

	<!-- 简答题和计算题模板 -->
	<script id="qtype5" type="text/template">
		<div class="swiper-slide" data-qtype="{{qtype}}">
			<div class="daily_ques type5">
	        	<div class="question_cont pl_r15">
				{{qcontent}}
				</div>
				<div class="question_option  pl_r15">
					<textarea name="Q-{{id}}" id="" onchange="shortAnswer(this,'{{id}}')"></textarea>
				</div>
			</div>
		</div>
	</script>
	<!-- 弹出框模板 -->
	<script id="confirm_model" type="text/template">
		<div class="confirm_shade">
			<div class="confirm_prictice">
				<h3 class="textc"><i class="icon iconfont icon-xiaolian1"></i><br>您确提交此次练习！</h3>
				<div class="flex">
					<a onclick="confirmSaveQuesFun()">确定提交</a>
					<a onclick="$('.confirm_shade').remove();">取消提交</a>
				</div>
				<span class="confirm_qx textc" onclick="$('.confirm_shade').remove();">×</span>
			</div>
		</div>
	</script>
	<script id="pause_model" type="text/template">
		<div class="confirm_shade">
			<div class="confirm_prictice">
				<h3 class="textc"><i class="icon iconfont icon-xiaolian1"></i><br>休息一会就得了！</h3>
				<div class="flex">
					<a onclick="goOn()">继续考试</a>
				</div>
			</div>
		</div>
	</script>

	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/swiper-3.4.2.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/exam/examPage.js${v}"></script>
</body>
</html>