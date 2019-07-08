<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文档维护</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style type="text/css">
		.ztree {overflow:auto;margin:0;_margin-top:10px;padding:10px 0 0 10px;}
	</style>
</head>
<body>
	<sys:message content="${message}"/>
	<div id="content" class="row-fluid">
		<div id="left" class="accordion-group">
			<div class="accordion-heading">
		    	<a class="accordion-toggle">文档目录<i class="icon-refresh pull-right" onclick="refreshTree();"></i></a>
				<form:form id="searchForm" modelAttribute="docInfoDirectory" action="${ctx}/doc/docInfoDirectory/treeData" method="post" class="breadcrumb form-search">
					<ul class="ul-form">
						<li><label>知识分类：</label>
							<form:select path="dtype" class="input-medium">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('dic_docinfo_doctype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</li>
						<li><label>所属科目：</label>
							<form:select path="rtype" class="input-medium">
								<form:option value="" label="不限"/>
								<form:options items="${fns:getDictList('dic_domain')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</li>
						<li class="clearfix"></li>
					</ul>
				</form:form>
		    </div>
			<div id="ztree" class="ztree"></div>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			<iframe id="officeContent" src="${ctx}/doc/docInfo/list" width="100%" height="91%" frameborder="0"></iframe>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
					var id = treeNode.id == '0' ? '' :treeNode.id;
					if(!treeNode.children)
						$('#officeContent').attr("src","${ctx}/doc/docInfo/list?directory.id="+id);
				}
			}
		};
		
		function refreshTree(){
			var dtype = $('#dtype').val()||1;
			var rtype = $('#rtype').val()||5;
			if(dtype == 3) {
				rtype = '';
			}
			$.getJSON("${ctx}/doc/docInfoDirectory/treeData?dtype="+dtype+"&rtype="+rtype,function(data){
				$.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
			});
		}
		$('#dtype').val(1);
		$('#rtype').val('');
		refreshTree();

		var leftWidth = 300; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose, #right, #right iframe");
		function wSize(){
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
			mainObj.css("width","auto");
			frameObj.height(strs[0] - 5);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
			$(".ztree").width(leftWidth - 10).height(frameObj.height() - $('.accordion-heading').height()-8);
		}

		$(function(){
			$('#dtype').change(function(e){
				if($(this).val() == 3) {
					$('#rtype').prop('disabled',true);
					$('#rtype').val('');
				} else {
					$('#rtype').prop('disabled',false);
				}
				$('#rtype').select2();
			});
		});
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>