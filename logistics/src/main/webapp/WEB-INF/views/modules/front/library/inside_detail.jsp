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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/library/reading_page_two.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pdf/pdfobject.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<style>
			.divPage {
				margin-top: 10px;
				width: 100%;
				height: 70px;
				text-align: center;
				line-height: 70px;
				clear: both;
				overflow: hidden;
			}
			.divPage .disabled {
				display: none;
			}
			.divPage a {
				padding: 6px 12px;
				border: solid 1px #DCDCDC;
				border-radius: 6px;
				font-size: 14px;
				color: #999;
			}
			.divPage .curr {
				border: solid 1px #BFBFC7;
				background: #BFBFC7;
				color: white;
			}
		</style>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="nav">
				<span class="spantitle" id="spanTitle"></span>
				<span class="spanmodel">
					<%--<span style="font-size: 12px;" onclick="library.toPDFPage()" id="typeSpan">PDF模式</span>--%>
				<%--<span><i class="fa fa-list-ul"></i></span>--%>
				<span onclick="library.goBack();"><i class="fa  fa-share "></i></span>
				<%--<span><i class="fa fa-font"></i></span>--%>
				<%--<span><i class="fa fa-question-circle"></i></span>--%>
				<span id="full_screen" title="全屏查看"><i class="fa fa-arrows-alt"></i></span>
				</span>
			</div>
			<div>
				<div id="leftDiv" class="divPaper">
					<%--<img onclick="library.before()" src="${ctxStatic}/hsun/front/img/library/left.png${v}" style="width: 25px;height: 40px;" />--%>
				</div>
				<div style="float: left;" class="diviframe" id="contentDiv">
					<%--<center>--%>
						<%--<iframe id="htmlIframe" frameborder="0" width="100%" height="720" src="" scrolling="no"></iframe>--%>
					<%--</center>--%>
						<div class="no_data" style="display:none;padding-top:1px;opacity:0.5;background:url('${ctxStatic}/hsun/front/img/nodata.png') no-repeat center 50px;height:100%;">
						</div>
				</div>
				<div id="rightDiv" class="divPaper">
					<%--<img onclick="library.next()" src="${ctxStatic}/hsun/front/img/library/rigth.png${v}" style="width: 25px;height: 36px;" />--%>
				</div>
			</div>
			<div style="clear:both;"></div>
			<div class="divPage" id="pagehtml">

			</div>
			<input type="hidden" id="hidPageNo" value="1" />
			<input type="hidden" id="hidPageCount" value="1" />
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/library/inside_detail.js${v}"></script>