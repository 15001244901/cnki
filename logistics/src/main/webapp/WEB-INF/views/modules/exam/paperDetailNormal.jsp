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

		var pager = null;
		var var_sectionId = 1;

		$(document).ready(function() {
			tmPaper.pageInit();
			pager = new Pagination("listnav");
			tmPaper.searchQuestions(1);
			jQuery('#form_paper_detail').validationEngine();
		});

		//分页回调
		function pagination_data() {
			tmPaper.searchQuestions(pager.getIndexPage());
		}

		var tmPaper = {
			uiInit : function(){
				$( ".tm_adm_questionlist" ).unbind("sortstop");

				$( ".tm_adm_questionlist" ).sortable({connectWith: ".tm_adm_questionlist"}).disableSelection();
				$( ".tm_adm_questionlist" ).bind('sortstop', function(event, ui) {
					//当前拖动的对象的父对象
					var questionUL = ui["item"].parent();
					//获取父对象的段落ID
					var section_id = questionUL.data("sectionid");
					//alert(section_id);

					//批量对下级空间更改命名
					questionUL.find("input[name^='p_question_scores_']").attr("name","p_question_scores_"+section_id);
					questionUL.find("input[name^='p_question_types_']").attr("name","p_question_types_"+section_id);
					questionUL.find("input[name^='p_question_ids_']").attr("name","p_question_ids_"+section_id);
					questionUL.find("input[name^='p_question_cnts_']").attr("name","p_question_cnts_"+section_id);
				});
				$( ".tm_adm_paper_body_section" ).sortable({connectWith: ".tm_adm_paper_body_section"}).disableSelection();

				//绑定计算分数的方法
				$(".tm_qscore").unbind("change");
				$(".tm_qscore").bind("change", function(){
					tmPaper.countScore();
				});

			},

			addSection : function(){
				var_sectionId++;
				var html = [];
				html.push('<li>');
				html.push('	<dl class="tm_adm_paper_body_section_dl">');
				html.push('  <dt>');
				html.push('    <span class="section_title">');
				html.push('		 段落名称 : ');
				html.push('		 <input type="text" name="p_section_names" class="validate[required] tm_txt" size="50" />');
				html.push('	   </span>');
				html.push('    <span class="section_tools">');
				html.push('      <a href="javascript:void(0);" onclick="javascript:tmPaper.toggleSection(this);" class="tm_ico_max tm_position_adjustment"></a>');
				html.push('      <a href="javascript:void(0);" onclick="javascript:tmPaper.removeSection(this);" class="tm_ico_delete tm_position_adjustment"></a>');
				html.push('    </span>');
				html.push('    <input type="hidden" name="p_section_ids" value="'+var_sectionId+'" />');
				html.push('  </dt>');
				html.push('  <dt>');
				html.push('		段落描述 : ');
				html.push('		<input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" />');
				html.push('  </dt>');
				html.push('  <dd>');
				html.push('     <ul class="tm_adm_questionlist" data-sectionid="'+var_sectionId+'"></ul>');
				html.push('  </dd>');
				html.push(' </dl>');
				html.push('</li>');
				$("#paper_sections").append(html.join(""));
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
				$(".tm_adm_paper_body_section .tm_qscore").each(function(i,o){
					var score = parseInt($(this).val());
					totalscore += score;

				});
				passscore = Math.ceil(0.6 * totalscore);
				$("input[name='totalscore']").val(totalscore);
				$("input[name='passscore']").val(passscore);
			},

			removeItem : function(obj){
				var pobj = $(obj).parent().parent().parent().parent();
				if(pobj.is("li")){
					pobj.remove();
				}else{
					pobj.parent().remove();
				}
				tmPaper.countScore();
			},


			searchQuestions : function(pageid){
				var q_type = $("select[name='qType']").val();
				var q_dbid = $("select[name='qDbid']").val();
				var q_level = $("select[name='qLevel']").val();
				var q_content = $("input[name='qContent']").val();

				$("#question_list").empty();
				var surl = "${ctx}/exam/question/listjson";
				$.getJSON(surl, {pageNo:pageid, qType:q_type, qDbid:q_dbid, qLevel:q_level, qContent:q_content, t:Math.random()}, function(data){
					if(data){
						$.each(data["list"],function(idx, itm){
							var content = itm["qContent"];
							if(content && content.length>32) content = content.substring(0,32) + "..";

							var arrline = new Array();
							arrline.push('<li><table class="question_item">');
							arrline.push('<tr>');
							arrline.push('<td class="td1">');
							arrline.push('	分值 : ');
							arrline.push('	<input type="text" name="p_question_scores_" class="validate[required,custom[integer],min[1]] tm_qscore" value="0" size="1" />');
							arrline.push('</td>');
							arrline.push('<td class="td2">');
							arrline.push(content);
							arrline.push('<input type="hidden" name="p_question_types_" value="'+itm["qType"]+'" />');
							arrline.push('<input type="hidden" name="p_question_ids_" value="'+itm["id"]+'" />');
							arrline.push('<input type="hidden" name="p_question_cnts_" value="'+content+'" />');
							arrline.push('</td>');
							arrline.push('<td class="td3"><a href="javascript:void(0);" onclick="javascript:tmPaper.removeItem(this);" class="tm_ico_delete"></a></td>');
							arrline.push('</tr>');
							arrline.push('</table></li>');
							$("#question_list").append(arrline.join(""));
						});
						tmPaper.uiInit();

						var totalrows = parseInt(data["count"]);
						var perpage = parseInt(data["pageSize"]);
						var current_page = parseInt(data["pageNo"]);
						var total_pages = parseInt(data["totalPageCount"]);

						try{
							pager.setStep(1);
							pager.setTotalNum(totalrows);
							pager.setMaxNum(perpage);
							pager.setIndexPage(current_page);
							pager.initPage("pager");
						}catch(e){
							alert(e.message);
							alert(e.description);
						}

					}
				});
			},

			pageInit : function(){

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
								<h2 style="background:#ddd; padding:5px 0;">
									<b>普通试卷</b> &nbsp;
									考生试卷相同
								</h2>
								<h2>
									<b>时间设定</b> : <fmt:formatDate value="${paper.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/> -- <fmt:formatDate value="${paper.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
								<button class="tm_btn" type="button" onclick="tmPaper.expandSection()">全部展开</button>
								<button class="tm_btn" type="button" onclick="tmPaper.shrinkSection()">全部收缩</button>
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
														<a href="javascript:void(0);" onclick="javascript:tmPaper.toggleSection(this);" class="tm_ico_max tm_position_adjustment"></a>
													</span>
														<input type="hidden" name="p_section_ids" value="1" />
													</dt>
													<dt>
														段落描述 :
														<input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" />
													</dt>
													<dd>
														<ul class="tm_adm_questionlist" data-sectionid="1"></ul>
													</dd>
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
														<a href="javascript:void(0);" onclick="javascript:tmPaper.toggleSection(this);" class="tm_ico_max tm_position_adjustment"></a>
														<a href="javascript:void(0);" onclick="javascript:tmPaper.removeSection(this);" class="tm_ico_delete tm_position_adjustment"></a>
													</span>
															<input type="hidden" name="p_section_ids" value="${section.id}" />
														</dt>
														<dt>
															段落描述 :
															<input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" value="${section.remark}" />
														</dt>
														<dd>
															<ul class="tm_adm_questionlist" data-sectionid="${section.id}">
																<c:forEach var="question" items="${section.questions}">
																	<li><table class="question_item">
																		<tr>
																			<td class="td1">
																				分值 :
																				<input type="text" name="p_question_scores_${section.id}" class="validate[required,custom[integer],min[1]] tm_qscore" value="${question.QScore}" size="1" />
																			</td>
																			<td class="td2">
																					${question.QContent}
																				<input type="hidden" name="p_question_types_${section.id}" value="${question.QType}" />
																				<input type="hidden" name="p_question_ids_${section.id}" value="${question.id}" />
																				<input type="hidden" name="p_question_cnts_${section.id}" value="${question.QContent}" />
																			</td>
																			<td class="td3"><a href="javascript:void(0);" onclick="javascript:tmPaper.removeItem(this);" class="tm_ico_delete"></a></td>
																		</tr>
																	</table></li>
																</c:forEach>
															</ul>
														</dd>
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

				<td width="10">&nbsp;</td>
				<!--  right-->
				<td width="450" valign="top">
					<div class="tm_question_pannel">
						<table border="0" cellpadding="0" cellspacing="0" width="100%" cellspacing="0">
							<tr>
								<th>从题库中筛选试题加入到当前试卷</th>
							</tr>
							<tr>
								<td>
									<select name="qType" class="tm_select" style="width:90px">
										<option value="">不限..</option>
										<c:forEach var="it" items="${fns:getDictList('dic_exam_questiontype')}">
											<option value="${it.value}">${it.label}</option>
										</c:forEach>
									</select>
									<select name="qDbid" class="tm_select" style="width:120px">
										<option value="">不限..</option>
										<c:forEach var="qdb" items="${qdbs}">
											<option value="${qdb.id}">${qdb.name}</option>
										</c:forEach>
									</select>
									<select name="qLevel" class="tm_select" style="width:90px">
										<option value="">不限..</option>
										<c:forEach var="it" items="${fns:getDictList('dic_exam_questionlevel')}">
											<option value="${it.value}">${it.label}</option>
										</c:forEach>
									</select>

									<input type="text" class="tm_txt" name="qContent" size="20" style="width:80px" placeholder="关键字" />
									<input type="image" src="${ctxStatic}/hsun/ywork/images/icos/search.png" onclick="tmPaper.searchQuestions(1)" class="btn_search" style="vertical-align:middle" />
								</td>
							</tr>
							<tr>
								<td valign="top">
									<!-- list -->
									<ul class="tm_adm_questionlist" id="question_list"></ul>
									<!-- list -->
								</td>
							</tr>
							<tr>
								<td align="center"><div id="listnav"></div></td>
							</tr>
						</table>
					</div>
					<!-- /tm_question_pannel -->
				</td>
				<!--  /right-->
			</tr>
		</table>
	</div>
</div>
</body>
</html>