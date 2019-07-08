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

	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>
	
</head>
<body>
	<div class="body_container">
		<!-- <div class="shade"></div> -->
		<header class="bg1 color1 top_header">
			<i class="icon iconfont icon-jt-left" onclick="window.location.href='knowledgeList.html';"></i>
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
				<div class="page_list page_answer"><i class="icon iconfont icon-chakan"></i><i>答案</i></div>
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
		<section class="question_table_list flex_main">
			<div class="flex flex-wrap card_container">

			</div>
		</section>
		<section class="table_warn textc">
			<span><i class="bg_success"></i>答对</span>
			<span><i class="bg_danger"></i>答错</span>
			<span><i class=""></i>未答</span>
			<span><i class="now_pos"></i>当前题</span>
			<span><i class="bg_default"></i>主观题</span>
		</section>
		<footer>
			<div class="flex flex-center bg_warn reset_btn" onclick="window.location.reload();">重新开始</div>
			<div class="flex flex-center bg_danger save_btn">结束作答</div>
		</footer>
	</section>

	<!-- 解析模板 -->
	<script id="ques_infor" type="text/template">
		<div class="question_answer hide">
	    	<div class="show_descript">暂无回答</div>
	    	<div class="show_answer">
	    		<div class="my_answer">
	    			<em>我的答案:</em>
	    			<div class="my_answer_content">无</div>
	    		</div>
	    		<div>
	    			<em>参考答案:</em>
	    			<div class="answer_content">{{qkey}}</div>
	    		</div>
	    	</div>
	    	<div class="show_infor">
	    		<div class="show_list">
	    			<em>知&nbsp;&nbsp;识&nbsp;点:&nbsp;</em><span>{{topicName}}</span>
	    		</div>
	    		<div class="show_lever show_list">
	    			<em>试题难度:&nbsp;</em><span>{{qlevel}}</span>
	    		</div>
	    		<div class="show_list">
	    			<em>试题岗位:&nbsp;</em><span>{{postName}}</span>
	    		</div>
	    		
	    		<div class="show_list">
	    			<em>依据标准:&nbsp;</em><span>{{stdNo}}</span>
	    		</div>
	    		<div class="show_analysis show_list">
	    			<em>参考解析:</em>
	    			<div class="show_analysis_cont">
	    				{{qresolve}}
	    			</div>
	    		</div>
	    	</div>
	    </div> 
	</script>
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
			    {{infor}}
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
			    {{infor}}
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
				{{infor}}
			</div>
		</div>
	</script>
	<!-- 填空题选项模板 -->
	<script id="input_model" type="text/template">
		<div class="question_option_item flex">
			<input class="textinput" type="text" name="Q-{{qid}}" placeholder="请填入第{{index}}个空的答案">
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
				{{infor}}
			</div>
		</div>
	</script>
	<!-- 弹出框模板 -->
	<script id="confirm_model" type="text/template">
		<div class="confirm_prictice">
			<h3 class="textc"><i class="icon iconfont icon-xiaolian1"></i><br>您确提交此次练习！</h3>
			<div class="flex">
				<a onclick="confirmSaveQuesFun()">确定提交</a>
				<a onclick="$('.confirm_prictice').remove();">取消提交</a>
			</div>
			<span class="confirm_qx textc" onclick="$('.confirm_prictice').remove();">×</span>
		</div>
	</script>

	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/swiper-3.4.2.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/practice/knowledgePractice.js${v}"></script>
</body>
</html>