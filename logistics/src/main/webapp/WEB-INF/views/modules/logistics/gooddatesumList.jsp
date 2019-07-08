<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货物信息管理test1</title>
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
		<li class="active"><a href="${ctx}/logistics/gooddatesum/">货物信息列表test1</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="gooddatesum" action="${ctx}/logistics/gooddatesum/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>发货日期：</label>
				<form:input path="months" htmlEscape="false" maxlength="60" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>发货日期1</th>
				<th>发放小费1</th>
				<th>物包件数1</th>
				<th>已收费用1</th>
				<th>对付费用1</th>
				<th>贷款金额1</th>
				<th>垫付金额1</th>
				<th>保价额度1</th>
				<th>手续费1</th>
				<th>保价费1</th>
				<th>退货金额1</th>
				<th>少收金额1</th>
				
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="gooddatesum">
			<tr>
				<td>
					${gooddatesum.months}
				</td>
				<td>
					${gooddatesum.gffxf}
				</td>
				<td>
					${gooddatesum.gwbjs}
				</td>
				<td>
					${gooddatesum.gysje}
				</td>
				<td>
					${gooddatesum.gdfje}
				</td>
				<td>
					${gooddatesum.gdkje}
				</td>
				<td>
					${gooddatesum.gdianfu}
				</td>
				<td>
					${gooddatesum.gbjed}
				</td>
				<td>
					${gooddatesum.gsxf}
				</td>
				<td>
					${gooddatesum.gbjf}
				</td>
				<td>
					${gooddatesum.gthje}
				</td>
				<td>
					${gooddatesum.gssje}
				</td>
			
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>