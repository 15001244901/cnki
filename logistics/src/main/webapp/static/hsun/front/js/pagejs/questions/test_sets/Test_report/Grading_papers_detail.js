$(function() {
	gradingPaperDetail.init();

});
var stuArr = [];
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
		
		var eid = gradingPaperDetail.getQueryString("eid");
		var pid = gradingPaperDetail.getQueryString("pid");
		$("#hidID").val(pid);
		$.ajax({
			url: urlpath_a + '/exam/examHistory/detail.jhtml',
			type: "GET",
			async: false,
			dataType: "jsonp",
			jsonp: "callback",
			jsonpCallback: "successCallback",
			data: {
				eid: eid,
				pid: pid
			},
			success: function(t) {
				console.log(t);
				var paper = t.paper;
				var datas = t.paper.sections;
				var data = t.data; //答案
				var user = t.user; //考生信息
				var detail = t.detail;
				var check = t.check; //得分信息

				if(true) {
					gradingPaperDetail.nextStudent();
					$("#divName").html(paper.name);
					// $("#spanTimeSetting").html(paper.starttime + "-" + paper.endtime);
					$("#spanDuration").html(paper.duration+'分钟');
					$("#spanTotalScpre").html(paper.totalscore+'分');
					// $("#spanPassScore").html(paper.passscore);
					$("#spanName").html(detail.urealname);
					$("#spanNo").html(detail.uno);
					$("#spanStartTime").html(detail.starttime);
					$("#spanSaveTime").html(detail.endtime);

					var end_str = detail.endtime.replace(/-/g,"/");
					var end_date = new Date(end_str);
					var sta_str = detail.starttime.replace(/-/g,"/");
					var sta_date = new Date(sta_str);
					var numminute =(end_date-sta_date)/(1000);
					var numscond = (end_date-sta_date)/(1000*60);
					// console.log(numscond);
					if(numscond <= 1){
						$("#spanTimeCost").html(numminute+'秒');
					}else{
						$("#spanTimeCost").html(detail.timecost+'分钟');
					}
					$("#spanCheckNums").html((detail.score||'')+'分');

					var newtimes = new Date().getTime();     //获取当前时间戳
					var times = t.paper.showtime;
					var showtimestamps = Date.parse(new Date(times));  //将发放试卷时间转化为时间戳
					var differstamps = showtimestamps - newtimes ;
					// console.log(times);
					// console.log(showtimestamps);
					// console.log(differstamps);
					if(differstamps < 0){
						layer.open({
							title: '系统提示',
							closeBtn: 1,
							skin: 'layui-layer-molv',
							content: '<div style="text-align:center;">此试卷的成绩已经公布,试题分数已不能修改</div>',
							yes: function(index, layero){
								layer.close(index);
								// window.location.href = "edit_item_page_next.html?pid="+(id || pid);
							}
						});
					}


					var html = [];
					var questionCounts = [];
					var questionCount = 1;
					var titleNum = 0;
					for(var i = 0; i < datas.length; i++) {

						html.push('<div class="div2">');

						html.push(' <div class="one1"> ' + datas[i].name + '&nbsp;&nbsp;&nbsp;<span class="que_remark">' + datas[i].remark + '</span></div>');

						var questions = datas[i].questions;
						for(var j = 0; j < questions.length; j++) {
							titleNum = titleNum + 1;
							var qid = "Q-" + questions[j].id;
							//考生答案
							var answered = data[qid];

							if(typeof(answered) == "undefined") {
								answered = "";
							}else{
								answered = gradingPaperDetail.delAns(answered);
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

							//去除题干的html
							questions[j].qcontent = gradingPaperDetail.delP(questions[j].qcontent);


							questionCounts.push({ "qcount": qcount, "qid": questions[j].id });
							html.push('<div id="QC-' + questions[j].id + '" class="ask_list">');
							
							if(questions[j].qtype == 1) { //单选
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								html.push('	</div>');
								html.push('<div>');
								html.push(' <div class="two1"> ' + titleNum +'、(<i class="fen">'+ questions[j].qscore +'</i>)' + questions[j].qcontent + '</div>');
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
									html.push(options[k].alisa + "&nbsp;、&nbsp;" + options[k].text);
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
								if(differstamps >= 0){
									html.push('  <span class="de_fen" onclick="gradingPaperDetail.tm_buildSetter(\'' + detail.id + '\', \'' + questions[j].id + '\', \'' + questions[j].qscore + '\', this,\'2\');">得分设置</span>');
								}
								html.push('	</div>');

								html.push('<div>');
								html.push(' <div class="two1"> ' + titleNum +'、(<i class="fen">'+ questions[j].qscore +'</i>)' + questions[j].qcontent + '</div>');
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
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;" + options[k].text);
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
							} else if(questions[j].qtype == 3) { //判断
                                html.push('	<div class="get_set">');
                                html.push('	 <span class="jie_xi">答案解析</span>');
                                html.push('	</div>');
								html.push('<div>');
								html.push(' <div class="two1"> ' + titleNum +'、(<i class="fen">'+ questions[j].qscore +'</i>)' + questions[j].qcontent + '</div>');
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
								if(differstamps >= 0){
									html.push('<span class="de_fen" onclick="gradingPaperDetail.tm_buildSetter(\'' + detail.id + '\', \'' + questions[j].id + '\', \'' + questions[j].qscore + '\', this,\'4\');">得分设置</span>');
								}
								html.push('	</div>');

								var qcontent = gradingPaperDetail.replaceInput(questions[j].qcontent, questions[j].id);
								html.push('<div>');
								html.push(' <div class="two1"> ' + titleNum +'、(<i class="fen">'+ questions[j].qscore +'</i>)' + qcontent + '</div>');
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
								if(differstamps >= 0){
									html.push('<span class="de_fen" onclick="gradingPaperDetail.tm_buildSetter(\'' + detail.id + '\', \'' + questions[j].id + '\', \'' + questions[j].qscore + '\', this,\'5\');">得分设置</span>');
								}
								html.push('	</div>');

								html.push('<div>');
								html.push(' <div class="two1"> ' + titleNum +'、(<i class="fen">'+ questions[j].qscore +'</i>)' + questions[j].qcontent + '</div>');
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
							} else if(questions[j].qtype == 6) { //简答
								html.push('	<div class="get_set">');
								html.push('	 <span class="jie_xi">答案解析</span>');
								if(differstamps >= 0){
									html.push('<span class="de_fen" onclick="gradingPaperDetail.tm_buildSetter(\'' + detail.id + '\', \'' + questions[j].id + '\', \'' + questions[j].qscore + '\', this,\'6\');">得分设置</span>');
								}
								html.push('	</div>');

								html.push('<div>');
								html.push(' <div class="two1"> ' + titleNum +'、(<i class="fen">'+ questions[j].qscore +'</i>)' + questions[j].qcontent + '</div>');
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
						cardHtml.push('   <b class="fl">' +title+ datas[l].name + '</b>');
						var stu_scoerd=0;
						for(var i = 0; i < questions.length; i++){
							var qid = "Q-" + questions[i].id;
							var studentscore = Number(check[qid]);
							if(typeof(studentscore) == "undefined") {
								studentscore = 0;
							}
							stu_scoerd += studentscore;

						}
						cardHtml.push('   <span class="fr style_socre" id="style_score_'+datas[l].id+'"><span>'+stu_scoerd+'</span>&nbsp;分</span>');


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
					// console.log(questionCounts);
//					for(var i = 0; i < questionCounts.length; i++) {
//						cardHtml.push('<span class="notAnswer" id="QQC-' + questionCounts[i].qid + '" onclick="gradingPaperDetail.anchorPosition(\'C-' + questionCounts[i].qid + '\')">' + questionCounts[i].qcount + '</span>  ');
//					}
					$("#questionCard1").html(cardHtml.join(""));
					$("#divContent").html(html.join(""));

				}
			}
		});
		
		
	},
	anchorPosition: function(pos) {
		var pos = $("#Q" + pos).offset().top;
		$("html,body").animate({ scrollTop: pos }, 400);
	},
	//弹出批改分选项
	tm_buildSetter: function(eid, qid, score, obj,typenum) {
		var offset = $(obj).offset();
		var the_top = offset.top-20;
		var the_left = offset.left-84;

		var btns = '';
		for(var i = 0; i <= eval(score); i++) {
			btns += '<a href="javascript:;" onclick="gradingPaperDetail.tm_setScore(\'' + eid + '\',\'' + qid + '\',' + i + ','+typenum+');" class="tm_lnk_score">' + i + '</a> ';
		}

		$("#divsetter").css("width", "100px");
		$("#divsetter").css("height", "auto");
		$("#divsetter").css("top", the_top + "px");
		$("#divsetter").css("left", the_left + "px");
		$("#divsetter").html(btns);
		$("#divsetter").show();
	},
	//保存选项分
	tm_setScore: function(eid, qid, score ,pnum) {
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
					var total_score = parseInt($("#spanCheckNums").html());
					var new_score = eval(total_score - old_score + score);

					current_obj.html(score);
					$("#spanCheckNums").html(new_score+'分');

					var now_score = parseInt($('#style_score_'+pnum).find('span').html()) - old_score + score;
					$('#style_score_'+pnum).find('span').html(now_score);

					layer.msg(
						t.msg,
						{
							icon:1,
							time:3000,
							skin: 'layui-layer-molv',
							// title:'系统提示',
						}
					);
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
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	delAns:function(ans){
		return ans.replace(/`/g,"")
	},
	//去掉html
	delHtml:function(str){
		// return str.replace(/<[^>]+>/g,"");
		str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
		bstr=str.replace(/<\/?.+?>/g,"");//去掉
		return bstr;
	},
    delP:function(str){
		str = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
		str = str.replace(/&nbsp;/g,"");
        return str;
    },
	//返回上一页
	goBack:function(){
		var pid = gradingPaperDetail.getQueryString("pid");
		$('.save_pos').attr('href','Grading_papers_two.html?pid='+pid)
	},
	//下一个考生
	nextStudent:function(){
		var pid = gradingPaperDetail.getQueryString("pid");
		var eid = gradingPaperDetail.getQueryString("eid");
        var orderBy = gradingPaperDetail.getQueryString("orderBy");
		var offices = gradingPaperDetail.getQueryString("offices");
		var numArr;

		var arr = [];
		$.ajax({
			url: urlpath_a + '/exam/examHistory/list.jhtml',
			type: "GET",
			async: false,
			data: {
				'pid': pid,
				'orderBy':orderBy
			},
			success: function(t){
				var stunum = t.data.list;
				// console.log(eid);

				for(var i=0;i<stunum.length;i++){

					// console.log(stunum[i]);
					if(stunum[i].status == 2&&stunum[i].id===eid&&stunum[i+1]){
						stuArr.push({'id':stunum[i+1].id});
						$('#next_adr a').removeClass('next_pos1').addClass('next_pos');
                        $('#next_adr a').prop('href','Grading_papers_detail.html?eid=' + stuArr[0].id + '&pid=' + pid+'&orderBy='+orderBy+'&offices='+offices+timestampv);
					}

				}
			}
		});
	}

	//模拟分数弹出
//	tig:function(){
//		alert('ok');
//		$(this).parent('div').parent('.ask_list').width();
//		alert('no');
//	}
}