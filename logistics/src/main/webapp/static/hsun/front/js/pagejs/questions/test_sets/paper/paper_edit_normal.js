$(function() {
	paperEditNormal.init();
});
var paperEditNormal = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		//tmPaper.uiInit();
		var id = paperEditNormal.getQueryString('pid');

		//绑定科目
		$.ajax({
			url: urlpath_a + '/sys/dict/listData.jhtml',
			type: "GET",
			async: false,
			data: {
				type: 'dic_exam_questionsubject' //科目
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data;
				var subjecthtml = [];
				if(success) {
					subjecthtml.push('<option value="">不限</option>');
					for(i = 0; i < datas.length; i++) {
						subjecthtml.push('<option value="' + datas[i].value + '">' + datas[i].label + '</option>');
					}
					$("#sltSubject").html(subjecthtml.join(""));

					//绑定题型
					$.ajax({
						url: urlpath_a + '/sys/dict/listData.jhtml',
						type: "GET",
						async: false,
						data: {
							type: 'dic_exam_questiontype' //题型
						},
						success: function(t) {
							var success = t.success;
							var datas = t.data;
							var questionhtml = [];
							if(success) {
								questionhtml.push('<option value="">不限</option>');
								for(i = 0; i < datas.length; i++) {
									questionhtml.push('<option value="' + datas[i].value + '">' + datas[i].label + '</option>');
								}
								$("#sltQuestion").html(questionhtml.join(""));

								//难度类别
								$.ajax({
									url: urlpath_a + '/sys/dict/listData.jhtml',
									type: "GET",
									async: false,
									data: {
										type: 'dic_exam_questionlevel' //难度
									},
									success: function(t) {
										var success = t.success;
										var datas = t.data;
										var levelhtml = [];
										if(success) {
											levelhtml.push('<option value="">不限</option>');
											for(i = 0; i < datas.length; i++) {
												levelhtml.push('<option value="' + datas[i].value + '">' + datas[i].label + '</option>');
											}
											$("#sltLevel").html(levelhtml.join(""));
											//根据试卷id获取试卷内容
											$.ajax({
												url: urlpath_a + '/exam/paper/view.jhtml',
												type: "GET",
												async: false,
												data: {
													id: id //试卷ID
												},
												success: function(t) {

													var success = t.success;

													if(success) {
														var paper = t.data;
														var datas = t.data.sections;
														$("#hidID").val(paper.id);
														$("#hidName").val(paper.name);
														$("#divName").html(paper.name);
														$("#txtDuration").val(paper.duration);
														$("#txtTotalScore").val(paper.totalscore);
														$("#txtPassScore").val(paper.passscore);

														$("#hidOrderType").val(paper.ordertype);
														$("#hidPaperType").val(paper.papertype);

														var contenthtml = [];
														if(typeof(datas) != "undefined") {
															for(i = 0; i < datas.length; i++) {
																contenthtml.push('<li>');
																contenthtml.push('  <dl class="tm_adm_paper_body_section_dl" style="padding: 0px; margin: 0px;">');
																contenthtml.push('    <dt>');
																contenthtml.push('      <span class="section_title">');
																contenthtml.push('        段落名称 :');
																contenthtml.push('        <input type="text" name="p_section_names" class="validate[required] tm_txt" size="50" value="' + datas[i].name + '" />');
																contenthtml.push('      </span>');
																contenthtml.push('      <span class="section_tools">');
																contenthtml.push('        <a onclick="javascript:tmPaper.toggleSection(this);">');
																contenthtml.push('          <i class="fa fa-arrow-circle-down" style="color: #2F96E9;font-size: 18px;"></i>');
																contenthtml.push('        </a>');
																contenthtml.push('        <a onclick="javascript:tmPaper.removeSection(this);">');
																contenthtml.push('          <i class="fa  fa-close" id="style" style="cursor:pointer;color: #FE8922;font-size: 18px;padding-left: 15px;"></i>');
																contenthtml.push('        </a>');
																contenthtml.push('      </span>');
																contenthtml.push('      <input type="hidden" name="p_section_ids" value="' + datas[i].id + '" />');
																contenthtml.push('    </dt>');
																contenthtml.push('    <dt>');
																contenthtml.push('      <span class="section_title">');
																contenthtml.push('        段落描述 :');
																contenthtml.push('        <input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" value="' + datas[i].remark + '"/>');
																contenthtml.push('      </span>');
																contenthtml.push('    </dt>');
																contenthtml.push('    <dd>');
																contenthtml.push('      <ul class="tm_adm_questionlist" data-sectionid="' + datas[i].id + '">');
																var questions = datas[i].questions;
																//alert(questions.length)
																for(var j = 0; j < questions.length; j++) {
																	contenthtml.push('        <li class="" style="list-style: outside none none; border-bottom: 1px solid rgb(220, 220, 220);">');
																	contenthtml.push('          <div style="margin: 10px">');

																	contenthtml.push('           <table>');
																	contenthtml.push('             <tr>');
																	contenthtml.push('               <td class="td1">');
																	contenthtml.push('                 <span class="span1">分值：</span>');
																	contenthtml.push('               </td>');
																	contenthtml.push('               <td class="td2">');
																	contenthtml.push('                 <span class="span2">');
																	contenthtml.push('                   <input class="txtScore" name="p_question_scores_' + datas[i].id + '" value="' + questions[j].qscore + '" type="text"/>');
																	contenthtml.push('                   <input name="p_question_types_' + datas[i].id + '" value="' + questions[j].qtype + '" type="hidden"/>');
																	contenthtml.push('                   <input name="p_question_ids_' + datas[i].id + '" value="' + questions[j].id + '" type="hidden"/>');
																	contenthtml.push('                   <input name="p_question_cnts_' + datas[i].id + '" value="' + questions[j].qcontent + '" type="hidden"/>');
																	contenthtml.push('                 </span>');
																	contenthtml.push('               </td>');
																	contenthtml.push('               <td class="td3">');
																	contenthtml.push('                 <span style="">' + paperEditNormal.replaceInput(questions[j].qcontent) + '</span>');
																	contenthtml.push('               </td>');
																	contenthtml.push('               <td>');
																	contenthtml.push('                  <span class="span3" onclick="javascript:tmPaper.removeItem(this);">');
																	contenthtml.push('                    <i class="fa fa-close" style="cursor:pointer;float: right;margin-right: 15px;margin-top: 5px;color: #FE8922;font-size: 18px;"></i>');
																	contenthtml.push('                  </span>');
																	contenthtml.push('               </td>');
																	contenthtml.push('             </tr>');
																	contenthtml.push('           </table>');

																	contenthtml.push('         </div>');
																	contenthtml.push('       </li>');
																}
																contenthtml.push('      </ul>');
																contenthtml.push('    </dd>');
																contenthtml.push('  </dl>');
																contenthtml.push('</li>');

															}
															$("#paper_sections").html(contenthtml.join(""));
															tmPaper.uiInit();
															var_sectionId = datas.length + 1;
														}
														paperEditNormal.treeDate("");
													}
												}
											});

										}
									}
								});
							}

						}
					});
				}

			}

		});
	},
	//查询
	searchLibrary: function() {

		var keyword = $("#keyword").val();
		$("#pageNo").val("1");
		$("#pageNoSingle").val("1");
		$("#pageNoCompany").val("1");

		var hidtype = $("#hidtype").val();
		if(hidtype == 1) {
			paperEditNormal.treeDate("");
		} else {
			//treeDateSingle(keyword);
		}
	},

	//分类点击
	clickType: function(sthis, value) {
		var spantype = document.getElementsByName("spanType");
		for(var i = 0; i < spantype.length; i++) {
			spantype[i].className = "";
		}
		sthis.className = "active";
		if(value == "知识点") {
			$("#hidtype").val("1")

			$("#pageNo").val("1");
			$("#pageNoCollection").val("1");
			$("#pageNoCompany").val("1");
			treeDate("");
		} else if(value == "我的收藏") {
			$("#hidtype").val("2")

			$("#pageNo").val("1");
			$("#pageNoCollection").val("1");
			$("#pageNoCompany").val("1");

			$("#questionListAll").html("");
			$("#questionListPage").html("");
		} else if(value == "企业专属") {
			$("#hidtype").val("3")

			$("#pageNo").val("1");
			$("#pageNoCollection").val("1");
			$("#pageNoCompany").val("1");

			$("#questionListAll").html("");
			$("#questionListPage").html("");
		}
	},
	//获取题库列表知识点
	treeDate: function(keyword) {
		var pageNo = $("#pageNo").val();
		var subjectValue = $("#sltSubject").val();
		var questionValue = $("#sltQuestion").val();
		var levelValue = $("#sltLevel").val();
		$.ajax({
			url: urlpath_a + '/exam/question/list.jhtml',
			type: "GET",
			data: {
				pageNo: pageNo, //当前页号
				pageSize: 10, //每页记录数
				qContent: keyword, //关键字
				subject: subjectValue, //科目
				QType: questionValue, //题型
				qLevel: levelValue, //难度
				qStatus: 1 //已审查的
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data.list;
				if(success) {
					var contenthtml = [];
					for(j = 0; j < datas.length; j++) {
						contenthtml.push('<li style="list-style: none;border-bottom:solid 1px #DCDCDC;cursor: cursorAt;">');
						contenthtml.push('	<div style="margin: 10px">');

						contenthtml.push('           <table>');
						contenthtml.push('             <tr>');
						contenthtml.push('               <td class="td1">');
						contenthtml.push('                 <span class="span1">分值：</span>');
						contenthtml.push('               </td>');
						contenthtml.push('               <td class="td2">');
						contenthtml.push('                 <span class="span2">');
						contenthtml.push('                    <input type="text" class="txtScore" name="p_question_scores_" />');
						contenthtml.push('                    <input type="hidden" name="p_question_types_" value="' + datas[j].qtype + '"/>');
						contenthtml.push('                    <input type="hidden" name="p_question_ids_" value="' + datas[j].id + '"/>');
						contenthtml.push('                    <input type="hidden" name="p_question_cnts_" value="' + datas[j].qcontent + '"/>');
						contenthtml.push('                 </span>');
						contenthtml.push('               </td>');
						contenthtml.push('               <td class="td3">');
						contenthtml.push('                 <span style="">' + paperEditNormal.replaceInput(datas[j].qcontent) + '</span>');
						contenthtml.push('               </td>');
						contenthtml.push('               <td>');
						contenthtml.push('                  <span class="span3" onclick="javascript:tmPaper.removeItem(this);">');
						contenthtml.push('                    <i class="fa fa-close" style="cursor:pointer;float: right;margin-right: 15px;margin-top: 5px;color: #FE8922;font-size: 18px;"></i>');
						contenthtml.push('                  </span>');
						contenthtml.push('               </td>');
						contenthtml.push('             </tr>');
						contenthtml.push('          </table>');

						contenthtml.push(' </div>');
						contenthtml.push('</li>');
					}
					$("#questionListAll").html(contenthtml.join(""));
					//tmPaper.uiInit();
					$("#questionListPage").html(t.data.frontPageHtml);
				}

			}
		});
	},
	//保存进度
	savaSchedule: function() {
		var formSerialize = $("form").serialize();
		formSerialize = formSerialize + "&iscomplete=0"
		$.ajax({
			url: urlpath_a + '/exam/paper/detail.jhtml',
			type: "POST",
			data: formSerialize,
			success: function(t) {
				var success = t.success;
				var msg = t.msg;
				if(success) {
					alert(t.msg);
					window.location.href = "../text_sets.html";
				} else {
					alert(msg);
				}
			}
		});
	},
	//完成选择
	savaChoose: function() {
		var formSerialize = $("form").serialize();
		formSerialize = formSerialize + "&iscomplete=1"
		$.ajax({
			url: urlpath_a + '/exam/paper/detail.jhtml',
			type: "POST",
			data: formSerialize,
			success: function(t) {
				var success = t.success;
				var msg = t.msg;
				if(success) {
					alert(t.msg);
					window.location.href = "../text_sets.html";
				} else {
					alert(msg);
				}
			}
		});
	},
	//替换输入框
	replaceInput: function(qcontent) {
		//return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text"  class="questionInput"/>&nbsp;&nbsp;')
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//获取url参数传值
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	}
}
var var_sectionId = 1;
var tmPaper = {
	uiInit: function() {
		$(".tm_adm_questionlist").unbind("sortstop");

		$(".tm_adm_questionlist").sortable({ connectWith: ".tm_adm_questionlist" }).disableSelection();

		$(".tm_adm_questionlist").bind('sortstop', function(event, ui) {
			//当前拖动的对象的父对象
			var questionUL = ui["item"].parent();
			//获取父对象的段落ID
			var section_id = questionUL.data("sectionid");
			//alert(section_id);
			//批量对下级空间更改命名
			questionUL.find("input[name^='p_question_scores_']").attr("name", "p_question_scores_" + section_id);
			questionUL.find("input[name^='p_question_types_']").attr("name", "p_question_types_" + section_id);
			questionUL.find("input[name^='p_question_ids_']").attr("name", "p_question_ids_" + section_id);
			questionUL.find("input[name^='p_question_cnts_']").attr("name", "p_question_cnts_" + section_id);
		});
		$(".tm_adm_paper_body_section").sortable({ connectWith: ".tm_adm_paper_body_section" }).disableSelection();
	},
	addSection: function() {
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
		html.push('      <a onclick="javascript:tmPaper.toggleSection(this);">');
		html.push('      <i class="fa fa-arrow-circle-down" style="color: #2F96E9;font-size: 18px;"></i>');
		html.push('      </a>');
		html.push('      <a onclick="javascript:tmPaper.removeSection(this);">');
		html.push('      <i class="fa  fa-close" id="style" style="color: #FE8922;font-size: 18px;padding-left: 15px;"></i>');
		html.push('      </a>');
		html.push('    </span>');
		html.push('    <input type="hidden" name="p_section_ids" value="' + var_sectionId + '" />');
		html.push('  </dt>');
		html.push('  <dt>');
		html.push('    <span class="section_title">');
		html.push('		段落描述 : ');
		html.push('		<input type="text" class="validate[required] tm_txt" size="50" name="p_section_remarks" />');
		html.push('	   </span>');
		html.push('  </dt>');
		html.push('  <dd>');
		html.push('     <ul class="tm_adm_questionlist" data-sectionid="' + var_sectionId + '"></ul>');
		html.push('  </dd>');
		html.push(' </dl>');
		html.push('</li>');
		$("#paper_sections").append(html.join(""));
		tmPaper.uiInit();
	},
	toggleSection: function(obj) {
		var pobj = $(obj).parent().parent().parent();

		var current_ico = $(obj).children("i").attr("class");
		//				alert(current_ico);
		if(pobj) {
			if(current_ico.indexOf("fa fa-arrow-circle-down") > -1) {
				$(obj).children("i").removeClass("fa fa-arrow-circle-down");
				$(obj).children("i").addClass("fa fa-arrow-circle-up");
				pobj.children("dd").slideUp();
			} else {
				$(obj).children("i").removeClass("fa fa-arrow-circle-up");
				$(obj).children("i").addClass("fa fa-arrow-circle-down");
				pobj.children("dd").slideDown();
			}
		}
	},
	removeSection: function(obj) {
		var pobj = $(obj).parent().parent().parent().parent();
		if(pobj.is("li")) {
			pobj.remove();
		} else {
			pobj.parent().remove();
		}
		tmPaper.countScore();
	},
	expandSection: function() {
		$(".tm_adm_paper_body_section_dl dd ").slideDown();
		$(".fa-arrow-circle-up").removeClass("fa-arrow-circle-up").addClass("fa-arrow-circle-down");
	},
	shrinkSection: function() {
		$(".tm_adm_paper_body_section_dl dd ").slideUp();
		$(".fa-arrow-circle-down").removeClass("fa-arrow-circle-down").addClass("fa-arrow-circle-up");
	},
	removeItem: function(obj) {
		var pobj = $(obj).parent().parent();
		if(pobj.is("li")) {
			pobj.remove();
		} else {
			pobj.parent().remove();
		}
		tmPaper.countScore();
	},
	countScore: function() {
		var totalscore = 0,
			passscore = 0;
		$(".tm_adm_paper_body_section .txtScore").each(function(i, o) {
			var score = parseInt($(this).val());
			totalscore += score;

		});
		passscore = Math.ceil(0.6 * totalscore);
		$("input[name='totalscore']").val(totalscore);
		$("input[name='passscore']").val(passscore);
	}
}
//分页
function page(pageno, pagesize) {
	var hidtype = $("#hidtype").val();
	if(hidtype == 1) {
		$("#pageNo").val(pageno);
		paperEditNormal.treeDate("");
	} else if(hidtype == 2) {
		$("#pageNoCollection").val(pageno);
		paperEditNormal.treeDateSingle("");
	} else if(hidtype == 3) {
		$("#pageNoCompany").val(pageno);
		paperEditNormal.treeDateSingle("");
	}
	//scrollTo(0, 0);
}