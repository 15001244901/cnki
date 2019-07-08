<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<!doctype html>
<html>
<head>
	<title>组卷练习</title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/wdatepicker/WdatePicker.js" type="text/javascript"></script>
	<style>
		.tm_section_setting{}
		.tm_section_table{border-collapse:collapse; margin:0 0 20px 0; border:solid 1px #eee;}
		.tm_section_table tr td{border:solid 1px #eee !important;}
		.tm_section_table tr th{border:none !important; background:#eee; }
		.tm_section_table tr th a{margin:0 auto;}

		.tm_section_template{display:none}
	</style>

	<link rel="stylesheet" href="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/css/validationEngine.jquery.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/jquery.validationEngine.js"></script>
	
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/languages/jquery.validationEngine-zh_CN.js"></script>

	<script type="text/javascript">

		$(document).ready(function() {
			tmPaper.addSection();
			jQuery('#form_paper_fastadd').validationEngine();
		});

		var tmPaper = {
			addSection : function(){
				var temp = $(".tm_section_template").html();
				$(".tm_section_setting").append(temp);
			}, 
			
			removeSection : function(obj){
				$(obj).parent().parent().parent().parent().remove()
			},
		};
		
		function tm_fun_disabled(){
			alert('对不起，该功能被管理员禁止。如有需要，请联系管理员。');
			return false;
		}

	</script>
  </head>
  
<body>

	<div class="tm_main">
    	
		<div class="tm_container">
			<ul class="tm_breadcrumb">
				<li><a href="${ctx}/sys/user/info">首页</a> <span class="divider">&gt;</span></li>
				<li class="active">组卷练习</li>
			</ul>
		</div>
        
        <div class="tm_container">
        	<div class="tm_navtitle">
				<h1>组卷练习</h1>
                <span>请在下列的表单中设置模拟练习的参数，以便生成模拟练习试卷</span>
            </div>
        </div>
        
        <br/>
        <div class="tm_container">
			<form action="${basectx}/user/practice/newdetail" method="post" id="form_paper_fastadd">
        	<table width="100%" cellpadding="5" border="0" class="tm_table_form">
            	<tbody>
					<colgroup>
						<col width="15%"></col>
						<col width="85%"></col>
					</colgroup>
					<tr>
                        <th>试卷名称 : </th>
                        <td><input type="text" name="p_name" class="validate[required] tm_txt" size="50" style="width:400px" maxlength="30" /></td>
                    </tr>
					<tr>
                        <th>考试时长 : </th>
                        <td><input type="text" name="p_duration" class="validate[required,custom[integer],min[1],max[120]] tm_txt tm_width200" size="20" maxlength="3" /> 分钟</td>
                    </tr>
                    <tr>
                        <th>段落设置 : </th>
                        <td>
							<div style="margin:0 0 5px 0;">
								<input type='button' class='tm_btn' value='增加段落' onclick='tmPaper.addSection();' />
							</div>

							<div class="tm_section_setting"></div>

						</td>
                    </tr>
                </tbody>
                
                <tfoot>
                	<tr>
                    	<th></th>
                        <td>
                        	<c:choose>
								<c:when test="${sys_allow_test == 'allow'}">
									<button class="tm_btn tm_btn_primary" type="submit">提交</button>
									<button class="tm_btn" type="button" onclick="javascript:history.go(-1)">返回</button>
								</c:when>
								<c:otherwise>
									<button class="tm_btn" type="button" onclick="tm_fun_disabled();">提交</button>
									<button class="tm_btn" type="button" onclick="javascript:history.go(-1)">返回</button>
								</c:otherwise>
							</c:choose>
							
                        </td>
                    </tr>
                </tfoot>
            </table>

			</form>
        </div>
        
        
    </div>

	<!-- tm_section_template -->
	<div class="tm_section_template">
		<table border="0" cellpadding="5" cellspacing="0" class="tm_section_table">
			<tr>
				<td>
					<input type="text" name="p_section_names" class="validate[required] tm_txt" style="width:400px" size="50" maxlength="20" placeholder='段落名称' />
					&nbsp;
					<input type="hidden" name="p_section_remarks" class="tm_txt tm_width300" size="50" maxlength="50" />
				</td>
				<th width="50" align="center" rowspan="2">
					<a href="javascript:;" onclick="tmPaper.removeSection(this);" class="tm_ico_delete"></a>
				</th>
			</tr>
			<tr>
				<td>
					<select name="p_dbids" class="validate[required] tm_select" style="min-width:150px">
						<option value="">选择题库</option>
						<c:forEach var="qdb" items="${qdbs}">
						<option value="${qdb.id}">${qdb.name}</option>
						</c:forEach>
					</select>

					<select name="p_subjects" class="validate[required] tm_select" style="min-width: 150px;">
						<option value="">选择知识点</option>
						<c:forEach items="${fns:getDictList('dic_exam_questionsubject')}" var="d">
							<option value="${d.value}">${d.label}</option>
						</c:forEach>
					</select>

					<select name="p_qtypes" class="validate[required] tm_select" style="min-width:100px">
						<option value="">选择题型</option>
						<option value="1">单选</option>
						<option value="2">多选</option>
						<option value="3">判断</option>
						<option value="4">填空</option>
						<option value="5">简答</option>
						<option value="6">计算</option>
					</select>

					<select name="p_levels" class="validate[required] tm_select" style="min-width:100px">
						<option value="">选择难度</option>
						<option value="1">初级</option>
						<option value="2">中级</option>
						<option value="3" selected>高级</option>
					</select>

					试题数量 :
					<input type="text" class="validate[required,custom[integer],min[1]] tm_txt" size="3" name="p_qnums" value="1" />

					每题分值 :
					<input type="text" class="validate[required,custom[integer],min[1]] tm_txt" size="3" name="p_scores" value="1" />
				</td>
			</tr>
		</table>
	</div>
	<!-- /tm_section_template -->

</body>
</html>
