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
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/swiper-3.4.2.min.css${v}">
	
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/head.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/confirm.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/userCenter/practiceContent.css${v}">

	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>

</head>
<body>
	<div class="body_container">
		<header class="bg1 color1 top_header">
			<i class="icon iconfont icon-jt-left" onclick="window.location.href='examRecord.html';"></i>
			<span class="exam_time flex flex-center">考试记录</span>
		</header>


		<section class="sec_body top_sec1" id="mycontainer">
			<div class="pt1 daily_pra_body">

					
			</div>
		</section>


		<footer class="bg1 top_footer">
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/home.html" data-bg="/"><i class="icon iconfont icon-index"></i><br>首页</a>
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/practice/knowledgeList.html" data-bg="practice"><i class="icon iconfont icon-lianxi"></i><br>练习</a>
			<a class="text_login_btn" data-href="${ctxRoot}/course/showcoulist" data-bg="course"><i class="icon iconfont icon-spzx"></i><br>视频</a>
			<a class="text_login_btn" data-href="${ctxRoot}/page/mobile/userCenter/userCenter.html" data-bg="userCenter"><i class="icon iconfont icon-grzx"></i><br>我的</a>
		</footer>
	</div>

	<section class="question_table flex_table">
		<header class="bg1 color1">
			<i class="icon iconfont icon-jt-left ques_table_hide"></i>
			<span class="model_name">试题统计</span>
		</header>
		<section class="question_table_infor">
			<div class="question_table_infor_cont">
				<div class="table_infor_list flex"><em>试卷名称：</em><span class="exam_name"></span></div>
				
				<div class="table_infor_list"><em>开考时间：</em><span class="exam_begintime"></span></div>
				<div class="table_infor_list"><em>交卷时间：</em><span class="exam_endtime"></span></div>
				<div class="table_infor_list">
					<em>考试成绩：</em><span class="exam_score wid10"></span>
					<em>试卷总分：</em><span class="exam_totalscore"></span>
				</div>
				<div class="table_infor_list">
					<em>考试耗时：</em><span class="exam_costtime wid10"></span>
					<em>试卷时长：</em><span class="exam_totaltime"></span>
				</div>
				
			</div>
		</section>
		<section class="question_table_list flex_main">
			<div class="flex flex-wrap card_container">

			</div>
		</section>
		<section class="table_warn textc">
			<span><i class="bg_success"></i>答对</span>
			<span><i class="bg_danger"></i>答错</span>
			<span><i class="bg_default"></i>未答</span>
			<span><i class="bg_selected"></i>主观题</span>

		</section>
		<footer>
			<div class="flex flex-center bg_warn reset_btn ques_table_hide">退出</div>
		</footer>
	</section>

	<section class="show_table">
		<i class="icon iconfont icon-datiqia"></i>
	</section>

	<!-- 解析模板 -->
	<script id="ques_infor" type="text/template">
		<div class="question_answer">
	    	<div class="show_descript {{bjclass}}">{{bj}}</div>
	    	<div class="show_answer">
	    		<div class="show_list">
	    			<em>此题得分:</em>
	    			<span>{{thisscore}}分</span>
	    		</div>
	    		<div class="my_answer">
	    			<em>我的答案:</em>
	    			<div class="my_answer_content">{{mykey}}</div>
	    		</div>
	    		<div>
	    			<em>参考答案:</em>
	    			<div class="answer_content">{{qkey}}</div>
	    		</div>
	    		<div class="more textl" onclick="moreInfor(this)">更多信息</div>
	    	</div>
	    	<div class="show_infor hide">
	    		<div class="show_list">
	    			<em>题&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型:</em>
	    			<span>{{typeName}}</span>
	    		</div>
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
		<div class="daily_ques" id="pos_{{id}}">
        	<div class="question_cont pl_r15">
			<span class="ques_num" style="float: left;">{{num}}({{qscore}}分)&nbsp;&nbsp;</span>{{qcontent}}
			</div>
			<div class="question_option type_{{qtype}} pl_r15" data-qtype="{{qtype}}">
				{{options}}
			</div>
		    {{infor}}
		</div>
	</script>
	<!-- 选项模板 -->
	<script id="options_model" type="text/template">
		<div class="question_option_item flex selects">
			<label>{{alisa}}、</label><span class="flex">{{text}}</span>
		</div>
	</script>
	<!-- 判断题模板 -->
	<script id="qtype3" type="text/template">
		<div class="daily_ques" id="pos_{{id}}">
        	<div class="question_cont pl_r15">
			<span class="ques_num" style="float: left;">{{num}}({{qscore}}分)&nbsp;&nbsp;</span>{{qcontent}}
			</div>
			<div class="question_option pl_r15" data-qtype="{{qtype}}">
				<div class="question_option_item flex">
					<label>Y、</label><span class="flex">正确</span>
				</div>
				<div class="question_option_item flex">
					<label>N、</label><span class="flex">错误</span>
				</div>
			</div>
		    {{infor}}
		</div>
	</script>
	<!-- 填空题 -->
	<script id="qtype4" type="text/template">
		<div class="daily_ques" id="pos_{{id}}">
        	<div class="question_cont pl_r15">
			<span class="ques_num" style="float: left;">{{num}}({{qscore}}分)&nbsp;&nbsp;</span>{{qcontent}}
			</div>
			
			{{infor}}
		</div>
	</script>
	
	<!-- 简答题和计算题模板 -->
	<script id="qtype5" type="text/template">
		<div class="daily_ques type5" id="pos_{{id}}">
        	<div class="question_cont pl_r15">
			<span class="ques_num" style="float: left;">{{num}}({{qscore}}分)&nbsp;&nbsp;</span>{{qcontent}}
			</div>
			{{infor}}
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
	<script src="${ctxStatic}/hsun/front/mobile/js/userCenter/examContent.js${v}"></script>
</body>
</html>