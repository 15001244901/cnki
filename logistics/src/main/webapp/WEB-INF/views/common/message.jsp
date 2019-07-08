<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>系统消息 - System Message</title>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
</head>
<body>

<table border="0" cellpadding="0" cellspacing="0" class="tm_message">
	<thead>
		<tr>
			<th colspan="2">系统消息</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td width="70" style="text-align:center">
				<c:choose>
					<c:when test="${message.success}">
						<img src="${ctxStatic}/hsun/ywork/images/success.png" />
					</c:when>
					<c:otherwise>
						<img src="${ctxStatic}/hsun/ywork/images/error.png" />
					</c:otherwise>
				</c:choose>
			</td>
			<td>
				<div style="padding:0 20px 20px 0; line-height:20px">${message.message }</div>
				<div>
					<c:forEach var="link" items="${message.urls }">
						<a href="${link.url }" <c:if test="${link.top}">target="_top"</c:if>>${link.title }</a> &nbsp;
					</c:forEach>
				</div>
			</td>
		</tr>
	</tbody>
</table>

</body>
</html>


