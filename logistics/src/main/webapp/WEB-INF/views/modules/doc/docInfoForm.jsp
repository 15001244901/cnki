<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文档维护管理</title>
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

		function fileOnlinePreview(url){
			$('#onlinePreviewForm input').eq(0).val(url);
			$('#onlinePreviewForm')[0].submit();
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/doc/docInfo/list?directory.id=${docInfo.directory.id}">文档维护列表</a></li>
		<li class="active"><a href="${ctx}/doc/docInfo/form?id=${docInfo.id}&doctype=${docInfo.doctype}&domain=${docInfo.domain}&directory.id=${docInfo.directory.id}">文档维护<shiro:hasPermission name="doc:docInfo:edit">${not empty docInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="doc:docInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="docInfo" action="${ctx}/doc/docInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="directory.id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">文库分类：</label>
			<div class="controls">
				<form:select path="doctype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('dic_docinfo_doctype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所属科目：</label>
			<div class="controls">
				<form:select path="domain" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('dic_domain')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文档标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="300" class="input-xlarge "/>
			</div>
		</div>
		<c:if test="${docInfo.doctype eq '3'}">
			<div class="control-group">
				<label class="control-label">文档编号：</label>
				<div class="controls">
					<form:input path="fileno" htmlEscape="false" maxlength="300" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">版次：</label>
				<div class="controls">
					<form:input path="edition" htmlEscape="false" maxlength="300" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">颁布日期：</label>
				<div class="controls">
					<input name="publicdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
						   value="<fmt:formatDate value="${docInfo.publicdate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">摘要：</label>
			<div class="controls">
				<form:textarea path="summary" htmlEscape="false" rows="4" maxlength="300" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关键字：</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文档大小：</label>
			<div class="controls">
				<form:input path="filesize" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">展现方式：</label>
			<div class="controls">
				<form:radiobuttons path="showtype" items="${fns:getDictList('doc_showtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">正文：</label>
			<div class="controls">
				<form:hidden id="content" path="content" htmlEscape="false" maxlength="2000" class="input-xlarge"/>
				<sys:ckfinderpreview input="content" type="files" uploadPath="/doc/docInfo" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:hidden id="files" path="files" htmlEscape="false" maxlength="2000" class="input-xlarge"/>
				<sys:ckfinderpreview input="files" type="files" uploadPath="/doc/docInfo" selectMultiple="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">浏览量：</label>
			<div class="controls">
				<form:input path="pvcount" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下载量：</label>
			<div class="controls">
				<form:input path="downloadcount" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="doc:docInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<div style="display:none">
		<form id="onlinePreviewForm" action="${ctxRoot}/page/library/${docInfo.doctype eq '1'?'knowledge_detail':'inside_detail'}.html?id=${docInfo.id}" target="_blank" method="post">
			<input name="fileURL" type="hidden">
		</form>
	</div>
</body>
</html>