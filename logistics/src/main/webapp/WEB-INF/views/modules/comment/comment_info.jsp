<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/comment/css/commentList.css">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
	<title>修改评论</title>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>评论列表</a></li>
	</ul>
	<form action="${ctx}/comment/reply/update" method="post" id="commentForm"  class="form-horizontal">
	<input type="hidden" name="commentId" value="${comment.commentId}">
	<div class="pad20">
		<table id="iscontainer">
			<tr>
				<td >
					<font color="red">*</font>评论人：
				</td>
				<td>
					${comment.userName }
				</td>
			</tr>
			<tr>
				<td>类型：</td>
				<td>
						<c:if test="${comment.type==1}">文章</c:if>
						<c:if test="${comment.type==2}">课程</c:if>
				</td>
			</tr>
			<tr>
				<td>点赞数：</td>
				<td>
					<input class="form-control" style="width: 100px;" type="text" value="${comment.praiseCount}" name="praiseCount">
				</td>
			</tr>
			<tr>
				<td>回复数：</td>
				<td>
					${comment.replyCount}
				</td>
			</tr>
			<tr>
				<td style="vertical-align: top;">评论内容：</td>
				<td>
					<textarea class="form-control" style="width: 400px;height: 100px;" type="text" value="" name="content"><c:out value="${comment.content}"></c:out></textarea>
				</td>
			</tr>
			<tr style="border:none;">
				<td></td>
				<td>
					<input onclick="history.go(-1)" class="btn btn-info" type="button" value="返回">
					<input  class="btn btn-primary" type="submit" value="提交">
				</td>
			</tr>
		</table>
	</div>
	</form>
</body>
</html>