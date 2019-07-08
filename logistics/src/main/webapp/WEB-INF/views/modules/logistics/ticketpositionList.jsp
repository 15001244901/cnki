<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>铺位管理</title>
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
		<li class="active"><a href="${ctx}/logistics/ticketposition/">铺位列表</a></li>
		<shiro:hasPermission name="logistics:ticketposition:edit"><li><a href="${ctx}/logistics/ticketposition/form">铺位添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ticketposition" action="${ctx}/logistics/ticketposition/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>铺位名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>铺位名称</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="logistics:ticketposition:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ticketposition">
			<tr>
				<td><a href="${ctx}/logistics/ticketposition/form?id=${ticketposition.id}">
					${ticketposition.name}
				</a></td>
				<td>
					<fmt:formatDate value="${ticketposition.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ticketposition.remarks}
				</td>
				<shiro:hasPermission name="logistics:ticketposition:edit"><td>
    				<a href="${ctx}/logistics/ticketposition/form?id=${ticketposition.id}">修改</a>
					<a href="${ctx}/logistics/ticketposition/delete?id=${ticketposition.id}" onclick="return confirmx('确认要删除该铺位吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>