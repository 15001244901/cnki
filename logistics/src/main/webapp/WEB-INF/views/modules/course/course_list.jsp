<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="decorator" content="default"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>课程列表</title>
    <script type="text/javascript" src="${ctxStatic}/common/multilevel.js"></script>
    <script type="text/javascript">
    var subjectList = eval('('+'${subjectList}'+')');
    $(function(){
        var param={
                data:subjectList,//处理的数据（必选）数据格式：[{object Object},{object Object}]
                showId:'levelId',//显示的数据标签ID（必选）
                idKey:'subjectId',//数据的ID（必选）
                pidKey:'parentId',//数据的父ID（必选）
                nameKey:'subjectName',//数据显示的名（必选）
                returnElement:'subjectId',//返回选中的值（必选 ）
                //-----------------------------------------------------
                initVal:'${queryCourse.subjectId}',
                defName:'请选择',//默认显示的选项名（可选，如果不设置默认显示“请选择”）
                defValue:'0'//默认的选项值（可选，如果不设置默认是“0”）
            };
        ML._init(param);
    });

    /**
     * 删除课程
     */
    function avaliable(courseId,type,em){
        if(!confirm('确实要删除吗?')){
            return;
        }
        $.ajax({
            url:'${ctx}/course/avaliable/'+courseId+'/'+type,
            type:'post',
            dataType:'json',
            success:function(result){
                if(result.success==false){
                    alert(result.message);
                }else{
                    location.reload();
                }
            },
            error:function(error){
                alert("系统繁忙，请稍后再操作！");
            }
        });
    }
    </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/course/list">课程列表</a></li>
		<shiro:hasPermission name="course:edit"><li><a href="${ctx}/course/toAddCourse">课程添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="" action="${ctx}/course/list" method="post" class="breadcrumb form-search">
		<input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
		<input type="hidden" id="subjectId" name="queryCourse.subjectId" value="${queryCourse.subjectId}" />
		<ul class="ul-form">
			<li><input type="text" name="queryCourse.courseName" value="${queryCourse.courseName}" placeholder="课程标题" class="input-medium"/></li>
			<li><label>状态：</label>
				<select name="queryCourse.isavaliable">
					<option value="0">请选择</option>
					<option <c:if test="${queryCourse.isavaliable==1 }">selected</c:if> value="1">上架</option>
					<option <c:if test="${queryCourse.isavaliable==2 }">selected</c:if> value="2">下架</option>
				</select>
			</li>
			<li><label>专业：</label>
				<samp id="levelId"></samp>
			</li>
			<li><label>创建时间</label>
				<input placeholder="开始创建时间" name="queryCourse.beginCreateTime"
					   value="<fmt:formatDate value="${queryCourse.beginCreateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" id="beginCreateTime" type="text"
					   readonly="readonly" style="width: 128px;" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>-
				<input placeholder="结束创建时间" id="endCreateTime" name="queryCourse.endCreateTime" class="Wdate"
					   value="<fmt:formatDate value="${queryCourse.endCreateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" readonly="readonly" style="width: 128px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input type="reset" class="btn btn-default" value="重置"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<td align="center" width="150px">课程名</td>
				<td align="center">状态</td>
				<td align="center">专业</td>
				<td align="center">原价</td>
				<td align="center">优惠价</td>
				<td align="center">课时</td>
				<td align="center">销售量</td>
				<td align="center">浏览量</td>
				<td align="center">创建时间</td>
				<td align="center">有效结束时间</td>
				<td align="center">操作</td>
			</tr>
		</thead>

		<tbody>
			<c:forEach items="${courseList}" var="course">
				<tr class="odd">
					<td align="center">${course.courseName}</td>
					<td align="center">
						<c:if test="${course.isavaliable==1}">上架</c:if>
						<c:if test="${course.isavaliable==2}">下架</c:if>
					</td>
					<td align="center">${course.subjectName}</td>
					<td align="center">${course.sourcePrice}</td>
					<td align="center">${course.currentPrice}</td>
					<td align="center">${course.lessionNum}</td>
					<td align="center">${course.pageBuycount}</td>
					<td align="center">${course.pageViewcount}</td>
					<td align="center">
						<fmt:formatDate value="${course.addTime}" pattern="yyyy/MM/dd HH:mm" />
					</td>
					<td align="center">
						<c:if test="${not empty course.endTime}">
							<fmt:formatDate value="${course.endTime}" pattern="yyyy/MM/dd HH:mm" />
						</c:if>
						<c:if test="${empty course.endTime}">
							购买后${course.loseTime}天
						</c:if>
					</td>
					<td align="center">
						<a href="${ctx}/course/kpoint/list/${course.courseId}" class="btn btn-small btn-default">章节管理</a>
						<a href="${ctx}/course/initUpdate/${course.courseId}" class="btn btn-small btn-default">修改</a>
						<a href="javascript:void(0)" onclick="avaliable(${course.courseId},3,this)" class="btn btn-small btn-warning">删除</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/include/admin_page.jsp" />
</body>
</html>