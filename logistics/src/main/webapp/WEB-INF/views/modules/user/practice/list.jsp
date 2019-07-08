<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>模拟练习管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/user/practice/">模拟练习列表</a></li>
		<shiro:hasPermission name="user:userPractice:edit"><li><a href="${ctx}/user/practice/form">模拟练习添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="userPractice" action="${ctx}/user/practice/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>试卷名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>试卷名称</th>
				<shiro:hasPermission name="user:userPractice:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userPractice">
			<tr>
				<td><a href="${ctx}/user/practice/form?id=${userPractice.id}">
					${userPractice.name}
				</a></td>
				<shiro:hasPermission name="user:userPractice:edit"><td>
    				<a href="${ctx}/user/practice/form?id=${userPractice.id}">修改</a>
					<a href="${ctx}/user/practice/delete?id=${userPractice.id}" onclick="return confirmx('确认要删除该模拟练习吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>