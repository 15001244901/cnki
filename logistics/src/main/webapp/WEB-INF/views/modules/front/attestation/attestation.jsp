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

        <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/attestation/attestation.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/json2.js${v}" type="text/javascript" charset="utf-8"></script>
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>

		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css${v}">

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>


	</head>

	<body>
		<div id="divheader"></div>

		<div class="divcontent" id="cont_header">
			<div id="title_search">
                <div id="section">
                    <span><a href="${ctxRoot}/page/library/knowledge_library.html">文库</a></span>
                    <span><a href="${ctxRoot}/page/baike/baike.html">百科</a></span>
                    <span class="active"><a href="${ctxRoot}/page/attestation/attestation.html">认证认可</a></span>
                    <div id="bottom_line"></div>
                </div>
				<%--搜索--%>
				<div class="bo_search">
					<div>
						<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
						<span class="spansearch"><a id="search_btn" href="javascript:void(0);"><i class="fa fa-search fa-lg"></i></a></span>
					</div>
				</div>
			</div>
		</div>
		<div id="divcontent" class="divcontent">
			<div id="divlist">
				<div class="divlist_fl">
					<div class="divlist_fl_title">分类导航</div>
					<div class="divlist_fl_list">
						<ul class="dash_line dash_pos ml15 tree_container" id="onecontainer">
							<li>
								<div class="one_title one sel_bg" data-id="all">
									<em class="bg title_dash"></em><span onclick="selClick(this);" title="不限"><i class="sel select selected"></i><span class="topic_name">不限</span></span>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="divlist_fr">
					<div>
						<ul class="menu-one" id="contents">
							<div class="section">
								<div class="div5"> <span class="three1"><a href="/ywork/page/standard/tour.html?id=100" style="color:#30bf89">标准编号：GB/T476-2008</a></span> <span class="three2">实施日期 : 2009-05-01</span> </div>
								<div class="div6"> <span class="one6">标准名称：煤中碳和氢的测定方法</span> <span class="two6">现行 </span> </div>
							</div>
							<div class="section">
								<div class="div5"> <span class="three1"><a href="/ywork/page/standard/tour.html?id=101" style="color:#30bf89">标准编号：GB/T479-2000</a></span> <span class="three2">实施日期 : 2000-12-01</span> </div>
								<div class="div6"> <span class="one6">标准名称：烟煤胶质层指数测定方法</span> <span class="two6">现行 </span> </div>
							</div>
							<div class="section">
								<div class="div5"> <span class="three1"><a href="/ywork/page/standard/tour.html?id=102" style="color:#30bf89">标准编号：GB/T480-2010</a></span> <span class="three2">实施日期 : 2011-02-01</span> </div>
								<div class="div6"> <span class="one6">标准名称：煤的铝甑低温干馏试验方法</span> <span class="two6">现行 </span> </div>
							</div>
						</ul>
					</div>
					<div class="divPage" id="pageSinglehtml">
						<%--<a class="next prev disabled" href="javascript:">上一页</a>--%>
						<%--<a class="curr" href="javascript:">1</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(2,10,'');">2</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(3,10,'');">3</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(4,10,'');">4</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(5,10,'');">5</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(6,10,'');">6</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(7,10,'');">7</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(8,10,'');">8</a>--%>
						<%--<a class="" href="javascript:">...</a>--%>
						<%--<a class="num" href="javascript:" onclick="page(20,10,'');">20</a>--%>
						<%--<a class="next" href="javascript:" onclick="page(2,10,'');">下一页</a>--%>
					</div>
				</div>

			</div>
			<input type="hidden" value="" id="nowid">
		</div>
		<script id="model" type="text/template">
			<li>
				<div class="one_title one sel_bg" id="sub-{{id}}" data-id="{{id}}">
					<em class="bg {{bg}}" onclick="toggerClick(this);"></em><span onclick="selClick(this);" title="{{title}}"><i class="sel select"></i><span class="topic_name">{{name}}</span></span>
				</div>
				<ul class="dash_line dash_pos ml19 hide">
				</ul>
			</li>
		</script>
		<script id="model_2" type="text/template">
			<li>
				<div class="one_title" id="sub-{{id}}" data-id="{{id}}">
					<em class="bg {{bg}}" onclick="toggerClick(this);"></em><span onclick="selClick(this);" title="{{title}}"><i class="sel select"></i><span class="topic_name">{{name}}</span></span>
				</div>
				<ul class="dash_line dash_pos ml19 hide">
				</ul>
			</li>
		</script>
	</body>

</html>
<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/jquery.slimscroll.min.js${v}" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/attestation/attestation.js${v}"></script>
