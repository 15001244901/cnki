<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文档目录管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
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
							dtype: getDictLabel(${fns:toJson(fns:getDictList('dic_docinfo_doctype'))}, row.dtype),
							rtype: getDictLabel(${fns:toJson(fns:getDictList('dic_domain'))}, row.rtype),
							type: getDictLabel(${fns:toJson(fns:getDictList('doc_directory_type'))}, row.type),
						blank123:0}, pid: (root?0:pid), row: row
					}));
					//递归调用
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/doc/docInfoDirectory/">文档目录列表</a></li>
		<shiro:hasPermission name="doc:docInfoDirectory:edit"><li><a href="${ctx}/doc/docInfoDirectory/form">文档目录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="docInfoDirectory" action="${ctx}/doc/docInfoDirectory/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>文库分类：</label>
				<form:select path="dtype" class="input-medium">
					<form:option value="" label="不限"/>
					<form:options items="${fns:getDictList('dic_docinfo_doctype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>所属科目：</label>
				<form:select path="rtype" class="input-medium">
					<form:option value="" label="不限"/>
					<form:options items="${fns:getDictList('dic_domain')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>目录名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>目录名称</th>
				<th>文库类型</th>
				<th>所属科目</th>
				<th>目录类型（章/节）</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="doc:docInfoDirectory:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/doc/docInfoDirectory/form?id={{row.id}}">
				{{row.name}}
			</a></td>
			<td>
				{{dict.dtype}}
			</td>
			<td>
				{{dict.rtype}}
			</td>
			<td>
				{{dict.type}}
			</td>
			<td>
				{{row.updateDate}}
			</td>
			<td>
				{{row.remarks}}
			</td>
			<shiro:hasPermission name="doc:docInfoDirectory:edit"><td>
   				<a href="${ctx}/doc/docInfoDirectory/form?id={{row.id}}">修改</a>
				<a href="${ctx}/doc/docInfoDirectory/delete?id={{row.id}}" onclick="return confirmx('确认要删除该文档目录及所有子文档目录吗？', this.href)">删除</a>
				<a href="${ctx}/doc/docInfoDirectory/form?parent.id={{row.id}}">添加下级</a>
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>