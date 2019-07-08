<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/page.js"></script>
<c:if test="${page != null && page.totalResultSize>0}">
	<div class="paging">
		<a href="javascript:goPageAjax(1);" title="">首</a>
		<c:choose>
			<c:when test="${page.first}">
				<a id="backpage" class="undisable" href="javascript:void(0)" title="">&lt;</a>
			</c:when>
			<c:otherwise>
				<a id="backpage" href="javascript:goPageAjax(${page.currentPage-1 });" title="">&lt;</a>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${page.last}">
				<a id="nextpage"href="javascript:void(0)" title="" class="undisable">&gt;</a>
			</c:when>
			<c:otherwise>
				<a id="nextpage" href="javascript:goPageAjax(${page.currentPage+1});" title="">&gt;</a>
			</c:otherwise>
		</c:choose>
		<a href="javascript:goPageAjax(${page.totalPageSize});" title="">末</a>
		<div class="clear"></div>
	</div>

	<div class="mobile_page">
		<c:choose>
			<c:when test="${page.first}">
				<a id="prevpages" class="undisable" href="javascript:void(0)" title="">上一页</a>
			</c:when>
			<c:otherwise>
				<a id="prevpages" href="javascript:goPage(${page.currentPage-1 });" title="">上一页</a>
			</c:otherwise>
		</c:choose>
		<div class="mobile_pagesize">
			<a>第${page.currentPage}页</a>
		</div>
		<div class="mobile_pagesize_container">
			<div class="mobile_pagenumber">

			</div>
		</div>
		<c:choose>
			<c:when test="${page.last}">
				<a id="nextpages" href="javascript:void(0)" title="" class="undisable">下一页</a>
			</c:when>
			<c:otherwise>
				<a id="nextpages" href="javascript:goPage(${page.currentPage+1});" title="">下一页</a>
			</c:otherwise>
		</c:choose>

	</div>

</c:if>
<script type="text/javascript">
    var totalPageSize =${page.totalPageSize};
    var currentPage =${page.currentPage-1}<1 ? 1 :${page.currentPage};
    var totalPage = ${page.totalPageSize};
    showAjaxPageNumber();

	var mobilePageFun = function(){
		var that = this;
		this.mobile_pagesize = $('.mobile_pagesize');
		this.mobile_pagenum = $('.mobile_pagenumber');
		this.mobile_pagesize_container = $('.mobile_pagesize_container');

		this.loadPageFun = function(){
			var mobilePageHtml = [];
			mobilePageHtml.push('<a class="page_title">共'+ totalPage +'页，当前为第'+ currentPage +'页</a>');
			for(var i=0; i<totalPage; i++){
				if(currentPage == (i+1)){
					mobilePageHtml.push('<a class="num_list now_page" href="javascript:void(0);">第'+(i+1)+'页</a>');
				}else{
					mobilePageHtml.push('<a class="num_list" href="javascript:goPage('+(i+1)+')">第'+(i+1)+'页</a>');
				}
			}
			that.mobile_pagenum.html(mobilePageHtml.join(""));
		};

		this.showPageFun = function(){
			that.mobile_pagesize_container.fadeIn();
			that.mobile_pagenum.css('bottom',0);
		};
		this.hidePageFun = function(){
			that.mobile_pagenum.css('bottom','-200px');
			that.mobile_pagesize_container.fadeOut();
		};

		this.mobilePagenumber = function(e){
			e.stopPropagation();
		};

		this.init = function(){
			this.loadPageFun();
			this.mobile_pagesize_container.off('click').on('click',this.hidePageFun);
			this.mobile_pagesize.off('click').on('click',this.showPageFun);
			this.mobile_pagenum.off('click').on('click',this.mobilePagenumber);
		}
	};
	var mobilePage = new mobilePageFun;
	mobilePage.init();
</script>