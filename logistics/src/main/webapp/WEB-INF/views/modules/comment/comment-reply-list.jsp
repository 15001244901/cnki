<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/comment/css/commentList.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/comment/css/boPage.css${v}">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
	<title>评论回复列表</title>
<script>
function delcomment(commentId){
	 $.ajax({
		url : '${ctx}/comment/del/'+commentId,
		type : 'post',
		async : true,
		dataType : 'text',
		success : function(result) {
			location.reload();
		}
	});
}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/comment/query">评论列表</a></li>
		<li class="active"><a>回复列表</a></li>
	</ul>
	<div class="pad20" style="margin-top:10px;">
		<form action="${ctx}/comment/reply/query?pCommentId=${comment.PCommentId}" method="post" id="searchForm" class="form-search form-inline breadcrumb">
			<input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
			<input class="form-control" placeholder="回复人" type="text" name="userName" value="${comment.userName}" />
			<input class="form-control" placeholder="内容" type="text" name="content" value="${comment.content}" />
			<a  onclick="javascript:$('#searchForm').submit();" class="btn btn-primary" href="javascript:void(0)">
				<span class="ui-icon ui-icon-search"></span>
				查找评论
			</a>
			<a title="清空" onclick="javascript:$('#searchForm input:text').val('');$('#searchForm select').val(0);" class="button tooltip"
				href="javascript:void(0)">
				<span class="ui-icon ui-icon-cancel"></span>
				清空
			</a>
			<input onclick="window.location.href='${ctx}/comment/query';" class="btn btn-default" type="button" value="返回">
		</form>
		<table cellspacing="0" cellpadding="0" border="0" class="fullwidth table table-bordered table-hover">
			<thead>
				<tr>
					<td align="center">
						id
					</td>
					<td align="center">回复人</td>
					<td align="center">类型</td>
					<td align="center">点赞</td>
					<td align="center">回复</td>
					<td align="center">创建时间</td>
					<td align="center">评论内容</td>
					<td align="center" width="232">操作</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${commentList}" var="com">
					<tr class="odd">
						<td align="center">
							${com.commentId}
						</td>
						<td align="center">${com.userName}</td>
						<td align="center">
							<c:if test="${com.type==1}">文章</c:if>
							<c:if test="${com.type==2}">课程</c:if>
						</td>
						<td align="center">${com.praiseCount}</td>
						<td align="center">${com.replyCount}</td>
						<td align="center">
							<fmt:formatDate value="${com.addTime}" pattern="yyyy/MM/dd HH:mm" />
						</td>
						<td align="center">${com.content}</td>
						<td align="center">
							<a href="${ctx}/comment/reply/info/${com.commentId}" class="btn btn-warning">修改</a>
							<a href="javascript:delcomment('${com.commentId}')" class="btn btn-danger">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="bopage">
			<jsp:include page="/WEB-INF/views/include/admin_page.jsp" />
		</div>
	</div>
</body>
</html>