<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!doctype html>
<html>
<head>
	<title>考试记录</title>
	<meta name="decorator" content="default"/>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/layer/layer.js" type="text/javascript"></script>
	<script>
		function deleteRecordComfirm(){
			var v = window.confirm('删除操作无法恢复，您确认要删除吗？');
			if(v){
				v = window.confirm('删除操作无法恢复，请再次确认是否进行删除操作。');
			}
			return v;
		}

		function doDownLoadHistory(pid){
			$.ajax({
				type: "POST",
				url: "${tm_base}system/paper/history/export.do",
				data: {"pid":pid, "t":Math.random()},
				dataType: "json",
				success: function(ret){
					if("ok" == ret["code"]){
						window.open("${tm_base}files/export/" + ret["data"]);
					}else if("nodata" == ret["code"]){
						alert('没有数据可以导出');
					}else{
						alert('导出数据发送异常，请稍后再试');
					}
				},
				error:function(){
					alert('系统忙，请稍后再试');
				}
			}); 
		}

		function loadHistoryDetail(pid, eid, uid){
			if(baseutil.isNull(pid) || baseutil.isNull(eid) || baseutil.isNull(uid)){
				alert("缺少参数. Parameters Required.");
				return;
			}
			layer.open({
				title: '考试详情',
				type: 2,
				area: ['900px', '600px'],
				maxmin:true,
				shadeClose: true,
				content: "${ctx}/exam/examHistory/detail?pid="+pid+"&eid="+eid+"&uid="+uid
			});
		}

		$(document).ready(function() {
			$('#btn-autocheck').click(function(e){
				$.ajax({
					url:ctx+'/exam/examHistory/autoCheck',
					dataType:'json',
					success:function(json){
						alert(json.msg);
					}
				});
			});
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

	<div class="tm_main">
    	
		<div class="tm_container">
			<ul class="tm_breadcrumb">
				<li><a href="">首页</a> <span class="divider">&gt;</span></li>
				<li><a href="">试卷管理</a> <span class="divider">&gt;</span></li>
				<li class="active">考试记录</li>
			</ul>
		</div>
        
        <div class="tm_container">
        	<table width="500" cellpadding="5" border="0" class="tm_table_form">
				<tr>
					<th width="100">试卷名称</th>
					<td>
						${paper.name}

						<c:choose>
							<c:when test="${paper.papertype == '0'}">(普通试卷)</c:when>
							<c:when test="${paper.papertype == '1'}">(<b>随机试卷</b>)</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>时间设定</th>
					<td><fmt:formatDate value="${paper.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/> -- <fmt:formatDate value="${paper.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr>
					<th>考试时长</th>
					<td><span class="tm_label">${paper.duration}</span> 分钟</td>
				</tr>
				<tr>
					<th>卷面总分</th>
					<td><span class="tm_label">${paper.totalscore}</span> &nbsp; (及格分数:${paper.passscore}) </td>
				</tr>
			</table>
        </div>

		<div class="tm_container">
			<form id="searchForm" action="${ctx}/exam/examHistory/${pid}" method="post">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="tm_searchbox">
					<table border="0" width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								&nbsp;
								关键字 :
								<input type="text" name="urealname" class="tm_txts" size="10" maxlength="20" value="${param.keywords}" style="margin-bottom:0px;width:100px;"/> &nbsp;

								<select class="tm_select" name="orderBy" style="margin-bottom:0px;width:100px;min-width:100px">
									<option value="id asc">排序方式</option>
									<option value="score desc" <c:if test="${param.orderBy == 'score desc'}">selected</c:if>>得分从高到底</option>
									<option value="score asc" <c:if test="${param.orderBy == 'score asc'}">selected</c:if>>得分从低到高</option>
									<option value="timecost desc" <c:if test="${param.orderBy == 'timecost desc'}">selected</c:if>>耗时从高到低</option>
									<option value="timecost asc" <c:if test="${param.orderBy == 'timecost asc'}">selected</c:if>>耗时从低到高</option>
									<option value="endtime desc" <c:if test="${param.orderBy == 'endtime desc'}">selected</c:if>>交卷从晚到早</option>
									<option value="endtime asc" <c:if test="${param.orderBy == 'endtime asc'}">selected</c:if>>交卷从早到晚</option>
								</select> &nbsp;

								<select class="validate[required] tm_select" name="office.id" style="margin-bottom:0px;width:100px">
									<option value="">所属部门</option>
									<c:forEach var="office" items="${offices}">
										<option value="${office.id}" <c:if test="${param['office.id'] == office.id}">selected</c:if>>${office.name}</option>
									</c:forEach>
								</select> &nbsp;


								<button class="btn btn-small btn-primary" type="submit">检索</button>

								<button class="btn btn-small btn-success" id="btn-autocheck">自动判断测试</button>
							</td>
							<td align="right">
								<c:set var="tm_total_records" value="${progress.testing+progress.wait+progress.checked}"></c:set>
								<c:set var="tm_checked_percent" value="${progress.checked * 100 /tm_total_records}"></c:set>

								<c:if test="${tm_total_records==0}">
									<c:set var="tm_checked_percent" value="0"></c:set>
								</c:if>

								<!--
							${progress.testing},
							${progress.wait},
							${progress.checked}
							-->

								<table width="230" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td>批改进度 : </td>
										<td>
											<div style="width:100px; height:15px; background:#ddd; font-size:1px">
												<div style="float:left; background:#0f0; width:${tm_checked_percent}px; font-size:1px; height:15px"></div>
											</div>
										</td>
										<td><fmt:formatNumber value="${tm_checked_percent}" pattern= "#0.00" />%</td>
										<td><a href="javascript:void(0);" onclick="javascript:window.location.reload();"><img src="${ctxStatic}/hsun/ywork/images/icos/reload.png" align="absmiddle"/></a></td>
									</tr>
								</table>
							</td>
							<td align="right" width="220">
								<img src="${ctxStatic}/hsun/ywork/images/icos/excel.png" align="absmiddle" border="0" />
								<a href="javascript:void(0);" onclick="doDownLoadHistory('${paper.id}');">导出数据</a>
								&nbsp;
								<img src="${ctxStatic}/hsun/ywork/images/icos/eraser.png" align="absmiddle" border="0" />
								<a href="${ctx}/exam/examHistory/clear/${paper.id}" onclick="return deleteRecordComfirm();">清空考试记录</a>
								&nbsp;
							</td>
						</tr>
					</table>

				</div>

				<jsp:useBean id="nowDate" class="java.util.Date" />
				<table width="100%" cellpadding="10" border="0" class="tm_table_list">
					<thead>
					<tr>
						<th>考生姓名</th>
						<th>所属部门</th>
						<th>工号</th>
						<th>考试时间</th>
						<th>耗时(分钟)</th>
						<th>批改状态</th>
						<th>得分</th>
						<th>IP地址</th>
						<th>操作</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="exam" items="${page.list}">

						<c:set var="itimeleft" value="1" />
						<tr>
							<td>${exam.uname}<br/>${exam.urealname}</td>
							<td>${exam.office.name}</td>
							<td>${exam.uno} </td>
							<td>
								<fmt:formatDate value="${exam.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/><br/>
								<c:choose>
									<c:when test="${exam.status == '2'}">
										<fmt:formatDate value="${exam.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</c:when>
									<c:when test="${exam.status == '1'}">
										<fmt:formatDate value="${exam.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</c:when>
									<c:otherwise>
										<font color="gray">--</font>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${empty exam.timecost}">
										<c:set var="interval" value="${nowDate.time - exam.starttime.time}" />
										<c:set var="itimeleft" value="${paper.duration - interval/1000/60}" />

										<c:choose>
											<c:when test="${itimeleft<0}"><font color="red">超时未提交</font></c:when>
											<c:otherwise>
												<span class="tm_label" style="color:#aaa"><fmt:formatNumber value= "${interval/1000/60}" pattern= "#0.0" /></span>
												分钟
											</c:otherwise>
										</c:choose>

									</c:when>
									<c:otherwise>
										<span class="tm_label">${exam.timecost}</span>
										分钟
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
								<c:when test="${itimeleft<0}"><font color="red">超时未提交</font></c:when>
								<c:otherwise>
								<c:choose>
								<c:when test="${exam.status == '0'}"><font color="gray">进行中</font></c:when>
								<c:when test="${exam.status == '1'}"><i>等待批改<i></c:when>
									<c:when test="${exam.status == '2'}">已经批改</c:when>
								<c:otherwise><font color="red">批改失败</font></c:otherwise>
								</c:choose>
								</c:otherwise>
								</c:choose>


							</td>
							<td>
								<c:choose>
									<c:when test="${exam.status == '2'}">
										<c:choose>
											<c:when test="${exam.score >= paper.passscore}"><span class="tm_label">${exam.score}</span></c:when>
											<c:otherwise><span class="tm_label" style="color:red">${exam.score}</span></c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<font color="gray">--</font>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${exam.ip}</td>
							<td>
								<c:choose>
									<c:when test="${exam.status == '2'}">
										<a href="javascript:void(0)" onclick="javascript:loadHistoryDetail('${paper.id}','${exam.id}','${exam.uid}');">详情</a> |
										<a href="${ctx}/exam/examHistory/delete?id=${exam.id}" onclick="return deleteRecordComfirm();">删除</a>
									</c:when>
									<c:otherwise>
										<font color="gray">详情</font> |
										<a href="${ctx}/exam/examHistory/delete?id=${exam.id}" onclick="return deleteRecordComfirm();">删除</a>
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
