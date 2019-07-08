<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/comment/css/commentList.css">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/comment/css/boPage.css">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
	<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<title>评论列表</title>
<script>
function delcomment(commentId){
	 $.ajax({
		url :  '${ctx}/comment/del/'+commentId,
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
		<li class="active"><a>评论列表</a></li>
	</ul>
	<div class="pad20" style="margin-top:10px;">
		<form action="${ctx}/comment/query" method="post" id="searchForm" class="form-search form-inline breadcrumb">
			<input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
			<input class="form-control" placeholder="评论人" type="text" name="userName" value="${comment.userName}" />

			<input class="form-control" placeholder="内容" type="text" name="content" value="${comment.content}" />
			<select name="type" class="form-control">
				<option value="0">请选择类型</option>
				<option value="1" <c:if test="${comment.type==1}"> selected="selected" </c:if> >文章</option>
				<option value="2" <c:if test="${comment.type==2}"> selected="selected" </c:if> >课程</option>
			</select> 
			创建时间:
			<input placeholder="开始创建时间" name="beginCreateTime"
				   value="<fmt:formatDate value="${comment.beginCreateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" id="beginCreateTime" type="text"
				   readonly="readonly" style="width: 128px;" class="Wdate form-control mr0" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>-
			<input placeholder="结束创建时间" id="endCreateTime" name="endCreateTime" class="Wdate form-control"
				   value="<fmt:formatDate value="${comment.endCreateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" readonly="readonly" style="width: 128px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			<a  onclick="javascript:$('#searchForm').submit();" class="btn btn-primary" href="javascript:void(0)">
				<span class="ui-icon ui-icon-search"></span>
				查找评论
			</a>
			<a title="清空" onclick="javascript:$('#searchForm input:text').val('');$('#searchForm select').val(0);" class="btn btn-default"
				href="javascript:void(0)">
				<span class="ui-icon ui-icon-cancel"></span>
				清空
			</a>
		</form>
		<table cellspacing="0" cellpadding="0" class="fullwidth table table-bordered table-hover">
			<thead>
				<tr>
					<td align="center">
						id
					</td>
					<td align="center" style="width:8%;">评论人</td>
					<td align="center">类型</td>
					<td align="center">点赞</td>
					<td align="center">回复</td>
					<td align="center">创建时间</td>
					<td align="center" style="width:40%;">评论内容</td>
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
						<td align="center"><c:out value="${com.content}"></c:out></td>
						<td align="">
							<a href="${ctx}/comment/reply/info/${com.commentId}" class="btn btn-warning">修改</a>
							<a href="javascript:delcomment('${com.commentId}')" class="btn btn-danger">删除</a>
							<c:if test="${com.replyCount !=0}">
							<a href="${ctx}/comment/reply/query?pCommentId=${com.commentId}"  class="btn btn-info">回复列表</a>
							</c:if>
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