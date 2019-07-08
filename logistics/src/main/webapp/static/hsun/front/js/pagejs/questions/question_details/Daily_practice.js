$(function() {
	dailyPractice.init();
});
var ints;
var interval = 1000;
var leftsecond = 0;
var dailyPractice = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		var load_img = '<img id="load_img" style="margin: 100px auto 0;display: block;" src="'+imgUrl+'/usercenter/images/loading.gif">';
		$('#model_exam').html(load_img);
		$.ajax({
			url: urlpath + '/user/practice/startPractice.jhtml',
			type: "GET",
			data: {
				ptype: 4
			},
			success: function(t) {
				console.log(t);
				var success = t.success;
				if(success) {
					var html = [];
					var datas = t.data.sections;
					if(typeof(datas) != "undefined") {
						$(".pos_name span").html(t.data.name);
						$("#hidDuration").val(t.data.duration);

						var questions = datas[0].questions;
						if(typeof(questions) != "undefined") {
							html.push('<div class="div2">');
							html.push('<div name="QDiv" id="QC-' + questions[0].id + '" style="display:block">');

							$(".key_cont_key p").html((questions[0].qkey || ''));
							$(".key_cont_lever p").html(questions[0].levelName);
							if(questions[0].qresolve){
								$(".key_cont_analysis p").html(questions[0].qresolve);
							}

							$("#hidQid").val(questions[0].id);

							if(questions[0].qcontent){
								questions[0].qcontent = dailyPractice.delP(questions[0].qcontent);
								questions[0].qcontent = '['+questions[0].typeName+'] '+questions[0].qcontent
							}
							if(questions[0].qtype == 1) {
								html.push(' <div class="two1"> ' + questions[0].qcontent + '</div>');
								html.push(' <div class="three1">');
								var options = questions[0].options;
								for(var k = 0; k < options.length; k++) {
									options[k].text = dailyPractice.delP(options[k].text);
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;" + options[k].text);
									html.push('</div>');
								}
								html.push(' </div>');
								html.push(' <div class="four1">');

								html.push('<div style="margin-left: 20px;">');
								for(var k = 0; k < options.length; k++) {
									html.push('<label class="labelRadio" id="Q-' + questions[0].id + "-" + options[k].alisa + '" name="' + questions[0].id + '" onclick="dailyPractice.choose(this,\'' + questions[0].id + '\')" for="radio-' + questions[0].id + '-' + k + '">' + options[k].alisa + '</label>');
									html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[0].id + '" name="Q-' + questions[0].id + '" id="radio-' + questions[0].id + '-' + k + '" value="' + options[k].alisa + '"/>');
								}
								html.push('</div>');
								html.push(' </div>');
							} else if(questions[0].qtype == 2) {
								html.push(' <div class="two1"> ' + questions[0].qcontent + '</div>');
								html.push(' <div class="three1">');
								var options = questions[0].options;
								for(var k = 0; k < options.length; k++) {
									options[k].text = dailyPractice.delP(options[k].text);
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;" + options[k].text);
									html.push('</div>');
								}
								html.push(' </div>');
								html.push(' <div class="four1">');

								html.push('<div style="margin-left: 20px;">');
								for(var k = 0; k < options.length; k++) {
									html.push('<label class="labelCheckbox" id="Q-' + questions[0].id + "-" + options[k].alisa + '" onclick="dailyPractice.chooseMulti(this,\'checkbox-' + questions[0].id + '-' + k + '\')" for="checkbox-' + questions[0].id + '-' + k + '">' + options[k].alisa + '</label>');
									html.push('<input class="checkbox qk-mchoice" type="checkbox" data-qid="' + questions[0].id + '" name="Q-' + questions[0].id + '" id="checkbox-' + questions[0].id + '-' + k + '" value="' + options[k].alisa + '">');
								}
								html.push('</div>');

								html.push(' </div>');

							} else if(questions[0].qtype == 3) {
								html.push(' <div class="two1"> ' + questions[0].qcontent + '</div>');

								html.push(' <div class="four1">');

								html.push('<div style="margin-left: 20px;">');
								html.push('<label class="labelRadio" id="Q-' + questions[0].id + '-Y" name="' + questions[0].id + '" onclick="dailyPractice.choose(this,\'' + questions[0].id + '\')" for="radio-' + questions[0].id + '-Y">Y</label>');
								html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[0].id + '" name="Q-' + questions[0].id + '" id="radio-' + questions[0].id + '-Y" value="Y"/>');
								html.push('<label class="labelRadio" id="Q-' + questions[0].id + '-N" name="' + questions[0].id + '" onclick="dailyPractice.choose(this,\'' + questions[0].id + '\')" for="radio-' + questions[0].id + '-N">N</label>');
								html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[0].id + '" name="Q-' + questions[0].id + '" id="radio-' + questions[0].id + '-N" value="N"/>');
								html.push('</div>');

								html.push(' </div>');

							} else if(questions[0].qtype == 4) {
								var qcontent = dailyPractice.replaceInput(questions[0].qcontent, questions[0].id);
								html.push(' <div class="two1"> ' + qcontent + '</div>');

							} else if(questions[0].qtype == 5) {
								html.push(' <div class="two1"> ' + questions[0].qcontent + '</div>');
								html.push('	<div class="four1">');
								html.push('  <div style="margin-left: 40px;">');
								// onchange="dailyPractice.changeTextArea(this,\'Q-' + questions[0].id + '\')"
								html.push('   <textarea class="questionTextArea qk-txt" name="Q-' + questions[0].id + '"></textarea>');
								html.push('   <div class="q-res">');
								html.push('    <div class="edit-wrap2">');
								html.push('      <div contenteditable="true" class="fill-edit txt-field edit-line done-textarea"></div>');
								html.push('    </div>');
								html.push('  </div>');
								html.push(' </div>');

							}else if(questions[0].qtype == 6) {
								html.push(' <div class="two1"> ' + questions[0].qcontent + '</div>');
								html.push('	<div class="four1">');
								html.push('  <div style="margin-left: 40px;">');
								// onchange="dailyPractice.changeTextArea(this,\'Q-' + questions[0].id + '\')"
								html.push('   <textarea class="questionTextArea qk-txt" name="Q-' + questions[0].id + '"></textarea>');
								html.push('   <div class="q-res">');
								html.push('    <div class="edit-wrap2">');
								html.push('      <div contenteditable="true" class="fill-edit txt-field edit-line done-textarea"></div>');
								html.push('    </div>');
								html.push('  </div>');
								html.push(' </div>');

							}
							html.push('</div>');
							html.push('</div>');
							html.push('<div style="padding-left: 30px;padding-right: 30px;margin: 20px;text-align:right">');
							html.push(' <input type="hidden" id="firstQuestion" value="QC-" />');
							html.push('</div>');
						}
						$("#model_exam").html(html.join(""));
						// 加载公式编辑器
						addedit();
					}
					dailyPractice.getData();
					ints = window.setInterval(function () {
						dailyPractice.ShowCountDown();
					}, interval);

				}
			},
			error:function(){
				loadFail('#model_exam')
			}
		});
	},
	//选择单选答案
	choose: function(lthis, id) {
		var radios = document.getElementsByName(id);
		for(var i = 0; i < radios.length; i++) {
			$(radios[i]).removeClass("chooseRadio");
		}
		$(lthis).addClass("chooseRadio");
		dailyPractice.changeProgress(100);
	},
	//选择多选答案
	chooseMulti: function(lthis, id) {
		if($('#'+id).prop('checked')) {
			$(lthis).removeClass("chooseCheckbox");
		} else {
			$(lthis).addClass("chooseCheckbox");
		}
		dailyPractice.changeProgress(100);
	},
	delP:function(str){
		if(!str){
			return str;
		}
		str=str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
		str = str.replace(/&nbsp;/g,"");
		return str;
	},
	//判断题
	chooseTrueFalse: function(lthis, YN, id) {
		var truefalse = document.getElementsByName(id);
		for(var i = 0; i < truefalse.length; i++) {
			$(truefalse[i]).removeClass("chooseTrueFalse");
		}
		$(lthis).addClass("chooseTrueFalse");
		if(YN == "Y") {
			$("#" + id).val("Y");
		} else {
			$("#" + id).val("N");
		}
		dailyPractice.changeProgress('100');
	},
	//替换输入框
	replaceInput: function(qcontent, qid) {
		//alert(qid);
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text" onchange="dailyPractice.changeInput(this,\'Q-' + qid + '\')" class="questionInput qk-blank" data-qid="' + qid + '" name="Q-' + qid + '" />&nbsp;&nbsp;')
	},
	//查看答案
	seeAnswer: function() {
		if($('.paper_key_cont').css('display') == 'none'){
			$('.paper_key_cont').slideDown();
			$(this).html('收起答案');
		}else{
			$('.paper_key_cont').slideUp();
			$('#answerDiv').slideUp();
			$(this).html('查看答案');
		}
	},
	//提交笔记
	submitNodes: function() {
		var ispublic = document.getElementById("chkpublic").checked;
		if(ispublic) {
			ispublic = 1;
		} else {
			ispublic = 0;
		}
		var nodescontent = $("#nodesContent").val();
		if(nodescontent == "") {
			layer.open({
				title: '系统提示',
				closeBtn: 1,
				skin: 'layui-layer-molv',
				content: '<div style="text-align:center;">笔记内容不能为空</div>',
				yes: function(index, layero){
					layer.close(index);
				}
			});
			return;
		}
		var code = $("#inp_text").val();
		if(code == "") {
			layer.open({
				title: '系统提示',
				closeBtn: 1,
				skin: 'layui-layer-molv',
				content: '<div style="text-align:center;">验证码不能为空</div>',
				yes: function(index, layero){
					layer.close(index);
				}
			});
			return;
		}
		var qid = $("#hidQid").val();

		$.ajax({
			url: urlpath_a + '/exam/question/commentsave.jhtml',
			type: "post",
			data: {
				ctype: 2,
				qid: qid,
				content: nodescontent,
				validateCode: code,
				ispublic: ispublic
			},
			success: function(t) {
				var success = t.success;
				if(success) {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+t.msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
						}
					});
					$("#pageNo").val("1");
					dailyPractice.getData();
				} else {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+t.msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
						}
					});
				}
			}
		});

	},
	//做笔记按钮
	nodesClick: function() {
		if($('#answerDiv').css('display') == 'none'){
			$('#answerDiv').slideDown();
		}else{
			$('#answerDiv').slideUp();
		}
	},
	//获取笔记列表
	getData: function() {
		var qid = $("#hidQid").val();
		var pageNo = $("#pageNo").val();
		//alert(urlpath_a + '/exam/question/comment.jhtml')
		$.ajax({
			url: urlpath_a + '/exam/question/comment.jhtml',
			type: "GET",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				qid: qid,
				ctype: 2
			},
			success: function(t) {
				var success = t.success;
				$("#spannodes").html(t.data.count);
				if(success) {
					var nodeshtml = [];
					var datas = t.data.list;
					if(typeof(datas) != "undefined") {
						$("#totalPageCount").val(t.data.totalPageCount);
						for(var i = 0; i < datas.length; i++) {
							nodeshtml.push('<tr>');
							nodeshtml.push('  <td>');
							nodeshtml.push('    <span class="spanUserPhoto"><img src="' + userphotopath + datas[i].userphoto + '"/></span>');
							nodeshtml.push('    <span class="spanName">' + datas[i].name + '</span>');
							nodeshtml.push('    <span class="spanTime">' + datas[i].createDate + '</span>');
							nodeshtml.push('    <br/>');
							nodeshtml.push('    <span class="spanContent">' + datas[i].content + '</span>');
							nodeshtml.push('  </td>');
							nodeshtml.push('</tr>');
						}
						$("#nodesTable").append(nodeshtml.join(""));
					}
					//$("#pagehtml").html(t.data.frontPageHtml);
				}
			}
		});
	},
	//暂停做题
	spanPause: function () {
		window.clearInterval(ints);
		layer.confirm('暂停做题，休息一下！', {
			btn: ['确定'],
			closeBtn: 0,
			title: false
		}, function () {
			ints = window.setInterval(function () {
				dailyPractice.ShowCountDown();
			}, interval);
			layer.closeAll('dialog');
		});
	},
	//倒计时
	ShowCountDown: function () {
		var day1 = Math.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day1 * 24 * 60 * 60) / 3600);
		var minute = Math.floor((leftsecond - day1 * 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day1 * 24 * 60 * 60 - hour * 3600 - minute * 60);
		var cc = document.getElementById("spanTime");
		var h = document.getElementById("spanHour");
		var m = document.getElementById("spanMinute");
		var c = document.getElementById("spanSecond");
		if (hour.toString().length == 1) {
			hour = "0" + "" + hour;
		}
		if (minute.toString().length == 1) {
			minute = "0" + "" + minute;
		}
		if (second.toString().length == 1) {
			second = "0" + "" + second;
		}
		h.innerHTML = hour;
		m.innerHTML = minute;
		c.innerHTML = second;

		leftsecond++;
	},
	//我要提交
	savaQuestions: function() {
		// 耗费时间
		var duration;
		if(leftsecond<=60){
			duration = 1
		}else{
			duration = Math.floor(leftsecond/60)
		}
		$('#hidTimecost').val(duration);
		$.ajax({
			url: urlpath + '/user/practice/submit.jhtml',
			type: "post",
			data: $("form").serialize(),
			success: function(t) {
				if(t.success) {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+t.msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
							window.location.href = "../question_bank.html"+timestamps;
						}
					});
				} else {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+t.msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
						}
					});
				}
			}
		});
	},
	// 监控进度条变化
	changeProgress:function(pernum){
		pernum = parseFloat(pernum.toFixed(2));
		$('.progress_num em').html('已完成'+pernum+'%');
		$('.progress_bar p').css('width',pernum+'%');
	},
	//填空题内容变化
	changeInput: function (lthis, qid) {
		var inputs = document.getElementsByName(qid);
		var input_par = $(lthis).parents('.two1');
		var input_nums = input_par.find('input').length;
		var result = 0;
		for (var i = 0; i < inputs.length; i++) {
			var inputValue = inputs[i].value;
			if (inputValue != "") {
				result += 1;
			}
		}
		var per_num   = (result/input_nums)*100;
		dailyPractice.changeProgress(per_num);
	},
	//输入域改变后改变进度条样式
	changeTextArea: function (lthis) {
		var input_nums = 1;
		var result = 0;
		if($(lthis).val()){
			result = 1
		}else{
			result = 0
		}
		var per_num   = (result/input_nums)*100;
		dailyPractice.changeProgress(per_num);
	}

};
//分页
function page() {
	var pageNo = $("#pageNo").val();
	$("#pageNo").val(parseInt(pageNo) + 1);

	var totalpage = $("#totalPageCount").val();
	if(parseInt(pageNo) + 1 == totalpage) {
		document.getElementById("pagehtml").style.display = "none";
		document.getElementById("pagehtml_all").style.display = "block";
	}
	dailyPractice.getData();
}
// 公式编辑器
function addedit(){
	var xml_data = "";
	var FormulaImgHash = {
		index: xml_data ? xml_data.index : 0, // 索引自增
		data: xml_data ? xml_data.answer_xml : {}, // 图片与xml映射内容
		answers: null, // 主观填空类图片答案
		getHash: function() {
			// 获取需要的图片与答案xml映射
			var ids = [];
			var _filter = function(str) {
				var reg = /data-kfformula-index="(\d+)"/g;
				var m;
				while (m = reg.exec(str)) {
					ids.push(m[1]);
				}
			};
			_.each(this.answers, function(item, i) {
				if (typeof item === 'string') {
					_filter(item);
				} else if (item != null && _.size(item) > 0) {
					_.each(item, function(v, k) {
						if (typeof v === 'string') _filter(v);
					})
				}
			});
			var res = {};
			_.each(this.data, function(v, k) {
				k = k.toString();
				if (_.indexOf(ids, k) > -1) {
					res[k] = v;
				}
			});
			return {
				answer_xml: res,
				index: this.index
			};
		}
	};
	// 公式编辑器

	// CKEDITOR.config.customConfig = 'config-custom.js';
	var current_editor = null;
	$('.fill-edit').each(function() {
		var _editor = CKEDITOR.inline(this);

		var self = this;
		_editor.on('change', function(evt) {
			var txt = _editor.getData();
			$('.qk-txt').val(txt);
			if(txt){
				dailyPractice.changeProgress(100);
			}else{
				dailyPractice.changeProgress(0);
			}
			$(self).trigger('fillblank', txt);
		});
		$(this).on('dblclick', function(evt){
			if (typeof formulaShow === 'function') formulaShow();
			current_editor = _editor;
		});
		_editor.on('focus', function(evt) {
			current_editor = _editor;
		});

		// $(this).parent('.edit-wrap2').find('.edit-show').on('click',function(){
		// 	$(self).trigger('dblclick');
		// });
	});

	if (document.body.addEventListener) {
		var $FeditorContainer = $('#formula-wrap');
		var formulaEditor_visible = false;
		var url = projectname + '/page/questions/test_sets/Start_the_test/editor.html';
		$FeditorContainer.find('iframe').attr({
			'src': url
		});

		var formulaShow = function(state) {
			if (state === false) {
				formulaEditor_visible = false;
				$FeditorContainer.animate({
					'right': '-800px'
				}, 'slow');
				return false;
			}
			if (formulaEditor_visible) return false;
			formulaEditor_visible = true;
			$FeditorContainer.animate({
				'right': 0
			}, 'slow');
		};

		// formulaShow();
		$('#J_FormulaClose').click(function() {
			formulaShow(false);
		});

		$FeditorContainer.draggable({
			handle: '.formula-tit',
			axis: "y",
			containment: 'window'
		});

		window.formulaReady = function(feditor) {
			$('#J_FormulaOk').click(function() {

				feditor.execCommand('get.image.data', function(data) {
					var latex = feditor.execCommand('get.source');
					var mathml = TeXZilla.toMathMLString(latex, false, false, true);
					// var html = '<img class="kfformula" src="'+ data.img +'" data-mathexpression="' + encodeURI(mathml) + '" />';
					var html = '<img class="kfformula" data-kfformula-index="' + FormulaImgHash.index + '" src="' + data.img + '" />';
					FormulaImgHash.data[FormulaImgHash.index] = mathml; // 全部变量，公式图片与xml映射
					FormulaImgHash.index += 1;
					if (current_editor) current_editor.insertHtml(html);
				});
			});

		}
	}
};