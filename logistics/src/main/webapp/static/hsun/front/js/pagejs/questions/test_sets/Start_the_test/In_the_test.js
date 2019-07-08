$(function() {
	inTheTest.init();
	$(window).scroll(function(){
		if ($(window).scrollTop() > 135){
			$('.left').addClass('pos');
		} else {
			$('#div .left').removeClass('pos');
		}
		var scroll_offset_top = $('#div').offset().top + $('#div').height();
		var table_offset_top  = $('.left').offset().top + 572;
		if( table_offset_top >= scroll_offset_top){
			$('.one4').hide();
		}else{
			$('.one4').show();
		}
	});
	// 全部变量，公式图片与xml映射
	$(function(){
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
			var url = 'editor.html';
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
	});
	//把编辑器的文本复制到相应的textarea
	$('.fill-edit').each(function(){
		$(this).off('blur').on('blur',function(){
			var this_html = $(this).html();
			this_html = inTheTest.delP(this_html);
			this_html = this_html.replace('<br>','');
			$(this).parents('.four1').find('textarea').val(this_html);
            $(this).parents('.four1').find('textarea').trigger('change');
            $(this).parents('.four1').find('textarea').trigger('blur');
		});
	});

});
var questionTypes = [];
var ints;
var interval = 1000;
var leftsecond = 0;
var inTheTest = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);

		var pid = inTheTest.getQueryString("id");
		$("#hidID").val(pid);
		tm_pid = pid;
		$.ajax({
			url: urlpath + '/user/paper/startExam.jhtml',
			type: "GET",
			async: false,
			data: {
				pid: pid
			},
			success: function(t) {
				// console.log(t);
				var success = t.success;
				if(success) {
					var datas = t.data.sections;
					$("#divName").html(t.data.name);
					$("#txtTotalScore").val(t.data.totalscore);
					$("#txtDuration").val(t.data.duration);

					leftsecond = t.data.duration * 60;

					//试题编号
					var question_num = 0;
					var html = [];
					var questionCounts = [];
					var questionCount = 1;
					for(var i = 0; i < datas.length; i++) {
						//题型序列号
						var title;
						switch(i){
							case 0:
								title = '一、';
								break;
							case 1:
								title = '二、';
								break;
							case 2:
								title = '三、';
								break;
							case 3:
								title = '四、';
								break;
							case 4:
								title = '五、';
								break;
							case 5:
								title = '六、';
								break;
						}
						questionTypes.push({'name':datas[i].name,'num':title,'type':datas[i].id});
						html.push('<div class="div2">');

						html.push(' <div class="one1">'+title + datas[i].name + '&nbsp;&nbsp;&nbsp;' + datas[i].remark + '</div>');
						var questions = datas[i].questions;

						for(var j = 0; j < questions.length; j++) {
							var qcount = questionCount++;
							question_num++;
							if(qcount.toString().length < 2) {
								qcount = "0" + qcount;
							}
							questionCounts.push({ "qcount": qcount, "qid": questions[j].id ,'stype':questions[j].qtype});
							html.push('<div id="QC-' + questions[j].id + '">');
							if(questions[j].qtype == 1) {
								html.push(' <div class="two1"> <span class="que_num">'+question_num+'、(<i>'+ questions[j].qscore +'分</i>)</span>'+ inTheTest.delP(questions[j].qcontent) + '</div>');
								html.push(' <div class="three1">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									if(options[k].text){
										options[k].text = inTheTest.delP(options[k].text);
									}
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;"+options[k].text);
									html.push('</div>');
								}
								html.push(' </div>');
								html.push(' <div class="four1">');

								html.push('<div style="margin-left: 20px;">');
								for(var k = 0; k < options.length; k++) {
									html.push('<label class="labelRadio" id="Q-' + questions[j].id + "-" + options[k].alisa + '" name="' + questions[j].id + '" onclick="inTheTest.choose(this,\'' + questions[j].id + '\')" for="radio-' + questions[j].id + '-' + k + '">' + options[k].alisa + '</label>');
									html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="radio-' + questions[j].id + '-' + k + '" value="' + options[k].alisa + '"/>');
								}
								html.push('</div>');

								html.push(' </div>');
								if(j != questions.length - 1) {
									html.push(' <hr />');
								}

							} else if(questions[j].qtype == 2) {
								html.push(' <div class="two1"><span class="que_num">'+question_num+'、(<i>'+ questions[j].qscore +'分</i>)</span>'+ inTheTest.delP(questions[j].qcontent) + '</div>');
								html.push(' <div class="three1">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									if(options[k].text){
										options[k].text = inTheTest.delP(options[k].text);
									}
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;"+options[k].text);
									html.push('</div>');
								}
								html.push(' </div>');
								html.push(' <div class="four1">');

								html.push('<div style="margin-left: 20px;">');
								for(var k = 0; k < options.length; k++) {
									html.push('<label class="labelCheckbox" id="Q-' + questions[j].id + "-" + options[k].alisa + '" onclick="inTheTest.chooseMulti(this,\'checkbox-' + questions[j].id + '-' + k + '\')" for="checkbox-' + questions[j].id + '-' + k + '">' + options[k].alisa + '</label>');
									html.push('<input class="checkbox qk-mchoice" type="checkbox" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="checkbox-' + questions[j].id + '-' + k + '" value="' + options[k].alisa + '">');

								}
								html.push('</div>');

								html.push(' </div>');
								if(j != questions.length - 1) {
									html.push(' <hr />');
								}
							} else if(questions[j].qtype == 3) {
								html.push(' <div class="two1"><span class="que_num">'+question_num+'、(<i>'+ questions[j].qscore +'分</i>)</span>'+ inTheTest.delP(questions[j].qcontent) + '</div>');
								html.push(' <div class="three1">');
								html.push('  <div>Y&nbsp;、&nbsp;正确</div>');
								html.push('  <div>N&nbsp;、&nbsp;错误</div>');
								html.push(' </div>');
								html.push(' <div class="four1">');

								html.push('<div style="margin-left: 20px;">');

								html.push('<label class="labelRadio" id="Q-' + questions[j].id + '-Y" name="' + questions[j].id + '" onclick="inTheTest.choose(this,\'' + questions[j].id + '\')" for="radio-' + questions[j].id + '-Y">Y</label>');
								html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="radio-' + questions[j].id + '-Y" value="Y"/>');
								html.push('<label class="labelRadio" id="Q-' + questions[j].id + '-N" name="' + questions[j].id + '" onclick="inTheTest.choose(this,\'' + questions[j].id + '\')" for="radio-' + questions[j].id + '-N">N</label>');
								html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="radio-' + questions[j].id + '-N" value="N"/>');
								html.push('</div>');

								html.push(' </div>');
								if(j != questions.length - 1) {
									html.push(' <hr />');
								}
							} else if(questions[j].qtype == 4) {
								var qcontent = inTheTest.replaceInput(questions[j].qcontent, questions[j].id);
								html.push(' <div class="two1 width95"> ' + question_num +'、(<i>'+ questions[j].qscore +'</i>)'+ inTheTest.delP(qcontent) + '</div>');

								if(j != questions.length - 1) {
									html.push(' <hr />');
								}
							} else if(questions[j].qtype == 5) {
								html.push(' <div class="two1"><span class="que_num">'+question_num+'、(<i>'+ questions[j].qscore +'分</i>)</span>'+ inTheTest.delP(questions[j].qcontent) + '</div>');
								html.push('	<div class="four1">');
								html.push('  <div style="margin-left: 40px;">');
								html.push('   <textarea onchange="inTheTest.changeTextArea(this,\'Q-' + questions[j].id + '\')" data-qid="' + questions[j].id + '" class="questionTextArea qk-txt textarea_cont" name="Q-' + questions[j].id + '"></textarea>');

								html.push('   <div class="q-res">');
								html.push('    <div class="edit-wrap2">');
								html.push('      <div contenteditable="true" class="fill-edit txt-field edit-line done-textarea"></div>');

								html.push('    </div>');
								html.push('   </div>');

								html.push('  </div>');
								html.push(' </div>');
								if(j != questions.length - 1) {
									html.push(' <hr />');
								}
							} else if(questions[j].qtype == 6) {
								html.push(' <div class="two1 width95"><span class="que_num">'+question_num+'、(<i>'+ questions[j].qscore +'分</i>)</span>'+ inTheTest.delP(questions[j].qcontent) + '</div>');
								html.push('	<div class="four1">');
								html.push('  <div style="margin-left: 40px;">');
								html.push('   <textarea class="textarea_cont qk-txt" onchange="inTheTest.changeTextArea(this,\'Q-' + questions[j].id + '\')" data-qid="' + questions[j].id + '" class="questionTextArea qk-txts" name="Q-' + questions[j].id + '"></textarea>');

								html.push('   <div class="q-res">');
								html.push('    <div class="edit-wrap2">');
								html.push('      <div contenteditable="true" class="fill-edit txt-field edit-line done-textarea"></div>');

								html.push('    </div>');
								html.push('   </div>');

								html.push('  </div>');
								html.push(' </div>');
								if(j != questions.length - 1) {
									html.push(' <hr />');
								}
							}
							html.push('</div>');
						}
						html.push('</div>');
					}


					var cardHtml = [];
					// console.log(questionCounts);
					// console.log(questionTypes);
					// for(var i = 0; i < questionCounts.length; i++) {
                    //
					// 	cardHtml.push('<span class="notAnswer" id="QQC-' + questionCounts[i].qid + '" onclick="inTheTest.anchorPosition(\'C-' + questionCounts[i].qid + '\')">' + questionCounts[i].qcount + '</span>  ');
					// }

					for(var l = 0; l < questionTypes.length; l++) {
						cardHtml.push('<div id="item1_title">');
						cardHtml.push(' <div class="item1_title">');
						cardHtml.push('   <b class="fl">' +questionTypes[l].num+ questionTypes[l].name + '</b>');
						cardHtml.push(' </div>');
						cardHtml.push(' <div class="item1_num item_num">');
						for(var i = 0; i < questionCounts.length; i++){

							if(questionCounts[i].stype ==  questionTypes[l].type){
								cardHtml.push('<span class="notAnswer" id="QQC-' + questionCounts[i].qid + '" onclick="inTheTest.anchorPosition(\'C-' + questionCounts[i].qid + '\')">' + questionCounts[i].qcount + '</span>  ');
							}
						}
						cardHtml.push(' </div">');
						cardHtml.push('</div">');

					}
					$("#txtCount").val(questionCounts.length);
					$("#questionCard").html(cardHtml.join(""));
					$("#divContent").html(html.join(""));

					//自动加载本地缓存
					inTheTest.tmLoadUserPaperCache(tm_uid, tm_pid);

					$.ajax({
						type: "POST",
						url: urlpath + "/user/paper/"+pid+"/leftTime.jhtml",
						data: {"t":Math.random()},
						dataType: "json",
						success: function(ret){
							leftsecond = parseInt(ret["data"]);
							if(leftsecond == -9){
								alert('获取剩余时间失败,请联系管理员');
								top.location.reload();
							}else{
								ints = setInterval(function() { inTheTest.ShowCountDown(); }, interval);
							}
						},
						error:function(){
							alert('获取剩余时间失败,请联系管理员');
							top.location.reload();
						}
					});
				} else {
					$(window).unbind('beforeunload');
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+t.msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
							window.location.href = "online_test.html";
						}
					});

				}

			}
		});
	},
	//去掉html
	delHtml:function(str){
		// return str.replace(/<[^>]+>/g,"");
		str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
		bstr=str.replace(/<\/?.+?>/g,"");//去掉
		return bstr;
	},
	//去掉p
	delP:function(str){
		if(!str){
			return str;
		}
		str = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
		str = str.replace(/&nbsp;/g,"");
		return str;
	},
	//加载本地缓存
	tmLoadUserPaperCache: function(uid, pid) {
		var cacheData = tmUserDataCache.getCache(uid, pid);

		if(cacheData == null) {
			return;
		}
		try {
			var cacheJson = JSON.parse(cacheData);
			$.each(cacheJson, function(idx, item) {
				if(!item["value"]){
					return;
				}
				if(item["type"] == "blank") {
					var iskong = false;
					item["value"].map(function(val){
						if(val){
							iskong = true;
						}
					});
					if(!iskong){
						return;
					}
					$("input[name='" + item["name"] + "']").each(function(ii, iblank) {
						$(this).val(item["value"][ii]);
						var theqid = item["name"].replace("Q-", "");
						$("#QQC-" + theqid).attr("class", "yesAnswer");
					});

				} else if(item["type"] == "choice") {
					var theqid = item["name"].replace("Q-", "");
					$("#QQC-" + theqid).attr("class", "yesAnswer");
					$("#" + item["name"] + "-" + item["value"].split("")).attr("class", "labelRadio chooseRadio");
					$("input[name='" + item["name"] + "']").val(item["value"].split(""));

				} else if(item["type"] == "mchoice") {

					var cho = item["value"].split("");
					var theqid = item["name"].replace("Q-", "");
					$("#QQC-" + theqid).attr("class", "yesAnswer");
					for(var i = 0; i < cho.length; i++) {
						$("#" + item["name"] + "-" + cho[i]).attr("class", "labelCheckbox chooseCheckbox");
					}
					$("input[name='" + item["name"] + "']").val(item["value"].split(""));

				} else if(item["type"] == "essay") {

					$("textarea[name='" + item["name"] + "']").val(item["value"]);
					$("textarea[name='" + item["name"] + "']").next('.q-res').find('.txt-field').html(item["value"]);
					var theqid = item["name"].replace("Q-", "");
					$("#QQC-" + theqid).attr("class", "yesAnswer");
				}

			});

		} catch(e) {
			//BROWSER DOESN'T SUPPORTED
		}

	},
	anchorPosition: function(pos) {
		var pos = $("#Q" + pos).offset().top;
		$("html,body").animate({ scrollTop: pos }, 400);
	},
	//我要交卷
	savaQuestions: function() {
		$(window).unbind('beforeunload');
		$.ajax({
			url: urlpath + '/user/paper/submitPaper.jhtml',
			type: "post",
			data: $("form").serialize(),
			success: function(t) {
				var success = t.success;
				if(success) {
					layer.confirm('<div style="text-align:center;">提交成功！<p style="text-align:left;">（可以点击“个人中心”，到“考试记录”中查看考卷信息。）</p></div>', {
						title: '系统提示',
						closeBtn: 0,
						skin: 'layui-layer-molv',
						btn: ['返回','个人中心'] //按钮
					}, function(){
						window.location.href = "online_test.html";
					}, function(){
						window.location.href = urlpath+"/page/usercenter/usercenter.html";
					});

				} else {
					layer.confirm(t.msg, {
						btn: ['确定'],
						closeBtn: 0,
						title: false
					}, function() {
						layer.closeAll('dialog');
					});
				}
			}
		});
	},
	//替换输入框
	replaceInput: function(qcontent, qid) {
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text" onchange="inTheTest.changeInput(this,\'Q-' + qid + '\')" class="questionInput qk-blank" data-qid="' + qid + '" name="Q-' + qid + '" />&nbsp;&nbsp;')
	},
	//输入框改变值后触发改变答题卡样式
	changeInput: function(lthis, qid) {
		//var cardID = $(lthis).parent().parent().attr("id");
		var inputs = document.getElementsByName(qid);
		var result = "false";
		for(var i = 0; i < inputs.length; i++) {
			var inputValue = inputs[i].value;
			if(inputValue != "") {
				result = "true";
				break;
			}
		}
		var cardID = qid.replace("Q-", "QC-");
		if(result == "true") {
			$("#Q" + cardID).attr("class", "yesAnswer");
		}
		tmUserPaper.bindQuickTip();
	},
	//输入域改变后改变答题卡样式
	changeTextArea: function(lthis, qid) {
		//var cardID = $(lthis).parent().parent().parent().attr("id");
		var inputs = document.getElementsByName(qid);
		var result = "false";
		for(var i = 0; i < inputs.length; i++) {
			var inputValue = inputs[i].value;
			if(inputValue != "") {
				result = "true";
				break;
			}
		}
		var cardID = qid.replace("Q-", "QC-");
		if(result == "true") {
			$("#Q" + cardID).attr("class", "yesAnswer");
		} else {
			$("#Q" + cardID).attr("class", "notAnswer");
		}
		tmUserPaper.bindQuickTip();
	},
	//选择单选答案
	choose: function(lthis, id) {
		var radios = document.getElementsByName(id);
		for(var i = 0; i < radios.length; i++) {
			$(radios[i]).removeClass("chooseRadio");
		}
		$(lthis).addClass("chooseRadio");

		var cardID = $(lthis).parent().parent().parent().attr("id");
		$("#Q" + cardID).attr("class", "yesAnswer");

		tmUserPaper.bindQuickTip();
	},
	//选择多选答案
	chooseMulti: function(lthis, id) {
		if(document.getElementById(id).checked) {
			$(lthis).removeClass("chooseCheckbox");
		} else {
			$(lthis).addClass("chooseCheckbox");
		}
		var cardID = $(lthis).parent().parent().parent().attr("id");
		$("#Q" + cardID).attr("class", "yesAnswer");
		tmUserPaper.bindQuickTip();
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
		var cardID = $(lthis).parent().parent().parent().attr("id");
		$("#Q" + cardID).attr("class", "yesAnswer");
	},
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//暂停做题
	spanPause: function() {
		window.clearInterval(ints);
		parent.layer.confirm('暂停做题，休息一下！', {
			btn: ['继续做题'],
			closeBtn: 0,
			title: false
		}, function() {
			ints = window.setInterval(function() { inTheTest.ShowCountDown(); }, interval);
			parent.layer.closeAll('dialog');
		});
	},
	//倒计时
	ShowCountDown: function() {
		var day1 = Math.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day1 * 24 * 60 * 60) / 3600);
		var minute = Math.floor((leftsecond - day1 * 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day1 * 24 * 60 * 60 - hour * 3600 - minute * 60);
		var cc = document.getElementById("spanTime");
		var h = document.getElementById("spanHour");
		var m = document.getElementById("spanMinute");
		var c = document.getElementById("spanSecond");


		if(hour.toString().length == 1) {
			hour = "0" + "" + hour;
		}
		if(minute.toString().length == 1) {
			minute = "0" + "" + minute;
		}
		if(second.toString().length == 1) {
			second = "0" + "" + second;
		}
		// cc.innerHTML = hour + ":" + minute + ":" + second;
		h.innerHTML = hour;
		m.innerHTML = minute;
		c.innerHTML = second;

		if(leftsecond == 5*60) {
			layer.open({
				title: '系统提示',
				closeBtn: 0,
				skin: 'layui-layer-molv',
				content: '<div style="text-align:center;">注意：距离考试结束时间还有5分钟，请尽快作答！<br/>倒计时结束后，如您没有交卷，试卷将自动提交。</div>',
				yes: function(index, layero){
					layer.close(index);
				}
			});
		}

		if(leftsecond == 30) {
			layer.open({
				title: '系统提示',
				closeBtn: 0,
				skin: 'layui-layer-molv',
				content: '<div style="text-align:center;">30秒后试卷将自动提交!</div>',
				yes: function(index, layero){
					layer.close(index);
				}
			});
		}

		if(leftsecond <= 0) {
			$(window).unbind('beforeunload');
			clearInterval(ints);
			$.ajax({
				url: urlpath + '/user/paper/submitPaper.jhtml',
				type: "post",
				data: $("form").serialize(),
				success: function(t) {
					var success = t.success;
					if(success) {
						layer.closeAll('dialog');
						layer.confirm('<div style="text-align:center;">提交成功！<p style="text-align:left;">（可以点击“个人中心”，到“考试记录”中查看考卷信息。）</p></div>', {
							title: '系统提示',
							closeBtn: 0,
							skin: 'layui-layer-molv',
							btn: ['返回', '个人中心'] //按钮
						}, function () {
							window.location.href = "online_test.html";
						}, function () {
							window.location.href = urlpath+"/page/usercenter/usercenter.html";
						});
					} else {
						// alert(t.msg);
					}
				}
			});
		} else {
			leftsecond--;
		}
	}
};

$(window).bind('beforeunload', function() {
	return '您尚未提交试卷，确定离开此页面吗？';
});

var tm_pid = "1";
var tm_uid = ismyid;
var tmUserPaper = {
	bindQuickTip: function() {
		//单选题题绑定
		$(".qk-choice").click(function() {
			var thename = $(this).attr("name");
			var theqid = $(this).data("qid");
			var chval = "";
			$.each($('input[name=' + thename + ']:checked'), function(idx, item) {
				chval += $(this).val();
			});
			//增加到本地缓存
			tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "choice", chval);
		});
		//多选题题绑定
		$(".qk-mchoice").click(function() {
			var thename = $(this).attr("name");
			var theqid = $(this).data("qid");
			var chval = "";
			$.each($('input[name=' + thename + ']:checked'), function(idx, item) {
				chval += $(this).val();
			});
			//增加到本地缓存
			tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "mchoice", chval);
		});
		//填空题绑定
		$(".qk-blank").blur(function() {
			var thename = $(this).attr("name");
			var theqid = $(this).data("qid");
			var charrval = [];
			$.each($('input[name=' + thename + ']'), function(idx, item) {
				charrval.push($(this).val());
			});

			//增加到本地缓存
			tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "blank", charrval);
		});
		//问答题绑定
		$(".qk-txt").blur(function() {
			var thename = $(this).attr("name");
			var theqid = $(this).data("qid");
			var chval = $(this).val();
			//增加到本地缓存
			tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "essay", chval);

		});
	}
};
//本地缓存操作
var tmUserDataCache = {
	support: function() {
		try {
			if(window.localStorage) {
				return true;
			} else {
				return false;
			}
		} catch(e) {
			return false;
		}

	},

	addCache: function(uid, pid, qid, qtype, val) {

		if(!tmUserDataCache.support()) {
			return;
		}

		var cacheData = tmUserDataCache.getCache(uid, pid);
		var cacheKey = "C" + uid + pid;
		var cacheJson = [];
		try {
			if(cacheData != null) {
				cacheJson = JSON.parse(cacheData);
			}

			$(cacheJson).each(function(idx, item) {
				var _name = "Q-" + qid;
				if(_name == item["name"]) {
					cacheJson.splice(idx, 1);
				}
			});
			cacheJson.push({ "name": "Q-" + qid, "type": qtype, "value": val });

			var strCacheData = JSON.stringify(cacheJson);
			localStorage.setItem(cacheKey, strCacheData);

		} catch(e) {
			//BROWSER DOESN'T SUPPORTED
		}

	},

	getCache: function(uid, pid) {
		if(!tmUserDataCache.support()) {
			return;
		}
		var cacheKey = "C" + uid + pid;
		return localStorage.getItem(cacheKey);
	}
};
