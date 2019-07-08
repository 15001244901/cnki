<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<title>地理云课堂</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		<link href="${ctxStatic}/hsun/front/css/questions/simulation_exercise/majorpageIntelligence.css${v}" type="text/css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/question_details/swiper.min.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/idangerous.swiper.min.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
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
		</style>
	</head>

	<body>
		<div id="divheader"></div>
		<div class="navigation_bar">
			<span onclick="magorpageIntelligence.skip('0')">&nbsp;&nbsp;按知识点练习&nbsp;&nbsp;</span>
			<span onclick="magorpageIntelligence.skip('1')" class="spansubjecttitle">&nbsp;&nbsp;智能组卷练习&nbsp;&nbsp;</span>
			<span onclick="magorpageIntelligence.skip('2')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;套题练习&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<span onclick="magorpageIntelligence.skip('3')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新智能组卷练习&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		</div>
		<!--智能组卷练习-->
		<div id="JKDiv_1">

			<table id="table2" cellspacing="0" cellpadding="0">
				<tr class="firstChild all">
					<td>
						<span>试卷名称：</span>
					</td>
					<td class="first" colspan="9">
						<span>
							<input type="text" id="txtPaperName"/>
						</span>
					</td>

				</tr>
				<tr class="last">
					<td rowspan="2">
						<p class="first first2">
							题目数量：
							<label style="width: 20px;padding: 10px;" id="lblnums">1</label>
						</P>
						<p class="remark">
							<span class="radios"></span>
							<span>为推荐题数</span>

						</p>
					</td>
					<td colspan="9" rowspan="2">
						<canvas id="myCanvas" width="1000" height="50" style="position: relative; top:15px;">		
                        </canvas>
						<div class='range2'>
							<div class='mea' onmousedown="magorpageIntelligence.change2(this,event)"></div>
						</div>
						<br />
					</td>

				</tr>
				<tr class="all">

				</tr>
				<%--<tr class="all">--%>
					<%--<td>--%>
						<%--<span>组卷内容：</span>--%>
					<%--</td>--%>
					<%--<td colspan="9" class="first" id="paperTD">--%>
					<%--</td>--%>
				<%--</tr>--%>
				<tr class="all">
					<td>
						<span>选择科目：</span>
					</td>
					<td class="first" colspan="9" id="subjectTD">
					</td>
				</tr>
				<tr class="all">
					<td>
						<span>选择知识点：</span>
					</td>
					<td class="first" colspan="9" id="topicTD">
					</td>
				</tr>
				<%--<tr class="all">--%>
					<%--<td>--%>
						<%--<span>针对练习：</span>--%>
					<%--</td>--%>
					<%--<td class="first" colspan="9">--%>
						<%--<span><a name="practice" class="active" onclick="magorpageIntelligence.practice(this)">随机</a></span>--%>
						<%--<span><a name="practice" onclick="magorpageIntelligence.practice(this)">已做</a></span>--%>
						<%--<span><a name="practice" onclick="magorpageIntelligence.practice(this)">全新题</a></span>--%>
						<%--<span><a name="practice" onclick="magorpageIntelligence.practice(this)">错题</a></span>--%>
					<%--</td>--%>
				<%--</tr>--%>
				<tr class="all">
					<td>
						<span>题型选择：</span>
					</td>
					<td class="first" colspan="9" id="questionTD">
					</td>

				</tr>
				<tr class="all">
					<td>
						<span>难度：</span>
					</td>
					<td class="first" colspan="9" id="levelTD">
					</td>
				</tr>

				<tr class="last">
					<td rowspan="2">
						<p class="first">
							时间(分钟)：
							<label style="width: 20px;padding: 10px;" id="lbltime">1</label>
						</p>
						<p class="remark">
							<span class="radios"></span>
							<span>为推荐时间</span>
						</p>
					</td>
					<td colspan="9" rowspan="2">

						<canvas id="myCanvas1" width="1000" height="50" style="position: relative;top:14px;">		
                       </canvas>
						<div class='range2'>
							<div class='mea' onmousedown="magorpageIntelligence.change3(this,event)"></div>
						</div>
						<br />

					</td>
				</tr>
				<tr class="all">

				</tr>
				<tr class="last">
					<td rowspan="2">
						<p class="first">
							每题分值：
							<label style="width: 20px;padding: 10px;" id="lblScore">1</label>
						</p>
						<p class="remark">
							<!--<span class="radios"></span>-->
							<!--<span>为推荐时间</span>-->
						</p>
					</td>
					<td colspan="9" rowspan="2">

						<canvas id="myCanvasScores" width="1000" height="50" style="position: relative;top:14px;">		
                       </canvas>
						<div class='rangeScores'>
							<div class='mea' onmousedown="magorpageIntelligence.changeScore(this,event)"></div>
						</div>
						<br />

					</td>
				</tr>
				<tr class="all">

				</tr>
				<tr class="twoChild">

				</tr>
				<tr class="threeChild">
					<td colspan="10" id="click">
						<span class="give"><a onclick="magorpageIntelligence.creatPaper()" style="color: white;" href="javascript:;">创建试卷</a></span>
					</td>

				</tr>

			</table>
			<!--组卷内容-->
			<input type="hidden" id="papertype" />
			<!--科目-->
			<input type="hidden" id="subjecttype" />
			<!--知识点-->
			<input type="hidden" id="topictype" />
			<!--针对练习-->
			<input type="hidden" id="practicetype" />
			<!--题型-->
			<input type="hidden" id="questiontype" />
			<!--难度-->
			<input type="hidden" id="leveltype" />

		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/simulation_exercise/magorpageIntelligence.js${v}"></script>