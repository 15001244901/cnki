<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<!--[if lt IE 7]>      <html class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no,minimal-ui">
	<title>地理云课堂-课程列表</title>
	<meta name="author" content="FYJCKT" />
	<meta name="keywords" content="地理,在线教育,网络教育,远程教育,云网校,在线学习,在线考试" />
	<meta name="description" content="" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta content="telephone=no" name="format-detection" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/reset.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/theme.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/global.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/web.css${v}">
	<link href="${ctxStatic}/hsun/front/qa/css/mw_320_768.css" rel="stylesheet" type="text/css" media="screen and (min-width: 320px) and (max-width: 768px)">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/mobile_reset.css${v}">
	<!--[if lt IE 9]><script src="${ctxStatic}/hsun/front/qa/js/html5.js"></script><![endif]-->
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/jquery-1.7.2.min.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/webutils.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/common.js${v}"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<%--<script id="esp_urlpath" type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_urlpath.js${v}"></script>--%>
	<%--<script id="esp_header" type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_header.js${v}"></script>--%>
	<link id="courses_list" rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/js/especial_mobile/courses_list.css${v}">

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_public.js${v}"></script>

	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/course.js${v}"></script>


</head> 
<body>
	<div id="divheader"></div>

	<div id="aCoursesList" class="of">
		<!-- /课程列表 开始 -->
		<section class="container">
			<%--<header class="comm-title">--%>
				<%--<h2 class="fl tac">--%>
					<%--<span class="c-333">全部课程</span>--%>
				<%--</h2>--%>
			<%--</header>--%>
			<section class="c-sort-box">
				<section class="c-s-dl">
					<dl>
						<dt>
							<span class=" fsize14">按科目 :</span>
						</dt>
						<dd class="c-s-dl-li">
							<ul class="clearfix">
								<li <c:if test="${queryCourse.subjectId==0}">class="current"</c:if>><a onclick="submitForm(1,0)" title="全部" href="javascript:void(0)">全部</a></li>
								<c:forEach items="${subjectList}" var="subject">
									<li <c:if test="${queryCourse.subjectId==subject.subjectId or subjectParentId==subject.subjectId}">class="current"</c:if>><a onclick="submitForm(1,${subject.subjectId})" title="${subject.subjectName}" href="javascript:void(0)">${subject.subjectName}</a></li>
								</c:forEach>
							</ul>
							<aside class="c-s-more">
								<a href="javascript: void(0)" title="" class="fsize14 c-master">[展开]</a> 
							</aside>
						</dd>
					</dl>
					<c:if test="${sonSubjectList!=null&&sonSubjectList.size()>0 }">
                      	<dl>
							<dt>
								<span class="c-999 fsize14"></span>
							</dt>
							<dd class="c-s-dl-li">
								<ul class="clearfix">
									<c:forEach items="${sonSubjectList}" var="subject">
										<li <c:if test="${queryCourse.subjectId==subject.subjectId}">class="current"</c:if>><a onclick="submitForm(1,${subject.subjectId})" title="${subject.subjectName}" href="javascript:void(0)">${subject.subjectName}</a></li>
									</c:forEach>
								</ul>
								<aside class="c-s-more">
									<a href="javascript: void(0)" title="" class="fsize14 c-master">[展开]</a>
								</aside>
							</dd>
						</dl>
                    </c:if>
					<dl style="border-bottom:none;">
						<dt>
							<span class=" fsize14">按讲师 :</span>
						</dt>
						<dd class="c-s-dl-li">
							<ul class="clearfix">
								<li <c:if test="${queryCourse.teacherId==0}">class="current"</c:if>><a onclick="submitForm(2,0)" title="全部" href="javascript:void(0)">全部</a></li>
								<c:forEach items="${teacherList}" var="teacher">
									<li <c:if test="${teacher.id==queryCourse.teacherId}">class="current"</c:if>><a title="${teacher.name}" onclick="submitForm(2,${teacher.id})" href="javascript:void(0)">${teacher.name}</a></li>
								</c:forEach>
							</ul>
							<aside class="c-s-more">
								<a href="javascript: void(0)" title="" class="fsize14 c-master">[展开]</a>
							</aside>
						</dd>
					</dl>
					<div class="clear"></div>
				</section>
				<div class="js-wrap">
					<section class="fr">
						<span class="c-ccc"> <tt class="c-master f-fM">${page.currentPage}</tt>/<tt class="c-666 f-fM">${page.totalPageSize}</tt>
						</span>
					</section>
					<section class="fl">
						<ol class="js-tap clearfix">
							<li <c:if test="${queryCourse.order=='NEW'}">class="current bg-greent"</c:if>><a title="最新" onclick="submitForm(3,'NEW')" href="javascript:void(0)">最新</a></li>
							<li <c:if test="${queryCourse.order=='FOLLOW'}">class="current bg-greent"</c:if>><a title="关注度" onclick="submitForm(3,'FOLLOW')" href="javascript:void(0)">关注度</a></li>
							<li <c:if test="${queryCourse.order=='ASCENDING'||queryCourse.order=='DESCENDING'}">class="current bg-greent"</c:if>><a title="价格" onclick="submitForm(4,'<c:if test="${not empty queryCourse.order}">${queryCourse.order }</c:if><c:if test="${empty queryCourse.order}">ONE</c:if>')" href="javascript:void(0)">价格<span><c:if test="${queryCourse.order=='ASCENDING' }">↑</c:if><c:if test="${queryCourse.order=='DESCENDING' }">↓</c:if></span></a></li>
						</ol>
					</section>
				</div>
				<div class="mt40">
					<c:if test="${empty courseList}">
						<!-- /无数据提示 开始-->
						<section class="no-data-wrap">
							<em class="icon30 no-data-ico">&nbsp;</em> <span class="c-666 fsize14 ml10 vam">没有相关数据，小编正在努力整理中...</span>
						</section>
						<!-- /无数据提示 结束-->
					</c:if>
					<c:if test="${not empty courseList}">
						<article class="comm-course-list">
							<ul class="of">
								<c:forEach items="${courseList}" var="course" varStatus="index">
									<li>
										<div class="cc-l-wrap">
											<section class="course-img">
												<c:choose>
													<c:when test="${not empty course.logo }">
														<img xSrc="${course.logo}" src="${ctxStatic}/hsun/front/qa/img/default-img.gif" class="img-responsive" alt="">
													</c:when>
													<c:otherwise>
														<img xSrc="${ctxStatic}/hsun/front/qa/img/default-img.gif" src="${ctxStatic}/hsun/front/qa/img/default-img.gif" class="img-responsive" alt="" >
													</c:otherwise>
												</c:choose>
												<div class="cc-mask">
													<a href="${ctxRoot}/course/couinfo/${course.courseId}" title="" class="comm-btn c-btn-1">开始学习</a>
												</div>
											</section>
											<h3 class="hLh30 txtOf mt10">
												<a href="${ctxRoot}/course/couinfo/${course.courseId}" title="${course.courseName}" class="course-title fsize16 c-333">${course.courseName}</a>
											</h3>
											<section class="mt10 hLh20 of">
												<c:if test="${course.currentPrice=='0.00' }">
													<span class="fr jgTag bg-green noprice"><tt class="c-fff fsize12 f-fA ">免费</tt></span>
												</c:if>
												<c:if test="${course.currentPrice!='0.00' }">
													<span class="fr jgTag bg-orange isprice"><tt class="c-fff fsize14 f-fG ">￥${course.currentPrice }</tt></span>
												</c:if>
												<span class="fl jgAttr c-ccc f-fA"> <tt class="c-999 f-fA">${course.pageBuycount }人学习</tt> | <tt class="c-999 f-fA">${course.pageViewcount }浏览</tt>
												</span>
											</section>
										</div>
									</li>
								</c:forEach>
							</ul>
							<div class="clear"></div>
						</article>
					</c:if>
				</div>
				<!-- 公共分页 开始 -->
				<jsp:include page="/WEB-INF/views/modules/front/qa/front_page.jsp" />
				<!-- 公共分页 结束 -->
				<form action="${ctxRoot}/course/showcoulist" id="searchForm" method="post">
					<input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
					<input type="hidden" name="queryCourse.teacherId" value="${queryCourse.teacherId}" />
					<input type="hidden" name="queryCourse.subjectId" value="${queryCourse.subjectId}" />
					<input type="hidden" name="queryCourse.order" value="${queryCourse.order}" />
				</form>
			</section>
		</section>
		<!-- /课程列表 结束 -->
	</div>
	<script>
		$(function() {
		    if(especial_public){
                $("#divheader").load(projectname + "/page/include/header.html"+timestamps);
            }else{
                $("#divheader").remove();
            }
			cSortFun(); //分类更多按钮交互效果
			scrollLoad(); //响应滚动加载课程图片
		});
		//sort suMore
		var cSortFun = function() {
		    $(".c-s-dl>dl .c-s-more>a").each(function() {
		        var _this = $(this),
		            _uList = _this.parent().siblings("ul"),
		            _uLw = _uList.height();
		        if (_uLw <= "40") {
		            _this.hide();
		        } else {
		            _uList.css("height","40px");
		            _this.click(function() {
		                if(_this.html() == "[展开]") {
		                    _uList.css("height","auto");
		                    _this.text("[收起]");
		                } else {
		                    _uList.css("height" , "40px");
		                    _this.text("[展开]");
		                }
		            })
		        }
		    });
		}
	</script>
</body>
</html>