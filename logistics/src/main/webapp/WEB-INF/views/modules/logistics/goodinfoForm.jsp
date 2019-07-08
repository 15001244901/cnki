<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货物信息管理</title>
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
		<li><a href="${ctx}/logistics/goodinfo/">货物信息列表</a></li>
		<li class="active"><a href="${ctx}/logistics/goodinfo/form?id=${goodinfo.id}">货物信息<shiro:hasPermission name="logistics:goodinfo:edit">${not empty goodinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="logistics:goodinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="goodinfo" action="${ctx}/logistics/goodinfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">数据来源：</label>
			<div class="controls">
				<form:radiobuttons path="datatype" items="${fns:getDictList('dic_wl_datatype')}" itemLabel="label" itemValue="value" htmlEscape="false" class="" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否已读：</label>
			<div class="controls">
				<form:radiobuttons path="isread" items="${fns:getDictList('dic_wl_isread')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货单号：</label>
			<div class="controls">
				<form:input path="gno" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收件人：</label>
			<div class="controls">
				<form:input path="gname" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发货人：</label>
			<div class="controls">
				<form:input path="gfhr" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发站：</label>
			<div class="controls">
				<form:radiobuttons path="gfz.value" items="${fns:getDictList('dic_wl_fz')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货地址：</label>
			<div class="controls">
				<form:select path="gaddr.id" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getGoodaddrList()}" itemLabel="addr" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发货日期：</label>
			<div class="controls">
				<input name="gfhrq" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${goodinfo.gfhrq}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">送货费：</label>
			<div class="controls">
				<form:input path="gffxf" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">物包件数：</label>
			<div class="controls">
				<form:input path="gwbjs" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">付款类型：</label>
			<div class="controls">
				<form:radiobuttons path="gfklx" items="${fns:getDictList('dic_wl_fklx')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">已收费用：</label>
			<div class="controls">
				<form:input path="gysje" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">对付费用：</label>
			<div class="controls">
				<form:input path="gdfje" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否自提：</label>
			<div class="controls">
				<form:radiobuttons path="gsfzt" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">贷款金额：</label>
			<div class="controls">
				<form:input path="gdkje" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">垫付金额：</label>
			<div class="controls">
				<form:input path="gdianfu" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保价额度：</label>
			<div class="controls">
				<form:input path="gbjed" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手续费：</label>
			<div class="controls">
				<form:input path="gsxf" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保价费：</label>
			<div class="controls">
				<form:input path="gbjf" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话：</label>
			<div class="controls">
				<form:input path="glxdh" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">退货金额：</label>
			<div class="controls">
				<form:input path="gthje" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">少收金额：</label>
			<div class="controls">
				<form:input path="gssje" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物状态：</label>
			<div class="controls">
				<form:radiobuttons path="gstatus" items="${fns:getDictList('dic_wl_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="4" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="logistics:goodinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>