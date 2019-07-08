<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考试记录管理</title>
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
	<form:form id="searchForm" modelAttribute="examHistory" action="${ctx}/exam/examHistory/${pid}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>考生姓名</th>
				<th>所属部门</th>
				<th>工号</th>
				<th>考试时间</th>
				<th>耗时(分钟)</th>
				<th>批改状态</th>
				<th>得分</th>
				<th>IP地址</th>
				<shiro:hasPermission name="exam:examHistory:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="examHistory">
			<tr>
				<td>${examHistory.uname}</td>
				<td>${examHistory.deptname}</td>
				<td>${examHistory.uno}</td>
				<td><fmt:formatDate value="${examHistory.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/><br/>
					<fmt:formatDate value="${examHistory.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${examHistory.timecost}</td>
				<td>${examHistory.status}</td>
				<td>${examHistory.score}</td>
				<td>${examHistory.ip}</td>
				<shiro:hasPermission name="exam:examHistory:edit"><td>
    				<a href="${ctx}/exam/examHistory/form?id=${examHistory.id}">详情</a>
					<a href="${ctx}/exam/examHistory/delete?id=${examHistory.id}" onclick="return confirmx('确认要删除该考试记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>