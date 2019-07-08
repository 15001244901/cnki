<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>标准管理管理</title>
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

			$.ajax({
				url:ctx+'/sys/dict/listData.jhtml',
				data:{type:'${param.category eq 1?"std_type":"std_type_zltx"}'},
				type:'post',
				success:function(data){
//					$('#typesys').empty();
//					$('#typesys').append('<option value=""></option>');
					$.each(data.data,function(index,item){
						$('#typesys').find('option[value="'+item.value+'"]').attr('data-id',item.id);
					});
				}
			});

			$('#typesys').on('change',function(){
				var that = $(this);
				var parentid = that.find('option[value="'+that.val()+'"]').data('id');
				$.ajax({
					url:ctx+'/sys/dict/listData.jhtml',
					data:{type:'${param.category eq 1?"std_subtype":"std_subtype_zltx"}',parentId:parentid},
					type:'post',
					success:function(data){
						$('#subtype').empty();
						$('#subtype').append('<option value=""></option>');
						$.each(data.data,function(index,item){
							$('#subtype').append('<option value="'+item.value+'">'+item.label+'</option>');
						});
					}
				});
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
		<li><a href="${ctx}/standard/yWStandard?category=${param.category}">${param.category eq 2?"质量体系":"国家标准"}列表</a></li>
		<li class="active"><a href="${ctx}/standard/yWStandard/form?id=${yWStandard.id}"><shiro:hasPermission name="standard:yWStandard:edit">${not empty yWStandard.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="standard:yWStandard:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="yWStandard" action="${ctx}/standard/yWStandard/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input id="category" name="category" type="hidden" value="${param.category}"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">科目：</label>
			<div class="controls">
				<form:select path="typesys" class="input-xlarge ">
					<form:option value="" label=""/>
					<c:if test="${param.category eq 1}">
						<form:options items="${fns:getDictList('std_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</c:if>
					<c:if test="${param.category eq 2}">
						<form:options items="${fns:getDictList('std_type_zltx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</c:if>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">子科目：</label>
			<div class="controls">
				<form:select path="subtype" class="input-xlarge ">
					<form:option value="" label=""/>
					<c:if test="${param.category eq 1}">
						<form:options items="${fns:getDictList('std_subtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</c:if>
					<c:if test="${param.category eq 2}">
						<form:options items="${fns:getDictList('std_subtype_zltx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</c:if>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准号：</label>
			<div class="controls">
				<form:input path="sno" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">中文名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">英文名称：</label>
			<div class="controls">
				<form:input path="enname" htmlEscape="false" maxlength="300" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准文件：</label>
			<div class="controls">
				<form:hidden id="files" path="files" htmlEscape="false" maxlength="500" class="input-xlarge"/>
				<sys:ckfinderpreview input="files" type="files" uploadPath="/std" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">缩略图:</label>
			<div class="controls">
				<form:hidden id="thumbnail" path="thumbnail" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="thumbnail" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="150" maxHeight="210"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">年代号：</label>
			<div class="controls">
				<form:input path="yearno" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准状态：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">ICS分类：</label>
			<div class="controls">
				<form:input path="ics" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">组织类别：</label>
			<div class="controls">
				<form:input path="typeorg" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">中标分类：</label>
			<div class="controls">
				<form:input path="typezh" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准分类编号：</label>
			<div class="controls">
				<form:input path="typeno" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">页数：</label>
			<div class="controls">
				<form:input path="pagenum" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发布日期：</label>
			<div class="controls">
				<input name="issuedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${yWStandard.issuedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">实施日期：</label>
			<div class="controls">
				<input name="executedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${yWStandard.executedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">作废日期：</label>
			<div class="controls">
				<input name="canceldate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${yWStandard.canceldate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">被替代标准：</label>
			<div class="controls">
				<form:input path="replacedby" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">替代标准：</label>
			<div class="controls">
				<form:input path="replacestd" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">引用标准（多个标准用英文分号分割）：</label>
			<div class="controls">
				<form:textarea path="citestd" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">采用标准：</label>
			<div class="controls">
				<form:input path="usestd" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">起草单位（多个标准用英文分号分割）：</label>
			<div class="controls">
				<form:textarea path="draftcompany" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归口单位：</label>
			<div class="controls">
				<form:textarea path="gkcompany" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原文标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">复核结果：</label>
			<div class="controls">
				<form:input path="recheckresult" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标引依据：</label>
			<div class="controls">
				<form:textarea path="according" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">补充修订：</label>
			<div class="controls">
				<form:input path="supplement" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">范围：</label>
			<div class="controls">
				<form:input path="stdrange" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">有/无文件：</label>
			<div class="controls">
				<form:input path="hasfile" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="standard:yWStandard:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

	<div style="display:none">
		<form id="onlinePreviewForm" action="${ctxRoot}/page/standard/tour.html?id=${yWStandard.id}" target="_blank" method="post">
			<input name="fileURL" type="hidden">
		</form>
	</div>
</body>
</html>