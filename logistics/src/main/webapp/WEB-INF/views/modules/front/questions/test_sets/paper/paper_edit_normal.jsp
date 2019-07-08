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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/paper/paper_edit_normal.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery-ui/jquery-ui.min.js${v}" type="text/javascript" charset="utf-8"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/js/jquery-ui/jquery-ui.min.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
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
		<script>
			
		</script>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="divpapername" id="divName"></div>
			<form>
				<div class="divpaperinfo">
					<span>考试时长： <input id="txtDuration" name="duration" type="text" style="border: 0px; border-bottom: solid 1px #dcdcdc;width: 60px;" maxlength="3"/></span>
					<span>卷面总分： <input id="txtTotalScore" name="totalscore" type="text" style="border: 0px; border-bottom: solid 1px #dcdcdc;width: 60px" maxlength="3"/></span>
					<span>及格分数： <input id="txtPassScore" name="passscore" type="text" style="border: 0px; border-bottom: solid 1px #dcdcdc;width: 60px" maxlength="3"/></span>
				</div>

				<div class="section">
					<div class="divyxlist">已选择试题列表</div>
					<div class="divmenu">
						<span onclick="tmPaper.addSection()">添加段落</span>
						<span onclick="tmPaper.expandSection()">全部展开</span>
						<span onclick="tmPaper.shrinkSection()">全部收缩</span>
						<span onclick="tmPaper.countScore()">计算总分</span>
					</div>
					<div class="tm_adm_paper_body">
						<ul class="tm_adm_paper_body_section" id="paper_sections">

						</ul>
					</div>
				</div>
				<input type="hidden" id="hidID" name="id" />
				<input type="hidden" id="hidName" name="name" />
				<input type="hidden" name="starttime" />
				<input type="hidden" name="endtime" />
				<input type="hidden" name="showtime" />
				<input type="hidden" id="hidOrderType" name="ordertype" />
				<input type="hidden" id="hidPaperType" name="papertype" />
				<input type="hidden" name="remark" />
			</form>
			<div class="section1">
				<div class="div5">
					<span style="font-size: 16px;">请选择试题</span>
					<!--<span style="font-size: 14px; color: #fe8922;margin-left: 149px;">单击试题浏览，单机加号添加试题到当前试卷中</span>-->
				</div>
				<div class="div6">
					<span name="spanType" onclick="paperEditNormal.clickType(this,'知识点')" class="active">知识点</span>
					<span name="spanType" onclick="paperEditNormal.clickType(this,'我的收藏')">我的收藏</span>
					<span name="spanType" onclick="paperEditNormal.clickType(this,'企业专属')">企业专属</span>
				</div>
				<div class="div7">
					<select name="" class="style5" id="sltSubject">
					</select>
					<select name="" class="style5" id="sltQuestion">
					</select>
					<select name="" class="style5" id="sltLevel">
					</select>
					<input type="text" class="style6" id="keyword" placeholder="&nbsp;请输入搜索内容" />
					<i onclick="paperEditNormal.searchLibrary()" class="fa fa-search"></i>
				</div>

				<div id="div8" class="divList">
					<ul id="questionListAll" class="tm_adm_questionlist" style="margin: 0; padding: 0px;">

					</ul>

				</div>
				<div id="questionListPage" class="divPage">

				</div>
			</div>
			<div class="button" style="clear: both;">
				<!--当前页-->
				<input type="hidden" id="pageNo" value="1" />
				<!--收藏分页当前页-->
				<input type="hidden" id="pageNoCollection" value="1" />
				<!--企业专属当前页-->
				<input type="hidden" id="pageNoCompany" value="1" />
				<!--类型  1知识点2我的收藏3企业专属-->
				<input type="hidden" id="hidtype" value="1" />

				<span onclick="paperEditNormal.savaSchedule()">保存进度</span>
				<span class="active" onclick="paperEditNormal.savaChoose()">完成选择</span>
			</div>
		</div>

	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/paper/paper_edit_normal.js${v}"></script>