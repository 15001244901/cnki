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
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/index.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/question.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/findError.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>

</head>
<body>
<div class="body_container">
	<div class="shade"></div>
	<header class="bg1 color1 flex_center">
		<i class="icon iconfont icon-jt-left" onclick="window.location.href='userCenter.html';"></i>
		<span>试题收藏</span>
	</header>
	<div class="head_size pos"></div>

	<section class="pt1">
		<div class="que_select">
			<ul>
				<li class="que_select_item knowledge_point bgclick" data-name="topictValue"><span>知识点</span><i class="icon iconfont icon-jt-down"></i></li>
				<li class="que_select_item ques_type bgclick" data-type="dic_exam_questiontype" data-name="questionType"><span>题型</span><i class="icon iconfont icon-jt-down"></i></li>
				<li class="que_select_item ques_level bgclick" data-type="dic_exam_questionlevel" data-name="levelType"><span>难度</span><i class="icon iconfont icon-jt-down"></i></li>
				<li class="que_select_item ques_post bgclick" data-type="dic_exam_questionpost" data-name="postType"><span>岗位</span><i class="icon iconfont icon-jt-down"></i></li>
			</ul>
			<div class="que_select_cont">

			</div>
		</div>
		<div class="clear"></div>
		<div class="que_cont">
			<ul>

			</ul>

		</div>
	</section>

	<div class="page_size pos"></div>
	<section class="page">
		<div class="page_html">
			<div class="page_btnl bgclick">上一页</div>
			<div class="page_btnnum bgclick"><i class="now_page_num">1</i>/<i class="total_page_num">200</i><i></i></div>
			<div class="page_btnr bgclick">下一页</div>
		</div>
		<div class="page_num">
			<div class="page_num_title">共 <i class="total_page_num">200</i> 页，当前为第 <i class="now_page_num">1</i> 页</div>
			<div>
				<span>跳转到:</span><input type="number" name="pagenum" value="">页<button class="page_num_btn bgclick">跳转</button>
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

<!-- 纠错 -->
<section class="error_container"></section>
<!-- 纠错模板 -->
<script type="text/template" id="ques_error">
	<header class="bg1 color1 flex_center">
		<i class="icon iconfont icon-jt-left" onclick="hideError()"></i>
		<span>试题纠错</span>
	</header>
	<section class="error">
		<div class="error_title">
			一直在完善。从未停歇过，但是有些题目可能仍然存在瑕疵，为发昂变我们排查错误，请您详细描述本体错误！
		</div>
		<div class="error_cont">
			<textarea name="text" id="error_cont" placeholder="请输入内容"></textarea>
		</div>
		<div class="test_code">
			<input type="text" class="code" placeholder="请输验证码">
			<img class="validateCode" src="{{urlpath}}/servlet/validateCodeServlet" alt="">
			<a onclick="$('.validateCode').attr('src','{{urlpath}}/servlet/validateCodeServlet?'+new Date().getTime());" class="icon iconfont icon-fresh"></a>
		</div>
		<button class="error_save" onclick="saveError(this,'{{id}}')">提交</button>
	</section>
</script>

<!--题型-->
<input type="hidden" id="questionType"/>
<!--难度-->
<input type="hidden" id="levelType"/>
<!--岗位-->
<input type="hidden" id="postType"/>
<!--知识点-->
<input type="hidden" id="topictValue">
<!--当前页列表-->
<input type="hidden" id="pageNo" value="1"/>

<!-- 试题模板 -->
<script type="text/template" id="ques_type_1">
	<li>
		<div class="question_title flex_center">
			<span>题型：{{typeName}}</span>
			<span>知识点：{{topicName}}</span>
		</div>
		<div class="question_cont">
			{{qcontent}}
		</div>
		<div class="question_option">
			{{sels}}
		</div>
		<div class="question_answer">
			<div class="mb10">
				<div class="answer_item1 mb10">【答案】</div>
				<div class="answer_item9 pl30">
					{{qkey}}
				</div>
			</div>
			<div class="mb10">
				<div class="answer_item1 mb10">【解析】</div>
				<div class="answer_item9 pl30">
					{{qresolve}}
				</div>
			</div>
		</div>
		<div class="question_btn">
			<span onclick="seeAnswer(this);"><i class="icon iconfont icon-chakan"></i>查看答案</span>
			<span onclick="collectQue(this,'{{id}}','{{iscollected}}');"><i class="icon iconfont icon-unlove"></i>取消收藏</span>
			<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
			<span onclick="takeNode(this,'{{id}}');"><i class="icon iconfont icon-biji"></i>笔记</span>
		</div>
	</li>
</script>
<script type="text/template" id="ques_type_3">
	<li>
		<div class="question_title flex_center">
			<span>题型：{{typeName}}</span>
			<span>知识点：{{topicName}}</span>
		</div>
		<div class="question_cont">
			{{qcontent}}
		</div>
		<div class="question_option">
			<p>Y 、 正确</p>
			<p>N 、 错误</p>
		</div>
		<div class="question_answer">
			<div class="mb10">
				<div class="answer_item1 mb10">【答案】</div>
				<div class="answer_item9 pl30">
					{{qkey}}
				</div>
			</div>
			<div class="mb10">
				<div class="answer_item1 mb10">【解析】</div>
				<div class="answer_item9 pl30">
					{{qresolve}}
				</div>
			</div>
		</div>
		<div class="question_btn">
			<span onclick="seeAnswer(this);"><i class="icon iconfont icon-chakan"></i>查看答案</span>
			<span onclick="collectQue(this,'{{id}}','{{iscollected}}');"><i class="icon iconfont icon-unlove"></i>取消收藏</span>
			<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
			<span onclick="takeNode(this,'{{id}}');"><i class="icon iconfont icon-biji"></i>笔记</span>
		</div>
	</li>
</script>
<script type="text/template" id="ques_type_4">
	<li>
		<div class="question_title flex_center">
			<span>题型：{{typeName}}</span>
			<span>知识点：{{topicName}}</span>
		</div>
		<div class="question_cont">
			{{qcontent}}
		</div>
		<div class="question_answer">
			<div class="mb10">
				<div class="answer_item1 mb10">【答案】</div>
				<div class="answer_item9 pl30">
					{{qkey}}
				</div>
			</div>
			<div class="mb10">
				<div class="answer_item1 mb10">【解析】</div>
				<div class="answer_item9 pl30">
					{{qresolve}}
				</div>
			</div>
		</div>
		<div class="question_btn">
			<span onclick="seeAnswer(this);"><i class="icon iconfont icon-chakan"></i>查看答案</span>
			<span onclick="collectQue(this,'{{id}}','{{iscollected}}');"><i class="icon iconfont icon-unlove"></i>取消收藏</span>
			<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
			<span onclick="takeNode(this,'{{id}}');"><i class="icon iconfont icon-biji"></i>笔记</span>
		</div>
	</li>
</script>
<script type="text/template" id="ques_type_5">
	<li>
		<div class="question_title flex_center">
			<span>题型：{{typeName}}</span>
			<span>知识点：{{topicName}}</span>
		</div>
		<div class="question_cont">
			{{qcontent}}
		</div>
		<div class="question_answer">
			<div class="mb10">
				<div class="answer_item1 mb10">【答案】</div>
				<div class="answer_item9 pl30">
					{{qkey}}
				</div>
			</div>
			<div class="mb10">
				<div class="answer_item1 mb10">【解析】</div>
				<div class="answer_item9 pl30">
					{{qresolve}}
				</div>
			</div>
		</div>
		<div class="question_btn">
			<span onclick="seeAnswer(this);"><i class="icon iconfont icon-chakan"></i>查看答案</span>
			<span onclick="collectQue(this,'{{id}}','{{iscollected}}');"><i class="icon iconfont icon-unlove"></i>取消收藏</span>
			<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
			<span onclick="takeNode(this,'{{id}}');"><i class="icon iconfont icon-biji"></i>笔记</span>
		</div>
	</li>
</script>
<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
<script src="${ctxStatic}/hsun/front/mobile/js/userCenter/quesCorrection.js${v}"></script>
</body>
</html>