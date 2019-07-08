<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收货地址管理</title>
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
		<li class="active"><a href="${ctx}/logistics/goodaddr/">收货地址列表</a></li>
		<shiro:hasPermission name="logistics:goodaddr:edit"><li><a href="${ctx}/logistics/goodaddr/form">收货地址添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="goodaddr" action="${ctx}/logistics/goodaddr/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>地址简称：</label>
				<form:input path="addr" htmlEscape="false" maxlength="60" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>地址简称</th>
				<th>所属组</th>
				<th>排序</th>
				<th>详细地址</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="logistics:goodaddr:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goodaddr">
			<tr>
				<td><a href="${ctx}/logistics/goodaddr/form?id=${goodaddr.id}">
					${goodaddr.addr}
				</a></td>
				<td>
					${fns:getDictLabel(goodaddr.wlgroup, 'dic_wl_group', '')}
				</td>
				<td>
					${goodaddr.sort}
				</td>
				<td>
					${goodaddr.addrdesc}
				</td>
				<td>
					<fmt:formatDate value="${goodaddr.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${goodaddr.remarks}
				</td>
				<shiro:hasPermission name="logistics:goodaddr:edit"><td>
    				<a href="${ctx}/logistics/goodaddr/form?id=${goodaddr.id}">修改</a>
					<a href="${ctx}/logistics/goodaddr/delete?id=${goodaddr.id}" onclick="return confirmx('确认要删除该收货地址吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>