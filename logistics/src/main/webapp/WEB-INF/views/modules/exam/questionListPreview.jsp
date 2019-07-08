<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试题管理</title>
	<link href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.min.css${v}" rel="stylesheet" type="text/css" />
	<link href="${ctxStatic}/modules/exam/question/css/question.css${v}" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.css${v}">
	<script src="${ctxStatic}/jquery/jquery-3.2.0.min.js"></script>
	<script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/modules/exam/question/js/ui.js${v}"></script>
	<script src="${ctxStatic}/modules/exam/question/js/question.js${v}"></script>
	<script src="${ctxStatic}/common/ywork.js" type="text/javascript"></script>
    <script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';
		var uid = '${uid}';
	</script>
	<link href="${ctxStatic}/jquery-select2/4.0/css/select2.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-select2/4.0/js/select2.full.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
    <script src="${ctxStatic}/ckeditor_4.7.1_standard/ckeditor/ckeditor.js${v}"></script>
	<style>
		/*岗位和难度*/
		.question_quesdiv .is_lever,.question_quesdiv .is_post{
			display: inline-block;
			width:33%;
			margin-bottom:10px;
			float: left;
		}
		.select2-container .select2-choice>.select2-chosen{
			line-height:22px;
		}
		.question_quesdiv .is_form{
			height:30px;
			margin-top:2px;
			margin-bottom:0;
		}
		.is_post{
		}
		.is_post ul{
			width:200px;
			min-height: 30px;
			border-radius:3px;
		}
		.is_lever ul{
			height: 30px;
		}
		.is_post ul .select2-search-field{
			height: 26px;
		}
		.select2-container-multi .select2-choices .select2-search-field input{
			padding-top:0;
			padding-bottom:0;
		}
		.is_post ul li>div{
			width:30px;
		}
        /*知识点调整*/
        .select2-container--default .select2-selection--multiple .select2-selection__rendered li{
            font-size:12px;
            height:20px;
            line-height:17px;
            padding:0;
            padding-right:2px;
            padding-left:2px;
        }
        .select2-container--default .select2-selection--single .select2-selection__rendered{
            line-height: 25px;
        }
        .add_dictionary,.query_dictionary{
            display: none;
        }
		/*.cke_editable_inline{*/
			/*border:1px solid #d43f3a;*/
		/*}*/
		/*添加编辑器*/
		.question_quesdiv .questionContent{
			width:94.5%;
		}
		.question_reportError i{
			color: inherit;
			margin-right:3px;
			font-style: normal;
		}
		.questionContent>p,.question_choiceB>p,.question_editorBox>p{
			margin-bottom:0;
		}

		/*搜索试题*/
		.question_seach{
			line-height:46px;
			padding-top:1px;
		}
		.question_seach>div{
			width:600px;
			margin-top:7px;
			margin-left: 10px;
		}
		.question_seach>div .dropdown-toggle{
			height:34px;
			border-top-left-radius: 0;
			border-bottom-left-radius: 0;
		}
		.question_seach>div span{
			color:#fff;
			font-size:16px;
		}
		.question_seach>div li a{
			display: block;
			height:100%;
			line-height: 40px;
			font-size: 14px;
		}
		.question_seach>span{
			float: left;
			color: #999;
			font-size: 13px;
			margin-left: 10px;
		}
		/*知识点*/
		.zsd{
			line-height: 30px;
			height:30px;
			box-sizing: content-box;
		}
		input[name = topicName]{
			box-sizing: content-box;
			width:153px;
			height:28px;
			line-height: 28px;
			border-radius:4px;
			outline: none;
			border:1px solid #aaa;
			padding: 0 10px;
		}

	</style>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/exam/question/listpreview">试题审核</a></li>
	<shiro:hasPermission name="exam:question:edit"><li><a href="${ctx}/exam/question/form?backURL=${backURL}">试题添加</a></li></shiro:hasPermission>
</ul>
<div>
	<div class="question_knowledge">
		<div class="borderone">
			<div class="sel_title">
				选择知识点
			</div>
			<div class="slide_up_topic">
				<ul class="dash_line dash_pos ml19 tree_container" id="onecontainer">

				</ul>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>
	<div class="question_main">
		<div class="question_body" id="question_con_body">
			<div class="question_parthead">
				<div class="question_partheadbox" id="question_partheadbox1">
					<!--<div class="question_partname" id="question_partname1">第I卷（选择题）</div>-->
					<div class="question_partnote question_buttonnav">
						<div class="question_menutab">
							<ul>
								<%--<li>--%>
									<%--<div class="question_limenu">--%>
										<%--<span style="width:60px;text-align: right">科　目：</span>--%>
										<%--<a href="javascript:void(0)" class="question-tag curr del_type" data-tagtype="subject" data-value="">不限</a>--%>
										<%--<c:forEach items="${fns:getDictList('dic_exam_questionsubject')}" var="dict">--%>
											<%--<a href="javascript:void(0)" data-tagtype="subject" data-value="${dict.value}" class="question-tag">${dict.label}</a>--%>
										<%--</c:forEach>--%>
										<%--<button class="pull-right btn btn-success" style="margin: 3px 10px;" id="btn-add">试题添加</button>--%>
									<%--</div>--%>
								<%--</li>--%>

								<li>
									<div class="question_limenu" id="question_limenu">
										<span style="width:60px;text-align: right">状　态：</span>
										<a href="javascript:void(0)" class="curr del_type" id="all" data-status="all">不限</a>
										<a href="javascript:void(0)" id="cantel_check" data-status="0">未审</a>
										<a href="javascript:void(0)" id="pending" data-status=2>待定</a>
										<a href="javascript:void(0)" id="checked" data-status=1>已审</a>
									</div>
								</li>

								<li>
									<div class="question_limenu">
										<span style="width:60px;text-align: right">题　型：</span>
										<a href="javascript:void(0)" class="question-tag curr del_type" data-tagtype="qType" data-value="">不限</a>
										<c:forEach items="${fns:getDictList('dic_exam_questiontype')}" var="dict">
											<a href="javascript:void(0)" data-tagtype="qType" data-value="${dict.value}" class="question-tag">${dict.label}</a>
										</c:forEach>
									</div>
								</li>

								<li>
									<div class="question_limenu">
										<span style="width:60px;text-align: right">难　度：</span>
										<a href="javascript:void(0)" class="question-tag curr del_type" data-tagtype="qLevel" data-value="">不限</a>
										<c:forEach items="${fns:getDictList('dic_exam_questionlevel')}" var="dict">
											<a href="javascript:void(0)" data-tagtype="qLevel" data-value="${dict.value}" class="question-tag">${dict.label}</a>
										</c:forEach>
									</div>
								</li>
								<div style="height:60px;">
									<div class="question_seach">
										<span style="width:60px;text-align: right">搜　索：</span>
										<div class="input-group">
											<input id="search_cont" style="float: left;width:300px;margin-left: 10px;" type="number" min="1" class="form-control" placeholder="输入试题编号">
											<div class="btn-group" style="float: left">
												<%--<button id="pos_search" type="button" class="btn btn-success">定位到页</button>--%>
												<button id="pos_search" type="button" class="btn btn-success dropdown-toggle">
													<span class="glyphicon glyphicon-search"></span>
												</button>
											</div>
										</div>
									</div>
								</div>
							</ul>
							<div class="clear"></div>
						</div>

					</div>
					<div class="question_partnote" id="question_partnote1"></div>
				</div>
			</div>
			<div class="question_partbody">
				<div class="question_questypebody">
					<sys:message content="${message}"/>
					<ul id="question_questypebodyul">
						<!--静态数据已备份-->
					</ul>
				</div>
			</div>
			<div align="center">
				<div class="fenye" id="fenye">
					<table border="0">
						<tbody>
						<tr>
							<td id="pagelist">
							</td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="quenums">
<input type="hidden" id="storageid" value="${fns:getUser().id}">
<input type="hidden" id="posid" value="">
<!-- 插入数据模板 -->
<script type="text/template" id="template">
	<li id="pos-{{qno}}">
		<div class="question_quesbox">
			<div class="question_quesopmenu" id="question_quesopmenudiv" style="display: none;">

			</div>
			<div id="top-{{id}}">
				<!-- This div will handle all toolbars. -->
			</div>
			<div class="question_quesdiv">
				<font class="question_reportError" data-bj="false" data-id="{{id}}" data-type="{{qtype}}" sub_id="17" exam_id="1395359" style="display: none;"><i class="fa fa-pencil"></i><i class="control_editor">编辑</i></font>
				<div class="question_fck007">
					<span class="question_quesindex" style="background-color: rgb(255, 255, 255);">
						<b><span id="question_number">{{qno}}</span>.</b>
					</span>
					<span class="question_tips"></span>
					<span class="question_title_css">
                            <div class="questionContent" id="que_cont">{{qcontent}}</div>
					</span>
                    <%--<div class="clearfix"><br/></div>--%>
					<div id="question_optionsdiv" class="question_optionsclear">

					</div>
				</div>

				<div class="question_quesTxt question_quesTxt2 question_quesTxtfno">
					<ul>
						<li class="question_noborder question_title_css">
							<font>答案</font><div class="question_choiceB" id="question_choiceB">{{qkey}}</div>
						</li>
						<li>
							<font>解析</font>
							<div class="question_editorBox question_title_css" id="question_editorBox">
								{{qresolve}}
							</div>
						</li>
						<li>
							<font class="isknows">科目</font>
							<div class="question_fl">
								{{subjectName}}
							</div>
						</li>
						<li>
							<form id="form-{{id}}" class="is_form">
								<div class="is_post zsd">
									<span>知识点</span>
									<input id="topic{{id}}" name="topic" class="" type="hidden" value="">
									<input id="topicName{{id}}" name="topicName" readonly="readonly" type="text" value="" data-msg-required="" class="" style="" disabled>&nbsp;<a id="topicButton{{id}}" href="javascript:" class="query_dictionary" style=""><i class="fa fa-search"></i></a>&nbsp;<a class="add_dictionary" href="javascript:;"><i title="新知识点" class="fa fa-plus"></i></a>
								</div>
								<div class="is_post">
									<span>岗位</span>
									<select id="ispost-{{id}}" name="post" class="input-xlarge " multiple="multiple" style="width:200px;" disabled>
										<c:forEach items="${fns:getDictList('dic_exam_questionpost')}" var="item">
											<option value="${item.value}">${item.label}</option>
										</c:forEach>
									</select>
								</div>
								<div class="is_lever">
									<span>难度</span>
									<select id="islever-{{id}}" name="qLevel" class="input-xlarge select2-{{id}}" style="width:200px;" disabled>
										<c:forEach items="${fns:getDictList('dic_exam_questionlevel')}" var="item">
											<option value="${item.value}">${item.label}</option>
										</c:forEach>
									</select>
								</div>
							</form>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</li>
</script>
<!--选项模板-->
<script type="text/template" id="options_template">
	<div class="q_option"><span style="float:left;">{{alisa}}．</span><span style="float:left;">{{text}}</span></div>
</script>
<!-- 判断题选项-->
<script type="text/template" id="options_templateYN">
	<span class="question_em2" style="float:left;padding-right:30px;width: 100%;">A．正确</span>
	<span class="question_em2" style="float:left;padding-right:30px;width: 100%;">B．错误</span>
</script>
<!-- 功能菜单 未审核-->
<script type="text/template" id="quesopmenu_template">
	<%--<a href="javascript:void(0)" class="question_collection" style="display:none;"><button type="button" class="btn btn-info">收藏</button></a>--%>
	<a href="javascript:void(0)" class="is_save"><button data-id='{{id}}' type="button" class="btn btn-info ">保存</button></a>
	<a href="javascript:void(0)" class="question_answer"><button type="button" class="btn btn-info">解答</button></a>
	<%--<a href="javascript:void(0)" class="question_replace" ><button type="button" class="btn btn-info">换题</button></a>--%>
	<a href="javascript:void(0)" class="question_moveup"><button type="button" class="btn btn-info">上移</button></a>
	<a href="javascript:void(0)" class="question_movedn"><button type="button" class="btn btn-info">下移</button></a>
	<a href="javascript:void(0)" class="question_examine"><button data-qid='{{id}}' data-qno="{{qno}}" data-qstatus='' type="button" class="btn btn-success btn-question-check question_status">审核</button></a>
	<%--<a href="javascript:void(0)" id="question_cancel_examine-{{id}}" class="question_cancel_examine"><button data-qid='{{id}}' data-qstatus='' type="button" class="btn btn-info btn-question-cancelcheck question_status">弃审</button></a>--%>
	<a href="javascript:void(0)" class="question_pending"><button data-qid='{{id}}' data-qno="{{qno}}" data-qstatus='' type="button" class="btn btn-info btn-question-pending question_status">待定</button></a>
	<a href="javascript:void(0)" class="question_update" style="display:none;"><button data-qid='{{id}}' data-qstatus='' type="button" class="btn btn-warning btn-question-update question_status">编辑</button></a>
	<a href="javascript:void(0)" class="question_del" style="display:none;"><button data-qid='{{id}}' data-qstatus='' type="button" class="btn btn-danger btn-question-del question_status">移除</button></a>
</script>
<%--试题已审核--%>
<script type="text/template" id="qx_quesopmenu_template">
	<a href="javascript:void(0)" class="is_save"><button data-id='{{id}}' type="button" class="btn btn-info ">保存</button></a>
	<a href="javascript:void(0)" class="question_answer"><button type="button" class="btn btn-info">解答</button></a>
	<a href="javascript:void(0)" class="question_moveup" style="display:none;"><button type="button" class="btn btn-info">上移</button></a>
	<a href="javascript:void(0)" class="question_movedn" style="display:none;"><button type="button" class="btn btn-info">下移</button></a>
	<a href="javascript:void(0)" class="question_cancel_examine"><button data-qid='{{id}}' data-qno="{{qno}}" data-qstatus='' type="button" class="btn btn-success btn-question-cancelcheck question_status">退审</button></a>
	<a href="javascript:void(0)" class="question_pending"><button data-qid='{{id}}' data-qno="{{qno}}" data-qstatus='' type="button" class="btn btn-info btn-question-pending question_status">待定</button></a>
	<a href="javascript:void(0)" class="question_update"><button data-qid='{{id}}' data-qstatus='' type="button" class="btn btn-warning btn-question-update question_status">编辑</button></a>
	<a href="javascript:void(0)" class="question_del"><button data-qid='{{id}}' data-qstatus='' type="button" class="btn btn-danger btn-question-del question_status">移除</button></a>
</script>

<script id="model" type="text/template">
	<li>
		<div class="one_title one sel_bg" data-code="{{code}}" id="sub-{{id}}" data-id="{{id}}">
			<em class="bg {{bg}}" onclick="toggerClick(this);"></em><span onclick="selClick(this);"><i class="sel select"></i><span>{{name}}</span></span>
		</div>
		<ul class="dash_line dash_pos ml19">
		</ul>
	</li>
</script>
<script id="model_2" type="text/template">
	<li>
		<div class="one_title" id="sub-{{id}}" data-code="{{code}}" data-id="{{id}}">
			<em class="bg {{bg}}" onclick="toggerClick(this);"></em><span onclick="selClick(this);"><i class="sel select"></i><span>{{name}}</span></span>
		</div>
		<ul class="dash_line dash_pos ml19">
		</ul>
	</li>
</script>

</body>
</html>