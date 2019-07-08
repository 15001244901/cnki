$(function() {
	gradingPaperDetail.init();
	gradingPaperDetail.resetEdit();
	gradingPaperDetail.resetEditHide();
	gradingPaperDetail.paperAdjust();
	gradingPaperDetail.closePaperSize();
    //点击头部事件
    // $('#divheader').click(function(){
    //     // gradingPaperDetail.savaSchedule();
    // });
});
var questionCounts = [];
var questionTypes = [];
var gradingPaperDetail = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
	
		//折叠信息栏
		$('.ess_up').click(function(){
			$('.left').animate({left:'-290px'});
			$('.paper_right').animate({width:'1200px'},function(){
				$('#left_hide').show();
			});
			
		});
		//展开解析栏
		$('#left_hide').click(function(){
			$('#left_hide').hide();
			$('.left').animate({left:'0'});
			$('.paper_right').animate({width:'920px'});
		});
		
//		var eid = gradingPaperDetail.getQueryString("eid");
		var pid = gradingPaperDetail.getQueryString("pid");
		$("#hidID").val(pid);
		$.ajax({
			url: urlpath_a + '/exam/paper/view.jhtml',
			type: "GET",
			async: false,
			data: {
				'id': pid
			},
			success: function(t) {
				console.log(t);

				var datas = t.data.sections;
				
				var paper = t.data;
				$("#hidID").val(paper.id);
				$("#hidName").val(paper.name);
                $('.paperName').html(paper.name);
				$('.paper_name').val(paper.name);
				// $("#txtDuration").val(paper.duration);
				// $("#txtTotalScore").val(paper.totalscore);
				$('.reset_paper_time').html(paper.duration);
				$('.reset_paper_resord').html(paper.totalscore);
				// $("#txtPassScore").val(paper.passscore);

				$("#hidOrderType").val(paper.ordertype);
				$("#hidPaperType").val(paper.papertype);
				if(true) {

					$("#divName").html(t.data.name);

                    // 试题答案
                    var paper_qkey = [];
					paper_qkey.push('<div class="paperName" style="text-align:center;margin-top:15px;margin-bottom:15px;font-weight:bold;color:#222;font-size:16px;font-family:宋体">'+paper.name+'答案</div>');

					var html = [];
					var questionCount = 1;
					var questionContNumber = 0;
					for(var i = 0; i < datas.length; i++) {
					if(datas[i].questions){
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
						questionTypes.push({'type':datas[i].name,'num':title});

						html.push('<div class="div2" id="style-'+datas[i].id+'">');

						html.push(' <div class="one1" style="font-size:14px;font-weight:bold;vertical-align:middle;">');
						html.push(' <table align=left class="class_scord" style="text-align:center;color:#333;background:#fff;padding:5px 0;margin-right:20px;border-collapse:collapse;display: none;">');
                        html.push('  <tr><td style="width:70px;border:1px solid #dcdcdc;font-weight:500;">阅卷人</td><td style="width:70px;border:1px solid #dcdcdc;font-weight:500;"></td></tr>');

                        html.push('  <tr><td style="width:70px;border:1px solid #dcdcdc;font-weight:500;">得分</td><td style="width:70px;border:1px solid #dcdcdc;font-weight:500;"></td></tr>');
                        html.push(' </table>');
						html.push(   '<p>'+title+ datas[i].name + '&nbsp;<span class="one1_remark" style="color:#555;font-weight:100;padding-left:10px;">'+ datas[i].remark +'</span></p>');
						html.push(' </div>');

                        paper_qkey.push('<div style="font-size:14px;font-family:宋体;">'+ title + datas[i].name + '，共'+ datas[i].questions.length +'道题</div>');
                        paper_qkey.push('<div style="margin:10px 25px;font-size:14px;font-family:宋体;">');

						var questions = datas[i].questions;

						for(var j = 0; j < questions.length; j++) {
							var qid = "Q-" + questions[j].id;
							//去除题干的html
							questions[j].qcontent = gradingPaperDetail.delP(questions[j].qcontent);
                            // questions[j].qkey = gradingPaperDetail.delPs(questions[j].qkey);

							var qcount = questionCount++;
							if(qcount.toString().length < 2) {
								qcount = "0" + qcount;
							}

							questionContNumber++;  //试题编号
							questionCounts.push({ "qcount": qcount, "qid": questions[j].id,'type': questions[j].qtype,'name':questions[j].typeName});
							html.push('<div id="QC-' + questions[j].id + '" class="ask_list" style="margin-right:10px;padding-bottom:10px;position:relative;">');

							if(questions[j].qtype == 1) { //单选
                                questions[j].qcontent = gradingPaperDetail.replaceBar(questions[j].qcontent);
								html.push('<div>');
								html.push(' <div class="two1" style="color:#222222;font-size:14px;line-height:24px;margin-left:20px;margin-right:20px;vertical-align:middle;"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores" style="color:#555;padding-right:5px;">( '+questions[j].qscore+'分 )</span>' +questions[j].qcontent + '</div>');
								html.push('</div>');

								html.push(' <div class="three1" style="clear:both;font-size:14px;margin:0 20px;padding-left:20px;">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									if(options[k].text){
										options[k].text = gradingPaperDetail.delP(options[k].text);
									}
                                    html.push('<div class=MsoNormal style="margin-bottom:0cm;margin-bottom:.0001pt;margin-left:15px;line-height:24px;vertical-align:middle;">');
                                    html.push(options[k].alisa + "&nbsp;、&nbsp;" + options[k].text);
                                    html.push('</div>');
								}
								html.push(' </div>');

                                paper_qkey.push('<span style="display:inline-block;margin-right:20px;">'+questionContNumber+'、'+questions[j].qkey+'</span>&nbsp;&nbsp;');

							} else if(questions[j].qtype == 2) { //多选
                                questions[j].qcontent = gradingPaperDetail.replaceBar(questions[j].qcontent);
                                html.push('<div>');
                                html.push(' <div class="two1" style="color:#222222;font-size:14px;line-height:24px;margin-left:20px;margin-right:20px;vertical-align:middle;"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores" style="color:#555;padding-right:5px;">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
                                html.push('</div>');

                                html.push(' <div class="three1" style="clear:both;font-size:14px;margin:0 20px;padding-left:20px;">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									if(options[k].text){
										options[k].text = gradingPaperDetail.delP(options[k].text);
									}
                                    html.push('<div class=MsoNormal style="margin-bottom:0cm;margin-bottom:.0001pt;margin-left:15px;line-height:24px;vertical-align:middle;">');
                                    html.push(options[k].alisa + "&nbsp;、&nbsp;" + options[k].text);
                                    html.push('</div>');
                                }
								html.push(' </div>');

                                paper_qkey.push('<span style="display:inline-block;margin-right:20px;">'+questionContNumber+'、'+questions[j].qkey+'</span>&nbsp;&nbsp;');

							} else if(questions[j].qtype == 3) { //判断
                                questions[j].qcontent = gradingPaperDetail.replaceBar(questions[j].qcontent);
                                html.push('<div>');
                                html.push(' <div class="two1" style="color:#222222;font-size:14px;line-height:24px;margin-left:20px;margin-right:20px;vertical-align:middle;"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores" style="color:#555;padding-right:5px;">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
                                html.push('</div>');

                                html.push(' <div class="three1" style="clear:both;font-size:14px;margin:0 20px;padding-left:20px;">');
                                html.push('  <div style="line-height:24px;">');
                                html.push('   <div class=MsoNormal style="margin-bottom:0cm;margin-bottom:.0001pt;margin-left:15px;line-height:24px;">Y&nbsp;、&nbsp;正确</div>');
                                html.push('   <div class=MsoNormal style="margin-bottom:0cm;margin-bottom:.0001pt;margin-left:15px;line-height:24px;">N&nbsp;、&nbsp;错误</div>');
                                html.push(' </div>');
                                html.push(' </div>');

                                paper_qkey.push('<span style="display:inline-block;margin-right:20px;">'+questionContNumber+'、'+questions[j].qkey+'</span>&nbsp;&nbsp;');

							} else if(questions[j].qtype == 4) { //填空
								var qcontent = gradingPaperDetail.replaceInput(questions[j].qcontent, questions[j].id);
                                html.push('<div>');
                                html.push(' <div class="two1" style="color:#222222;font-size:14px;line-height:24px;margin-left:20px;margin-right:20px;"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores" style="color:#555;padding-right:5px;">( '+questions[j].qscore+'分 )</span>' + qcontent + '</div>');
                                html.push('</div>');

                                paper_qkey.push('<div style="line-height:24px;;margin-bottom:15px;">'+questionContNumber+'、'+questions[j].qkey+'</div>');

							} else if(questions[j].qtype == 5) { //简答
                                html.push('<div>');
                                html.push(' <div class="two1" style="color:#222222;font-size:14px;line-height:24px;margin-left:20px;margin-right:20px;"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores" style="color:#555;padding-right:5px;">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
                                html.push('</div>');
                                html.push('<div></br></br></br></br></br></br></div>');

								paper_qkey.push('<div class="key_cont" style="line-height:24px;;margin-bottom:15px;"><span align=left style="float:left;">'+questionContNumber+'、</span><div style="margin-left:25px;">'+questions[j].qkey+'</div></div>');

							}else if(questions[j].qtype == 6) { //简答
                                html.push('<div>');
                                html.push(' <div class="two1" style="color:#222222;font-size:14px;line-height:24px;margin-left:20px;margin-right:20px;"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores" style="color:#555;padding-right:5px;">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
                                html.push('</div>');
                                html.push('<div></br></br></br></br></br></br></div>');

                                paper_qkey.push('<div class="key_cont" style="line-height:24px;;margin-bottom:15px;"><span style="float:left;">'+questionContNumber+'、</span><div style="margin-left:25px;">'+questions[j].qkey+'</div></div>');

							}
							html.push('</div>');
						}
						html.push('</div>');

                        paper_qkey.push('</div>');
					}
                    }
					var cardHtml = [];
					var count = 0;
					for(var l = 0; l < datas.length; l++) {
                        if(!datas[l].questions){
                        }else{
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
							case 5:
								title = '六、';
							  break;
                            }
                            cardHtml.push('<li id="item1_title">');
                            cardHtml.push(' <div class="item1_title">');
                            //cardHtml.push('   <b class="fl">' +title+ datas[l].name + '</b><span class="fr">得10分</span>');
                            cardHtml.push('   <b class="fl">' +title+ datas[l].name + '</b>');
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
					}
					$("#questionCard1").html(cardHtml.join(""));
					$(".exam_list").html(html.join(""));
                    $(".paper_qkey").html(paper_qkey.join(""));
                    $('.two1 table').css({'clear':'both','marginTop':'15px','text-align':'center'});
                    $('#creatPaper .two1').css({'marginTop':'15px','margin-bottom':'5px'});
                    $('#creatPaper .three1 div').css({'line-height':'18px'});
                    $('#creatPaper .one1 p').css({'marginTop':'15.0pt','marginBottom':'18.0pt'});
                    $('#creatPaper .div2').css({'marginBottom':'20px','marginTop':'10px'});
                    $('#creatPaper .paper_title_name').css({'marginBottom':'10px'});
                    $('#creatPaper img').css({'vertical-align':'middle'});
                    $('#creatPaper img').parents('.two1').css({'marginTop':'0'});


					$('.paper_qkey img').css({'vertical-align':'middle'});
					$('.key_cont>div>p').css({'marginTop':0,'marginBottom':0,'vertical-align':'middle'});
					$(".paper_qkey_bei").html($('.paper_qkey').html());

					gradingPaperDetail.paperScoreCar();
				}
			}
		});
	},
	anchorPosition: function(pos) {
	    var pos = $("#Q" + pos).offset().top;
	    $("html,body").animate({ scrollTop: pos }, 400);
	},
	// 替换小括号
    replaceBar:function(str){
        str = str.replace(/\（\）/g,'<u style="letter-spacing:40px;">&nbsp;</u>') + '（&nbsp;&nbsp;）';
        return str;
    },
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//去除html标签
	delHtmlTag:function(str){
		return str.replace(/<[^>]+>/g,"");//去掉所有的html标记
	},
	//去掉p
	delP:function(str){
		bstr = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
		bstr = bstr.replace(/&nbsp;/g,"");
		return bstr;
	},
	//去掉p
	delPs:function(str){
		str = str.replace(/&nbsp;/g,"");//去掉
		return str;
	},
	//替换输入框
	replaceInput: function(qcontent, qid) {
		// return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;');
        return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '<u style="letter-spacing:60px;">&nbsp;</u>');
    },
	//计算总分
	addTotal:function(id){
		var question_length = $('#style-'+id).find('.ask_list').length;
		var total = 0;
		for (var i = 0; i < question_length; i++) {
			var ch = parseInt($('#style-'+id).find('input[name=\'p_question_scores_'+id+'\']').eq(i).val());
			total += ch ;
		};
		$('#style-'+id).find('.one1_remark').html('( 共'+question_length+'题，共'+total+'分 )');
		$('#style-'+id).find('input[name=\'p_section_remarks\']').val('( 共'+question_length+'题，共'+total+'分 )');
		gradingPaperDetail.countTotal();
	},
	//批量计算总分
	addTotals:function(id,tos){
		var question_length = $('#style-'+id).find('.ask_list').length;
		var total = 0;
		for (var i = 0; i < question_length; i++) {
			$('#style-'+id).find('input[name=\'p_question_scores_'+id+'\']').eq(i).val(tos)
			var ch = parseInt($('#style-'+id).find('input[name=\'p_question_scores_'+id+'\']').eq(i).val());
			total += ch ;
		};
		$('#style-'+id).find('.one1_remark').html('( 共'+question_length+'题，'+total+'分 )');
		$('#style-'+id).find('input[name=\'p_section_remarks\']').val('( 共'+question_length+'题，'+total+'分 )');
		gradingPaperDetail.countTotal();
	},
	//清除汉字和符号
	clearChina:function(str){
		return str.replace(/[0-9]/g,"");
	},
	//从新排列左侧面板
	loadTable:function(){
		// console.log(questionCounts);
		var cardHtml = [];
		var count = 0;
		for(var l = 0; l < questionTypes.length; l++) {
			cardHtml.push('<li id="item1_title">');
			cardHtml.push(' <div class="item1_title">');
			cardHtml.push('   <b class="fl">' +questionTypes[l].num+ questionTypes[l].type + '</b>');
			cardHtml.push(' </div>');
			cardHtml.push(' <div class="item1_num item_num">');
			for(var k = 0; k < questionCounts.length; k++){

				if(questionCounts[k].name ==  questionTypes[l].type){
					count = count+1;
					cardHtml.push('<span class="item_active" id="QQC-' + questionCounts[k].qid + '" onclick="gradingPaperDetail.anchorPosition(\'C-' + questionCounts[k].qid + '\')">' + count + '</span>');
				}
			}
			cardHtml.push(' </div">');
			cardHtml.push('</li">');
		 
		
		}
		
		$("#questionCard1").html(cardHtml.join(""));
	},
	
	//试题编号重新排序
    Reordering:function(){
   		var dnum = $('.right .question_cont_number').length;
   		for(var d=0 ;d <= dnum;d++){
   			var ranknum = d+1;
   			$('.right .question_cont_number').eq(d).html(ranknum+'、');

   		}
    },
    //计算卷面总份数
    countTotal:function(){
    	var count_total = 0;
    	var qlength = $('.count_total').length;
    	for(var c=0; c<qlength;c++){
    		count_total += parseInt($('.count_total').eq(c).val());
    	}
    	$('#txtTotalScore').val(count_total);
		$("#txtPassScore").val(parseInt(count_total*0.6));
    },
    //删除试题
    deleQuestion:function(fid,pid){
    	$('#QC-'+fid).remove();
        if($('#style-'+pid).find('.ask_list').length<=0){
            $('#style-'+pid).find('.p_section').html('');
        }
    	for(var n=0;n < questionCounts.length;n++){
    		if(questionCounts[n].qid == fid)
    		questionCounts.splice(n,1);
    	}
    	
    	gradingPaperDetail.Reordering();
    	gradingPaperDetail.loadTable();
    	gradingPaperDetail.addTotal(pid);
    	gradingPaperDetail.countTotal();
    },

    //从新设置试卷总分
    replayPaperInfor:function(){
        var totalscore= $('#txtTotalScore').val();
        var id = gradingPaperDetail.getQueryString("pid");
        $.ajax({
            url: urlpath_a + '/exam/paper/save.jhtml',
            type: "post",
            data: {
                "id": id,
                "status": "0",
                "totalscore": totalscore,
                "passscore": parseInt(totalscore*6/10)
            },
            success: function(t) {
            }
        });
    },
	// 显示输入框
	resetEdit:function(){
		$('.reset_title').click(function(){
			$(this).hide();
			$('.reset_title_name').show().focus();
		});
        $('.paper_title_name').click(function(){
            $(this).hide();
            $('.reset_paper_title_name').show().focus();
        });
		$('.paperName').click(function(){
			$(this).hide();
			$('.paper_name').show().focus();
		});
	},
	//输入框失去焦点隐藏
	resetEditHide:function(){
		$('.paper_rule').on('blur','.reset_title_name',function(){
			var test = $(this).val();
			test = test.replace(/\n/g, '<br/>');//IE9、FF、chrome
			test = test.replace(/\r/g, '<br/>');//IE9、FF、chrome
			$('.reset_title').html(test);
			$(this).hide();
			$('.reset_title').show();
		});
        $('#infor_list').on('blur','.reset_paper_title_name',function(){
            var test = $(this).val();
            $('.paper_title_name').html(test);
            $(this).hide();
            $('.paper_title_name').show();
        });
		$('.paper_right').on('blur','.paper_name',function(){
			var test = $(this).val();
			test = test.replace(/\n/g, '<br/>');//IE9、FF、chrome
			test = test.replace(/\r/g, '<br/>');//IE9、FF、chrome
			$('.paperName').html(test);
			$(this).hide();
			$('.paper_right .paperName').show();
		});
	},
	// 调整试卷结构
	paperAdjust:function(){
		$('.paper_adjust li>span').click(function(){
			var edit_tegger = $(this).data('class');
            var is_html     = $('.paper_right .'+edit_tegger).html();
			if($(this).hasClass('check')){
				$(this).removeClass('check');
				$('.'+edit_tegger).hide();
                if(edit_tegger == 'paper_rule'){
                    $('.creatPaper .'+edit_tegger).html('');
                }
			}else{
				$(this).addClass('check');
				$('.'+edit_tegger).show();
                if(edit_tegger == 'paper_rule'){
                    $('.creatPaper .'+edit_tegger).html(is_html);
                }
			}
		});
	},
	// 插入总评分
	paperScoreCar:function(){
		var ques_num = $('#divContent .one1').length;
		var ques_score_car_title = [];
		var ques_score_car_stu = [];
		ques_score_car_title.push('<th style="border:1px solid #dcdcdc;width:120px;padding:5px 10px;font-weight:500;color:#000;">题号</th>');
		ques_score_car_stu.push('<th style="border:1px solid #dcdcdc;width:120px;padding:5px 10px;font-weight:500;color:#000;">得分</th>');
		for(var i=0;i<ques_num; i++){
			var title;
			switch(i){
				case 0:
					title = '一';
					break;
				case 1:
					title = '二';
					break;
				case 2:
					title = '三';
					break;
				case 3:
					title = '四';
					break;
				case 4:
					title = '五';
					break;
				case 5:
					title = '六';
					break;
			}
			ques_score_car_title.push('<td style="border:1px solid #dcdcdc;width:120px;padding:5px 10px;text-align:center">'+title+'</td>');
			ques_score_car_stu.push('<th style="border:1px solid #dcdcdc;width:120px;padding:5px 10px;font-weight:500;color:#000;text-align:center"></th>');
		}
		ques_score_car_title.push('<td style="border:1px solid #dcdcdc;width:120px;padding:5px 10px;text-align:center">总分</td>');
		ques_score_car_stu.push('<th style="border:1px solid #dcdcdc;width:120px;padding:5px 10px;font-weight:500;color:#000;"></th>');

		$('.paper_score_title').html(ques_score_car_title.join(''));
		$('.paper_score_stu').html(ques_score_car_stu.join(''));
	},
    // 替换图片路径
    replaceImgUrl:function(ret){
        $(ret).each(function(){
            var isurl = $(this).prop('src');
			var index = isurl.lastIndexOf('userfiles');
			isurl=isurl.substr(index);
			var reg=/\//g;
            isurl = isurl.replace(reg,"\\");
            isurl = ctx_addr + isurl;
            $(this).prop('src',isurl);
        });
    },
	// 换回图片路径
	backImgUrl:function(){
        var img_num =  $('.paper_right img').length;
        for(var i=0;i<img_num ; i++){
            var url = $('.paper_right img').eq(i).prop('src');
            $('#creatPaper .exam_list img').eq(i).prop('src',url);
        }
	},
	//关闭弹出框
	closePaperSize:function(){
		//关闭弹出框
		$('.sel_psize_close').off('click').on('click',function(){
			$('#sel_psize').hide();
		});
		//选择纸张
		$('.sel_psize_cont_list li').off('click').on('click',function(){
			var issize = $(this).data('size');
			$('.sel_inp').addClass('no_sel').removeClass('has_sel');
			$(this).find('.sel_inp').addClass('has_sel').removeClass('no_sel');
			console.log(issize);
			$('#down_paper_size').val(issize);
		})

	},
	showPaperSize:function(){
		$('#sel_psize').show();
	},
    // 下载试卷
    downPaper:function(){
		$('#sel_psize').hide();
		if($('#creatPaper .paper_rule').html() == ''){
            $('#br').show();
        }
        $('#creatPaper .reset_title_name').remove();
        gradingPaperDetail.replaceImgUrl('#creatPaper .exam_list img');
        var html = $('#creatPaper').html();
		gradingPaperDetail.backImgUrl();
        var paper_name = $('#divName').html();

		$('#down_paper_name').val(paper_name);
		$('#down_paper_cont').val(html);
		$('#down_paper').trigger('click');
	},
    downPaperAnswer:function(){
        var paper_name = $('#divName').html();
        gradingPaperDetail.replaceImgUrl('.paper_qkey_bei img');
        var key_html = $('.paper_qkey_bei').html();
        $('.paper_qkey_bei').html($('.paper_qkey').html());
        $('#down_qkey_name').val(paper_name+'答案');
        $('#down_qkey_cont').val(key_html);
        $('#down_qkey').trigger('click');
    }

};


