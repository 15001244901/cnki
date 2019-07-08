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

		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<!--<script src="${ctxStatic}/hsun/front/js/jquery/floding.js" type="text/javascript" charset="utf-8"></script>-->
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/create_test_paper/edit_item_page/Edit_item_two.css${v}" />

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<form>
				<div>
					<div class="divpapername" id="divName">创建试卷</div>
					<div class="divpaerinfo">
						<!--<span>试卷名称：<input type="text" id="txtName" name="name" value="" /></span>-->
						<span>总分值：<input type="text" class="style" id="txtTotalScore" name="totalscore" value="" /></span>
						<span>题目数量：<input type="text" class="style" id="txtCount" name="" value="" /></span>
						<span>时间（分钟）：<input type="text" class="style" id="txtduration" name="duration" value="" /></span>
					</div>
				</div>
				<div class="left">
					<div>
						<div class="divschedule" onclick="editItemTwo.savaSchedule()">
							<i class="fa fa-list-alt" id="style3"></i><br />
							<span>保存进度</span>
						</div>
						<div class="divsave" onclick="editItemTwo.saveQuestion()">
							<i class="fa fa-list-ul" id="style3"></i><br />
							<span>完成试卷</span>
						</div>
					</div>
				</div>
				<div class="right">
					<div>
						<input type="hidden" id="hidQuestionID" value="" />
						<input type="hidden" id="sectionID" value="" />

						<input type="hidden" id="hidid" name="id" value="" />
						<input type="hidden" id="hidname" name="name" value="" />
						<input type="hidden" id="hidstatus" name="status" value="" />
						<input type="hidden" id="hidiscomplete" name="iscomplete" value="" />
						<input type="hidden" id="hidstarttime" name="starttime" value="" />
						<input type="hidden" id="hidendtime" name="endtime" value="" />
						<input type="hidden" id="hidshowtime" name="showtime" value="" />
						<input type="hidden" id="hidordertype" name="ordertype" value="" />
						<input type="hidden" id="hidpapertype" name="papertype" value="" />
						<input type="hidden" id="hidremark" name="remark" value="" />
						<input type="hidden" id="hidshowkey" name="showkey" value="" />
						<input type="hidden" id="hidshowmode" name="showmode" value="" />

						<ul class="menu-one" id="questionsUL">

						</ul>
					</div>
				</div>
			</form>
			<div id="divquestionscontent">
				<div class="divquestionmenu">
					<select class="sel" id="p_subject">
						<option></option>
					</select>
					<select class="sel" id="p_types">
						<option></option>
					</select>
					<select class="sel" id="p_levels">
						<option></option>
					</select>
					<a href="javascript:;" onclick="editItemTwo.searchQuestions()">搜索</a>
					<a href="javascript:;" onclick="editItemTwo.closeDiv()">关闭</a>
				</div>
				<div class="divContent">
					<table cellpadding="0" cellspacing="0" id="tableContent">
						<!--<tr>
							<td class="tdName">11</td>
							<td class="tdOperate">
								<a href="javascript:;" onclick="editItemTwo.replaceQuestion('id','qcontent');">确定</a>
							</td>
						</tr>-->
					</table>
				</div>
				<div class="divPage" id="divHtmlPage">

				</div>
			</div>
			<input type="hidden" id="pageNo" value="1" />
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/edit_item_page/Edit_item_two.js${v}"></script>