$(function() {
	editItemTwo.init();
});
var editItemTwo = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		var id = editItemTwo.getQueryString('id');
		$.ajax({
			url: urlpath_a + '/exam/paper/view.jhtml',
			type: "GET",
			async: false,
			data: {
				id: id //试卷ID
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data.sections;

				$("#divName").html(t.data.name);
				$("#txtTotalScore").val(t.data.totalscore);
				$("#txtduration").val(t.data.duration);

				$("#hidid").val(t.data.id)
				$("#hidname").val(t.data.name);
				$("#hidstatus").val(t.data.status);
				$("#hidstarttime").val(t.data.starttime);
				$("#hidendtime").val(t.data.endtime);
				$("#hidshowtime").val(t.data.showtime);
				$("#hidordertype").val(t.data.ordertype);
				$("#hidpapertype").val(t.data.papertype);
				$("#hidremark").val(t.data.remark);
				$("#hidshowkey").val(t.data.showkey);
				$("#hidshowmode").val(t.data.showmode);

				var html = [];
				if(success) {
					var count = 0
					for(i = 0; i < datas.length; i++) {
						var rnum = datas[i].rnum;
						var rscore = datas[i].rscore;

						count += rnum;
						html.push('<li class="firstChild">');
						html.push(' <dl style="margin:0px;padding:0px">');
						html.push('  <dt class="header">');
						html.push('   <span>' + datas[i].name + '（共' + rnum * rscore + '分）。</span>');
						html.push('   <span onclick="javascript:tmPaper.toggleSection(this);" class="txt">');
						html.push('    <i class="fa fa-minus-square" id="style4"></i>');
						html.push('   </span>');

						html.push('   <input name="p_section_ids" value="' + datas[i].id + '" type="hidden">');
						html.push('   <input name="p_section_names" value="' + datas[i].name + '" type="hidden">');
						html.push('   <input name="p_section_remarks" value="' + datas[i].remark + '" type="hidden">');

						html.push('   <input name="p_subjects" value="' + datas[i].subject + '" type="hidden">');
						html.push('   <input name="p_qtypes" value="' + datas[i].rtype + '" type="hidden">');
						html.push('   <input name="p_levels" value="' + datas[i].rlevel + '" type="hidden">');
						html.push('   <input name="p_qnums" value="' + datas[i].rnum + '" type="hidden">');
						html.push('   <input name="p_scores" value="' + datas[i].rscore + '" type="hidden">');

						html.push('  </dt>');
						html.push('  <dd style="margin: 0px;padding: 0px;">');
						html.push('   <ul data-sectionid="' + datas[i].id + '">');
						var questions = datas[i].questions;
						for(var j = 0; j < questions.length; j++) {
							html.push('    <li>');
							html.push('     <div class="menu-two">');
							html.push('     <div id="question_' + questions[j].id + '">');
							html.push('		  <input name="p_question_ids_' + datas[i].id + '" value="' + questions[j].id + '" type="hidden">');
							html.push('		  <input name="p_question_cnts_' + datas[i].id + '" value="' + questions[j].qcontent + '" type="hidden">');
							html.push('       <span class="four1">' + editItemTwo.replaceInput(questions[j].qcontent) + '</span>');
							html.push('       <span class="four2" onclick="editItemTwo.ShowDiv(\'' + questions[j].id + '\',' + datas[i].id + ')">重新编辑</span>');
							html.push('     </div>');
							html.push('     </div>');

							html.push('<input name="p_question_scores_' + datas[i].id + '" value="' + datas[i].rscore + '" type="hidden">');
							html.push('<input name="p_question_types_' + datas[i].id + '" value="' + questions[j].qtype + '" type="hidden">');

							html.push('    </li>');
						}
						html.push('   </ul>');
						html.push('  </dd>');
						html.push(' </dl>');
						html.push('</li>');
					}
					$("#txtCount").val(count);
					$("#questionsUL").html(html.join(""));

					//科目类别
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
							var ulSubject = [];
							if(success) {
								ulSubject.push('<option value="">不限</option>');

								for(i = 0; i < datas.length; i++) {
									ulSubject.push('<option value="' + datas[i].value + '">' + datas[i].label + '</option>');
								}
								$("#p_subject").html(ulSubject.join(""));

								//题型类型
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
										var ulQuestion = [];
										if(success) {
											ulQuestion.push('<option value="">不限</option>');
											for(i = 0; i < datas.length; i++) {
												ulQuestion.push('<option value="' + datas[i].value + '">' + datas[i].label + '</option>');
											}
											$("#p_types").html(ulQuestion.join(""));

											//难度类别
											$.ajax({
												url: urlpath_a + '/sys/dict/listData.jhtml',
												type: "GET",
												async: false,
												data: {
													type: 'dic_exam_questionlevel' //难度
												},
												success: function(t) {
													//var t = JSON.parse(data);
													var success = t.success;
													var datas = t.data;
													var ulLevel = [];
													if(success) {
														ulLevel.push('<option value="">不限</option>');
														for(i = 0; i < datas.length; i++) {
															ulLevel.push('<option value="' + datas[i].value + '">' + datas[i].label + '</option>');
														}
														$("#p_levels").html(ulLevel.join(""));
														editItemTwo.treeDate();
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
	//绑定题库列表
	treeDate: function() {
		var pageNo = $("#pageNo").val();
		var subject = $("#p_subject").val();
		var types = $("#p_types").val();
		var level = $("#p_levels").val();
		$.ajax({
			url: urlpath_a + '/exam/question/list.jhtml',
			type: "GET",
			data: {
				pageNo: pageNo,
				pageSize: 10, //每页记录数
				qStatus: 1, //0未审核；1已审核；2待定
				subject: subject, //科目
				QType: types, //题型
				qLevel: level //难度
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data.list;
				if(success) {
					var contenthtml = [];
					for(j = 0; j < datas.length; j++) {
						contenthtml.push('<tr>');
						contenthtml.push('  <td class="tdName">' + editItemTwo.replaceInput(datas[j].qcontent) + '</td>');
						contenthtml.push('  <td class="tdOperate">');
						var qcontent = editItemTwo.excludeSpecial(datas[j].qcontent);
						qcontent = qcontent.replace("\r\n", "").replace("\t", "");
						contenthtml.push('   <a href="javascript:;" onclick="editItemTwo.replaceQuestion(\'' + datas[j].id + '\',\'' + qcontent + '\');">确定</a>');
						contenthtml.push('  </td>');
						contenthtml.push('</tr>');
					}
					$("#tableContent").html(contenthtml.join(""));
					$("#divHtmlPage").html(t.data.frontPageHtml);
				}

			}
		});
	},
	//保存进度
	savaSchedule: function() {
		$("#hidstatus").val(0);
		$("#hidiscomplete").val(0);
		var formSerialize = $("form").serialize();
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
	//保存试卷
	saveQuestion: function() {
		$("#hidstatus").val(0);
		$("#hidiscomplete").val(1);
		var formSerialize = $("form").serialize();
		$.ajax({
			url: urlpath_a + '/exam/paper/detail.jhtml',
			type: "POST",
			//traditional: true,
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
	//替换题目
	replaceQuestion: function(id, names) {
		//试题ID
		var questionsID = $("#hidQuestionID").val();
		//段落ID
		var sectionID = $("#sectionID").val();
		var html = [];
		html.push('<input name="p_question_ids_' + sectionID + '" value="' + id + '" type="hidden">');
		html.push('<input name="p_question_cnts_' + sectionID + '" value="' + names + '" type="hidden">');
		html.push('<span class="four1">' + editItemTwo.replaceInput(names) + '</span>');
		html.push('<span class="four2" onclick="editItemTwo.ShowDiv(\'' + id + '\',\'' + sectionID + '\')">重新编辑</span>');

		$("#question_" + questionsID).html(html.join(""));
		$("#question_" + questionsID).attr("id", "question_" + id);
		document.getElementById("divquestionscontent").style.display = "none";
	},
	//搜索试题
	searchQuestions: function() {
		editItemTwo.treeDate("", "", "");
	},
	//显示试题题库
	ShowDiv: function(id, sectionid) {
		//		alert(id);
		$("#hidQuestionID").val(id);
		$("#sectionID").val(sectionid);
		document.getElementById("divquestionscontent").style.display = 'block';
	},
	//关闭div
	closeDiv: function() {
		document.getElementById("divquestionscontent").style.display = "none";
	},

	excludeSpecial: function(s) {
		s = s.replace(/[\'\"\\\/\b\f\n\r\t]/g, '');
		return s;
	},
	//替换输入框
	replaceInput: function(qcontent) {
		//return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text"  class="questionInput"/>&nbsp;&nbsp;')
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	}
}
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	editItemTwo.treeDate();
}
var tmPaper = {
	toggleSection: function(obj) {
		var pobj = $(obj).parent().parent();

		var current_ico = $(obj).children("i").attr("class");
		if(pobj) {
			if(current_ico.indexOf("fa fa-minus-square") > -1) {
				$(obj).children("i").removeClass("fa fa-minus-square");
				$(obj).children("i").addClass("fa fa-plus-square");
				pobj.children("dd").slideUp();
			} else {
				$(obj).children("i").removeClass("fa fa-plus-square");
				$(obj).children("i").addClass("fa fa-minus-square");
				pobj.children("dd").slideDown();
			}
		}
	}
}