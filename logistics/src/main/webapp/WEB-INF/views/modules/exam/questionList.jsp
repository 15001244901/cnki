<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试题管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//将填空题的宏替换为下划线
			$('.questionContent').each(function(i,e){
				$(e).html($(e).html().replace(/\[BlankArea[A-Za-z0-9]+\]/g,'<u style="letter-spacing:60px;">&nbsp;</u>'));
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			return false;
		}

		function showStdInfo(obj){
			var that = $('#'+$(obj).data('ref'));
			var text = that.data('value');
			if(text&&text.indexOf(',')>=0){
				text = text.split(',').join('<br/>');
			}
			that.html(text);
			that.toggle();
			$(obj).text(that.css('display')=='none'?'查看':'隐藏');
		}
	</script>
	<style type="text/css">
		#contentTable th , #contentTable td {
			text-align: center;
		}
	</style>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/exam/question/">试题列表</a></li>
	<shiro:hasPermission name="exam:question:edit"><li><a href="${ctx}/exam/question/form">试题添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="question" action="${ctx}/exam/question/" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>关键字：</label>
			<form:input path="qKeyword" htmlEscape="false" maxlength="300" class="input-medium" cssStyle="width:130px;"/>
		</li>
		<li><label>科目：</label>
			<form:select path="subject" class="input-medium" cssStyle="width:130px;">
				<form:option value="" label="不限"/>
				<form:options items="${fns:getDictList('dic_exam_questionsubject')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>题型：</label>
			<form:select path="qType" class="input-medium" cssStyle="width:80px;">
				<form:option value="" label="不限"/>
				<form:options items="${fns:getDictList('dic_exam_questiontype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>难度：</label>
			<form:select path="qLevel" class="input-medium" cssStyle="width:80px;">
				<form:option value="" label="不限"/>
				<form:options items="${fns:getDictList('dic_exam_questionlevel')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>审批状态：</label>
			<form:select path="qStatus" class="input-medium" cssStyle="width:80px;">
				<form:option value="" label="不限"/>
				<form:options items="${fns:getDictList('dic_exam_questionstatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-success" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th style="width:80px;">所属科目</th>
		<th style="width:80px;">知识点</th>
		<th style="width:60px;">试题类型</th>
		<th style="width:60px;">试题难度</th>
		<th style="width:60px;">试题状态</th>
		<th style="width:60px;">依据标准</th>
		<th>试题提干</th>
		<th style="width:130px;">创建人</th>
		<th style="width:130px;">最后修改人</th>
		<shiro:hasPermission name="exam:question:edit"><th style="width:100px;">操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="question">
		<tr>
			<td>
					${fns:getDictLabel(question.subject, 'dic_exam_questionsubject', '')}
			</td>
			<td>
					${fns:getDictLabel(question.topic, 'dic_exam_questiontopic', '')}
			</td>
			<td>
					${fns:getDictLabel(question.QType, 'dic_exam_questiontype', '')}
			</td>
			<td>
					${fns:getDictLabel(question.QLevel, 'dic_exam_questionlevel', '')}
			</td>
			<td>
					${fns:getDictLabel(question.QStatus, 'dic_exam_questionstatus', '')}
			</td>
			<td style="text-align:left">
				<button class="btn btn-small btn-default btn-yjbz" data-ref="yjbz_${question.id}" onclick="showStdInfo(this)">查看</button>
				<div id="yjbz_${question.id}" style="width:200px;display:none;" data-value="${fns:getStandardNames(question.QStdid, '1', '')}"></div>
			</td>
			<td class="questionContent" style="text-align: left">
				<a href="${ctx}/exam/question/form?id=${question.id}">${question.QContent}</a>
			</td>
			<td>
					${question.createBy.name}<br/>
				<fmt:formatDate value="${question.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			<td>
					${question.updateBy.name}<br/>
				<fmt:formatDate value="${question.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			<shiro:hasPermission name="exam:question:edit"><td>
				<%--<a href="${ctx}/exam/question/form?id=${question.id}">${question.QStatus eq '1'?'待定':'审核'}</a>--%>
				<a href="${ctx}/exam/question/form?id=${question.id}">修改</a>
				<a href="${ctx}/exam/question/delete?id=${question.id}" onclick="return confirmx('确认要删除该试题吗？', this.href)">删除</a>
				<%--<a href="/ywork/user/question/${question.id}/basket.jhtml?isbasket=${question.isbasket}&qtype=${question.QType}">${question.isbasket eq '0'?'加入试题蓝':'从试题篮移除'}</a>--%>
			</td></shiro:hasPermission>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>