<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>题库管理</title>
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
	<style type="text/css">
		#contentTable th , #contentTable td {
			text-align: center;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/exam/questionDB/">题库列表</a></li>
		<shiro:hasPermission name="exam:questionDB:edit"><li><a href="${ctx}/exam/questionDB/form">题库添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="questionDB" action="${ctx}/exam/questionDB/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>题库名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-default" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>题库名称</th>
				<th>题库图标</th>
				<th>题库状态</th>
				<th>试题数量</th>
				<th>创建人</th>
				<th>最后修改人</th>
				<shiro:hasPermission name="exam:questionDB:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="questionDB">
			<tr>
				<td><a href="${ctx}/exam/questionDB/form?id=${questionDB.id}">
					${questionDB.name}
				</a></td>
				<td>
					${questionDB.logo}
				</td>
				<td>
					${fns:getDictLabel(questionDB.status, 'dic_exam_questiondb_status', '')}
				</td>
				<td style="font-size: 20px;font-weight: bold;">
					${questionDB.questionNums}
				</td>
				<td>
					${questionDB.createBy.name}<br/>
					<fmt:formatDate value="${questionDB.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${questionDB.updateBy.name}<br/>
					<fmt:formatDate value="${questionDB.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="exam:questionDB:edit"><td>
    				<a href="${ctx}/exam/questionDB/form?id=${questionDB.id}">修改</a>
					<a href="${ctx}/exam/questionDB/delete?id=${questionDB.id}" onclick="return confirmx('确认要删除该题库吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>