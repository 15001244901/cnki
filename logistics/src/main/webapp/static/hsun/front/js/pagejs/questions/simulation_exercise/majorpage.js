$(function() {
    $("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
    majorpage.init();
	majorpage.closeAlert();
});

var majorpage = {
	//初始化
	init: function() {
		$.ajax({
			url: urlpath + '/user/practice/practice.jhtml',
			type: "GET",
			data: {
				ptype: 1
			},
			success: function(t) {
				// console.log(t);
				if(!t.data || t.data.length<1){
					$(".tree_paper_cont").html('');
					$(".tree_paper_cont").addClass('no_info');
					return;
				}
				// 0d63fd54b0de4e41895b1088ed7a9732
				var success = t.success;
				if(success) {
					var datas =t.data;
					for(var i = 0; i < datas.length; i++) {
						if(datas[i].pid == '0d63fd54b0de4e41895b1088ed7a9732'){
							parentHtml(datas[i]);
						}else if(!datas[i].pid){
							parentHtml(datas[i]);
						}
					}
					function parentHtml(obj){
						var i = 0;
						var datas = [];
						datas.push(obj);
						var questionhtml = [];
						questionhtml.push('<li class="hide onetree">');
						questionhtml.push(' <div class="one_list" data-code="'+datas[i].topic+'">');
						if(datas[i].isleaf){
							questionhtml.push('  <span class="_cont_name cursor_down"><i class="fa fa-list ml30 fz20"></i>'+datas[i].topic+'.'+(datas[i].topicname || '知识点待定')+'<span><em class="had_num"> '+datas[i].unum+'</em> / <em class="total_num">'+datas[i].qnum+'</em></span></span>');
						}else{
							questionhtml.push('  <span class="_cont_name"><i class="fa fa-dot-circle-o posr ml30 fz20"></i>'+datas[i].topic+'.'+(datas[i].topicname || '知识点待定')+'<span><em class="had_num"> '+datas[i].unum+'</em> / <em class="total_num">'+datas[i].qnum+'</em></span></span>');
						}
						questionhtml.push('  <span class="_cont_btn">');
                        // if(!datas[i].isleaf){
                        //     if(datas[i].unum == '0'){
                        //         questionhtml.push(' <a class="exam mr30"  href="javascript:;" title="开始做题" onclick="majorpage.practice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                        //     }else if(datas[i].unum == datas[i].qnum){
                        //         questionhtml.push(' <a class="mr30 replay_exam"  href="javascript:;" title="重新做题"onclick="majorpage.replayPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                        //     }else{
                        //         questionhtml.push(' <a class=" replay_exam"  href="javascript:;" title="重新做题" onclick="majorpage.replayPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                        //         questionhtml.push(' <a class="mr30 going_exam"  href="javascript:;" title="继续做题" onclick="majorpage.goingPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                        //     }
                        // }else{
                            questionhtml.push(' <a class="exam mr30"  href="javascript:;" title="开始做题" onclick="majorpage.practice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                            questionhtml.push(' <a class=" replay_exam"  href="javascript:;" title="重新做题" onclick="majorpage.replayPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                            questionhtml.push(' <a class="going_exam mr30"  href="javascript:;" title="继续做题" onclick="majorpage.goingPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                        // }

						questionhtml.push('  </span>');
						questionhtml.push(' </div>');
						if(datas[i].isleaf){
							var isId = datas[i].id;
							questionhtml.push('<ul class="next_lis" id="list-'+isId+'">');

							questionhtml.push('</ul>');
						}
						questionhtml.push('</li>');
						$('.tree_paper_cont').append(questionhtml.join(''));

						if(isId){
							childHtml(isId);
						}
					}
					function childHtml(parentId){

						for(var i=0;i<datas.length;i++){
							if(datas[i].pid == parentId){
								var childhtml = [];
								var is_id = '';
								childhtml.push('<li>');
								childhtml.push(' <div class="one_list" data-code="'+datas[i].topic+'">');
								if(datas[i].isleaf){
									childhtml.push('  <span class="_cont_name cursor_down"><i class="fa fa-list ml60 fz16 posr"></i>'+datas[i].topic+'.'+datas[i].topicname+'<span><em class="had_num"> '+datas[i].unum+'</em> / <em class="total_num">'+datas[i].qnum+'</em></span></span>');
								}else{
									childhtml.push('  <span class="_cont_name"><i class="fa fa-dot-circle-o ml60 fz16 posr"></i>'+datas[i].topic+'.'+datas[i].topicname+'<span><em class="had_num"> '+datas[i].unum+'</em> / <em class="total_num">'+datas[i].qnum+'</em></span></span>');
								}

								childhtml.push('  <span class="_cont_btn">');
                                if(!datas[i].isleaf){
                                    if(datas[i].unum == '0'){
                                        childhtml.push(' <a class="exam mr30"  href="javascript:;" title="开始做题" onclick="majorpage.practice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                                    }else if(datas[i].unum == datas[i].qnum){
                                        childhtml.push(' <a class="mr30 replay_exam"  href="javascript:;" title="重新做题"onclick="majorpage.replayPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                                    }else{
                                        childhtml.push(' <a class=" replay_exam"  href="javascript:;" title="重新做题" onclick="majorpage.replayPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                                        childhtml.push(' <a class="mr30 going_exam"  href="javascript:;" title="继续做题" onclick="majorpage.goingPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                                    }
                                }else{
                                    childhtml.push(' <a class="exam mr30"  href="javascript:;" title="开始做题" onclick="majorpage.practice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                                    childhtml.push(' <a class=" replay_exam"  href="javascript:;" title="重新做题" onclick="majorpage.replayPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                                    childhtml.push(' <a class="going_exam mr30"  href="javascript:;" title="继续做题" onclick="majorpage.goingPractice(\'' + (datas[i].topic||'') + '\',\'' + (datas[i].topicname||'') + '\',\'' + (datas[i].isleaf||'') + '\',this)"></a>');
                                }

								childhtml.push('  </span>');
								childhtml.push(' </div>');
								if(datas[i].isleaf){
									var isId = datas[i].id;
									is_id = isId;
									childhtml.push('<ul class="next_lis" id="list-'+isId+'">');

									childhtml.push('</ul>');
								}
								childhtml.push('</li>');
								$('#list-'+parentId).append(childhtml.join(''));
								if(is_id){
									childHtml(is_id);
								}
							}
						}

					}
                    majorpage.countChildNums();
					$('.cursor_down').off('click').on('click',majorpage.childTitleDown);
				} else {
				}
			},
			error:function(){
				loadFail('.tree_paper_cont');
			}
		});
	},
	// 展开下级菜单
	childTitleDown:function(){
		var is_next_ul = $(this).parent('.one_list').next('.next_lis');
		if(is_next_ul.css('display') == 'none'){
			is_next_ul.slideDown();
			$(this).addClass('icolor');
		}else{
			is_next_ul.slideUp();
			$(this).removeClass('icolor');
		}
	},
    // 统计每个父级的子集题数
    countChildNums:function(){
        var one_nums = $('.tree_paper_cont').children('li');
        var two_nums = $('.tree_paper_cont').children('li').children('ul').children('li');
        // 统计第二阶梯试题
        two_nums.each(function(index){
            var is_two_hadnums = $(this).children('.one_list');
            var is_add_hadnums = 0;
            var is_add_totalnums = 0;
            $(this).find('em').each(function(){
                if($(this).hasClass('had_num')){
                    is_add_hadnums = Number($(this).html()) + is_add_hadnums;
                }else if($(this).hasClass('total_num')){
                    is_add_totalnums = Number($(this).html()) + is_add_totalnums;
                }
            });

            if(is_add_hadnums == 0){
                is_two_hadnums.find('.replay_exam').remove();
                is_two_hadnums.find('.going_exam').remove();
            }else if(is_add_hadnums >= is_add_totalnums){
                is_two_hadnums.find('.exam').remove();
                is_two_hadnums.find('.going_exam').remove();
                is_two_hadnums.find('.replay_exam').addClass('mr30')
            }else{
                is_two_hadnums.find('.exam').remove();
            }

            is_two_hadnums.find('.had_num').html(is_add_hadnums);
            is_two_hadnums.find('.total_num').html(is_add_totalnums);
        });
        // 统计第一阶梯试题
        one_nums.each(function(){
            var is_one_hadnums = $(this).children('.one_list');
            var is_add_hadnums = Number(is_one_hadnums.find('.had_num').html());
            var is_add_totalnums = Number(is_one_hadnums.find('.total_num').html());
            $(this).children('ul').children('li').children('.one_list').find('em').each
            (function(){
                if($(this).hasClass('had_num')){
                    is_add_hadnums = Number($(this).html()) + is_add_hadnums;
                }else if($(this).hasClass('total_num')){
                    is_add_totalnums = Number($(this).html()) + is_add_totalnums;
                }
            });

            if(is_add_hadnums == 0){
                is_one_hadnums.find('.replay_exam').remove();
                is_one_hadnums.find('.going_exam').remove();
            }else if(is_add_hadnums >= is_add_totalnums){
                is_one_hadnums.find('.exam').remove();
                is_one_hadnums.find('.going_exam').remove();
                is_one_hadnums.find('.replay_exam').addClass('mr30')
            }else{
                is_one_hadnums.find('.exam').remove();
            }
            is_one_hadnums.find('.had_num').html(is_add_hadnums);
            is_one_hadnums.find('.total_num').html(is_add_totalnums);
        });
        $('#load_img').remove();
        $('.onetree').removeClass('hide');
    },
	//开始做题跳转
	practice: function(id, name, leaf, is) {
        if(leaf){
            var arrid = [];
            arrid.push(id);
            var iscode = $(is).parent('._cont_btn').parent('.one_list').next('ul').find('.one_list');
            iscode.each(function(index){
                arrid.push($(this).data('code'));
            });
            id = arrid.join(",")
        }
		var this_aurl = "manual_questions.html"+timestamps+"&topic=" + id + "&topicname=" + name;
		var this_text = '每次固定只抽取20道题，抽完为止';
		$('.this_alert p').css('marginTop','30px');

        if($(is).parent('._cont_btn').parent('.one_list').find('.total_num').html() == "0"){
            majorpage.noQuestionAlert('该知识点下暂时无题');
        }else{
            majorpage.showAlert(this_aurl,this_text);
        }
	},
	//继续做题跳转
	goingPractice: function(id, name, leaf, is) {
        if(leaf){
            var arrid = [];
            arrid.push(id);
            var iscode = $(is).parent('._cont_btn').parent('.one_list').next('ul').find('.one_list');
            iscode.each(function(index){
                arrid.push($(this).data('code'));
            });
            id = arrid.join(",")
        }
		var this_aurl = "manual_questions.html"+timestamps+"&topic=" + id + "&topicname=" + name;
		var this_text = '每次固定只抽取20道题，抽完为止';
		$('.this_alert p').css('marginTop','30px');
		majorpage.showAlert(this_aurl,this_text);
	},
	//重新做题跳转
	replayPractice: function(id, name, leaf, is) {
        if(leaf){
            var arrid = [];
            arrid.push(id);
            var iscode = $(is).parent('._cont_btn').parent('.one_list').next('ul').find('.one_list');
            iscode.each(function(index){
                arrid.push($(this).data('code'));
            });
            id = arrid.join(",")
        }
		var this_aurl = "manual_questions.html"+timestamps+"&topic=" + id + "&topicname=" + name+'&restart=true';
		var this_text = '(您之前的已做题记录将被清除)<br>每次固定只抽取20道题，抽完为止';
		$('.this_alert p').css('marginTop','10px');
		majorpage.showAlert(this_aurl,this_text);
	},
	//跳转
	skip: function(type) {
        if(!validateUser()){
            validateLogin();
            return;
        }
		if(type == 0) {
			window.location.href = "majorpage.html"+timestamps;
		} else if(type == 1) {
			window.location.href = "auto_creat_practice_paper.html"+timestamps;
		} else if(type == 2) {
			window.location.href = "majorpageQuestion.html"+timestamps;
		}
	},
	// 弹出框
	showAlert:function(url,text){
		$('.this_alert_btn').attr('href',url);
		$('.this_alert p').html(text);
		$('#this_alert').show(0,function(){
			$('.this_alert').removeClass('t_scale01');
		});
		// $('.this_alert').addClass('t_scale1');
	},
    noQuestionAlert:function(text){
        layer.msg(
            text,
            {
                anim:4,
                time:3000
            }
        );
    },
	// 关闭弹出框
	closeAlert:function(){
		$('#this_alert_close').off('click').on('click',function(){
			$('#this_alert').hide(0,function(){
				$('.this_alert').addClass('t_scale01');
			});
		})
	}
}