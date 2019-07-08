<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>标准管理管理</title>
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
		<li class="active"><a href="${ctx}/standard/yWStandard?category=${param.category}">${param.category eq 2?"质量体系":"国家标准"}列表</a></li>
		<shiro:hasPermission name="standard:yWStandard:edit"><li><a href="${ctx}/standard/yWStandard/form?category=${param.category}">添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="YWStandard" action="${ctx}/standard/yWStandard/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="category" name="category" type="hidden" value="${param.category}"/>
		<ul class="ul-form">
			<li><label>科目：</label>
				<form:select path="typesys" class="input-medium" cssStyle="width:200px;">
					<form:option value="" label=""/>
					<c:if test="${param.category eq 1}">
						<form:options items="${fns:getDictList('std_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</c:if>
					<c:if test="${param.category eq 2}">
						<form:options items="${fns:getDictList('std_type_zltx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</c:if>
				</form:select>
			</li>
			<li><label>标准号：</label>
				<form:input path="sno" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>中文名称：</label>
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
				<th width="150">标准号</th>
				<th width="200">中文名称</th>
				<th width="200">英文名称</th>
				<th width="40">年代号</th>
				<th width="60">标准状态</th>
				<th width="80">实施日期</th>
				<th width="60">有无文件</th>
				<shiro:hasPermission name="standard:yWStandard:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="yWStandard">
			<tr>
				<td><a href="${ctx}/standard/yWStandard/form?id=${yWStandard.id}">
					${yWStandard.sno}
				</a></td>
				<td>
					${yWStandard.name}
				</td>
				<td>
					${yWStandard.enname}
				</td>
				<td>
					${yWStandard.yearno}
				</td>
				<td>
					${yWStandard.status}
				</td>
				<td>
					<fmt:formatDate value="${yWStandard.executedate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${yWStandard.hasfile}
				</td>
				<shiro:hasPermission name="standard:yWStandard:edit"><td>
					<a href="${ctxRoot}/page/standard/tour.html?id=${yWStandard.id}" target="_blank">前台浏览</a>
					<a href="${ctx}/standard/yWStandard/form?id=${yWStandard.id}&category=${param.category}">修改</a>
					<a href="${ctx}/standard/yWStandard/delete?id=${yWStandard.id}" onclick="return confirmx('确认要删除该标准管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>