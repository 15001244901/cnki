$(function() {
	gradingPaperDetail.init();
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
			$('#infor_list').animate({width:'1200px'});
			$('.right').animate({marginLeft:'10px',width:'1190px'},function(){
				$('#left_hide').show();
			});
			
		});
		//展开解析栏
		// $('.jie_xi').off('click').live('click',function(){
		// 	if($(this).parents('.ask_list').find('.jiexi_show').css('display') == 'none'){
		// 		$(this).parents('.ask_list').find('.jiexi_show').slideDown();
		// 	}else{
		// 		$(this).parents('.ask_list').find('.jiexi_show').slideUp();
		// 	}
		// });
		$('#left_hide').click(function(){
			$('#left_hide').hide();
			$('.left').animate({left:'0'});
			$('#infor_list').animate({width:'910px'});
			$('.right').animate({marginLeft:'290px',width:'910px'});
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
				if( !t.success || !t.data.sections ){
                    layer.msg('您的试卷中还没有试题，您可以选取试题栏添加试题，也可返回上一页！', {
                        title:'系统提示',
                        time: 0, //20s后自动关闭
                        btn: ['前往试题栏', '返回上一层'],
                        area: ['360px', '200px'],
                        btnAlign: 'c',
                        skin: 'layui-layer-molv',
                        shade: [0.8, '#393D49'],
                        yes: function(){
                            window.location.href = "edit_item_page.html?pid="+pid+timestampv;
                        },
                        btn2: function(){
                            window.location.href = "../text_sets.html"+timestamps;
                        }
                    });
                    return;
				};
				var datas = t.data.sections;
				
				var paper = t.data;
				$("#hidID").val(paper.id);
				$("#hidName").val(paper.name);
				$("#divName").html(paper.name);
				$("#txtDuration").val(paper.duration);
				$("#txtTotalScore").val(paper.totalscore);
				$("#txtPassScore").val(paper.passscore);

				$("#hidOrderType").val(paper.ordertype);
				$("#hidPaperType").val(paper.papertype);
				if(true) {

					$("#divName").html(t.data.name);


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

						html.push(' <div class="one1">'+title+ datas[i].name + '&nbsp;&nbsp;&nbsp; <span class="one1_remark">'+ datas[i].remark +' </span>');
						html.push(' <div class="p_section">');
						html.push('  <input type="hidden" name="p_section_names" value="' + datas[i].name + '">');
						html.push('  <input type="hidden" name="p_section_ids" value="' + datas[i].id + '" />');
						html.push('  <input type="hidden" name="p_section_remarks" value="' + datas[i].remark + '"/>');
						html.push(' </div>');
						// html.push('  <div class="get_class_set">');
						// html.push('	  <span class="add_tis add_example" onclick="gradingPaperDetail.addSet(\'' + datas[i].id + '\')">加题</span>');
						// html.push('   <span class="de_fens" onclick="gradingPaperDetail.alertScodes(\'' + datas[i].id + '\',\'' + datas[i].name + '\')">批量设置得分</span>');
						// html.push('  </div>');
						html.push(' </div>');

						var questions = datas[i].questions;

						for(var j = 0; j < questions.length; j++) {
							var qid = "Q-" + questions[j].id;
							//去除题干的html
							questions[j].qcontent = gradingPaperDetail.delP(questions[j].qcontent);

							var qcount = questionCount++;
							if(qcount.toString().length < 2) {
								qcount = "0" + qcount;
							}

							questionContNumber++;  //试题编号
							questionCounts.push({ "qcount": qcount, "qid": questions[j].id,'type': questions[j].qtype,'name':questions[j].typeName});
							html.push('<div id="QC-' + questions[j].id + '" class="ask_list">');

							if(questions[j].qtype == 1) { //单选
								// html.push('	<div class="get_set">');
								// html.push('	 <span class="dele_ti" onclick="gradingPaperDetail.deleQuestion(\'' + questions[j].id + '\',\'' + datas[i].id + '\')">删除</span>');
								// html.push('  <span class="de_fen" onclick="gradingPaperDetail.alertScode(\'' + questions[j].id + '\',\'' + datas[i].id + '\',\'' + datas[i].name+ '\',\'' +questionContNumber+ '\')">得分设置</span>');
								// html.push('	</div>');

								html.push(' <div class="question_set" >');
								html.push('   <input class="count_total" name="p_question_scores_'+datas[i].id+'" value="'+questions[j].qscore+'" type="hidden"/>');
								html.push('   <input name="p_question_types_'+datas[i].id+'" value="'+questions[j].qtype+'" type="hidden"/>');
								html.push('   <input name="p_question_ids_'+datas[i].id+'" value="'+questions[j].id+'" type="hidden"/>');
								html.push(' </div>');

								html.push('<div>')
								html.push(' <div class="two1"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
								html.push('</div>');

								html.push(' <div class="three1">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									// html.push('<div style="float:left">');
									// html.push(options[k].alisa + "&nbsp;、&nbsp;");
									// html.push('</div>');
                                    //
									// html.push('<div>');
									// html.push(gradingPaperDetail.delP(options[k].text));
									// html.push('</div>');
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;"+gradingPaperDetail.delP(options[k].text));
									html.push('</div>');
								}
								html.push(' </div>');

							} else if(questions[j].qtype == 2) { //多选
								// html.push('	<div class="get_set">');
								// html.push('	 <span class="dele_ti" onclick="gradingPaperDetail.deleQuestion(\'' + questions[j].id + '\',\'' + datas[i].id + '\')">删除</span>');
								// html.push('  <span class="de_fen" onclick="gradingPaperDetail.alertScode(\'' + questions[j].id + '\',\'' + datas[i].id + '\',\'' + datas[i].name+ '\',\'' +questionContNumber+ '\')">得分设置</span>');
								// html.push('	</div>');

								html.push(' <div class="question_set" >');
								html.push('   <input class="count_total" name="p_question_scores_'+datas[i].id+'" value="'+questions[j].qscore+'" type="hidden"/>');
								html.push('   <input name="p_question_types_'+datas[i].id+'" value="'+questions[j].qtype+'" type="hidden"/>');
								html.push('   <input name="p_question_ids_'+datas[i].id+'" value="'+questions[j].id+'" type="hidden"/>');
								html.push(' </div>');

								html.push('<div>');
								html.push(' <div class="two1"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
								html.push('</div>');

								html.push(' <div class="three1">');
								var options = questions[j].options;
								for(var k = 0; k < options.length; k++) {
									// html.push('<div style="float:left">');
									// html.push(options[k].alisa + "&nbsp;、&nbsp;");
									// html.push('</div>');
                                    //
									// html.push('<div>');
									// html.push(gradingPaperDetail.delP(options[k].text));
									// html.push('</div>');
									html.push('<div>');
									html.push(options[k].alisa + "&nbsp;、&nbsp;"+gradingPaperDetail.delP(options[k].text));
									html.push('</div>');
								}
								html.push(' </div>');

							} else if(questions[j].qtype == 3) { //判断
								// html.push('	<div class="get_set">');
								// html.push('	 <span class="dele_ti" onclick="gradingPaperDetail.deleQuestion(\'' + questions[j].id + '\',\'' + datas[i].id + '\')">删除</span>');
								// html.push('  <span class="de_fen" onclick="gradingPaperDetail.alertScode(\'' + questions[j].id + '\',\'' + datas[i].id + '\',\'' + datas[i].name+ '\',\'' +questionContNumber+ '\')">得分设置</span>');
								// html.push('	</div>');

								html.push(' <div class="question_set" >');
								html.push('   <input class="count_total" name="p_question_scores_'+datas[i].id+'" value="'+questions[j].qscore+'" type="hidden"/>');
								html.push('   <input name="p_question_types_'+datas[i].id+'" value="'+questions[j].qtype+'" type="hidden"/>');
								html.push('   <input name="p_question_ids_'+datas[i].id+'" value="'+questions[j].id+'" type="hidden"/>');
								html.push(' </div>');

								html.push('<div>');
								html.push(' <div class="two1"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
								html.push('</div>');

								html.push('<div class="three1">');
								html.push(' <div>Y、&nbsp;&nbsp;正确</div>');
								html.push(' <div>N、&nbsp;&nbsp;错误</div>');
								html.push('</div>');

							} else if(questions[j].qtype == 4) { //填空

								// html.push('	<div class="get_set">');
								// html.push('	 <span class="dele_ti" onclick="gradingPaperDetail.deleQuestion(\'' + questions[j].id + '\',\'' + datas[i].id + '\')">删除</span>');
								// html.push('  <span class="de_fen" onclick="gradingPaperDetail.alertScode(\'' + questions[j].id + '\',\'' + datas[i].id + '\',\'' + datas[i].name+ '\',\'' +questionContNumber+ '\')">得分设置</span>');
								// html.push('	</div>');

								html.push(' <div class="question_set" >');
								html.push('   <input class="count_total" name="p_question_scores_'+datas[i].id+'" value="'+questions[j].qscore+'" type="hidden"/>');
								html.push('   <input name="p_question_types_'+datas[i].id+'" value="'+questions[j].qtype+'" type="hidden"/>');
								html.push('   <input name="p_question_ids_'+datas[i].id+'" value="'+questions[j].id+'" type="hidden"/>');
								html.push(' </div>');
								var qcontent = gradingPaperDetail.replaceInput(questions[j].qcontent, questions[j].id);
								html.push('<div>');
								html.push(' <div class="two1"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores">( '+questions[j].qscore+'分 )</span>' + qcontent + '</div>');
								html.push('</div>');
							} else if(questions[j].qtype == 5) { //简答
								// html.push('	<div class="get_set" onclick="gradingPaperDetail.deleQuestion(\'' + questions[j].id + '\',\'' + datas[i].id + '\')">');
								// html.push('	 <span class="dele_ti">删除</span>');
								// html.push('  <span class="de_fen" onclick="gradingPaperDetail.alertScode(\'' + questions[j].id + '\',\'' + datas[i].id + '\',\'' + datas[i].name+ '\',\'' +questionContNumber+ '\')">得分设置</span>');
								// html.push('	</div>');

								html.push(' <div class="question_set" >');
								html.push('   <input class="count_total" name="p_question_scores_'+datas[i].id+'" value="'+questions[j].qscore+'" type="hidden"/>');
								html.push('   <input name="p_question_types_'+datas[i].id+'" value="'+questions[j].qtype+'" type="hidden"/>');
								html.push('   <input name="p_question_ids_'+datas[i].id+'" value="'+questions[j].id+'" type="hidden"/>');
								html.push(' </div>');

								html.push('<div>');
								html.push(' <div class="two1"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
								html.push('</div>');
							}else if(questions[j].qtype == 6) { //简答
								// html.push('	<div class="get_set" onclick="gradingPaperDetail.deleQuestion(\'' + questions[j].id + '\',\'' + datas[i].id + '\')">');
								// html.push('	 <span class="dele_ti">删除</span>');
								// html.push('  <span class="de_fen" onclick="gradingPaperDetail.alertScode(\'' + questions[j].id + '\',\'' + datas[i].id + '\',\'' + datas[i].name+ '\',\'' +questionContNumber+ '\')">得分设置</span>');
								// html.push('	</div>');

								html.push(' <div class="question_set" >');
								html.push('   <input class="count_total" name="p_question_scores_'+datas[i].id+'" value="'+questions[j].qscore+'" type="hidden"/>');
								html.push('   <input name="p_question_types_'+datas[i].id+'" value="'+questions[j].qtype+'" type="hidden"/>');
								html.push('   <input name="p_question_ids_'+datas[i].id+'" value="'+questions[j].id+'" type="hidden"/>');
								html.push(' </div>');

								html.push('<div>');
								html.push(' <div class="two1"> <span class="question_cont_number"> '+questionContNumber+'、</span><span class="this_scores">( '+questions[j].qscore+'分 )</span>' + questions[j].qcontent + '</div>');
								html.push('</div>');
							}
							html.push('</div>');
						}
						html.push('</div>');
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
					$("#divContent").html(html.join(""));
					// console.log(questionCounts);
					// console.log(questionTypes);
                    // if(bj){  //TODO:提示题库中有些题型是没有的，所以在自动组卷时不能添加上
                     //    layer.msg('有些试题没有添加上，原因是题库中没有符合条件的试题，退出组卷页面时不要忘记保存进度！', {
                     //        title:'系统提示',
                     //        time: 0, //20s后自动关闭
                     //        btn: ['前往试题栏', '取消'],
                     //        area: ['360px', '200px'],
                     //        btnAlign: 'c',
                     //        skin: 'layui-layer-molv',
                     //        shade: [0.8, '#393D49'],
                     //        yes: function(){
                     //            bj = false;
					// 			window.location.href = "edit_item_page.html?pid="+pid+timestampv;
                     //        },
                     //        btn2: function(){
                     //            bj = false;
                     //            layer.closeAll();
                     //        }
                     //    });
                    // }
				}
			}
		});
	},
	anchorPosition: function(pos) {
//		window.location.href = "#Q" + pos;
	    var pos = $("#Q" + pos).offset().top;
	    $("html,body").animate({ scrollTop: pos }, 400);
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
	//替换输入框
	replaceInput: function(qcontent, qid) {
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//单个设置分数
	alertScode:function(id,pids,pname,num){
		var old_val = $('#QC-'+id).find('input[name=\'p_question_scores_'+pids+'\']').val();
		$('#alert_score').val(old_val);
		layer.open({
		  type: 1,
		  title:'分数设置:&nbsp;' +pname+ '-第（' +num+ '）题',
		  skin: 'layui-layer-molv', //样式类名
		  anim: 1,
		  area: ['420px', '240px'], //宽高
		  shadeClose: true, //开启遮罩关闭
		  btn: ['确定', '取消'],
		  content: $('#alert_layer'),
		  yes: function(index, layero){
		    var val = $('#alert_score').val();
			  if(!val)
			  	val = 0;
		    $('#QC-'+id).find('.this_scores').html('(&nbsp;' +val+ '分&nbsp;)');
		    $('#QC-'+id).find('input[name=\'p_question_scores_'+pids+'\']').val(val);

		    gradingPaperDetail.addTotal(pids);
		    

		    layer.closeAll();
		  }
		
		});
		
		
		
	},
	//批量设置分数
	alertScodes:function(id,pname){
		var old_val =  $('#style-'+id).find('.count_total').eq(0).val();
		$('#alert_scores').val(old_val);

		layer.open({
		  type: 1,
		  title:'批量分数设置:&nbsp;' +pname+ '题',
		  skin: 'layui-layer-molv', //样式类名
		  anim: 1,
		  area: ['420px', '240px'], //宽高
		  shadeClose: true, //开启遮罩关闭
		  btn: ['确定', '取消'],
		  content: $('#alert_layers'),
		  yes: function(index, layero){
		    var val = $('#alert_scores').val();
		    $('#style-'+id).find('.this_scores').html('(&nbsp;' +val+ '分&nbsp;)');
		    gradingPaperDetail.addTotals(id,val);
		    layer.closeAll();
		  }
		
		});
		
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
	//增加试题
	addSet:function(now){
		$('#question_style_now').val(now)
		layer.open({
		    type: 2,
		  	title:'挑选试题',
		  	skin: 'layui-layer-molv',
		  	area: ['700px', '530px'],
		  	fixed: false, //不固定
		  	maxmin: true,
            shade: 0,
		  	content: 'select_panel.html'
		});
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
    //保存进度
	savaSchedule: function() {

        // if($('.ask_list').length<= 0){
        //     var pid = gradingPaperDetail.getQueryString("pid");
        //     layer.msg('您的试卷中还没有试题，快去试题栏中选题吧！', {
        //         title:'系统提示',
        //         closeBtn: 1,
        //         time: 0, //20s后自动关闭
        //         btn: ['前往试题栏', '返回上一层'],
        //         area: ['360px', '200px'],
        //         btnAlign: 'c',
        //         skin: 'layui-layer-molv',
        //         shade: [0.8, '#393D49'],
        //         yes: function(){
        //             window.location.href = "edit_item_page.html?pid="+pid;
        //         },
        //         btn2: function(){
        //             window.location.href = "../text_sets.html";
        //         }
        //     });
        //     return;
        // }
		var formSerialize = $("#form").serialize();
		formSerialize = formSerialize + "&iscomplete=0"
		$.ajax({
			url: urlpath_a + '/exam/paper/detail.jhtml',
			type: "POST",
			data: formSerialize,
			success: function(t) {
				var success = t.success;
				var msg = t.msg;
				if(success) {
                    gradingPaperDetail.replayPaperInfor();
					layer.open({
						title: '系统提示',

						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
							window.location.href = "../text_sets.html"+timestamps;
						}
					});

				} else {
					layer.msg(
						msg,{
							icon:1,
							time:3000,
							// area: ['320px', '140px'],
							skin: 'layui-layer-molv',
							title:'系统提示',
						});

				}
			}
		});
	},
	//完成选择
	savaChoose: function() {

        if($('.ask_list').length<= 0){
            var pid = gradingPaperDetail.getQueryString("pid");
            layer.msg('您的试卷中还没有试题，快去试题栏中选题吧！', {
                title:'系统提示',
                closeBtn: 1,
                time: 0, //20s后自动关闭
                btn: ['前往试题栏', '返回上一层'],
                area: ['360px', '200px'],
                btnAlign: 'c',
                skin: 'layui-layer-molv',
                shade: [0.8, '#393D49'],
                yes: function(){
                    window.location.href = "edit_item_page.html?pid="+pid+timestampv;
                },
                btn2: function(){
                    window.location.href = "../text_sets.html"+timestamps;
                }
            });
            return;
        }
		var formSerialize = $("#form").serialize();
		formSerialize = formSerialize + "&iscomplete=1"
		$.ajax({
			url: urlpath_a + '/exam/paper/detail.jhtml',
			type: "POST",
			data: formSerialize,
			success: function(t) {
				// console.log(t);
				var success = t.success;
				var msg = t.msg;
				if(success) {
                    gradingPaperDetail.replayPaperInfor();
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
							window.location.href = "../text_sets.html"+timestamps;
						}
					});
				} else {
					layer.msg(
						msg,{
							icon:1,
							time:3000,
							// area: ['320px', '140px'],
							skin: 'layui-layer-molv',
							title:'系统提示'
						});

				}
			}
		});
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
    }

	
}


