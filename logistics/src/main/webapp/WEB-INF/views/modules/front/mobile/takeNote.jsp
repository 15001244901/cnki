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

	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/font/iconfont.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/swiper-3.4.2.min.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/animate.min.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/flexible.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/header.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/question.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/findError.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/takeNote.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>
</head>
<body>
	<div class="body_container">
		<header class="bg1 color1 flex_center body_head">
			<i class="icon iconfont icon-jt-left" onclick="javascript :history.back(-1);"></i>
			<span>试题笔记</span>
		</header>
		<div class="head_size"></div>

		<!-- slide主体 -->
		<section class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide note_form">
					<!-- 试题 -->
					<section class="take_notes">
						<div class="que_cont">
							<ul>
								
							</ul>
						</div>
					</section>
					<!-- 录入内容 -->
					<section class="error">
						<div class="error_title">
							请在下方输入笔记内容：
						</div>
						<div class="error_cont">
							<textarea name="text" id="error_cont" placeholder="请输入内容"></textarea>
						</div>
						<div class="test_code">
							<input type="text" class="code" placeholder="请输验证码">
							<img class="validateCode" src="${ctxRoot}/servlet/validateCodeServlet" alt="">
							<a onclick="$('.validateCode').attr('src','${ctxRoot}/servlet/validateCodeServlet?'+new Date().getTime());" class="icon iconfont icon-fresh"></a>
						</div>
						<button class="error_save take_notes_save">提交</button>
					</section>
				</div>
				<div class="swiper-slide notes_list">
					<section>
						<ul class="notes_list_container">

							
						</ul>
						<div class="more"><img src="${ctxStatic}/hsun/front/mobile/images/loading.gif" alt="" /></div>
						<div class="last"><hr><span>已经到我的底线了！</span></div>
					</section>
				</div>
			</div>
		</section>

		<div class="nav_size border1"></div>
		<nav class="nav_slide border1">
			<a class="active" href="javascript:void(0);"><i class="icon iconfont icon-lianxi"></i>做笔记</a>
			<a href="javascript:void(0);"><i class="icon iconfont icon-chakan"></i>笔记本</a>
		</nav>
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
				<textarea name="text" placeholder="请输入内容"></textarea>
			</div>
			<div class="test_code">
				<input type="text" class="code" placeholder="请输验证码">
				<img class="validateCode" src="{{urlpath}}/servlet/validateCodeServlet" alt="">
				<a onclick="$('.validateCode').attr('src','{{urlpath}}/servlet/validateCodeServlet?'+new Date().getTime());" class="icon iconfont icon-fresh"></a>
			</div>
			<button class="error_save" onclick="saveError(this,'{{id}}')">提交</button>
		</section>
	</script>
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
				<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
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
				<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
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
				
				<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
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
				<span onclick="findError(this,'{{id}}');"><i class="icon iconfont icon-jiucuo"></i>纠错</span>
			</div>
		</li>
	</script>
	<!--笔记记录模板-->
	<script type="text/template" id="note_list">
		<li>
			<div class="notes_list_name">
				<span><img src="{{userphoto}}" alt=""></span><span class="color2">{{name}}</span><span>{{createDate}}</span>
			</div>
			<div class="notes_list_cont">
				{{content}}
			</div>
		</li>
	</script>

	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicFun.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/swiper-3.4.2.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/takeNote.js${v}"></script>
</body>
</html>