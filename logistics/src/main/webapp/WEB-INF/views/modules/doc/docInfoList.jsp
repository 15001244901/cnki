<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文档维护管理</title>
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
		<li class="active"><a href="${ctx}/doc/docInfo/">文档维护列表</a></li>
		<c:if test="${not empty docInfo.directory and not empty docInfo.directory.id}">
		<shiro:hasPermission name="doc:docInfo:edit"><li><a href="${ctx}/doc/docInfo/form?doctype=${docInfo.doctype}&domain=${docInfo.domain}&directory.id=${docInfo.directory.id}">文档维护添加</a></li></shiro:hasPermission>
		</c:if>
	</ul>
	<form:form id="searchForm" modelAttribute="docInfo" action="${ctx}/doc/docInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input name="directory.id" type="hidden" value="${docInfo.directory.id}"/>
		<ul class="ul-form">
			<li><label>文档标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="300" class="input-medium"/>
			</li>
			<li><label>关键字：</label>
				<form:input path="keywords" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>文库分类</th>
				<th>所属科目</th>
				<th>文档标题</th>
				<c:if test="${docInfo.directory.dtype eq '3'}">
					<th>文档编号</th>
					<th>版次</th>
					<th>颁布时间</th>
				</c:if>
				<th>创建时间</th>
				<th>更新时间</th>
				<%--<th>关键字</th>--%>
				<%--<th>文档大小</th>--%>
				<shiro:hasPermission name="doc:docInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="docInfo">
			<tr>
				<td>
					${fns:getDictLabel(docInfo.doctype, 'dic_docinfo_doctype', '')}
				</td>
				<td>
					${fns:getDictLabel(docInfo.domain, 'dic_domain', '')}
				</td>
				<td><a href="${ctx}/doc/docInfo/form?id=${docInfo.id}">
						${docInfo.title}
				</a></td>
				<c:if test="${docInfo.doctype eq '3'}">
					<td>${docInfo.fileno}</td>
					<td>${docInfo.edition}</td>
					<td><fmt:formatDate value="${docInfo.publicdate}" pattern="yyyy-MM-dd"/></td>
				</c:if>
				<td>
					${docInfo.createBy.name}<br/>
					<fmt:formatDate value="${docInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${docInfo.updateBy.name}<br/>
					<fmt:formatDate value="${docInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<%--<td>--%>
					<%--${docInfo.keywords}--%>
				<%--</td>--%>
				<%--<td>--%>
					<%--${docInfo.filesize}--%>
				<%--</td>--%>
				<shiro:hasPermission name="doc:docInfo:edit"><td>
					<a href="${ctxRoot}/page/library/${docInfo.doctype eq '1'?'knowledge_detail':'inside_detail'}.html?id=${docInfo.id}" target="_blank">前台浏览</a>
    				<a href="${ctx}/doc/docInfo/form?id=${docInfo.id}">修改</a>
					<a href="${ctx}/doc/docInfo/delete?id=${docInfo.id}" onclick="return confirmx('确认要删除该文档维护吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>