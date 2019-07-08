<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<html>
<head>
	<title>模拟练习管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>知识点</th>
				<th>已做/总题数</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${data}" var="row">
			<tr>
				<td>
					${row.subjectname}
				</td>
				<td>
					${row.unum}/${row.qnum}
				</td>

				<td>
    				<a href="${basectx}/user/practice/newdetail?ptype=${param.ptype}&subject=${row.subject}&subjectname=${row.subjectname}">开始练习</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>