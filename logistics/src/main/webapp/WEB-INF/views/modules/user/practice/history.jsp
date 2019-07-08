<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<!doctype html>
<html>
<head>
	<title>模拟练习记录</title>
	<%@include file="/WEB-INF/views/include/head.jsp"%>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>

	<script type="text/javascript">
		
	</script>

  </head>
  
<body>

	<div class="tm_main">
    	
		<div class="tm_container">
			<ul class="tm_breadcrumb">
				<li><a href="${ctx}/sys/user/info">首页</a> <span class="divider">&gt;</span></li>
				<li class="active">练习记录</li>
			</ul>
		</div>
        
        <div class="tm_container">
        	<div class="tm_navtitle">
				<h1>练习记录</h1>
                <span>我的练习记录，请选择相应的自测记录进行查看</span>
            </div>
        </div>
        
        <div class="tm_container">
			<form action="${basectx}/user/practice/history" method="get">
        	<table width="100%" cellpadding="10" border="0" class="tm_table_list">
            	<thead>
                	<tr>
                        <th>试卷名称</th>
                    	<th>卷面总分</th>
                        <th>考试得分</th>
                        <th>考试时间</th>
                        <th>耗时</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach var="paper" items="${page.list}">
                	<tr>
						<td>${paper.name}</td>
						<td><span class="tm_label">${paper.totalscore}</span></td>
						<td><span class="tm_label">${paper.userscore}</span></td>
						<td><fmt:formatDate value="${paper.testdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td><span class="tm_label">${paper.timecost}</span></td>
                        <td>
							<a href="${basectx}/user/practice/historydetail?id=${paper.id}">查看详情</a>
							<a href="${basectx}/user/practice/delete?id=${paper.id}" onclick="return window.confirm('删除操作无法恢复，您确定要删除吗？');">删除</a>
						</td>
                    </tr>
					</c:forEach>
                </tbody>
            </table>
			</form>
			<table width="100%" cellpadding="10" border="0" class="tm_table_list">
				<tfoot>
					<tr>
						<td><div class="pagination">${page}</div></td>
					</tr>
				</tfoot>
			</table>
        </div>
        
        
    </div>

</body>
</html>
