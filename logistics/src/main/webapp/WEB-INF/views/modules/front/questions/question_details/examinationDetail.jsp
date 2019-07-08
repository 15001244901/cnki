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

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/Grading_papers_detail.css${v}" />
	<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/Grading_papers_detail_bo.css${v}" />
	<style type="text/css">
		* {
			moz-user-select: -moz-none;
			-moz-user-select: none;
			-o-user-select: none;
			-khtml-user-select: none;
			-webkit-user-select: none;
			-ms-user-select: none;
			user-select: none;
		}
		.item1_num span {
			display: inline-block;
			padding: 0px;
			width:22px;
			height: 22px;
			line-height: 22px;
			text-align: center;
			cursor: pointer;
			margin-right: 6px;
			margin-left: 6px;
			font-size:12px;
			border: 1px solid #DFDFDF;
		}
		#div .div2 .three1{
			margin-left:35px;
		}
		.ess_infor ul div p span {
			width: 150px;
			font-weight: 100;
		}
	</style>

</head>

<body>
<div id="divheader"></div>
<div id="div">

	<div>
		<form>
			<div class="left">
				<div class="ess_infor">
					<p class="ess_infor_title"><span class="fl">基本信息</span> <pan class="fr ess_up">收起</pan></p>
					<ul>
						<li>
							<b>考生 :</b><span id="spanName"> </span>
							<b>编号 :</b><span id="spanNo"> </span>
						</li>
						<div>
							<b>总分 :</b><span id="spanTotalScpre"> </span>
							<b>得分 :</b><span class="p_width0" id="spanCheckNums"> </span>
							<b>规定时长 :</b><span class="p_width1" id="spanDuration"> </span>
							<b>耗时 :</b><span class="p_width0" id="spanTimeCost"> </span>
							<p>开考时间 : <span id="spanStartTime"></span></p>
							<p>交卷时间 : <span id="spanSaveTime"></span></p>
						</div>
						<%--<div>--%>
						<%--<p id="userscore">得分：<span></span></p>--%>
						<%--<p id="startdate">答题时间：<span></span></p>--%>
						<%--<p id="testdate">练习日期：<span></span></p>--%>
						<%--</div>--%>
					</ul>
				</div>
				<div class="item_infor">
					<p class="ess_infor_title"><span class="fl">试题统计</span> <pan class="fr ess_up">收起</pan></p>
					<ul class="" id="questionCard1">
						<li id="item1_title">
							<div class="item1_title">
								<b class="fl">一、单选题</b><span class="fr">得10分</span>
							</div>
							<div class="item1_num item_num">
								<span class="item_active">1</span><span>2</span><span>3</span>
							</div>
						</li>
						<li id="item2_title">
							<div class="item1_title">
								<b class="fl">二、阅读理解</b><span class="fr">得10分</span>
							</div>
							<div class="item1_num item_num">
								<span class="item_active">4</span><span>5</span><span>6</span>
							</div>
						</li>

					</ul>
				</div>
				<!--<div class="one4">

                    <div class="two2" id="questionCard">

                    </div>
                </div>-->
				<!--<div style="margin-top: 10px;text-align: center;">
                    <input type="button" value="返回" class="cancel" onclick="javascript:window.history.go(-1)" />
                </div>-->
			</div>
			<div id="infor_list">
				<div id="divName"></div>
			</div>
			<div class="right" id="divContent">

				<div class="div2">

				</div>
			</div>
			<div id="left_hide">展开信息</div>
			<div id="divsetter" style="z-index: 999;"></div>
			<input type="hidden" id="hidID" name="pid" />
		</form>
	</div>

</div>
<div style="clear: both;"></div>
<div id="next_adr">
	<%--<a class="save_pos" href="javascript:void(0);" onclick="javascript:window.history.go(-1)" >返回</a>--%>
</div>
</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/question_details/examinationDetail.js${v}"></script>