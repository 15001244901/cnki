<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<!doctype html>
<html>
<head>
	<title>我的考试</title>
	<%@include file="/WEB-INF/views/include/head.jsp"%>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/layer/layer.js" type="text/javascript"></script>

	<script type="text/javascript">
		var tm = {
			startExam : function(obj, pid){
				var _tr = $(obj).parent().parent();
				var _p_name = _tr.children("td").eq(0).text();
				var _p_time = _tr.children("td").eq(2).text();
				var _p_totalscore = _tr.children("td").eq(4).text();
				var _p_passscore = _tr.children("td").eq(5).text();
				

				var html = [];
				html.push('<div style="margin:20px">');
				html.push('	<p style="line-height:20px">确定进入试卷并开始考试吗？</p>');
				
				html.push('	<table style="margin:0 auto; width:350px" border="0" cellpadding="0" cellspacing="0">');
				html.push('	<tr>');
				html.push('		<td width="80"><img src="${ctxStatic}/hsun/ywork/images/paper_pencil.png" width="60" /></td>');
				html.push('		<td><p><b>试卷名称</b>：'+_p_name+'<p>');
				html.push('			<p><b>考试时长</b>：'+_p_time+'<p>');
				html.push('			<p><b>卷面总分</b>：'+_p_totalscore+'<p>');
				html.push('			<p><b>及格风俗</b>：'+_p_passscore+'<p>');
				html.push('		</td>');
				html.push('	</tr>');
				html.push('</table>');

				html.push('<p style="text-align:center; margin-top:30px">');
				html.push('<button class="tm_btn tm_btn_primary" type="button" onclick="tm.joinExam(\''+pid+'\')">确定</button>');
				html.push('</p>');

				html.push('</div>');

				layer.open({
				  type: 1,
				  title: '开始考试',
				  shadeClose: true,
				  shade: 0.8,
				  area: ['450px', '310px'],
				  content: html.join("")
				}); 

				return false;
			},
			joinExam : function(pid){
				window.location.href="${basectx}/user/paper/startExam?pid="+pid;
			}
		};

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
				<li><a href="common/welcome.thtml">首页</a> <span class="divider">&gt;</span></li>
				<li class="active">我的试卷</li>
			</ul>
		</div>
        
        <div class="tm_container">
        	<div class="tm_navtitle">
				<h1>我的试卷</h1>
                <span>我的试卷，请选择以下列表中我需要参加的考试。</span>
            </div>
        </div>
        
        <div class="tm_container">
			<form action="${basectx}/user/paper/list" method="get">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="tm_searchbox">
				试卷名称 :
				<input type="text" name="name" class="tm_txts" size="10" maxlength="20" value="${params.name}" /> &nbsp;

				试卷分类 :
				<select class="tm_select" name="cid" style="min-width:150px">
					<option value="">全部</option>
				</select> &nbsp;

				<button class="tm_btns" type="submit">查询</button>
			</div>

        	<table width="100%" cellpadding="10" border="0" class="tm_table_list">
            	<thead>
                	<tr>
                        <th>试卷名称</th>
                    	<th>时间设定</th>
                        <th>考试时长</th>
                        <th>试卷类型</th>
                        <th>卷面总分</th>
                        <th>及格分数</th>
                        <th>创建人</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach var="paper" items="${page.list}">
                	<tr>
						<td>${paper.name}</td>
                    	<td>
							<fmt:formatDate value="${paper.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/><br/><fmt:formatDate value="${paper.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td><span class="tm_label">${paper.duration}</span> 分钟</td>
						<td>
							<c:choose>
								<c:when test="${paper.papertype == '0'}">手动组卷</c:when>
								<c:when test="${paper.papertype == '1'}"><b>自动组卷（随机）</b></c:when>
								<c:when test="${paper.papertype == '2'}"><b>智能组卷（手动+自动）</b></c:when>
							</c:choose>
						</td>
						<td><span class="tm_label">${paper.totalscore}</span></td>
						<td><span class="tm_label">${paper.passscore}</span></td>
						<td>${paper.createBy.name}<br/><fmt:formatDate value="${paper.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
							<a href="javascript:void(0)" onclick="javascript:tm.startExam(this,'${paper.id}');">开始考试</a>
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
