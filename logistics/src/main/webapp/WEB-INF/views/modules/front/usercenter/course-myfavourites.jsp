<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>地理云课堂-我的课程收藏</title>
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
<script type="text/javascript">
	/**
	 * 全选或反选 
	 */
	function selectAll(em) {
		$("input[name='favouriteId']").attr('checked', $(em).prop('checked'));
	}

	/**
	 * 批量删除收藏
	 */
	function batchDelFav() {
		var arr = $("input[name='favouriteId']:checked");
		if (arr == null || arr.length == 0) {
			dialog("删除提示", "请选择要删除的收藏课程！", 1); 
			return;
		}
		var favouriteIdStr = "";
		$('input[name="favouriteId"]:checked').each(function() {
			favouriteIdStr = favouriteIdStr + $(this).val() + ",";
		});
		favouriteIdStr = favouriteIdStr.substring(0, favouriteIdStr.length - 1);
		dialog("删除提示", "确认要删除选择的收藏课程？", 2, "${ctxRoot}/course/deleteFaveorite/"
				+ favouriteIdStr);
	}
</script>
	<style>
		.u-r-cont{
			padding:10px;
		}

	</style>
</head>
<body>
	<article class="col-12">
		<div class="u-r-cont">
			<section>
				<div>
					<section class="c-infor-tabTitle c-tab-title">
						<a href="${ctxRoot}/course/myCourses" title="在学课程">在学课程</a>
						<a href="${ctxRoot}/course/myFavourites" title="课程收藏" class="current" style="cursor: default;">课程收藏</a>
					</section>
				</div>
				<section class="tar hLh30 pr10" style="background-color: #F6F6F6; margin-top: -20px;">
					<label class="hand c-999 vam"><input type="checkbox" name="" value="" style="vertical-align: -2px;" onclick="selectAll(this)">全选</label>
					<a href="javascript:void(0)" onclick="batchDelFav()" title="" class="vam ml10 c-blue">取消全部</a>
				</section>
				<div class="mt40" style="min-height: 900px;">
					<c:if test="${empty favoriteList}">
						<!-- /无数据提示 开始-->
						<section class="no-data-wrap">
							<em class="icon30 no-data-ico">&nbsp;</em> <span class="c-666 fsize14 ml10 vam">您还没有收藏任何课程哦！</span>
						</section>
						<!-- /无数据提示 结束-->
					</c:if>
					<c:if test="${not empty favoriteList}">
						<div class="u-sys-news u-collection-list">
							<form action="">
								<c:forEach items="${favoriteList}" var="favorite" varStatus="index">
									<dl>
										<dt>
											<section class="tar">
												<p class="hLh30">
													<b class="fsize14 f-fA c-red"><fmt:formatDate type="both" value="${favorite.addTime }" pattern="yyyy年" /></b>
												</p>
												<p class="hLh20">
													<span class="f-fA c-666"><fmt:formatDate type="both" value="${favorite.addTime }" pattern="MM月dd日 HH:mm" /></span>
												</p>
												<p class="hLh20">
													<span class="f-fA c-999">收藏</span>
												</p>
											</section>
										</dt>
										<dd>
											<section class="mt10">
												<div class="of cancel-colle">
													<div class="fr tac">
														<label class="hand"><input type="checkbox" style="vertical-align: -2px;" name="favouriteId" value="${favorite.favouriteId}"></label> <br>
														<a href="${ctxRoot}/course/deleteFaveorite/${favorite.favouriteId}" title="" class="c-blue">取消收藏</a>
													</div>
													<a target="_blank" href="${ctxRoot}/course/couinfo/${favorite.courseId }" title="">
														<c:choose>
															<c:when test="${not empty favorite.logo }">
																<img src="${favorite.logo}" width="60" alt="">
															</c:when>
															<c:otherwise>
																<img src="${ctxStatic}/hsun/front/qa/img/default-img.gif" width="60" alt="">
															</c:otherwise>
														</c:choose>
													</a>
												</div>
												<div class="hLh30 txtOf">
													<a href="${ctxRoot}/course/couinfo/${favorite.courseId }" class="c-666 fsize14" target="_blank">${favorite.courseName }</a>
												</div>
											</section>
										</dd>
									</dl>
								</c:forEach>
							</form>
						</div>
					</c:if>
					<!-- 公共分页 开始 -->
					<jsp:include page="/WEB-INF/views/modules/front/qa/front_page.jsp" />
					<!-- 公共分页 结束 -->
					<form action="${ctxRoot}/course/myFavourites" method="post" id="searchForm">
						<input type="hidden" name="page.currentPage" value="1" id="pageCurrentPage" />
						<%--<input type="hidden"  name="page.pageSize" value="5"/>--%>
					</form>
				</div>
			</section>
			<!-- /Wo的消息 -->
		</div>
	</article>
	<!-- /右侧内容区 结束 -->
</body>
<script type="text/javascript">
	if(top.hei){
		top.hei()
	}
</script>
</html>