<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订票订单管理</title>
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
		<li class="active"><a href="${ctx}/logistics/ticketorder/">订票订单列表</a></li>
		<shiro:hasPermission name="logistics:ticketorder:edit"><li><a href="${ctx}/logistics/ticketorder/form">订票订单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ticketorder" action="${ctx}/logistics/ticketorder/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>车号：</label>
				<form:input path="tno" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>乘车人姓名：</label>
				<form:input path="tname" htmlEscape="false" maxlength="60" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>车号</th>
				<th>乘车时间</th>
				<th>乘车人姓名</th>
				<th>联系方式</th>
				<th>铺位</th>
				<th>更新时间</th>
				<shiro:hasPermission name="logistics:ticketorder:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ticketorder">
			<tr>
				<td><a href="${ctx}/logistics/ticketorder/form?id=${ticketorder.id}">
					${ticketorder.tno}
				</a></td>
				<td>
					<fmt:formatDate value="${ticketorder.tdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ticketorder.tname}
				</td>
				<td>
					${ticketorder.tlink}
				</td>
				<td>
					${ticketorder.tposition.name}
				</td>
				<td>
					<fmt:formatDate value="${ticketorder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="logistics:ticketorder:edit"><td>
    				<a href="${ctx}/logistics/ticketorder/form?id=${ticketorder.id}">修改</a>
					<a href="${ctx}/logistics/ticketorder/delete?id=${ticketorder.id}" onclick="return confirmx('确认要删除该订票订单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>