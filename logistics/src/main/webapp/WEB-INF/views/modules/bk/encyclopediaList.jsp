<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>百科知识管理</title>
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
		<li class="active"><a href="${ctx}/bk/encyclopedia/">百科知识列表</a></li>
		<shiro:hasPermission name="bk:encyclopedia:edit"><li><a href="${ctx}/bk/encyclopedia/form">百科知识添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="encyclopedia" action="${ctx}/bk/encyclopedia/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>百科词条：</label>
				<form:input path="title" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>百科内容：</label>
				<form:input path="content" htmlEscape="false" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>百科内容</th>
				<th style="width:130px;">操作信息</th>
				<shiro:hasPermission name="bk:encyclopedia:edit"><th style="width:100px;">操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="encyclopedia">
			<tr>
				<td>关键词：${encyclopedia.keywords}<br/>
					<a href="${ctx}/bk/encyclopedia/form?id=${encyclopedia.id}">
						${encyclopedia.title}
					</a><br/>
					${encyclopedia.content}
				</td>
				<td>
					创建：${encyclopedia.createBy.name}<br/>
					<fmt:formatDate value="${encyclopedia.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					<br/>
					修改：
					${encyclopedia.updateBy.name}<br/>
					<fmt:formatDate value="${encyclopedia.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bk:encyclopedia:edit"><td>
    				<a href="${ctx}/bk/encyclopedia/form?id=${encyclopedia.id}">修改</a>
					<a href="${ctx}/bk/encyclopedia/delete?id=${encyclopedia.id}" onclick="return confirmx('确认要删除该百科词条吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>