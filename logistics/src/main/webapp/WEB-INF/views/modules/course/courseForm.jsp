<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>课程管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/webutils.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/common/multilevel.js${v}"></script>

	<script type="text/javascript">
		subjectList='${subjectList}';
		$(function(){
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
			var param={
				data:eval('('+subjectList+')'),	//处理的数据（必选）数据格式：[{object Object},{object Object}]
				showId:'levelId',//显示的数据标签ID（必选）
				idKey:'subjectId',//数据的ID（必选）
				pidKey:'parentId',//数据的父ID（必选）
				nameKey:'subjectName',//数据显示的名（必选）
				returnElement:'returnId',//返回选中的值（必选 ）
				//-----------------------------------------------------
				returnIds:'returnIds',//返回所有级的ID，以“,”隔开（可选）
				initVal:'${course.subjectId}',//初始默认ID（可选）
				defName:'请选择',//默认显示的选项名（可选，如果不设置默认显示“请选择”）
				defValue:'0'//默认的选项值（可选，如果不设置默认是“0”）
			};
			ML._init(param);

			// 将后台的字符串值转换为数组赋给select2控件
			$('#teacherIdArr').val('${course.teacherIdArr}'.split(',')).trigger("change");
		});
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/course/list">课程列表</a></li>
	<li class="active"><a href="${ctx}/course/initUpdate/${course.courseId}">课程<shiro:hasPermission name="course:edit">${course.courseId ne '0'?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="course:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<c:set var="formAction">${ctx}/course/updateCourse</c:set>
<c:if test="${course.courseId eq '0'}">
	<c:set var="formAction">${ctx}/course/addCourse</c:set>
</c:if>
<form:form id="inputForm" modelAttribute="course" action="${formAction}" method="post" class="form-horizontal">
	<form:hidden path="courseId"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">课程名称：</label>
		<div class="controls">
			<form:input path="courseName" htmlEscape="false" maxlength="300" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">专业分类：<span class="help-inline"><font color="red">*</font> </span></label>
		<div class="controls">
			<input type="hidden" value="${course.subjectId}" id="returnId" name="course.subjectId" />
			<input type="hidden" id="returnIds" value="${course.subjectLink}" name="course.subjectLink" />
			<div id="levelId"></div>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">状态：</label>
		<div class="controls">
			<form:radiobuttons path="isavaliable" items="${fns:getDictList('dic_course_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">发布时间:</label>
		<div class="controls">
			<input id="publicTime" name="publicTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
				   value="<fmt:formatDate value="${course.publicTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">总课时：</label>
		<div class="controls">
			<form:input path="lessionNum" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">课程原价格：</label>
		<div class="controls">
			<form:input path="sourcePrice" htmlEscape="false" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">课程销售价格：</label>
		<div class="controls">
			<form:input path="currentPrice" htmlEscape="false" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">有效期类型：</label>
		<div class="controls">
			<form:radiobuttons path="loseType" items="${fns:getDictList('dic_course_yxqlx')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" onclick="if($(this).val() == 1) {$('.endTimeShow').show();$('.loseTimeShow').hide()} else {$('.endTimeShow').hide();$('.loseTimeShow').show()}"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group endTimeShow" ${course.loseType eq '0'?'style="display: none;"':''}>
		<label class="control-label">有效期：</label>
		<div class="controls">
			<form:input path="loseTime" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group loseTimeShow" ${course.loseType eq '1'?'style="display: none;"':''}>
		<label class="control-label">有效结束时间：</label>
		<div class="controls">
			<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
				   value="<fmt:formatDate value="${course.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">添加讲师：</label>
		<div class="controls">
			<form:select path="teacherIdArr" class="input-xlarge " multiple="multiple">
				<form:options items="${allTeachers}" itemLabel="name" itemValue="id" htmlEscape="false"/>
			</form:select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">销售数量：</label>
		<div class="controls">
			<form:input path="pageBuycount" htmlEscape="false" maxlength="11" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">浏览量：</label>
		<div class="controls">
			<form:input path="pageViewcount" htmlEscape="false" maxlength="11" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">课程简介：</label>
		<div class="controls">
			<form:input path="title" htmlEscape="false" maxlength="200" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">课程图片：</label>
		<div class="controls">
			<form:hidden id="logo" path="logo" htmlEscape="false" maxlength="200" class="input-xlarge"/>
			<sys:ckfinder input="logo" type="images" uploadPath="/course" selectMultiple="false"/>
			<font color="red">(请上传 640*357(长X宽)像素 的图片)</font>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">课程详情：</label>
		<div class="controls">
			<script type="text/plain" id="context_script">${course.context}</script>
			<textarea rows="4" maxlength="2000" id="context" name="context" class="input-xxlarge  required">${course.context}</textarea>
			<sys:ckeditor replace="context" uploadPath="/course" height="100"/>
		</div>
	</div>
	<div class="form-actions">
		<shiro:hasPermission name="course:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
</body>
</html>
