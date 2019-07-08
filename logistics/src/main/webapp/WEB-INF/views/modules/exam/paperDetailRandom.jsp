<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!doctype html>
<html>
<head>
	<title>试卷试题配置</title>
	<link href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/inc/js/pagination/pagination.css" />

	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/wdatepicker/WdatePicker.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/pagination/pagination.js" type="text/javascript"></script>

	<style>
		.tm_qscore{
			background-color:#fff; border:1px solid #ccc;
			height:15px; padding:3px 5px; font-size:12px; line-height:15px; color:#555;
			vertical-align:middle; -webkit-border-radius:3px; -moz-border-radius:3px; border-radius:3px;
		}
		.tm_position_adjustment{
			float:left; margin-right:10px; margin-top:3px;
		}
	</style>

	<link rel="stylesheet" href="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/css/validationEngine.jquery.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/jquery.validationEngine.js"></script>

	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/languages/jquery.validationEngine-zh_CN.js"></script>

	<script type="text/javascript">

		var var_sectionId = 1;

		$(document).ready(function() {
			tmPaper.pageInit();
			jQuery('#form_paper_detail').validationEngine();
		});

		var tmPaper = {
			uiInit : function(){
				$( ".tm_adm_paper_body_section" ).sortable({connectWith: ".tm_adm_paper_body_section"}).disableSelection();

				//绑定计算分数的方法
				$("input[name='p_scores']").unbind("change");
				$("input[name='p_scores']").bind("change", function(){
					tmPaper.countScore();
				});

				$("input[name='p_qnums']").unbind("change");
				$("input[name='p_qnums']").bind("change", function(){
					tmPaper.countScore();
				});

			},

			addSection : function(){
				var_sectionId++;
				//设置新值
				$("#tm_template_section input[name='p_section_ids']").val(var_sectionId);
				var html = $("#tm_template_section").html();
				$("#paper_sections").append(html);
				tmPaper.uiInit();
			},

			toggleSection : function(obj){
				var pobj = $(obj).parent().parent().parent();
				var current_ico = $(obj).attr("class");

				if(pobj){
					if(current_ico.indexOf("tm_ico_max")>-1){
						$(obj).removeClass("tm_ico_max");
						$(obj).addClass("tm_ico_min");
						pobj.children("dd").slideUp();
					}else{
						$(obj).removeClass("tm_ico_min");
						$(obj).addClass("tm_ico_max");
						pobj.children("dd").slideDown();
					}
				}
			},

			removeSection : function(obj){
				var pobj = $(obj).parent().parent().parent().parent();
				if(pobj.is("li")){
					pobj.remove();
				}else{
					pobj.parent().remove();
				}
				tmPaper.countScore();
			},

			expandSection : function(){
				$(".tm_adm_paper_body_section_dl dd ").slideDown();
				$(".tm_ico_min").removeClass("tm_ico_min").addClass("tm_ico_max");
			},

			shrinkSection : function(){
				$(".tm_adm_paper_body_section_dl dd ").slideUp();
				$(".tm_ico_max").removeClass("tm_ico_max").addClass("tm_ico_min");
			},

			countScore : function(){
				var totalscore = 0, passscore = 0;

				$("input[name='p_qnums']").each(function(i,o){
					var _nums = parseInt($(this).val());
					var _score = parseInt($(this).parent().children("input[name='p_scores']").val());

					if(!isNaN(_nums) && !isNaN(_score)){
						var _xscore = _nums * _score;
						totalscore += _xscore;
					}

				});

				passscore = Math.ceil(0.6 * totalscore);
				$("input[name='p_total_score']").val(totalscore);
				$("input[name='p_pass_score']").val(passscore);
			},

			pageInit : function(){
				tmPaper.uiInit();
			}
		};

	</script>
</head>

<body>

<div class="tm_main">

	<div class="tm_container">
		<ul class="tm_breadcrumb">
			<li><a href="#">首页</a> <span class="divider">&gt;</span></li>
			<li><a href="${ctx}/exam/paper/list">试卷管理</a> <span class="divider">&gt;</span></li>
			<li class="active">配置</li>
		</ul>
	</div>

	<div class="tm_container">
		<div class="tm_navtitle">
			<h1>试卷配置</h1>
			<span>试卷详情配置，您可以在当前页面创建段落，并向段落中添加试题并设置分值。</span>
		</div>
	</div>

	<br/>
	<div class="tm_container">

		<table border="0" width="100%" cellpadding="0">
			<tr>
				<!-- left -->
				<td valign="top">
					<form action="detail" method="post" id="form_paper_detail">
						<div class="tm_adm_paper">
							<div class="tm_adm_paper_head">
								<h1>${paper.name}</h1>
								<h2 style="background:#ffa; padding:5px 0;">
									<b>随机试卷</b> &nbsp;
									各考生试卷随机生成
								</h2>
								<h2>
									<b>时间设定</b> : <fmt:formatDate value="${paper.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/> -- <fmt:formatDate value="${paper.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<b>考试时长</b> : ${paper.duration} 分钟
								</h2>
								<h3>
									<b>卷面总分</b> :
									<input type="text" class="tm_txt" name="totalscore" value="${paper.totalscore}" readonly style="background:#eee" />
									&nbsp;&nbsp;
									<b>及格分数</b> :
									<input type="text" class="validate[required,custom[integer],min[1]] tm_txt" name="passscore" value="${paper.passscore}" />
								</h3>
							</div>
							<div class="tm_adm_paper_tool">
								<button class="tm_btn" type="button" onclick="tmPaper.addSection()">增加段落</button>
								<button class="tm_btn" type="button" onclick="tmPaper.countScore()">计算总分</button>
							</div>
							<div class="tm_adm_paper_body">
								<c:choose>
									<c:when test="${empty paperx }">
										<ul class="tm_adm_paper_body_section" id="paper_sections">
											<li>
												<dl class="tm_adm_paper_body_section_dl">
													<dt>
													<span class="section_title">
														段落名称 :
														<input type="text" name="p_section_names" class="validate[required] tm_txt" size="50" />
													</span>
														<span class="section_tools">
														<a href="javascript:void(0);" onclick="javascript:tmPaper.toggleSection(this);" class="tm_ico_delete tm_position_adjustment"></a>
													</span>
														<input type="hidden" name="p_section_ids" value="1" />
													</dt>
													<dt>
														段落描述 :
														<input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" />
													</dt>
													<dt>
														段落设定 :
														<span class="tm_section_setting">
															<select name="p_dbids" class="validate[required] tm_select" style="min-width:150px">
																<option value="">选择题库</option>
																<c:forEach var="qdb" items="${qdbs}">
																	<option value="${qdb.id}">${qdb.name}</option>
																</c:forEach>
															</select>

															<select name="p_subjects" class="validate[required] tm_select" style="min-width:150px">
																<option value="">选择知识点</option>
																<c:forEach var="it" items="${fns:getDictList('dic_exam_questionsubject')}">
																	<option value="${it.value}">${it.label}</option>
																</c:forEach>
															</select>

															<select name="p_qtypes" class="validate[required] tm_select" style="min-width:100px">
																<option value="">选择题型</option>
																<c:forEach var="it" items="${fns:getDictList('dic_exam_questiontype')}">
																	<option value="${it.value}">${it.label}</option>
																</c:forEach>
															</select>

															<select name="p_levels" class="validate[required] tm_select" style="min-width:100px">
																<option value="">选择难度</option>
																<c:forEach var="it" items="${fns:getDictList('dic_exam_questionlevel')}">
																	<option value="${it.value}">${it.label}</option>
																</c:forEach>
															</select>

															&nbsp;
															试题数量 :
															<input type="text" class="validate[required,custom[integer],min[1]] tm_txt" size="3" name="p_qnums" maxlength="3" value="1" />

															&nbsp;
															每题分值 :
															<input type="text" class="validate[required,custom[integer],min[0]] tm_txt" size="3" name="p_scores" maxlength="3" value="0" />
														</span>
													</dt>
												</dl>
											</li>
										</ul>
									</c:when>


									<c:otherwise>
										<script>
											var_sectionId = 0;
										</script>
										<ul class="tm_adm_paper_body_section" id="paper_sections">
											<c:forEach var="section" items="${paperx.sections}">
												<li>
													<dl class="tm_adm_paper_body_section_dl">
														<dt>
													<span class="section_title">
														段落名称 :
														<input type="text" name="p_section_names" class="validate[required] tm_txt" size="50" value="${section.name}" />
													</span>
													<span class="section_tools">
														<a href="javascript:void(0);" onclick="javascript:tmPaper.removeSection(this);" class="tm_ico_delete tm_position_adjustment"></a>
													</span>
															<input type="hidden" name="p_section_ids" value="${section.id}" />
														</dt>
														<dt>
															段落描述 :
															<input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" value="${section.remark}" />
														</dt>
														<dt>
															段落设定 :
															<span class="tm_section_setting">
																<select name="p_dbids" class="validate[required] tm_select" style="min-width:150px">
																	<option value="">选择题库</option>
																	<c:forEach var="qdb" items="${qdbs}">
																		<option value="${qdb.id}" <c:if test="${section.rdbid == qdb.id}">selected</c:if>>${qdb.name}</option>
																	</c:forEach>
																</select>

																<select name="p_subjects" class="validate[required] tm_select" style="min-width:150px">
																	<option value="">选择知识点</option>
																	<c:forEach var="it" items="${fns:getDictList('dic_exam_questionsubject')}">
																		<option value="${it.value}" <c:if test="${section.subject == it.value}">selected</c:if>>${it.label}</option>
																	</c:forEach>
																</select>

																<select name="p_qtypes" class="validate[required] tm_select" style="min-width:100px">
																	<option value="">选择题型</option>
																	<c:forEach var="it" items="${fns:getDictList('dic_exam_questiontype')}">
																		<option value="${it.value}" <c:if test="${section.rtype == it.value}">selected</c:if>>${it.label}</option>
																	</c:forEach>
																</select>

																<select name="p_levels" class="validate[required] tm_select" style="min-width:100px">
																	<option value="">选择难度</option>
																	<c:forEach var="it" items="${fns:getDictList('dic_exam_questionlevel')}">
																		<option value="${it.value}" <c:if test="${section.rlevel == it.value}">selected</c:if>>${it.label}</option>
																	</c:forEach>
																</select>

																&nbsp;
																试题数量 :
																<input type="text" class="validate[required,custom[integer],min[1]] tm_txt" size="3" name="p_qnums" maxlength="3" value="${section.rnum}" />

																&nbsp;
																每题分值 :
																<input type="text" class="validate[required,custom[integer],min[0]] tm_txt" size="3" name="p_scores" maxlength="3" value="${section.rscore}" />
															</span>
														</dt>
													</dl>
												</li>
												<script>
													var_sectionId++;
												</script>
											</c:forEach>
										</ul>
									</c:otherwise>
								</c:choose>
							</div>
							<!-- /tm_adm_paper_body -->

							<div class="tm_adm_paper_foot">
								<button class="tm_btn tm_btn_primary" type="submit">提交</button>
								<button class="tm_btn" type="button" onclick="javascript:history.go(-1);">取消</button>
							</div>

							<input type="hidden" name="id" value="${paper.id}" />
							<input type="hidden" name="name" value="${paper.name}" />
							<input type="hidden" name="status" value="${paper.status}" />
							<input type="hidden" name="starttime" value="<fmt:formatDate value="${paper.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
							<input type="hidden" name="endtime" value="<fmt:formatDate value="${paper.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
							<input type="hidden" name="duration" value="${paper.duration}" />
							<input type="hidden" name="showtime" value="<fmt:formatDate value="${paper.showtime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
							<input type="hidden" name="ordertype" value="${paper.ordertype}" />
							<input type="hidden" name="papertype" value="${paper.papertype}" />
							<input type="hidden" name="remark" value="${paper.
							remark}" />

							<input type="hidden" name="showkey" value="${paper.showkey}" />
							<input type="hidden" name="showmode" value="${paper.showmode}" />

							<c:forEach var="plink" items="${links}">
								<input type="hidden" name="ln_bid" value="${plink.ln_buid}" />
							</c:forEach>


							<%--<input type="hidden" name="updateBy.id" value="${sessionScope.SEN_USERNAME}" />--%>

						</div>
					</form>
				</td><!-- /left -->
			</tr>
		</table>
	</div>
</div>

<div id="tm_template_section" style="display:none">
	<li>
		<dl class="tm_adm_paper_body_section_dl">
			<dt>
				<span class="section_title">段落名称：<input type="text" name="p_section_names" maxlength="30" class="validate[required] tm_txt" size="50" /></span>
				<span class="section_tools">
						<a href="javascript:void(0);" onclick="javascript:tmPaper.removeSection(this);" class="tm_ico_delete tm_position_adjustment"></a>
					</span>
				<input type="hidden" name="p_section_ids" value="1" />
			</dt>
			<dt>段落描述：<input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" maxlength="30" /></dt>
			<dt>
				段落设定 :
				<span class="tm_section_setting">
							<select name="p_dbids" class="validate[required] tm_select" style="min-width:150px">
								<option value="">选择题库</option>
								<c:forEach var="qdb" items="${qdbs}">
									<option value="${qdb.id}">${qdb.name}</option>
								</c:forEach>
							</select>

							<select name="p_subjects" class="validate[required] tm_select" style="min-width:150px">
								<option value="">选择知识点</option>
								<c:forEach var="it" items="${fns:getDictList('dic_exam_questionsubject')}">
									<option value="${it.value}">${it.label}</option>
								</c:forEach>
							</select>

							<select name="p_qtypes" class="validate[required] tm_select" style="min-width:100px">
								<option value="">选择题型</option>
								<c:forEach var="it" items="${fns:getDictList('dic_exam_questiontype')}">
									<option value="${it.value}">${it.label}</option>
								</c:forEach>
							</select>

							<select name="p_levels" class="validate[required] tm_select" style="min-width:100px">
								<option value="">选择难度</option>
								<c:forEach var="it" items="${fns:getDictList('dic_exam_questionlevel')}">
									<option value="${it.value}">${it.label}</option>
								</c:forEach>
							</select>

							试题数量 :
							<input type="text" class="validate[required,custom[integer],min[1]] tm_txt" size="3" name="p_qnums" maxlength="3" value="1" />

							每题分值 :
							<input type="text" class="validate[required,custom[integer],min[0]] tm_txt" size="3" name="p_scores" maxlength="3" value="0" />
						</span>
			</dt>
		</dl>
	</li>
</div>
</body>
</html>