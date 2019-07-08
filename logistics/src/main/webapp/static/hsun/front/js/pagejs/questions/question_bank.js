$(function() {
	questionBank.init();
	questionBank.selectSearch();
});
var questionBank = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		// 判断是否登录
		$('.now_is_login').off('click').on('click',function(event){
			if(!validateUser()){
				validateLogin();
				return;
			}
			var isurl = $(this).data('url');
            var ispower = $(this).data('power');

            switch (isurl){
				case(1):window.location.href='test_sets/Start_the_test/online_test.html'+timestamps
					break;
				case(2):window.location.href='simulation_exercise/majorpage.html'+timestamps
					break;
				case(3):window.location.href='question_details/Daily_practice.html'+timestamps
					break;
				case(4):
				    if(ispower == "1"){
                        window.location.href='test_sets/create_test_paper/create_test_paper_three.html'+timestamps
                    }else{
                        questionBank.noPower();
                    }
                    break;
                case(5):
                    if(ispower == "1"){
                        questionBank.handTest();
                    }else{
                        questionBank.noPower();
                    }
                    break;
                case(6):
                    if(ispower == "1"){
                        questionBank.autoTest();
                    }else{
                        questionBank.noPower();
                    }
                    break;
                case(7):
                    if(ispower == "1"){
                        window.location.href='test_sets/text_sets.html'+timestamps
                    }else{
                        questionBank.noPower();
                    }
                    break;
                case(8):
                    if(ispower == "1"){
                        window.location.href='test_sets/grading_papers.html'+timestamps
                    }else{
                        questionBank.noPower();
                    }
                    break;
                case(9):window.location.href='../usercenter/usercenter.html'+timestamps
                    break;
				case(10):
					if(ispower == "1"){
						window.location.href='test_center/text_center.html'+timestamps
					}else{
						questionBank.noPower();
					}
					break;
			}
		});
	},
	mouseOver: function(ithis, type) {
		var imgPath = projectname+'/static/hsun/front';
		if(type == 1) {
			ithis.src = imgPath+"/img/question/1_1.png";
		} else if(type == 2) {
			ithis.src = imgPath+"/img/question/2_1.png";
		} else if(type == 3) {
			ithis.src = imgPath+"/img/question/3_1.png";
		} else if(type == 4) {
			ithis.src = imgPath+"/img/question/4_1.png";
		} else if(type == 5) {
			ithis.src = imgPath+"/img/question/5_1.png";
		} else if(type == 6) {
			ithis.src = imgPath+"/img/question/6_1.png";
		} else if(type == 7) {
			ithis.src = imgPath+"/img/question/7_1.png";
		} else if(type == 8) {
			ithis.src = imgPath+"/img/question/8_1.png";
		} else if(type == 9) {
			ithis.src = imgPath+"/img/question/9_1.png";
		} else if(type == 10) {
			ithis.src = imgPath+"/img/question/10_1.png";
		}

	},
	//无权限弹出事件
	noPower:function(cthis){
        // var click_reg = /onclick\s*=\s*('[^']*'|"[^"]*") /g;
        layer.msg(
            '您暂没有权限查看此内容',
            {
                time:2000,
                anim:4
                // title:'系统提示',
            }
        );
	},
	mouseOut: function(ithis, type) {
		var imgPath = projectname+'/static/hsun/front';
		if(type == 1) {
			ithis.src = imgPath+"/img/question/1_2.png";
		} else if(type == 2) {
			ithis.src = imgPath+"/img/question/2_2.png";
		} else if(type == 3) {
			ithis.src = imgPath+"/img/question/3_2.png";
		} else if(type == 4) {
			ithis.src = imgPath+"/img/question/4_2.png";
		} else if(type == 5) {
			ithis.src = imgPath+"/img/question/5_2.png";
		} else if(type == 6) {
			ithis.src = imgPath+"/img/question/6_2.png";
		} else if(type == 7) {
			ithis.src = imgPath+"/img/question/7_2.png";
		} else if(type == 8) {
			ithis.src = imgPath+"/img/question/8_2.png";
		} else if(type == 9) {
			ithis.src = imgPath+"/img/question/9_2.png";
		} else if(type == 10) {
			ithis.src = imgPath+"/img/question/10_2.png";
		}
	},
	handTest:function(){
		layer.open({
			type:1,
			title: '<p style="font-size: 16px;font-weight: bold;text-align: center;color: #fff;">手动组卷</p>',
			shadeClose: true,
			shade: 0.8,
			shadeClose:false,
			area: ['400px', '280px'],
			content: $('#hand_test').html()
		});
		$('#txtDuration').inputmask('9{1,6}',{placeholder:"", clearMaskOnLostFocus: false });
		questionBank.creatPaper();
	},
	autoTest:function(){
		layer.open({
			type:1,
			title: '<p style="font-size: 16px;font-weight: bold;text-align: center;color: #fff;">智能组卷</p>',
			shadeClose: true,
			shade: 0.8,
			shadeClose:false,
			area: ['400px', '280px'],
			content: $('#auto_test').html()
		});
		$('#txtDuration').inputmask('9{1,6}',{placeholder:"", clearMaskOnLostFocus: false });
		questionBank.creatPaper();
	},
	//手动创建试卷
	submitPaper: function(state,url) {
		var name = $(".layui-layer-content #txtName").val();
		var duration = $(".layui-layer-content #txtDuration").val();
		if(name == "" || name == "请输入试卷名称" ) {
			layer.tips('试卷名称不能为空', '.layui-layer-content #txtName', {
				tips: [1, '#3595CC'],
				time: 2000
			});
			return;
		}
		if(duration == "" || duration == "请输入答题时间(分钟)" ) {
			layer.tips('考试时长不能为空', '.layui-layer-content #txtDuration', {
				tips: [1, '#3595CC'],
				time: 2000
			});
			return;
		}
		var ret = /^(\d)*$/;
		if(!duration.match(ret)){
			layer.tips('考试时间为数字', '.layui-layer-content #txtDuration', {
				tips: [1, '#3595CC'],
				time: 2000
			});
			return;
		}

		$.ajax({
			url: urlpath_a + '/exam/paper/save.jhtml',
			type: "POST",
			data: {
				"id": "",
				"name": name,
				"status": "0",
				"duration": duration,
				"totalscore": '',
				"passscore": '',
				"ordertype": "1",
				"papertype": state //,
				//"departments": globalPost
			},
			success: function(t) {
				//alert(t.success)
				var datas = t.data;
				if(t.success) {
					var id = datas.id;
					window.location.href = "../questions/test_sets/edit_item_page/"+url+".html?id=" + id;
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
	// 没有登录时点击图标弹出登录框
	login:function(e){
		$(e).parent('li').click(function(){
				var loginPage = $('<div></div>');
				$('body').append(loginPage);
				loginPage.load(projectname + '/frontlogin');
		});
	},
	//回车键提交创造试卷
	creatPaper:function(){
		$(document).keypress(function (e) {
			if (e.which == 13) {
				$('.create_btn').trigger('click');
			}
		});
	},
	// 选择搜索类型
	selectSearch:function(){
		$('.bo_search').on('click','.select_items a',function(){
			$(this).find('input').prop('checked','true');
			var text = $(this).find('span').html();
			$('.text_select em').html(text);
		});
	},
	//查询
	searchLibrary: function(is) {
		var keyword = $("#keyword").val();
		var power = $(is).data('power');
		if(!keyword)
			return;

		if(!power){
			questionBank.noPower();
			return;
		}
		if($(".search_type:checked").val() == 0){
			window.open('../searchResult/question_result.html?keyword='+ keyword,'_blank');
		}else{
			window.open('../questions/test_sets/text_sets.html?keyword='+ keyword,'_blank');
		}

	}
};