<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(page.list)}, ids = [], rootIds = []
			for (var i=0; i<data.length; i++){
				data[i]._sort = data[i].sort+10;
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
		if(parent.clouseLayer){
			parent.clouseLayer();
		}
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/sys/dict/">字典列表</a></li>
	<shiro:hasPermission name="sys:dict:edit"><li><a href="${ctx}/sys/dict/form?sort=10">字典添加</a></li></shiro:hasPermission>
</ul>
<div class="alert alert-warning">注意：业务数据依赖字典设置，修改请谨慎！</div>
<form:form id="searchForm" modelAttribute="dict" action="${ctx}/sys/dict/" method="post" class="breadcrumb form-search">
	<label>类型：</label><form:select id="type" path="type" class="input-medium"><form:option value="" label="不限"/><form:options items="${typeList}" htmlEscape="false"/></form:select>
	&nbsp;&nbsp;<label>描述 ：</label><form:input path="description" htmlEscape="false" maxlength="50" class="input-medium"/>
	&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<sys:message content="${message}"/>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>名称</th>
		<th>键值</th>
		<th>类型</th>
		<th>描述</th>
		<th>排序</th>
		<th>更新时间</th>
		<shiro:hasPermission name="test:testTree:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody id="treeTableList"></tbody>
</table>
<script type="text/template" id="treeTableTpl">
	<tr id="{{row.id}}" pId="{{pid}}">
		<td><a href="${ctx}/sys/dict/form?id={{row.id}}">
			{{row.label}}
		</a></td>
		<td>
			{{row.value}}
		</td>
		<td><a href="javascript:" onclick="$('#type').val('{{row.type}}');$('#searchForm').submit();return false;">{{row.type}}</a></td>
		<td>
			{{row.description}}
		</td>
		<td>
			{{row.sort}}
		</td>
		<td>
			{{row.updateDate}}
		</td>
		<shiro:hasPermission name="sys:dict:edit"><td>
			<a href="${ctx}/sys/dict/form?id={{row.id}}">修改</a>
			<a href="${ctx}/sys/dict/delete?id={{row.id}}&type={{row.type}}" onclick="return confirmx('确认要删除该字典吗？', this.href)">删除</a>
			<a href="${ctx}/sys/dict/form?parentId={{row.parentId}}&type={{row.type}}&description={{row.description}}&sort={{row._sort}}">添加键值</a>
		</td></shiro:hasPermission>
	</tr>
</script>
</body>
</html>