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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/standard/Detail.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	</head>

	<body>
		<div id="divheader"></div>
		<div id="divcontent">
			<div class="divtitle">
				<div class="divsno">
					<span>标准号：</span>
					<span style="margin-left: 10px;" id="spanSno"></span>
				</div>
				<div class="divcancel">
					<span><a href="javascript:;" onclick="standarddetail.tour();">返回标准</a></span>
				</div>
			</div>
			<div class="divname">
				<div>
					<span class="spankey">中文名称：</span>
					<span class="spanvalue" id="spanName"></span>
				</div>
				<div>
					<span class="spankey">英文名称：</span>
					<span class="spanvalue" id="spanEnname"></span>
				</div>
			</div>
			<div class="divtype">
				<div>
					<div class="left">
						<span class="spankey">中标分类：</span>
						<span class="spanvalue" id="spanTypezh"></span>
					</div>
					<div class="right">
						<span class="spankey">ICS分类：</span>
						<span class="spanvalue" id="spanIcs"></span>
					</div>
				</div>
				<div>
					<div class="left">
						<span class="spankey">标准分类编号：</span>
						<span class="spanvalue" id="spanTypeNo"></span>
					</div>
					<div class="right">
						<span class="spankey">页数：</span>
						<span class="spanvalue" id="spanPageNo"></span>
					</div>
				</div>
			</div>
			<div class="divtime">
				<div>
					<span class="spankey">发起日期:</span>
					<span class="spanvalue" id="spanIssuedate"></span>
				</div>
				<div>
					<span class="spankey">实施日期:</span>
					<span class="spanvalue" id="spanExecutedate"></span>
				</div>
				<div>
					<span class="spankey">作废日期：</span>
					<span class="spanvalue">--</span>
				</div>
			</div>
			<div class="divstandard">
				<div>
					<span class="spankey">被替代标准:</span>
					<span class="spanvalue" id="spanReplacedby"></span>
				</div>
				<div>
					<span class="spankey">代替标准：</span>
					<span class="spanvalue" id="spanReplacestd"></span>
				</div>
			</div>
			<div class="divstandard">
				<div>
					<span class="spankey">引用标准:</span>
					<span class="spanvalue" id="spanCitestd"></span>
				</div>
				<div>
					<span class="spankey">采用标准：</span>
					<span class="spanvalue" id="spanUsestd"></span>
				</div>
			</div>
			<div class="divstandard">
				<div>
					<span class="spankey">起草单位:</span>
					<span class="spanvalue" id="spanDraftcompany"></span>
				</div>
				<div>
					<span class="spankey">归口单位：</span>
					<span class="spanvalue" id="spanGkcompany"></span>
				</div>
			</div>
			<div class="divstandard" style="border-bottom: 1px dashed #DCDCDC;padding-bottom: 40px;">
				<div>
					<span class="spankey">原文标题:</span>
					<span class="spanvalue" id="spanTitle"></span>
				</div>
				<div>
					<span class="spankey">复审结果：</span>
					<span class="spanvalue" id="spanRecheckresult"></span>
				</div>
			</div>
			<div class="divremark">
				<div>
					<span class="spankey">标引依据:</span>
					<span class="spanvalue" id="spanAccording"></span>
				</div>
			</div>
			<div class="divremark">
				<div>
					<span class="spankey">补充修订：</span>
					<span class="spanvalue" id="spanSupplement"></span>
				</div>
			</div>
			<div class="divremark">
				<div>
					<span class="spankey">备注：</span>
					<span class="spanvalue" id="spanRemark"></span>
				</div>
			</div>
			<div class="divremark">
				<div>
					<span class="spankey">范围：</span>
					<span class="spanvalue" id="spanStdrange"></span>
				</div>
			</div>
		</div>
		<input type="hidden" id="standardid" value="" />
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/standard/detail.js${v}"></script>