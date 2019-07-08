<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试卷管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/exam/paper?category=${param.category}">试卷列表</a></li>
		<li class="active"><a href="${ctx}/exam/paper/form?id=${paper.id}&category=${param.category}">试卷<shiro:hasPermission name="exam:paper:edit">${not empty paper.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="exam:paper:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="paper" action="${ctx}/exam/paper/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input id="category" name="category" type="hidden" value="${param.category}"/>
		<input id="data" name="data" type="hidden" value="${param.data}"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">试卷名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">试卷分类：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:input path="cid" htmlEscape="false" maxlength="64" class="input-xlarge "/>--%>
			<%--</div>--%>
		<%--</div>--%>
		<c:if test="${param.category eq 1}">
		<div class="control-group">
			<label class="control-label">试卷状态：</label>
			<div class="controls">
				<form:radiobuttons path="status" items="${fns:getDictList('dic_exam_paper_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		</c:if>
		<c:if test="${param.category eq 2}">
			<input id="status" name="status" type="hidden" value="0"/>
		</c:if>
		<div class="control-group">
			<label class="control-label">是否完成：</label>
			<div class="controls">
				<form:radiobuttons path="iscomplete" items="${fns:getDictList('dic_exam_paper_iscomplete')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开考时间：</label>
			<div class="controls">
				<input name="starttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${paper.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				<input name="endtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${paper.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试时长：</label>
			<div class="controls">
				<form:input path="duration" htmlEscape="false" maxlength="5" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成绩公布时间：</label>
			<div class="controls">
				<input name="showtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${paper.showtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卷面总分：</label>
			<div class="controls">
				<form:input path="totalscore" htmlEscape="false" maxlength="5" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">及格分数：</label>
			<div class="controls">
				<form:input path="passscore" htmlEscape="false" maxlength="5" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">试题排列顺序：</label>
			<div class="controls">
				<form:radiobuttons path="ordertype" items="${fns:getDictList('dic_exam_paper_qorder')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">试卷类型：</label>
			<div class="controls">
				<form:radiobuttons path="papertype" items="${fns:getDictList('dic_exam_paper_type')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
				<div class="alert alert-warning">
					普通试卷：需人工逐一选题；
					<br/>随机试卷：卷面试题不确定，各考试卷面试题开考时随机生成；
					<br/>智能组卷：根据选定条件，从题库中智能选题，并可对单个试题进行微调。各考生卷面试题一致。
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">试卷说明：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" rows="4" class="input-xxlarge "/>
			</div>
		</div>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">试题设置：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:textarea path="data" htmlEscape="false" rows="4" class="input-xxlarge "/>--%>
			<%--</div>--%>
		<%--</div>--%>
		<div class="control-group">
			<label class="control-label">公布答案：</label>
			<div class="controls">
				<form:radiobuttons path="showkey" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">展现形式：</label>
			<div class="controls">
				<form:radiobuttons path="showmode" items="${fns:getDictList('dic_exam_paper_showmode')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<c:if test="${param.category ne 2}">
		<div class="control-group">
			<label class="control-label">考试部门：</label>
			<div class="controls">
				<form:checkboxes path="departments" items="${offices}" itemLabel="name" itemValue="id" htmlEscape="false" class=""/>
			</div>
		</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="exam:paper:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>