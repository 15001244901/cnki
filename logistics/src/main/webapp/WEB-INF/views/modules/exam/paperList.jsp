<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试卷管理</title>
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
		<li class="active"><a href="${ctx}/exam/paper?category=${param.category}">试卷列表</a></li>
		<shiro:hasPermission name="exam:paper:edit"><li><a href="${ctx}/exam/paper/form?category=${param.category}">试卷添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="paper" action="${ctx}/exam/paper/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="category" name="category" type="hidden" value="${param.category}"/>
		<ul class="ul-form">
			<li><label>试卷名称：</label>
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
				<th>试卷名称</th>
				<th>试卷状态</th>
				<th>开考时间</th>
				<th>结束时间</th>
				<th>考试时长</th>
				<th>卷面总分</th>
				<th>及格分数</th>
				<th>创建人</th>
				<th>展现形式</th>
				<shiro:hasPermission name="exam:paper:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="paper">
			<tr>
				<td><a href="${ctx}/exam/paper/form?id=${paper.id}&category=${paper.category}">
					${paper.name}
				</a></td>
				<td>
					${fns:getDictLabel(paper.status, 'dic_exam_paper_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${paper.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${paper.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${paper.duration}
				</td>
				<td>
					${paper.totalscore}
				</td>
				<td>
					${paper.passscore}
				</td>
				<td>
					${paper.createBy.name}<br/>
					<fmt:formatDate value="${paper.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(paper.showmode, 'dic_exam_paper_showmode', '')}
				</td>
				<shiro:hasPermission name="exam:paper:edit"><td>
					<a href="${ctx}/exam/paper/detail?id=${paper.id}">配置</a>
					<c:if test="${param.category ne 2}">
					<a href="${ctx}/exam/examHistory/list/${paper.id}">考试详情</a>
					</c:if>
    				<a href="${ctx}/exam/paper/form?id=${paper.id}&category=${paper.category}">修改</a>
					<a href="${ctx}/exam/paper/delete?id=${paper.id}&category=${paper.category}" onclick="return confirmx('确认要删除该试卷吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>