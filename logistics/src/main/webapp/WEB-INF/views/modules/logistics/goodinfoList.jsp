<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货物信息管理</title>
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
		<li class="active"><a href="${ctx}/logistics/goodinfo/">货物信息列表</a></li>
		<shiro:hasPermission name="logistics:goodinfo:edit"><li><a href="${ctx}/logistics/goodinfo/form">货物信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="goodinfo" action="${ctx}/logistics/goodinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>货单号：</label>
				<form:input path="gno" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>货单号</th>
				<th>收件人</th>
				<th>发货人</th>
				<th>发站</th>
				<th>收货地址</th>
				<th>发货日期</th>
				<th>送货费</th>
				<th>物包件数</th>
				<th>付款类型</th>
				<th>已收费用</th>
				<th>对付费用</th>
				<th>是否自提</th>
				<th>贷款金额</th>
				<th>垫付金额</th>
				<th>保价额度</th>
				<th>手续费</th>
				<th>保价费</th>
				<th>联系电话</th>
				<th>退货金额</th>
				<th>少收金额</th>
				<th>货物状态</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="logistics:goodinfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goodinfo">
			<tr>
				<td><a href="${ctx}/logistics/goodinfo/form?id=${goodinfo.id}">
					${goodinfo.gno}
				</a></td>
				<td>
					${goodinfo.gname}
				</td>
				<td>
					${goodinfo.gfhr}
				</td>
				<td>
					${goodinfo.gfz.label}
				</td>
				<td>
					${goodinfo.gaddr.addr}
				</td>
				<td>
					<fmt:formatDate value="${goodinfo.gfhrq}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${goodinfo.gffxf}
				</td>
				<td>
					${goodinfo.gwbjs}
				</td>
				<td>
					${fns:getDictLabel(goodinfo.gfklx, 'dic_wl_fklx', '')}
				</td>
				<td>
					${goodinfo.gysje}
				</td>
				<td>
					${goodinfo.gdfje}
				</td>
				<td>
					${fns:getDictLabel(goodinfo.gsfzt, 'yes_no', '')}
				</td>
				<td>
					${goodinfo.gdkje}
				</td>
				<td>
					${goodinfo.gdianfu}
				</td>
				<td>
					${goodinfo.gbjed}
				</td>
				<td>
					${goodinfo.gsxf}
				</td>
				<td>
					${goodinfo.gbjf}
				</td>
				<td>
					${goodinfo.glxdh}
				</td>
				<td>
					${goodinfo.gthje}
				</td>
				<td>
					${goodinfo.gssje}
				</td>
				<td>
					${fns:getDictLabel(goodinfo.gstatus, 'dic_wl_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${goodinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${goodinfo.remarks}
				</td>
				<shiro:hasPermission name="logistics:goodinfo:edit"><td>
    				<a href="${ctx}/logistics/goodinfo/form?id=${goodinfo.id}">修改</a>
					<a href="${ctx}/logistics/goodinfo/delete?id=${goodinfo.id}" onclick="return confirmx('确认要删除该货物信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>