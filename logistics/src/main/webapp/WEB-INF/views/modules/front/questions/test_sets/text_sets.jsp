<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<title>地理云课堂</title>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/text_sets.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css">

		<style>
			.bo_search{
				padding:0;
				margin-top:13px;
			}
		</style>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="border">
			<div class="sets">
				<div id="title_search">
					<div id="section">
						<span class="colorblue">未发起考卷</span>
						<span>已发起考卷</span>
						<div id="bott" data-index="0"></div>
						<!--<span class="active"><a href="text_sets.html">试卷管理</a></span>-->
						<!--<span class="title"><a href="grading_papers.html">批改试卷</a></span>-->

					</div>
					<div class="bo_search">
						<div>
							<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
							<span class="spansearch"><a href="javascript:;" onclick="textSets.searchLibrary();"><i class="fa fa-search fa-lg"></i></a></span>
						</div>
					</div>
				</div>
				<%--<div class="button">--%>
					<%--&lt;%&ndash;<span><a href="Start_the_test/Select_the_schema.html"><i class="fa fa-plus-circle"></i>&nbsp;&nbsp;创建试卷</a></span>&ndash;%&gt;--%>
				<%--</div>--%>

				<div class="content" id="contents">
					<%--<img id="load_img" style="margin: 140px auto 0;display: block;" src="${ctxStatic}/hsun/front/usercenter/images/loading.gif" alt="">--%>
				</div>

				<div class="divPage" id="pagehtml">

				</div>
				<!--当前页码-->
				<input type="hidden" id="pageNo" value="1" />
				<input type="hidden" id="style" value="">
				<input type="hidden" id="bott_left" value="0">

			</div>
		</div>
		<input type="hidden" id="hidQuestionId">
		<%--转为成套卷组卷窗口--%>
		<script type="text/template" id="hand_test" >
			<form id="form_hand_test">
				<ul>
					<li>
						<%--<span>试卷名称：</span>--%>
						<input type="text" class="txtinput" id="questionName" name="name" value="请输入试卷名称"
							   onfocus="if(value=='请输入试卷名称'){value='';style.color='#333'}"
							   onblur="if(value==''){value='请输入试卷名称';style.color='#888'}"
						/>
					</li>
				</ul>
				<div id="btn_hand_test">
					<a href="javascript:;" id="btn_a"  class="active" onclick="textSets.saveExam()">创建试卷</a>
				</div>
			</form>
		</script>
		<%--选择考试类型--%>
		<%--<style>--%>
			<%--.line_paper_type{--%>
				<%--padding:30px 20px 0;--%>
				<%--font-size:14px;--%>
				<%--color: #333;--%>
			<%--}--%>
			<%--.line_paper_type span{--%>
				<%--padding-left: 20px;--%>
				<%--padding-right:20px;--%>
				<%--cursor: pointer;--%>
				<%--background: url(${ctxStatic}/hsun/front/img/edit_item_random_two/nochecked.png) no-repeat left center;--%>
			<%--}--%>
			<%--.line_paper_type .check{--%>
				<%--background: url(${ctxStatic}/hsun/front/img/edit_item_random_two/checked.png) no-repeat left center;--%>
			<%--}--%>
			<%--.line_paper_type input{--%>
				<%--position: relative;--%>
				<%--top:2px;--%>
			<%--}--%>
		<%--</style>--%>
		<%--<script type="text/template" id="line_exam" >--%>
			<%--<div class="line_paper_dow">--%>
				<%--<div class="line_paper_type">--%>
					<%--<span class="check" data-type="0">线上考试</span>--%>
					<%--<span data-type="1">线下考试</span>--%>
				<%--</div>--%>
				<%--<a id="confire_btn" href="javascript:void(0);">线上考试</a>--%>
			<%--</div>--%>
		<%--</script>--%>

		<div class="confirm_container">
			<div class="confirm">
				<div class="confirm_title">
					信息提示
				</div>
				<div class="confirm_cont">
					<p>您确定要删除此试卷?</p>
					<a class="confirm_del" href="javascript:void(0);">删除</a>
					<a class="confirm_qx" href="javascript:void(0);">取消</a>
				</div>
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/text_sets.js${v}"></script>