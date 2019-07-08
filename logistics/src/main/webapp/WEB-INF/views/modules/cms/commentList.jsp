<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="cnname">数据</c:set>
<c:choose>
	<c:when test="${param.ctype eq '2'}">
		<c:set var="cnname">笔记</c:set>
	</c:when>
	<c:when test="${param.ctype eq '3'}">
		<c:set var="cnname">纠错</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="cnname">评论</c:set>
	</c:otherwise>
</c:choose>
<html>
<head>
	<title>评论管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function view(href){
			top.$.jBox.open('iframe:'+href,'查看详情',$(top.document).width()-220,$(top.document).height()-180,{
				buttons:{"关闭":true},
				loaded:function(h){
					//$(".jbox-content", top.document).css("overflow-y","hidden");
					//$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
				}
			});
			return false;
		}
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
		<li class="active"><a href="${ctx}/cms/comment/">${cnname}列表</a></li><%--
		<shiro:hasPermission name="cms:comment:edit"><li><a href="${ctx}/cms/comment/form?id=${comment.id}">评论添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="comment" action="${ctx}/cms/comment/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>数据类型：</label>
		<select name="ctype" style="width:100px;">
			<option value="">不限</option>
			<option value="1" ${param.ctype eq '1'?"selected":""}>文章评论</option>
			<option value="2" ${param.ctype eq '2'?"selected":""}>试题笔记</option>
			<option value="3" ${param.ctype eq '3'?"selected":""}>试题纠错</option>
		</select>
		<label>内容：</label><form:input path="content" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
		<label>状态：</label><form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" />
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-bordered table-condensed">
		<thead>
		<tr>
			<th>类型</th>
			<th>${cnname}内容</th>
			<c:choose>
			<c:when test="${param.ctype eq '1'}">
			<th>文档标题</th>
			</c:when>
			<c:otherwise>
			<th>针对试题</th>
			</c:otherwise>
			</c:choose>
			<th>记录人</th>
			<th>IP</th>
			<th>记录时间</th>
			<th nowrap="nowrap">操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="comment">
			<tr>
				<td>
					<c:if test="${comment.ctype eq '1'}">文章评论</c:if>
					<c:if test="${comment.ctype eq '2'}">试题笔记</c:if>
					<c:if test="${comment.ctype eq '3'}">试题纠错</c:if>
				</td>
				<td><a href="javascript:" onclick="$('#c_${comment.id}').toggle()">${fns:abbr(fns:replaceHtml(comment.content),40)}</a></td>
				<c:choose>
					<c:when test="${param.ctype eq '1'}">
						<td><a href="${pageContext.request.contextPath}${fns:getFrontPath()}/view-${comment.category.id}-${comment.contentId}${fns:getUrlSuffix()}" title="${comment.title}" onclick="return view(this.href);">${fns:abbr(comment.title,40)}</a></td>
					</c:when>
					<c:otherwise>
						<td><a href="${ctxRoot}/page/usercenter/cms_question.html?id=${comment.qid}" title="" onclick="return view(this.href);">查看</a></td>
					</c:otherwise>
				</c:choose>

				<td>${comment.name}</td>
				<td>${comment.ip}</td>
				<td><fmt:formatDate value="${comment.createDate}" type="both"/></td>
				<td><shiro:hasPermission name="cms:comment:edit">
					<c:if test="${comment.delFlag ne '2'}"><a href="${ctx}/cms/comment/delete?id=${comment.id}${comment.delFlag ne 0?'&isRe=true':''}" 
						onclick="return confirmx('确认要${comment.delFlag ne 0?'恢复审核':'删除'}该审核吗？', this.href)">${comment.delFlag ne 0?'恢复审核':'删除'}</a></c:if>
					<c:if test="${comment.delFlag eq '2'}"><a href="${ctx}/cms/comment/save?id=${comment.id}">审核通过</a></c:if></shiro:hasPermission>
				</td>
			</tr>
			<tr id="c_${comment.id}" style="background:#fdfdfd;display:none;"><td colspan="6">${fns:replaceHtml(comment.content)}</td></tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
