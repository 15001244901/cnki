<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>百科知识管理</title>
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
		<li><a href="${ctx}/bk/encyclopedia/">百科知识列表</a></li>
		<li class="active"><a href="${ctx}/bk/encyclopedia/form?id=${encyclopedia.id}">百科知识<shiro:hasPermission name="bk:encyclopedia:edit">${not empty encyclopedia.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bk:encyclopedia:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="encyclopedia" action="${ctx}/bk/encyclopedia/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">百科词条：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" class="input-xlarge required" style="width:600px;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关键字：</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" class="input-xlarge required" style="width:600px;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">百科内容：</label>
			<div class="controls">
				<script type="text/plain" id="content_script">${encyclopedia.content}</script>
				<textarea rows="4" maxlength="255" id="content" name="content" class="input-xxlarge  required">${encyclopedia.content}</textarea>
				<sys:ckeditor replace="content" uploadPath="/encyclopedia" height="100"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bk:encyclopedia:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>