<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>地理云课堂-在学课程</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no,minimal-ui">
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

	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_public.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
	<style>
		@media (min-width: 768px){
			.u-r-cont{
				padding:10px;
			}
			.comm-course-list li{
				width:25%;
			}
			.img-responsive{
				min-height:118px;
			}

		}
		.mobile_page{
			margin-bottom:40px;
		}
	</style>
</head>
<body>
<article class="col-12">
	<div class="u-r-cont">
		<section>
			<div>
				<section class="c-infor-tabTitle c-tab-title">
					<a href="${ctxRoot}/course/myCourses" title="在学课程" class="current" style="cursor: default;">在学课程</a>
					<a href="${ctxRoot}/course/myFavourites" title="课程收藏">课程收藏</a>
				</section>
			</div>
			<div class="mt40">
				<c:if test="${courseList==null || courseList.size()<=0 }">
					<!-- /无数据提示 开始-->
					<section class="no-data-wrap">
						<em class="icon30 no-data-ico">&nbsp;</em>
						<span class="c-666 fsize14 ml10 vam">暂无学习课程！</span>
					</section>
					<!-- /无数据提示 结束-->
				</c:if>
				<c:if test="${not empty courseList }">
					<div class="u-course-list">
						<article class="comm-course-list">
							<ul class="clearfix">
								<c:forEach items="${courseList}" var="course">
									<li>
										<div class="cc-l-wrap">
											<section class="course-img">
												<c:choose>
													<c:when test="${not empty course.logo}">
														<img src="${course.logo}" class="img-responsive" alt="${course.courseName}" />
													</c:when>
													<c:otherwise>
														<img src="${ctxStatic}/hsun/front/qa/img/default-img.gif" class="img-responsive" alt="${course.courseName}" />
													</c:otherwise>
												</c:choose>
												<div class="cc-mask">
													<a target="_blank" href="${ctxRoot}/course/play/${course.courseId}" title="" class="comm-btn c-btn-1">继续学习</a>
												</div>
											</section>
											<h3 class="hLh30 txtOf mt10">
												<a target="_blank" href="${ctxRoot}/course/play/${course.courseId}" title="${course.courseName}" class="course-title fsize14 c-333">${course.courseName}</a>
											</h3>
											<section class="mt10 of">
												<div class="time-bar-wrap">
													<div class="lev-num-wrap" title="已学${course.studyPercent}%">
														<aside class='lev-num-bar <c:if test="${course.studyPercent>=100}">bg-orange</c:if> <c:if test="${course.studyPercent<100}">bg-green</c:if>' style="width: ${course.studyPercent}%;"></aside>
														<span class="lev-num"><big>${course.studyPercent}%</big>/<small>100%</small></span>
													</div>
												</div>
											</section>
										</div>
									</li>
								</c:forEach>
							</ul>
						</article>
						<!-- 公共分页 开始 -->
						<jsp:include page="/WEB-INF/views/modules/front/qa/front_page.jsp" />
						<!-- 公共分页 结束 -->
						<form method="post" id="searchForm" action="${ctxRoot}/course/myCourses">
							<input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
							<%--<input type="hidden"  name="page.pageSize" value="12" />--%>
						</form>
					</div>
				</c:if>
			</div>
		</section>
		<!-- /我的课程 -->
	</div>
</article>
<script type="text/javascript">
	if(top.hei){
		top.hei()
	}
</script>
</body>
</html>