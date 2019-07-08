<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试题管理管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" rel="stylesheet"/>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script type="text/javascript">

		var editor_content = null;
		var editor_resolve = null;
        var editor_options = [];


		//空格数
		var var_Blanks = 0;

		var tmQuestion = {
			formInit : function(qtype){

			    //必须销毁动态创建的所有ckeditor实例，否则表单提交有问题。
                $.each(editor_options,function(i,it){
                    it.destroy();
                    it = null;
                });
                editor_options = [];

				var json = eval(${json});

				if(!json){
					json = {qKey:'',options:[{alisa:'A',text:''},{alisa:'B',text:''},{alisa:'C',text:''},{alisa:'D',text:''}]};
				}

				if(qtype == 1){
					tmQuestion.formInitSingle(json);
				}else if(qtype == 2){
					tmQuestion.formInitMultiple(json);
				}else if(qtype == 3){
					tmQuestion.formInitJudgment(json);
				}else if(qtype == 4){
					tmQuestion.formInitBlank(json);
				}else if(qtype == 5){
					tmQuestion.formInitEssay(json);
				}else if(qtype == 6){
                    tmQuestion.formInitEssay(json);
                }
			},

			formInitSingle : function(json){
				var html = [];
				var btnval = '增加选项';
				html.push("<div><input type='button' class='tm_btn' value='"+btnval+"' onclick='tmQuestion.addOption(1)' /></div>");

				var tm_options = json["options"];
				html.push('<table class="tm_question_options" align="left">');
				$(tm_options).each(function(i, ele){
					html.push('<tr>');
					html.push('	<td width="80" id="tm_option_' + ele["alisa"] + '">选项' + ele["alisa"] + '&nbsp;');
					html.push('	<input type="radio" class="required" name="qKey" value="' + ele["alisa"] + '" /></td>');
					html.push('	<th><textarea rows="3" name="_options" class="tm_txtx required" id="_options'+i+'"></textarea><script id="option_script_'+i+'" type="text/plain">' + ele["text"] + '<\/script></th>');
					if(i>0){
						html.push('	<td width="50"><a href="javascript:;" onclick="$(this).parent().parent().remove()" class="tm_ico_delete"></a></td>');
					}else{
						html.push('	<td width="50"></td>');
					}
					//html.push('	<td width="50"><a href="javascript:;" onclick="$(this).parent().parent().remove()" class="tm_ico_delete"></a></td>');
					html.push('</tr>');
				});
				html.push('</table>');

				$("#tm_body").html(html.join(""));
				$("#tm_title").html('选项设置：');
				$("input[name='qKey']").val(json["qKey"].split(''));

                var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);

                $(tm_options).each(function(i, ele){
                    var _ck = CKEDITOR.replace("_options"+i, {
//                        toolbar : 'Basic',
//                        toolbarStartupExpanded: false,
                        height:180
                    });
                    CKEDITOR.config.ckfinderPath = ctxStatic+"/ckfinder";
                    CKEDITOR.config.ckfinderUploadPath = "/exam/question/"+year+"/"+month+"/";
                    _ck.setData($('#option_script_'+i).html());
                    editor_options.push(_ck);
                });
			},

			formInitMultiple : function(json){
				var html = [];
				var btnval = '增加选项';
				html.push("<div><input type='button' class='tm_btn' value='"+btnval+"' onclick='tmQuestion.addOption(2)' /></div>");

				var tm_options = json["options"];
				html.push('<table class="tm_question_options" align="left">');
				$(tm_options).each(function(i, ele){
					html.push('<tr>');
					html.push('	<td width="80" id="tm_option_' + ele["alisa"] + '">选项' + ele["alisa"] + '&nbsp;');
					html.push('	<input type="checkbox" class="required" name="qKey" value="' + ele["alisa"] + '" /></td>');
					html.push('	<th><textarea rows="3" name="_options" class="tm_txtx required" id="_options'+i+'"></textarea><script id="option_script_'+i+'" type="text/plain">' + ele["text"] + '<\/script></th>');
					if(i>0){
						html.push('	<td width="50"><a href="javascript:;" onclick="$(this).parent().parent().remove()" class="tm_ico_delete"></a></td>');
					}else{
						html.push('	<td width="50"></td>');
					}
					//html.push('	<td width="50"><a href="javascript:;" onclick="$(this).parent().parent().remove()" class="tm_ico_delete"></a></td>');
					html.push('</tr>');
				});
				html.push('</table>');

				$("#tm_body").html(html.join(""));
				$("#tm_title").html('选项设置：');
				$("input[name='qKey']").val(json["qKey"].split(''));

                var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);

                $(tm_options).each(function(i, ele){
                    var _ck = CKEDITOR.replace("_options"+i, {
//                        toolbar : 'Basic',
//                        toolbarStartupExpanded: false,
                        height:180
                    });
                    CKEDITOR.config.ckfinderPath = ctxStatic+"/ckfinder";
                    CKEDITOR.config.ckfinderUploadPath = "/exam/question/"+year+"/"+month+"/";
                    _ck.setData($('#option_script_'+i).html());
                    editor_options.push(_ck);
                });
			},

			formInitJudgment : function(json){
				var html = [];
				html.push('<label style="line-height:30px"><input type="radio" class="required" name="qKey" value="Y" />正确</label> ');
//				html.push('<br/>');
				html.push('<label style="line-height:30px"><input type="radio" class="required" name="qKey" value="N" />错误</label>');

				$("#tm_body").html(html.join(""));
				$("#tm_title").html('答案设置：');
				$("input[name='qKey']").val(json["qKey"].split(''));
			},

			formInitBlank : function(json){
				var html = [];
				html.push('<div>');
				html.push(' <input type="button" class="tm_btn" value="增加填空" onclick="tmQuestion.addBlank();" />');
				html.push(' <input type="checkbox" value="Y" name="q_iscomplex" />混杂模式批改（不按答题顺序批改用户答案）');
				html.push(' <input type="text" class="required" style="clear:both; width:1px; height:1px; border:none;" id="tm_blank_marker" value="" />');
				html.push('</div>');
				html.push('<table class="tm_question_options" align="left">');
				html.push('<tr><td id="tm_question_blanks"></td></tr>');
				html.push('</table>');
				$("#tm_body").html(html.join(""));

				/******** AddBlank ********/
				$(json["blanks"]).each(function(i, ele){
					var _qblankid = parseInt(ele["id"]);
					if(_qblankid>=var_Blanks){
						var_Blanks = _qblankid;
					}

					var html = [];
					html.push('<div class="tm_question_blank">');
					html.push('<span>' + ele["id"] + ' : </span>');
					html.push('<input name="q_blankids" type="hidden" value="'+ele["id"]+'" />');
					html.push('<input name="q_blanks" type="input" class="required tm_txt" maxlength="30" class="txt" value="' + ele["value"] + '" />');
					html.push('<a href="javascript:;" data-blankid="' + ele["id"] + '" class="tm_ico_delete" onclick="tmQuestion.removeBlank(this)"></a>');
					html.push('</div>');
					$("#tm_question_blanks").append(html.join(""));
					$("#tm_blank_marker").val("HASVALUE");
				});
				/******** AddBlank *******/

				$("#tm_title").html('答案设置: ');

				var v_complex = json["isComplex"] ? "Y" : "N";
				$("input[name='q_iscomplex']").val(v_complex.split(""));
			},

			formInitEssay : function(json){
				var html = [];
				html.push('<div><textarea id="essay_key" name="qKey" rows="5" class="required tm_txtx" style="width:98%"></textarea><script id="essay_key_script" type="text/plain">' + json["qKey"] + '<\/script></div>');

				$("#tm_body").html(html.join(""));
				$("#tm_title").html('答案设置：');

                var _ck = CKEDITOR.replace("essay_key", {
//                        toolbar : 'Basic',
//                    toolbarStartupExpanded: false,
                    height:100
                });
                CKEDITOR.config.ckfinderPath = ctxStatic+"/ckfinder";
                CKEDITOR.config.ckfinderUploadPath = "/exam/question/"+year+"/"+month+"/";
                _ck.setData($('#essay_key_script').html());
                editor_options.push(_ck);
			},

			/*************** Opreations ************/
			addOption : function(qtype){
				var tm_options = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
				for(var i=0; i<tm_options.length; i=i+1){
					var this_value = tm_options[i];
					//不存在就添加
					if(!document.getElementById("tm_option_" + this_value)){
						var html = [];

						html.push('<tr>');
						html.push('	<td width="80" id="tm_option_' + this_value + '">选项' + this_value + '&nbsp;');

						if(1 == qtype){
							html.push('	<input type="radio" class="required" name="qKey" value="' + this_value + '" /></td>');
						}else if(2 == qtype){
							html.push('	<input type="checkbox" class="required" name="qKey" value="' + this_value + '" /></td>');
						}

						html.push('	<th><textarea rows="3" name="_options" class="tm_txtx required" id="_options'+this_value+'"></textarea></th>');
						html.push('	<td width="50"><a href="javascript:;" onclick="$(this).parent().parent().remove()" class="tm_ico_delete"></a></td>');
						html.push('</tr>');
						$(".tm_question_options").append(html.join(""));
                        var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);
                        var _ck = CKEDITOR.replace("_options"+this_value, {
//                        toolbar : 'Basic',
                            toolbarStartupExpanded: false,
                            height:180
                        });
                        CKEDITOR.config.ckfinderPath = ctxStatic+"/ckfinder";
                        CKEDITOR.config.ckfinderUploadPath = "/exam/question/"+year+"/"+month+"/";
                        editor_options.push(_ck);
						break;
					}
				}
			},

			addBlank : function(){
				var_Blanks ++;
				var html = [];
				html.push('<div class="tm_question_blank">');
				html.push('<span>' + var_Blanks + ' : </span>');
				html.push('<input name="q_blankids" type="hidden" value="'+var_Blanks+'" />');
				html.push('<input name="q_blanks" type="input" class="required tm_txt" maxlength="30" class="txt" />');
				html.push('<a href="javascript:;" data-blankid="'+var_Blanks+'" class="tm_ico_delete" onclick="tmQuestion.removeBlank(this)"></a>');
				html.push('</div>');

				editor_content.insertHtml("[BlankArea"+var_Blanks+"]");
				$("#tm_question_blanks").append(html.join(""));

				$("#tm_blank_marker").val('HASVALUE');
			},

			removeBlank : function(obj){
				var question_content = editor_content.getData();
				$(obj).parent().remove();
				var blankid = $(obj).attr("data-blankid");
				question_content = question_content.replace("[BlankArea"+blankid+"]","");
				editor_content.setData(question_content);

				var _blanks = $("input[name='q_blanks']").length;
				if(_blanks<=0){
					$("#tm_blank_marker").val("");
				}
			}
		};

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

			editor_content = qContentCkeditor;
			editor_resolve = qResolveCkeditor;
            editor_content.setData($('#qContent_script').html());
            editor_resolve.setData($('#qResolve_script').html());
			tmQuestion.formInit('${not empty question.QType?question.QType:"1"}');

            $('#qStdid').val('${question.QStdid}'.split(',')).trigger("change");
            $('#post').val('${question.post}'.split(',')).trigger("change");
		});
	</script>
    <style>
        #topicName{
            border-bottom-right-radius: 0;
            border-top-right-radius: 0;
        }
        #topicButton{
            display: inline-block;
            position: relative;
            left:-4px;
            top:2px;
            top:1px \9;
            width:47px;
            height:28px;
            line-height: 28px;
            font-size: 14px;
            color: #333;
            text-align: center;
            text-shadow: 0 1px 1px rgba(255,255,255,0.75);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.2), 0 1px 2px rgba(0,0,0,0.05);
            border: 1px solid #E5E5E5;
            -webkit-border-radius: 0 4px 4px 0;
            -moz-border-radius: 0 4px 4px 0;
            border-radius: 0 4px 4px 0;
            text-decoration: none;
        }
        #topicButton:hover{
            border-color: #D0D0D0;
        }
    </style>
</head>
<body>
	<ul class="nav nav-tabs">
        <c:if test="${not empty backURL}">
        <li><a href="${ctx}/exam/question/listpreview">试题审核</a></li>
        </c:if>
        <c:if test="${empty backURL}">
		<li><a href="${ctx}/exam/question/">试题列表</a></li>
        </c:if>
		<li class="active"><a href="${ctx}/exam/question/form?id=${question.id}&backURL=${backURL}">试题<shiro:hasPermission name="exam:question:edit">${not empty question.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="exam:question:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="question" action="${ctx}/exam/question/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
        <input type="hidden" name="backURL" value="${backURL}"/>
		<sys:message content="${message}"/>
        <table width="100%" cellpadding="5" border="0" class="tm_table_form">
            <tbody>
                <tr>
                    <th width="120">所属科目：</th>
                    <td width="40%">
                        <%--<select id="subject" name="subject" class="input-xlarge  select2-offscreen" tabindex="-1">--%>
                            <%--<option value="4">基础知识</option><option value="1">煤炭采样</option><option value="2">煤炭制样</option><option value="3" selected>煤炭化验</option><option value="5">电力行业相关知识</option><option value="6">实验室资质认证、认可</option>--%>
                        <%--</select>--%>
                        <form:select path="subject" class="input-xlarge ">
                            <form:options items="${fns:getDictList('dic_exam_questionsubject')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>

                    <th width="120">试题类型：</th>
                    <td width="40%">
                        <%--<select id="qType" name="qType" class="input-xlarge  select2-offscreen" onchange="tmQuestion.formInit(this.value)" tabindex="-1">--%>
                            <%--<option value="1" selected>单选</option><option value="2">多选</option><option value="3">是非</option><option value="4">填空</option><option value="5">简答</option><option value="6">计算</option>--%>
                        <%--</select>--%>

                        <form:select path="qType" class="input-xlarge " onchange="tmQuestion.formInit(this.value)">
                            <form:options items="${fns:getDictList('dic_exam_questiontype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
                </tr>

                <tr>
                    <th width="120">知识点：</th>
                    <td width="40%">
                        <%--<form:select path="topic" class="input-xlarge ">--%>
                            <%--<form:option value="" label="不限"/>--%>
                            <%--<form:options items="${fns:getDictList('dic_exam_questiontopic')}" itemLabel="label" itemValue="value" htmlEscape="false"/>--%>
                        <%--</form:select>--%>
                                <%--<sys:treeselect id="parent" name="topic" value="${question.topic}" labelName="topicName" labelValue=""  title="知识点" url="/sys/dict/treeData?type=dic_exam_questiontopic" extId="" cssClass="" allowClear="true"/>--%>
                            <input id="topic" name="topic" class="" type="hidden" value="${question.topic}">
                            <input id="topicName" name="topicName" readonly="readonly" type="text" value="${question.topicName}" data-msg-required="" class="" style="" disabled>&nbsp;<a id="topicButton" href="javascript:" class="query_dictionary" style=""><i class="icon-search"></i></a>
                    </td>
                    <script>
                        function initTopic() {
                            $("#topicButton").click(function(){
                                // 是否限制选择，如果限制，设置为disabled
                                if ($("#topicButton").hasClass("disabled")){
                                    return true;
                                }
                                // 正常打开
                                top.$.jBox.open("iframe:"+urlpath_a+"/tag/treeselect?url="+encodeURIComponent("/sys/dict/treeData?type=dic_exam_questiontopic")+"&module=&checked=&extId=&isAll=", "选择知识点", 300, 420, {
                                    ajaxData:{selectIds: $("#topic").val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                                        if (v=="ok"){
                                            var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                                            var ids = [], names = [], nodes = [];
                                            if ("" == "true"){
                                                nodes = tree.getCheckedNodes(true);
                                            }else{
                                                nodes = tree.getSelectedNodes();
                                            }
                                            for(var i=0; i<nodes.length; i++) {//
                                                ids.push(nodes[i].code);
                                                var _name = nodes[i].name;
                                                //
                                                names.push(_name);//
                                                break; // 如果为非复选框选择，则返回第一个选择
                                            }
                                            $("#topic").val(ids.join(",").replace(/u_/ig,""));
                                            $("#topicName").val(names.join(","));
                                        }//
                                        else if (v=="clear"){
                                            $("#topic").val("");
                                            $("#topicName").val("");
                                        }//
                                        if(typeof parentTreeselectCallBack == 'function'){
                                            parentTreeselectCallBack(v, h, f);
                                        }
                                    }, loaded:function(h){
                                        $(".jbox-content", top.document).css("overflow-y","hidden");
                                    }
                                });
                            });
                        }
                        initTopic();
                    </script>
                    <th width="120">试题难度：</th>
                    <td width="40%">
                        <form:select path="qLevel" class="input-xlarge ">
                            <form:options items="${fns:getDictList('dic_exam_questionlevel')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
                    <%--<th width="120">试题来源：</th>--%>
                    <%--<td width="40%">--%>
                        <%--<form:input path="qFrom" htmlEscape="false" maxlength="50" class="input-xlarge "/>--%>
                    <%--</td>--%>
                </tr>

                <tr>
                    <th width="120">试题状态：</th>
                    <td width="40%">
                        <form:select path="qStatus" class="input-xlarge ">
                            <form:options items="${fns:getDictList('dic_exam_questionstatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>

                    <th width="120">关键字：</th>
                    <td width="40%">
                        <form:input path="qKeyword" htmlEscape="false" maxlength="50" class="input-xlarge "/>
                    </td>
                </tr>

                <tr>
                    <th width="120">所属岗位：</th>
                    <td width="40%">
                        <form:select path="post" class="input-xlarge " multiple="multiple">
                            <form:options items="${fns:getDictList('dic_exam_questionpost')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>

                    <th width="120">依据标准：</th>
                    <td width="40%">
                        <form:select path="qStdid" class="input-xlarge " multiple="multiple" cssStyle="width:100%;">
                            <form:options items="${fns:getStandardList('1')}" itemLabel="name" itemValue="id" htmlEscape="false"/>
                        </form:select>
                    </td>
                </tr>

                <tr>
                    <th>试题提干：</th>
                    <td colspan="3">
                        <script type="text/plain" id="qContent_script">${question.QContent}</script>
                        <textarea rows="4" maxlength="255" id="qContent" name="qContent" class="input-xxlarge  required"></textarea>
                        <sys:ckeditor replace="qContent" uploadPath="/exam/question" height="100"/>
                    </td>
                </tr>

                <tr>
                    <th id="tm_title">试题选项：</th>
                    <td colspan="3" id="tm_body">
                    </td>
                </tr>

                <tr>
                    <th>试题解析：</th>
                    <td colspan="3">
                        <script type="text/plain" id="qResolve_script">${question.QResolve}</script>
                        <textarea rows="4" maxlength="255" id="qResolve" name="qResolve" class="input-xxlarge"></textarea>
                        <sys:ckeditor replace="qResolve" uploadPath="/exam/question" height="100"/>
                    </td>
                </tr>

                <tr>
                    <th>备注：</th>
                    <td colspan="3">
                        <form:textarea id="qRemark" path="qRemark" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
                    </td>
                </tr>

                <tr>
                    <th width="120"></th>
                    <td width="40%"></td>
                    <th width="120"></th>
                    <td width="40%"></td>
                </tr>
            </tbody>
        </table>
		<div class="form-actions">
			<shiro:hasPermission name="exam:question:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>