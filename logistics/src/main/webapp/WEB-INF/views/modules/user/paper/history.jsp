<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<!doctype html>
<html>
<head>
	<title>考试记录</title>
	<%@include file="/WEB-INF/views/include/head.jsp"%>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>

  </head>
  
<body>

	<div class="tm_main">
    	
		<div class="tm_container">
			<ul class="tm_breadcrumb">
				<li><a href="#">首页</a> <span class="divider">&gt;</span></li>
				<li class="active">考试记录</li>
			</ul>
		</div>
        
        <div class="tm_container">
        	<div class="tm_navtitle">
				<h1>考试记录</h1>
                <span>请选择以下列表中我参加过的考试进行详情查看。</span>
            </div>
        </div>
        
        <div class="tm_container">
			<form action="${basectx}/user/paper/history" method="get">
			<div class="tm_searchbox">
				试卷名称 :
				<input type="text" name="papername" class="tm_txts" size="10" maxlength="20" value="${param.papername}" /> &nbsp;
				<button class="tm_btns" type="submit">搜索</button>
			</div>

        	<table width="100%" cellpadding="10" border="0" class="tm_table_list">
            	<thead>
                	<tr>
                        <th>试卷名称</th>
						<th>试卷状态</th>
                        <th>考试时长</th>
                    	<th>考试耗时</th>
                    	<th>考试时间</th>
                        <th>试卷类型</th>
                        <th>试卷得分</th>
                        <th>及格分数/卷面总分</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach var="exam" items="${page.list}">
                	<tr>
						<td>${exam.papername}</td>
						<td>
							<c:choose>
								<c:when test="${exam.status == '1'}"><font color="red">待批改</font></c:when>
								<c:when test="${exam.status == '2'}">已批改</c:when>
							</c:choose>
						</td>
                    	<td>${exam.paper.duration} 分钟</td>
						<td><b>${exam.timecost}</b> 分钟</td>
						<td>
							<fmt:formatDate value="${exam.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/><br/><fmt:formatDate value="${exam.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<c:choose>
								<c:when test="${exam.paper.papertype == '0'}">普通试卷</c:when>
								<c:when test="${exam.paper.papertype == '1'}"><b>随机试卷</b></c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${exam.showscore == 'y'}">
									<span class="tm_label">${exam.score}</span>
									<c:choose>
										<c:when test="${exam.score >= exam.paper.passscore}"><font color="green">及格</font></c:when>
										<c:otherwise><font color="red"><b>不及格</b></font></c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<font color="gray"><b>待公开</font>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${exam.paper.passscore} / ${exam.paper.totalscore}</td>
                        <td>
							<c:choose>
								<c:when test="${exam.showscore == 'y'}">
									<a href="${basectx}/user/paper/history_detail?id=${exam.id}&pid=${exam.paper.id}">详情</a>
								</c:when>
								<c:otherwise>
									<font color="gray">--</font>
								</c:otherwise>
							</c:choose>
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
