$(function() {
	gradingPaperDetail.init();
});
var gradingPaperDetail = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);

		//隐藏小操作面板
		$('#divsetter').mouseleave(function(){
			$("#divsetter").hide();
		});
		//折叠信息栏
		$('.ess_up').click(function(){
			$('.left').animate({left:'-290px'});
			$('#infor_list').animate({width:'1200px'});
			$('.right').animate({marginLeft:'10px',width:'1190px'},function(){
				$('#left_hide').show();
			});

		});
		//展开解析栏
		$('.jie_xi').off('click').live('click',function(){
			if($(this).parents('.ask_list').find('.jiexi_show').css('display') == 'none'){
				$(this).parents('.ask_list').find('.jiexi_show').slideDown();
			}else{
				$(this).parents('.ask_list').find('.jiexi_show').slideUp();
			}
		});
		$('#left_hide').click(function(){
			$('#left_hide').hide();
			$('.left').animate({left:'0'});
			$('#infor_list').animate({width:'910px'});
			$('.right').animate({marginLeft:'290px',width:'910px'});
		})

		var eid = gradingPaperDetail.getQueryString("id");
		var pid = gradingPaperDetail.getQueryString("pid")
		$("#hidID").val(pid);
		$.ajax({
			url: urlpath + '/user/practice/historydetail.jhtml',
			type: "GET",
			async: false,
			// dataType: "jsonp",
			// jsonp: "callback",
			// jsonpCallback: "successCallback",
			data: {
				id: eid,
				pid: pid
			},
			success: function(t) {

				console.log(t);
				var paper = t.paper;
				var datas = t.paper.sections;
				var data = t.answer; //答案
				var user = t.user; //考生信息
				var detail = t.detail;
				var check = t.check; //得分信息

				if(true) {

					$("#divName").html(paper.name);
					$('#userscore').find('span').html(detail.userscore+'分');
					$('#startdate').find('span').html(detail.timecost+'分钟');
					$('#testdate').find('span').html(detail.testdate);
					// $("#spanTimeSetting").html(paper.starttime + "-" + paper.endtime);
					// $("#spanDuration").html(paper.duration);
					// $("#spanTotalScpre").html(paper.totalscore);
					// $("#spanPassScore").html(paper.passscore);
					// $("#spanName").html(detail.urealname);
					// $("#spanNo").html(detail.uno);
					// $("#spanStartTime").html(detail.starttime);
					// $("#spanSaveTime").html(detail.endtime);
					// $("#spanTimeCost").html(detail.timecost);
					// $("#spanCheckNums").html(detail.score);
					if(!datas[0].questions){
						return;
					}

					var html = [];
					var questionCounts = [];
					var questionCount = 1;
					var num = 0;

					for(var i = 0; i < datas.length; i++) {

						html.push('<div class="div2">');

						html.push(' <div class="one1">' + (datas[i].name || '') + '&nbsp;&nbsp;&nbsp;<span class="que_remark">' +(datas[i].remark||'')+ '</span></div>');
						// html.push(' <div class="one1">' + datas[i].name + '&nbsp;&nbsp;&nbsp;' + (datas[i].remark||'') + '</div>');
						var questions = datas[i].questions;
						for(var j = 0; j < questions.length; j++) {
							var qid = "Q-" + questions[j].id;
							num ++;

							var qscore = '';
							if(questions[j].qscore){
								qscore = '('+questions[j].qscore +'分)';
							}else{
								qscore = '';
							}
							//去除题干的html
							questions[j].qcontent = gradingPaperDetail.delP(questions[j].qcontent);

							//考生答案
							var answered = data[qid];

							if(typeof(answered) == "undefined") {
								answered = "";
							}else{
								if(questions[j].qtype == "2"){
									answered = answered.replace(/\`/g,'');
								}else if(questions[j].qtype == "4"){
									answered = answered.split("`");
									for(var y=0;y<answered.length;y++){
										answered[y] = '【'+answered[y]+'】'
									}
									answered = answered.join('');
								}
							}
							//考生得分
							var studentscore = check[qid];
							if(typeof(studentscore) == "undefined") {
								studentscore = "0";
							}

							//标准答案
							var yesanswered = questions[j].qkey;
							var result = true;
							if(answered != yesanswered) {
								result = false;
							}

							var qcount = questionCount++;
							if(qcount.toString().length < 2) {
								qcount = "0" + qcount;
							}
							questionCounts.push({ "qcount": qcount, "qid": questions[j].id });
							html.push('<div id="QC-' + questions[j].id + '" class="ask_list">');
							if(questions[j].qtype == 1) { //单选
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								html.push('	</div>');
								html.push('<div>');
								html.push(' <div class="two1"><span class="span_title" >' +num+'、'+qscore+'</span>'+ questions[j].qcontent + '</div>');
								html.push(' <div class="answer">');
								if(result) {
									html.push('<img src="'+imgUrl+'/img/paper/true.png">');
								} else {
									html.push('<img src="'+imgUrl+'/img/paper/false.png">');
								}
								html.push(' <span class="get_scord">得分 : </span>');
								html.push(' <span>' + studentscore + '</span>');
								html.push(' </div>');
								html.push('</div>');

								html.push(' <div class="three1">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									if(options[k].text){
										options[k].text = gradingPaperDetail.delP(options[k].text);
									}
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;" + (options[k].text || ''));
									html.push('</div>');
								}
								html.push(' </div>');

								html.push(' <div class="four1">');
								html.push('   <div class="answered">');
								html.push('    【考生答案】 :<span>' + answered + '</span>');
								html.push('   </div>');
								html.push('   <div class="jiexi_show">');
								html.push('    <div class="answered">');
								html.push('     【标准答案】 :<span>' + questions[j].qkey + '</span>');
								html.push('    </div>');
								html.push('    <div class="answered">');
								html.push('     【试题解析】 :<span>' + (questions[j].qresolve||'') + '</span>');
								html.push('    </div>');
								html.push('   </div>');
								html.push(' </div>');

//								if(j != questions.length - 1) {
//									html.push(' <hr />');
//								}

							} else if(questions[j].qtype == 2) { //多选
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								html.push('	</div>');
								html.push('<div>');
								html.push(' <div class="two1"> <span class="span_title" >' +num+'、'+qscore+'</span>'+questions[j].qcontent + '</div>');
								html.push(' <div class="answer" >');

								if(result) {
									html.push('<img src="'+imgUrl+'/img/paper/true.png" >');
								} else {
									html.push('<img src="'+imgUrl+'/img/paper/false.png">');
								}
								html.push(' <span class="get_scord">得分 : </span>');
								html.push('<span class="tm_qks" qid="' + questions[j].id + '" >' + studentscore + '</span>');
								html.push(' </div>');
								html.push('</div>');

								html.push(' <div class="three1">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									if(options[k].text){
										options[k].text = gradingPaperDetail.delP(options[k].text);
									}
									html.push('  <span>' + options[k].alisa + '、' + (options[k].text || '') + '</span><br />');
								}
								html.push(' </div>');

								html.push(' <div class="four1">');
								html.push('   <div class="answered">');
								html.push('    【考生答案】 :<span>' + answered + '</span>');
								html.push('   </div>');
								html.push('   <div class="jiexi_show">');
								html.push('    <div class="answered">');
								html.push('     【标准答案】 :<span>' + questions[j].qkey + '</span>');
								html.push('    </div>');
								html.push('    <div class="answered">');
								html.push('     【试题解析】 :<span>' + (questions[j].qresolve||'') + '</span>');
								html.push('    </div>');
								html.push('   </div>');
								html.push(' </div>');

//								if(j != questions.length - 1) {
//									html.push(' <hr />');
//								}
							} else if(questions[j].qtype == 3) { //判断
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								html.push('	</div>');
								html.push('<div>');
								html.push(' <div class="two1"> <span class="span_title" >' +num+'、'+qscore+'</span>'+questions[j].qcontent + '</div>');
								html.push(' <div class="answer">');

								// if(result) {
								// 	html.push('<img src="../../../../img/paper/true.png">');
								// } else {
								// 	html.push('<img src="../../../../img/paper/false.png">');
								// }
								if(result) {
									html.push('<img src="'+imgUrl+'/img/paper/true.png">');
								} else {
									html.push('<img src="'+imgUrl+'/img/paper/false.png">');
								}
								html.push(' <span class="get_scord">得分 : </span>');
								html.push(' <span>' + studentscore + '</span>');
								html.push(' </div>');
								html.push('</div>');

								html.push(' <div class="three1">');
								html.push('  <div>');
								html.push("   Y&nbsp;、&nbsp;正确");
								html.push('  </div>');
								html.push('  <div>');
								html.push("   N&nbsp;、&nbsp;错误");
								html.push('  </div>');
								html.push(' </div>');

								html.push(' <div class="four1">');
								html.push('   <div class="answered">');
								html.push('    【考生答案】 :<span>' + answered + '</span>');
								html.push('   </div>');
								html.push('   <div class="jiexi_show">');
								html.push('    <div class="answered">');
								html.push('     【标准答案】 :<span>' + questions[j].qkey + '</span>');
								html.push('    </div>');
								html.push('    <div class="answered">');
								html.push('     【试题解析】 :<span>' + (questions[j].qresolve||'') + '</span>');
								html.push('    </div>');
								html.push('   </div>');
								html.push(' </div>');

//								if(j != questions.length - 1) {
//									html.push(' <hr />');
//								}
							} else if(questions[j].qtype == 4) { //填空
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								html.push('	</div>');
								var qcontent = gradingPaperDetail.replaceInput(questions[j].qcontent, questions[j].id);
								html.push('<div>');
								html.push(' <div class="two1"> ' +num+'、'+qscore+ qcontent + '</div>');
								html.push(' <div class="answer" >');

								if(result) {
									html.push('<img src="'+imgUrl+'/img/paper/true.png">');
								} else {
									html.push('<img src="'+imgUrl+'/img/paper/false.png">');
								}
								html.push(' <span class="get_scord">得分 : </span>');
								html.push(' <span class="tm_qks" qid="' + questions[j].id + '" >' + studentscore + '</span>');

								html.push(' </div>');
								html.push('</div>');
								html.push(' <div class="three1">');
								html.push(' </div>');

								html.push(' <div class="four1">');
								html.push('   <div class="answered">');
								html.push('    【考生答案】 :<span>' + answered + '</span>');
								html.push('   </div>');
								html.push('   <div class="jiexi_show">');
								html.push('    <div class="answered">');
								html.push('     【标准答案】 :<span>' + questions[j].qkey + '</span>');
								html.push('    </div>');
								html.push('    <div class="answered">');
								html.push('     【试题解析】 :<span>' + (questions[j].qresolve||'') + '</span>');
								html.push('    </div>');
								html.push('   </div>');
								html.push(' </div>');

//								if(j != questions.length - 1) {
//									html.push(' <hr />');
//								}

							} else if(questions[j].qtype == 5) { //简答
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								html.push('	</div>');
								html.push('<div>');
								html.push(' <div class="two1"><span class="span_title" >' +num+'、'+qscore+'</span>'+ gradingPaperDetail.deleteStyle(questions[j].qcontent) + '</div>');
								html.push(' <div class="answer" >');

								if(result) {
									html.push('<img src="'+imgUrl+'/img/paper/true.png">');
								} else {
									html.push('<img src="'+imgUrl+'/img/paper/false.png">');
								}
								html.push(' <span class="get_scord">得分 : </span>');
								html.push('  <span class="tm_qks" qid="' + questions[j].id + '" >' + studentscore + '</span>');
								html.push(' </div name="Q-' + questions[j].id + '">');
								html.push('</div>');
								html.push(' <div class="three1">');
								html.push(' </div>');
								html.push('	<div class="four1">');
								html.push('   <div class="answered">');
								html.push('    【考生答案】 :<span>' + answered + '</span>');
								html.push('   </div>');
								html.push('   <div class="jiexi_show">');
								html.push('    <div class="answered">');
								html.push('     【标准答案】 :<span>' + questions[j].qkey + '</span>');
								html.push('    </div>');
								html.push('    <div class="answered">');
								html.push('     【试题解析】 :<span>' + (questions[j].qresolve||'') + '</span>');
								html.push('    </div>');
								html.push('   </div>');
								html.push(' </div>');
//								if(j != questions.length - 1) {
//									html.push(' <hr />');
//								}
							} else if(questions[j].qtype == 6) { //计算
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								html.push('	</div>');
								html.push('<div>');
								html.push(' <div class="two1"><span class="span_title" >' +num+'、'+qscore+'</span>'+ questions[j].qcontent + '</div>');
								html.push(' <div class="answer" >');

								if(result) {
									html.push('<img src="'+imgUrl+'/img/paper/true.png">');
								} else {
									html.push('<img src="'+imgUrl+'/img/paper/false.png">');
								}
								html.push(' <span class="get_scord">得分 : </span>');
								html.push('  <span class="tm_qks" qid="' + questions[j].id + '" >' + studentscore + '</span>');
								html.push(' </div name="Q-' + questions[j].id + '">');
								html.push('</div>');
								html.push(' <div class="three1">');
								html.push(' </div>');
								html.push('	<div class="four1">');
								html.push('   <div class="answered">');
								html.push('    【考生答案】 :<span>' + answered + '</span>');
								html.push('   </div>');
								html.push('   <div class="jiexi_show">');
								html.push('    <div class="answered">');
								html.push('     【标准答案】 :<span>' + questions[j].qkey + '</span>');
								html.push('    </div>');
								html.push('    <div class="answered">');
								html.push('     【试题解析】 :<span>' + (questions[j].qresolve||'') + '</span>');
								html.push('    </div>');
								html.push('   </div>');
								html.push(' </div>');
//								if(j != questions.length - 1) {
//									html.push(' <hr />');
//								}
							}
							html.push('</div>');
						}
						html.push('</div>');
					}
					var cardHtml = [];
					var count = 0;
					for(var l = 0; l < datas.length; l++) {
						var questions = datas[l].questions;
						var title;
						switch(l){
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
						}
						cardHtml.push('<li id="item1_title">');
						cardHtml.push(' <div class="item1_title">');
						// if(datas[l].name){
						// 	cardHtml.push('   <b class="fl">' +title+ datas[l].name || '' + '</b>');
						// }else{
						// 	cardHtml.push('   <b class="fl"></b>');
						// }
						cardHtml.push('   <b class="fl">' +title+ (datas[l].name || '') + '</b>');
						var stu_scoerd=0;
						for(var i = 0; i < questions.length; i++){
							var qid = "Q-" + questions[i].id;
							var studentscore = Number(check[qid]);
							if(typeof(studentscore) == "undefined") {
								studentscore = 0;
							}
							stu_scoerd += studentscore;

						}
						cardHtml.push('   <span class="fr">'+stu_scoerd+'分</span>');


						cardHtml.push(' </div>');
						cardHtml.push(' <div class="item1_num item_num">');
						for(var k = 0; k < questions.length; k++){
							b = k+1;
							count = count+1;
							cardHtml.push('<span class="item_active" id="QQC-' + questions[k].id + '" onclick="gradingPaperDetail.anchorPosition(\'C-' + questions[k].id + '\')">' + count + '</span>');
						}
						cardHtml.push(' </div">');
						cardHtml.push('</li">');

					}
					$("#questionCard1").html(cardHtml.join(""));
					$("#divContent").html(html.join(""));

                    // 如果是按知识点练习
                    if(!paper.papertype){
                        $('#userscore').hide();
                        $('.answer span').hide();
                        $('.item1_title span').hide();
                    }
				}
			}
		});


	},
	anchorPosition: function(pos) {
		var pos = $("#Q" + pos).offset().top;
		$("html,body").animate({ scrollTop: pos }, 400);
	},
	//弹出批改分选项
	tm_buildSetter: function(eid, qid, score, obj) {
		var offset = $(obj).offset();
		var the_top = offset.top-20;
		var the_left = offset.left-76;

		var btns = '';
		for(var i = 0; i <= eval(score); i++) {
			btns += '<a href="javascript:;" onclick="gradingPaperDetail.tm_setScore(\'' + eid + '\',\'' + qid + '\',' + i + ');" class="tm_lnk_score">' + i + '</a> ';
		}

		$("#divsetter").css("width", "100px");
		$("#divsetter").css("height", "auto");
		$("#divsetter").css("top", the_top + "px");
		$("#divsetter").css("left", the_left + "px");
		$("#divsetter").html(btns);
		$("#divsetter").show();
	},
	//保存选项分
	tm_setScore: function(eid, qid, score) {
		$.ajax({
			url: urlpath_a + "/exam/examHistory/check.jhtml",
			type: "GET",
			dataType: "jsonp",
			jsonp: "callback",
			jsonpCallback: "successCallback",
			data: {
				"eid": eid,
				"qid": 'Q-'+qid,
				"score": score,
				"t": Math.random()
			},
			success: function(t) {
				console.log(t);
				var success = t.success;
				if(success) {
					var current_obj = $(".tm_qks[qid=" + qid + "]");
					var old_score = current_obj.html();
					var total_score = $("#spanCheckNums").html();
					var new_score = eval(total_score - old_score + score);

					current_obj.html(score);
					$("#spanCheckNums").html(new_score);

					alert(t.msg);
				}
			},
			error: function() {
				alert('系统忙，请稍后再试');
			}
		});
	},
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//替换输入框
	replaceInput: function(qcontent, qid) {
		//alert(qid);
		// return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text" onchange="gradingPaperDetail.changeInput(this,\'Q-' + qid + '\')" class="questionInput qk-blank" data-qid="' + qid + '" name="Q-' + qid + '" />&nbsp;&nbsp;')
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//删除样式
	deleteStyle:function(str){
		str = str.replace('/style="[^"]*"/g','');
		return str;
	},
	//去掉p
	delP:function(str){
		if(!str){
			return str;
		}
		str = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
		str = str.replace(/&nbsp;/g,"");
		return str;
	}
	//模拟分数弹出
//	tig:function(){
//		alert('ok');
//		$(this).parent('div').parent('.ask_list').width();
//		alert('no');
//	}
}