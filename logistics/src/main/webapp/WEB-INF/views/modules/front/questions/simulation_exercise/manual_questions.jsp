<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

<head>
	<title>地理云课堂</title>
	<meta charset="UTF-8">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Expires" content="0">

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

	<%--<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/In_the_test.css${v}" />--%>
	<link href="${ctxStatic}/hsun/front/css/questions/simulation_exercise/manual_questions_toggle.css${v}" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>--%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

	<%--编辑器--%>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/ckeditor/css/question-answer.css${v}" />
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
		/*编辑器隐藏工具栏*/
		.cke_chrome .cke_inner{
			display: none;
		}
	</style>

</head>

<body>
<div id="divheader"></div>
<div id="div">
	<div>
		<div class="twos"></div>
	</div>
	<div>
		<form>
			<div class="right" id="divContent">
				<%--<div class="one" id="divName"></div>--%>
				<div class="pos_name">
					<i></i>模拟练习&nbsp;&nbsp;&nbsp;<em>></em>&nbsp;&nbsp;&nbsp;<span></span>
				</div>
				<div class="one1">
					<div class="progress_bar">
						<p></p>
					</div>
					<div class="progress_num">
						<em>已完成0题</em> / 共<i>20</i>题
					</div>
				</div>
				<div id="model_exam">

				</div>
                <%--<div class="paper_key">--%>
                    <%--<div class="paper_key_title">--%>
                        <%--<span class="paper_key_confirm"><i></i>确定</span>--%>
                        <%--<span class="paper_key_down">--%>
                            <%--<i></i><span>展开解析</span>--%>
                        <%--</span>--%>
                    <%--</div>--%>
                    <%--<div class="paper_key_cont">--%>
                        <%--<ul>--%>
                            <%--<li class="key_cont_key">--%>
                                <%--<span><i></i>参考答案 :</span>--%>
                                <%--<p>--%>
                                    <%--该教师没有树立正确的教师观，需要我们引以为戒。--%>
                                <%--</p>--%>
                            <%--</li>--%>
                            <%--<li class="key_cont_lever">--%>
                                <%--<span><i></i>试题难度 :</span>--%>
                                <%--<p>--%>
                                   <%--初级--%>
                                <%--</p>--%>
                            <%--</li>--%>
                            <%--<li class="key_cont_analysis">--%>
                                <%--<span><i></i>参考解析 :</span>--%>
                                <%--<p>--%>
                                    <%--暂无--%>
                                <%--</p>--%>
                            <%--</li>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                <%--</div>--%>
				<div id="single_model_container">
					<div id="single_model" class="fixed_p">
						<a id="pre_que"><i class="in_bl pre_que"></i>上一题</a>
						<a id="show_key"><i class="in_bl show_key" ></i>查看答案</a>
						<a id="next_que">下一题<i class="in_bl next_que" ></i></a>
					</div>
				</div>
			</div>

			<div class="left">

				<div class="paper_set">
					<ul>
						<li class="set_back">
							<a href="${ctxRoot}/page/questions/simulation_exercise/majorpage.html">
								<em class="fa fa-mail-reply (alias)"></em><br>
								返回
							</a>
						</li>
						<li class="set_set">
							<a href="javascript:void(0);">
								<em class="fa fa-cog"></em><br>
								设置
							</a>
							<div class="down_menu">
								<div>
									<input type="radio" data-id="1" name="set_paper">自动显示答案
								</div>
								<div>
									<input type="radio" data-id="2" name="set_paper">自动下一题
								</div>
								<div>
									<input type="radio" data-id="3" name="set_paper" checked>答对自动下一题(客观题有效)
								</div>
								<div>
									<input type="radio" data-id="4" name="set_paper">手动操作
								</div>
							</div>
						</li>
						<%--<li class="set_calculator">--%>
							<%--<a href="javascript:void(0);">--%>
								<%--<em class="fa fa-calculator"></em><br>--%>
								<%--计算器--%>
							<%--</a>--%>
						<%--</li>--%>
					</ul>
				</div>

				<div id="set_table">
					<div class="set_time">
						<em class=""></em><span style="padding-right:5px;">用时</span><span id="spanHour" class="color_red">00</span><span>:</span><span id="spanMinute" class="color_red">00</span><span>:</span><span id="spanSecond" class="color_red">00</span><span id="fause"><a href="javascript:void(0);" onclick="inTheTest.spanPause()"><i></i>暂停</a></span>
					</div>
					<div class="set_car_title">
						答题卡
					</div>
					<div class="one4">
						<div class="two2" id="questionCard">
							<!--<span class="yesAnswer" onclick="anchorPosition(1)">01</span>
                            <span class="notAnswer" onclick="anchorPosition(2)">02</span>
                            <span class="notAnswer" onclick="anchorPosition(3)">03</span>
                            <span class="notAnswer" onclick="anchorPosition(4)">04</span>
                            <span class="notAnswer" onclick="anchorPosition(5)">05</span>-->
						</div>
						<div class="two5">
							<span>正确 </span><i class="fa fa-stop" style="color: #62c68b ;"></i>
							<span>错误 </span><i class="fa fa-stop" style="color: #db856d;"></i>
							<span>已答主观题 </span><i class="fa fa-stop" style="color: #B4B4B4;"></i>
						</div>
					</div>
					<a id="over_paper" href="javascript:void(0)" onclick="inTheTest.savaQuestions()">结束作答</a>
				</div>
			</div>
			<input type="hidden" id="hidID" name="pid" />
			<input type="hidden" id="hidTimecost" name="t_timecost" />
			<input type="hidden" id="page_num" name="0" />
		</form>
	</div>

</div>
<%--公式编辑器--%>
<div id="formula-wrap" style="width: 560px; height: 420px;">
	<div class="formula-tit">地理云课堂    - 公式编辑器</div>
	<div class="formula-iframe">
		<iframe frameborder="0" width="100%" height="320"></iframe>
	</div>
	<button type="button" class="close" id="J_FormulaClose">关 闭</button>
	<button type="button" class="submit" id="J_FormulaOk">确 定</button>
</div>
</body>

</html>
<style type="text/css">
	.layui-layer-btn {
		text-align: center;
	}

	.layui-layer-content {
		text-align: center;
	}
</style>
<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/Start_the_test/In_the_test.js"></script>--%>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/simulation_exercise/manual_questions.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/ckeditor/ckeditor.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/js/jquery-ui-1.9.2.custom.min.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/js/texzilla.js${v}"></script>

