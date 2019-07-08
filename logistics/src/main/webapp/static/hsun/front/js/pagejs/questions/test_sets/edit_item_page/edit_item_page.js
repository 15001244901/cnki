$(function() {
	textCenter.init();
	textCenter.onloadGet();
	textCenter.initTopic();
	textCenter.slideUpTopic();
});

var stop = false;
var textCenter = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);

		var id = textCenter.getQueryString('id');
		var pid = textCenter.getQueryString('pid');
		//根据试卷id获取试卷内容
		$.ajax({
			url: urlpath_a + '/exam/paper/view.jhtml',
			type: "GET",
			async: false,
			data: {
				id: (id || pid)//试卷ID
			},
			success: function(t) {
				// console.log(t);
				var success = t.success;
				// var datas = t.data;
				if(success) {
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
		
		//科目类别
		// $.ajax({
		// 	url: urlpath_a + '/sys/dict/listData.jhtml',
		// 	type: "GET",
		// 	async: false,
		// 	dataType: "json",
		// 	jsonp: "callback",
		// 	jsonpCallback: "successCallback",
		// 	data: {
		// 		type: 'dic_exam_questionsubject' //科目
		// 	},
		// 	success: function(t) {
        //
		// 		var success = t.success;
		// 		var datas = t.data;
		// 		var ulSubject = [];
		// 		if(success) {
		// 			ulSubject.push('<li class="active" name="liSubject" onclick="textCenter.chooseSubjectType(this,\'\')">');
		// 			ulSubject.push('  <a href=\"javascript:;\"><span>不限</span></a>');
		// 			ulSubject.push('</li>');
		// 			for(i = 0; i < datas.length; i++) {
		// 				ulSubject.push('<li name="liSubject" onclick="textCenter.chooseSubjectType(this,\'' + datas[i].value + '\')">');
		// 				ulSubject.push('  <a href=\"javascript:;\"><span>' + datas[i].label + '</span></a>');
		// 				ulSubject.push('</li>');
		// 			}
		// 			$(".divsubject ul").html(ulSubject.join(""));

					//题型类型
					$.ajax({
						url: urlpath_a + '/sys/dict/listData.jhtml',
						type: "GET",
						async: false,
						dataType: "json",
						// jsonp: "callback",
						// jsonpCallback: "successCallback",
						data: {
							type: 'dic_exam_questiontype' //题型
						},
						success: function(t) {
							//var t = JSON.parse(data);
							var success = t.success;
							var datas = t.data;
							var ulQuestion = [];
							if(success) {
								ulQuestion.push('<li class="active" name="liQuestion" onclick="textCenter.chooseQuestionType(this,\'\')">');
								ulQuestion.push('  <a href=\"javascript:;\"><span>不限</span></a>');
								ulQuestion.push('</li>');
								for(i = 0; i < datas.length; i++) {
									ulQuestion.push('<li name="liQuestion" onclick="textCenter.chooseQuestionType(this,\'' + datas[i].value + '\')">');
									ulQuestion.push('  <a href=\"javascript:;\"><span>' + datas[i].label + '</span></a>');
									ulQuestion.push('</li>');
								}
								$("#ulQuestion").html(ulQuestion.join(""));
								//难度类别
								$.ajax({
									url: urlpath_a + '/sys/dict/listData.jhtml',
									type: "GET",
									async: false,
									dataType: "json",
									// jsonp: "callback",
									// jsonpCallback: "successCallback",
									data: {
										type: 'dic_exam_questionlevel' //难度
									},
									success: function(t) {
										var success = t.success;
										var datas = t.data;
										var ulLevel = [];
										if(success) {
											ulLevel.push('<li class="active" name="liLevel" onclick="textCenter.chooseLevelType(this,\'\')">');
											ulLevel.push('  <a href=\"javascript:;\"><span>不限</span></a>');
											ulLevel.push('</li>');
											for(i = 0; i < datas.length; i++) {
												ulLevel.push('<li name="liLevel" onclick="textCenter.chooseLevelType(this,\'' + datas[i].value + '\')">');
												ulLevel.push('  <a href=\"javascript:;\"><span>' + datas[i].label + '</span></a>');
												ulLevel.push('</li>');
											}
											$("#ulLevel").html(ulLevel.join(""));
											//岗位类别
											$.ajax({
												url: urlpath_a + '/sys/dict/listData.jhtml?t='+( new Date() ).getTime().toString(),
												type: "GET",
												async: false,
												dataType: "json",
												// jsonp: "callback",
												// jsonpCallback: "successCallback",
												data: {
													type: 'dic_exam_questionpost' //科目
												},
												success: function(t) {
													var success = t.success;
													var datas = t.data;
													var ulPost = [];
													if(success) {
														ulPost.push('<li class="active" name="liPost" onclick="textCenter.choosePostType(this,\'\')">');
														ulPost.push('  <a href=\"javascript:;\"><span>不限</span></a>');
														ulPost.push('</li>');
														for(i = 0; i < datas.length; i++) {
															ulPost.push('<li name="liPost" onclick="textCenter.choosePostType(this,\'' + datas[i].value + '\')">');
															ulPost.push('  <a href=\"javascript:;\"><span>' + datas[i].label + '</span></a>');
															ulPost.push('</li>');
														}
														$("#ulPost").html(ulPost.join(""));
														textCenter.treeDate("");
													}
												}
											});
										}
									}
								});
							}
						}
					});

		// 		}
		// 	}
		// });
		
				}
			}
		});
	},
	//获取题库列表
	treeDate: function(keyword) {
		$("#questionListDiv").removeClass('no_info');
		var pageNo = $("#pageNo").val();
		var subjectValue = $("#subjectType").val();
		var questionValue = $("#questionType").val();
		var levelValue = $("#levelType").val();
		var postValue = $("#postType").val();
		var topictValue = $("#topictValue").val();

		$('#questionListDiv').html('<div id="load_div" style="width: 100%;min-height:400px;position: relative;"></div>');
		var loading_img = '<img id="load_img" style="margin-top:-33px;margin-left:-33px;display: block;position: absolute;top:50%; left:50%;" src="'+imgUrl+'/usercenter/images/loading.gif" alt="">';
		$('#load_div').height($('#load_div').parent().height());
		$('#load_div').html(loading_img);

		$.ajax({
			url: urlpath_a + '/exam/question/list.jhtml',
			type: "GET",
			// async: false,
			dataType: "json",
			data: {
				pageNo: pageNo,
				pageSize: 10, //每页记录数
				qStatus: 1, //0未审核；1已审核；2待定
				qContent: keyword, //关键字
				// subject: subjectValue, //科目
				QType: questionValue, //题型
				qLevel: levelValue, //难度
				post: postValue, //岗位
				topic:topictValue //知识点
			},
			success: function(t) {
				// console.log(t);
				$("#pagehtml").html('');

				var success = t.success;
				if(success) {
					// $("#questionListDiv").html("");
					// $("#pagehtml").html("");
					var datas = t.datax;
					var da    = t.data.list;
					var contenthtml = [];

					if(!t.data.list){
						$("#questionListDiv").html('');
						$("#questionListDiv").addClass('no_info');
						return;
					}
					for(var i = 0; i < datas.length; i++) {

						contenthtml.push('<div id="b-' + datas[i].id + '" style="border: 1px solid #dcdcdc;margin-top: 10px;">');
						contenthtml.push('  <div class="exam-head">');
						contenthtml.push('    <p class="exam-head-left">');
						contenthtml.push('      <span>题型：' + (datas[i].typeName||'') + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>知识点：' + (datas[i].topicName||'') + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>难易度：' + (datas[i].levelName||'') + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>依据标准：' + (da[i].stdNo||'') + '</span>');
						contenthtml.push('    </p>');
						contenthtml.push('    <p class="exam-head-right">');
						// contenthtml.push('      <span>');
						// contenthtml.push('      本题正确率：61%&nbsp;&nbsp;&nbsp;&nbsp;此题被做次数：7348次');
						// contenthtml.push('      </span>');
						contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-con">');
						contenthtml.push('    <div class="exam-q" id="cont-'+datas[i].id+'">');
						if(datas[i].qtype == "4"){
							contenthtml.push('      ' + textCenter.replaceInput(datas[i].qcontent) + '');
						}else{
							contenthtml.push('      ' + datas[i].qcontent + '');
						}
						contenthtml.push('    </div>');
						contenthtml.push('    <div class="exam-s">');
						if(datas[i].qtype == "1" || datas[i].qtype == "2") {
							var qdatajsons = datas[i].options;
							for(var j = 0; j < qdatajsons.length; j++) {
								var alisa = qdatajsons[j].alisa;
								var alisaContent = qdatajsons[j].text;
								alisaContent = textCenter.delP(alisaContent);
								contenthtml.push('<div>');
								contenthtml.push(alisa + "&nbsp;、&nbsp;" + alisaContent);
								contenthtml.push('</div>');
							}
						}
                        if(datas[i].qtype == "3"){
                            contenthtml.push('<div>');
                            contenthtml.push("Y&nbsp;、&nbsp;正确");
                            contenthtml.push('</div>');
                            contenthtml.push('<div>');
                            contenthtml.push("N&nbsp;、&nbsp;错误");
                            contenthtml.push('</div>');
                        }

						contenthtml.push('    </div>');
						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-answer" id="R-' + datas[i].id + '" style="display:none">');

						contenthtml.push('    <div class="analyticbox">');
						contenthtml.push('      <span class="exam-point">【答案】</span>');
						contenthtml.push('      <div class="analyticbox-body"> ' + datas[i].qkey + ' </div>');
						contenthtml.push('    </div>');
						contenthtml.push('    <div class="analyticbox">');
						contenthtml.push('      <span class="exam-point">【解析】</span>');
						contenthtml.push('      <div class="analyticbox-body"> ' + (datas[i].qresolve||'') + '</div>');
						contenthtml.push('    </div>');

						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-foot">');
						contenthtml.push('    <p class="exam-foot-left">');
						contenthtml.push('      <a href="javascript:;" onclick="textCenter.seeResolve(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiexi"></i>查看解析');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="javascript:;" class="'+datas[i].id+'" onclick="textCenter.collectionSingle(\'' + datas[i].id + '\',\'' + (da[i].iscollected||'') + '\')">');
						// contenthtml.push('      <a href="javascript:;" data-iscollected="'+(da[i].iscollected || '0')+'" class="'+datas[i].id+'" onclick="textCenter.collection(this,\'' + datas[i].id + '\')">');
						if(!da[i].iscollected){
							contenthtml.push('        <i class="icona-shoucang"></i><span>收藏</span>');
						}else{
							contenthtml.push('        <i class="icona-quxiaosc"></i><span>已收藏</span>');
						}
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="javascript:;" onclick="textCenter.errorcorrection(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiucuo"></i>纠错');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="../../test_center/look_bank.html?id=' + datas[i].id + '">');
						contenthtml.push('        <i class="icona-biji"></i>笔记');
						contenthtml.push('      </a>');
						if(datas[i].isbasket == 0){
							contenthtml.push('      <a class="bo_addbtn" id="a-' + datas[i].id + '" data-basket="' + datas[i].isbasket + '" href="javascript:void(0);" onclick="textCenter.adds(\'' + datas[i].id + '\',\'' + datas[i].qtype + '\',\'' + datas[i].typeName + '\',\'' + i + '\')">');
							contenthtml.push('        <i class="icona-up"></i><span id="o-' + datas[i].id + '">选题</span>');
							contenthtml.push('      </a>');
						}else{
							contenthtml.push('      <a class="bo_addbtn bo_addbtn_bg" id="a-' + datas[i].id + '" data-basket="' + datas[i].isbasket + '" href="javascript:void(0);" onclick="textCenter.adds(\'' + datas[i].id + '\',\'' + datas[i].qtype + '\',\'' + datas[i].typeName + '\',\'' + i + '\')">');
							contenthtml.push('        <i class="icona-up"></i><span id="o-' + datas[i].id + '">移出</span>');
							contenthtml.push('      </a>');
						}
						
						contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						
						contenthtml.push('</div>');
					}
					$("#questionListDiv").html(contenthtml.join(""));
					$("#pagehtml").html(t.data.frontPageHtml);
					delDisabled();
				}

			},
			error:function(){
				loadFail('#questionListDiv')
			}
		});
	},
	//替换输入框
	replaceInput: function(qcontent) {
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//去除html标签
	delHtmlTag:function(str){
		return str.replace(/<[^>]+>/g,"");//去掉所有的html标记
	},
	// 去除p标签
	delP:function(str){
		bstr=str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
		return bstr;
	},
	//获取url参数传值
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//查看解析
	seeResolve: function(id) {
		if(document.getElementById("R-" + id).style.display == "block"){
			$("#R-" + id).slideUp();
		}else{
			$("#R-" + id).slideDown();
			document.getElementById("R-" + id).style.display = "block";
		}
		
	},
	//收藏
	// collection: function(is,id) {
	// 	var uid = useruid;
	// 	$.ajax({
	// 		url: urlpath + '/user/question/' + id + '/collect.jhtml',
	// 		type: "GET",
	// 		async: false,
	// 		dataType: "json",
	// 		// jsonp: "callback",
	// 		// jsonpCallback: "successCallback",
	// 		data: {
	// 			uid: uid,
	// 			id: id
	// 		},
	// 		success: function(t) {
	// 			// console.log(t);
	// 			var msg = t.msg;
	// 			if(t.success){
	// 				var iscollect = $(is).attr('data-iscollected');
	// 				layer.msg(
	// 					msg,{
	// 						icon:1,
	// 						time:3000,
	// 						skin: 'layui-layer-molv',
	// 						// title:'系统提示',
	// 					});
	// 				if(iscollect == '0'){
	// 					$(is).attr('data-iscollected','1');
    //
	// 					$(is).find('span').html('已收藏');
	// 					$(is).find('i').removeClass('icona-shoucang').addClass('icona-quxiaosc');
	// 				}else{
	// 					$(is).attr('data-iscollected','1');
	// 					$(is).find('span').html('收藏');
	// 					$(is).find('i').removeClass('icona-quxiaosc').addClass('icona-shoucang');
	// 				}
	// 			}else{
	// 				layer.msg(
	// 					'操作失败',{
	// 						icon:1,
	// 						time:3000,
	// 						skin: 'layui-layer-molv',
	// 						// title:'系统提示',
	// 					});
	// 			}
    //
	// 		}
	// 	});
	// },
	collectionSingle: function(id,isid) {
		var uid = useruid;
		$.ajax({
			url: urlpath + '/user/question/' + id + '/collect.jhtml',//delete
			type: "GET",
			// dataType: "jsonp",
			// jsonp: "callback",
			// jsonpCallback: "successCallback",
			data: {
				// uid: uid,
				id: id,
				iscollected:isid
			},
			success: function(t) {
				if(t.success) {
					layer.msg(
						t.msg,
						{
							icon:1,
							time:3000,
							skin: 'layui-layer-molv',
							// title:'系统提示',
						}
					);
					textCenter.treeDate("");
					// textCenter.treeDateSingle();
					// $('.'+id).find('span').html('已收藏');
				} else {
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
			}
		});
	},
	//纠错
	errorcorrection: function(qid) {
		layer.open({
			type: 2,
			area: ['600px', '330px'],
			title: '<span style="font-size:16px;margin-left:20px">试题纠错</span>',
			shade: 0.6,
			maxmin: false,
			anim: -1 //0-6的动画形式，-1不开启
				,
			content: '../../question_details/errorcorrection.html?id='+ qid + timestampv
		});
	},

	//点击科目
	chooseSubjectType: function(athis, id) {
		var subjectType = document.getElementsByName("liSubject");
		for(var i = 0; i < subjectType.length; i++) {
			subjectType[i].className = "";
		}
		athis.className = "active";
		$("#subjectType").val(id);
		$("#pageNo").val("1");
		$("#pageNoSingle").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			$("#questionListDiv").html("");
			$("#pagehtml").html("");
			textCenter.treeDate("");
		} else {
			textCenter.treeDateSingle("");
		}
	},
	//点击题库
	chooseQuestionType: function(athis, id) {
		var questionType = document.getElementsByName("liQuestion");
		for(var i = 0; i < questionType.length; i++) {
			questionType[i].className = "";
		}
		athis.className = "active";
		$("#questionType").val(id);
		$("#pageNo").val("1");
		$("#pageNoSingle").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			textCenter.treeDate("");
		} else {
			textCenter.treeDateSingle("");
		}
	},
	//点击难度
	chooseLevelType: function(athis, id) {
		var levelType = document.getElementsByName("liLevel");
		for(var i = 0; i < levelType.length; i++) {
			levelType[i].className = "";
		}
		athis.className = "active";
		$("#levelType").val(id);
		$("#pageNo").val("1");
		$("#pageNoSingle").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			textCenter.treeDate("");
		} else {
			textCenter.treeDateSingle("");
		}
	},
	//点击岗位
	choosePostType: function(athis, id) {
		var postType = document.getElementsByName("liPost");
		for(var i = 0; i < postType.length; i++) {
			postType[i].className = "";
		}
		athis.className = "active";
		$("#postType").val(id);
		$("#pageNo").val("1");
		$("#pageNoSingle").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			textCenter.treeDate("");
		} else {
			textCenter.treeDateSingle("");
		}
	},
	//查询
	searchLibrary: function() {
		var keyword = $("#keyword").val();
		$("#pageNo").val("1");
		$("#pageNoSingle").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			textCenter.treeDate(keyword);
		} else {
			textCenter.treeDateSingle(keyword);
		}
	},
	//添加试题
	adds:function(e,n,t,i){
		if($('.bo_fl').css('left') == '-260px'){
			var endTop = $('#swit').offset().top;
			var endLeft = $('#swit').offset().left;
		}else{
			var endTop = $('#J_Basket').offset().top;
			var endLeft = $('#J_Basket').offset().left;
		}
		var startTop = $('#b-'+e).offset().top;
		var startLeft =$('#b-'+e).offset().left;
		
		var text = $('#o-'+e).html();
		var isbasket = $('#a-'+e).attr('data-basket');
		$.ajax({
			url: urlpath +'/user/question/'+e+'/basket.jhtml',
			type: "post",
			async: false,
			dataType: "json",
			// jsonp: "callback",
			// jsonpCallback: "successCallback",
			data:{
				'qtype':n,
				'isbasket':isbasket
			},
			success: function(ret) {
				//console.log(ret);
				if(text == '选题'){
					stop = false;
					$('#o-'+e).html('移出');
					$('#o-'+e).parent('.bo_addbtn').addClass('bo_addbtn_bg');

					$('body').append('<div class="app" style="position:absolute;overflow:hidden;width:920px;"></div>');

					$('.app').css({'top':startTop,'left':startLeft});
					$('.app').append($('#b-'+e).clone(true));
					$('.app').animate({
						top:endTop,
						left:endLeft,
						width:100,
						height:50
						//opacity:1

					},function(){
						$('.app').remove();
						stop = false;
					});
				}else{
					stop = true;
					$('#a-'+e).attr('data-basket','0');
					$('#o-'+e).html('选题');
					$('#o-'+e).parent('.bo_addbtn').removeClass('bo_addbtn_bg');
				}
				textCenter.onloadGet(e);
			},
		    error: function(xhr, errorText, errorStatus){
				// layer.open({
				// 	title: '系统提示',
				// 	closeBtn: 1,
				// 	skin: 'layui-layer-molv',
				// 	content: '<div style="text-align:center;">'+errorText+'</div>',
				// 	yes: function(index, layero){
				// 		layer.close(index);
				// 	}
				// });
        	}
		});
		
	},
	//获取试题栏ajax
	onloadGet:function(kid){
		$.ajax({
			url: urlpath +'/user/question/basketCount.jhtml',
			type: "get",
			async: false,
			dataType: "json",
			// jsonp: "callback",
			// jsonpCallback: "successCallback",
			success: function(t) {
				// console.log(t);
				var baskethtml = [];
				var totalNum   = 0;
				for(var i=0; i<t.data.length; i++){
					var dat = t.data;
					baskethtml.push('<p title="'+dat[i].qtypelabel+'">'+dat[i].qtypelabel+'题：');
					baskethtml.push(' <span>'+dat[i].qnum+'</span>道');
					baskethtml.push(' <i class="icona-del1 f-fr" onclick="textCenter.removeAll(\'' + dat[i].qtype + '\')"></i>');
					baskethtml.push('</p>');

					totalNum += dat[i].qnum;
				}
				$(".baskrt-list").html(baskethtml.join(""));
				$('#totalnum').html(totalNum);
				$('#bas_num').html(totalNum);

				var basket_qid = t.basketList;
				for(var i = 0; i<basket_qid.length;i++){
					if($('#a-'+basket_qid[i].qid).length > 0){
						$('#a-'+basket_qid[i].qid).attr('data-basket',basket_qid[i].id);
					}
				}
			},
		    error: function(xhr, errorText, errorStatus){
				layer.open({
					title: '系统提示',
					closeBtn: 1,
					skin: 'layui-layer-molv',
					content: '<div style="text-align:center;">'+errorText+'</div>',
					yes: function(index, layero){
						layer.close(index);
					}
				});
        	}
		});
	},
    //初始化试题栏里的试题
    onloadBasketList:function(){
        $.ajax({
            url: urlpath +'/user/question/basketCount.jhtml',
            type: "get",
			async: false,
            dataType: "json",
            // jsonp: "callback",
            // jsonpCallback: "successCallback",
            success: function(t) {
                // console.log(t);
                var basketList = t.basketList;
                //加载试题栏里的试题
                // console.log(basketList);
                var title;
                for(var i = 0;i<basketList.length;i++){

                    switch(Number(basketList[i].qtype)){
                        case 1:
                            title = '单选';
                            break;
                        case 2:
                            title = '多选';
                            break;
                        case 3:
                            title = '是非';
                            break;
                        case 4:
                            title = '填空';
                            break;
                        case 5:
                            title = '简答';
                            break;
                        case 6:
                            title = '计算';
                            break;
                    }

                    var selquestion = [];
                    var selstype    = [];
                    selstype.push('<input class="validate[required] tm_txt" name="p_section_names" size="50" type="hidden" value="'+title+'">');
                    selstype.push(' <input class="validate[required] tm_txt" size="50" name="p_section_remarks" type="hidden" value="每题2分">');
                    selstype.push(' <input name="p_section_ids" value="'+basketList[i].qtype+'" type="hidden">');

                    selquestion.push('<li id="h-'+basketList[i].qid+'">');
                    selquestion.push(' <input name="p_question_scores_'+basketList[i].qtype+'" value="2" type="hidden" class="q_score">');
                    selquestion.push(' <input name="p_question_types_'+basketList[i].qtype+'" value="'+basketList[i].qtype+'" type="hidden">');
                    selquestion.push(' <input name="p_question_ids_'+basketList[i].qtype+'" value="'+basketList[i].qid+'" type="hidden">');
                    // selquestion.push(' <input name="p_question_cnts_'+basketList[i].qtype+'" value="" type="hidden">');
                    selquestion.push('</li>');
                    $('#basket_style_'+basketList[i].qtype).html(selstype.join(""));
                    $('#basket_id_'+basketList[i].qtype).append(selquestion.join(""));
                }
            },
            error: function(xhr, errorText, errorStatus){
				layer.open({
					title: '系统提示',
					closeBtn: 1,
					skin: 'layui-layer-molv',
					content: '<div style="text-align:center;">'+errorText+'</div>',
					yes: function(index, layero){
						layer.close(index);
					}
				});
            }
        });
    },
	//删除试题栏ajax
	removeAll:function(q){
		$.ajax({
			url: urlpath +'/user/question/'+q+'/basketDel.jhtml',
			type: "post",
			async: false,
			dataType: "json",
			// jsonp: "callback",
			// jsonpCallback: "successCallback",
			success: function(ret) {
				// console.log(ret);
				// textCenter.treeDate();
				textCenter.onloadGet();
				for(var i = 0; i< $('.bo_addbtn').length; i++){
					if($('.bo_addbtn').eq(i).attr('data-basket') != '0'){
						$('.bo_addbtn').eq(i).attr('data-basket','0');
						$('.bo_addbtn').eq(i).find('span').html('选题');
						$('.bo_addbtn').eq(i).removeClass('bo_addbtn_bg');
					}
				}
                $('#basket_style_'+q).html('');
                $('#basket_id_'+q).html('');
			},
		    error: function(xhr, errorText, errorStatus){
				layer.open({
					title: '系统提示',
					closeBtn: 1,
					skin: 'layui-layer-molv',
					content: '<div style="text-align:center;">'+errorText+'</div>',
					yes: function(index, layero){
						layer.close(index);
					}
				});
        	}
		});
		
	},
	//试题栏隐藏
	basketHide:function(){

		if($('#J_Basket').css('left')== '0px'){
			$('#J_Basket').animate({
				'left':'-166px'
			},200);
            $('.basket-tit').find('span').find('i').removeClass('icona-gouwuright');
		}else{
			$('#J_Basket').animate({
				'left':'0px'
			},200);
            $('.basket-tit').find('span').find('i').addClass('icona-gouwuright');

        }
	},
	// 左侧模块收起
	slideLeftHide:function(){
		$('.gohide').click(function(){
			// var goLeft = $('#bo_fl').position().left;
			var wTop = $(window).scrollTop();
			if($('.bo_fl').css('left') !== -260){
				$('.bo_fl').animate({
					'opacity':0,
					'left':-260

				},function(){
					$('#swit').show();
				});
				$('#divcontent').animate({
					'width':'1200px'
				});
			}
		});
	},
	// 左侧模块展开
	slideLeftShow:function(){
		$('#swit').click(function(){
			// var goLeft = $('#bo_fl').position().left;
			if($('.bo_fl').css('left') == '-260px'){
				$('#swit').hide();
				$('#divcontent').animate({
					'width':'923px'
				});
				$('.bo_fl').animate({
					'opacity':1,
					'left':$('#get_left').val()
				});

			}

		});
	},
	//获取左侧边栏初始的坐标，并存入隐藏域
	getLeft:function(){
		if($(window).width()>1200){
			var left = ($(window).width()-1200)/2;
			$('#get_left').val(left);
		}else{
			$('#get_left').val(0);
		}
	},
	//监控窗口变化
	onWindow:function(){
		$(window).resize(function() {
			// textCenter.getLeft();
			if($('.bo_fl').css('left') !== '-260px'){
				$('.bo_fl').animate({
					'left':$('#get_left').val()
				},0);

			}
		});
	},
	//完成选择
	savaChoose: function(e) {
		textCenter.onloadBasketList();     //加载试题栏里面的试题
		textCenter.replayPaperInfor();     //重新计算得分
        var id = textCenter.getQueryString('id');
		var pid = textCenter.getQueryString('pid');
		var formSerialize = $("#formList").serialize();
		formSerialize = formSerialize + "&iscomplete=0";


		$.ajax({
			url: urlpath_a + '/exam/paper/detail.jhtml',
			type: "POST",
			//traditional: true,
			data: formSerialize,
			success: function(t) {
				var success = t.success;
				var msg = t.msg;
				if(success) {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
							window.location.href = "edit_item_page_next.html?pid="+(id || pid)+timestampv;
						}
					});
					// window.location.href = "../text_sets.html";

				} else {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
						}
					});
				}
			}
		});
	},
	//从新设置试卷总分
	replayPaperInfor:function(){
		var totalscore= 0;
		for(var i=0;i < $('.q_score').length;i++){
			totalscore += parseInt($('.q_score').eq(i).val()) ;
		}
		$('#txtTotalScore').val(totalscore);
		$('#txtPassScore').val(parseInt(totalscore*6/10));
		// console.log(totalscore);
	},
	// 新添知识点树层结构===================================================================
	initTopic:function(){
		var tree_one_data = [];
		var tree_two_data = [];
		var tree_red_data = [];
		var tree_three_data = [];

		var list_html = [];
		$.ajax({
			url:urlpath_a+'/sys/dict/treeData?type=dic_exam_questiontopic',
			type: "GET",
			success: function(ret){
				// console.log(ret);
				// 插入不限
				var no_select_topic = [];
				list_html.push('<li id="">');
				list_html.push(' <div class="one_title" data-type="">');
				list_html.push('  <span class=" cuesor title_radio1"></span>');
				list_html.push('  <em class="topic_name cuesor" data-code="" title="不限">不限</em>');
				list_html.push(' </div>');
				list_html.push(' <ul class="two_section dash_line">');
				list_html.push(' </ul>');
				list_html.push('</li>');

				// 循环第一阶梯
				for(var i=0;i<ret.length;i++){
					if(ret[i].pId == '0d63fd54b0de4e41895b1088ed7a9732'){
						tree_one_data.push(ret[i]);
						list_html.push('<li id="'+ret[i].id+'">');
						list_html.push(' <div class="one_title" data-type="'+ret[i].id+'">');
						list_html.push('  <span class=" cuesor title_radio1"></span>');
						// list_html.push('  <b class="title_checkbox1 cuesor" data-code="'+ret[i].code+'" data-type="'+ret[i].id+'"></b>');
						list_html.push('  <em class="topic_name cuesor" data-code="'+ret[i].code+'" title="'+ret[i].name+'">'+ret[i].name+'</em>');
						list_html.push(' </div>');
						list_html.push(' <ul class="two_section dash_line">');
						list_html.push(' </ul>');
						list_html.push('</li>');
					}else{
						tree_two_data.push(ret[i]);
					}
				}
				// 将第一阶梯插入页面
				$('.one_section').html(list_html.join(''));

				// 循环第二阶梯
				for(var i=0;i<tree_one_data.length; i++){
					var is_id = tree_one_data[i].id;
					for(var j=0; j<tree_two_data.length; j++){
						if(tree_two_data[j].pId == is_id){
							var list_twohtml = [];
							list_twohtml.push('<li id="'+tree_two_data[j].id+'">');
							list_twohtml.push(' <div class="one_title" data-type="'+tree_two_data[j].id+'">');
							list_twohtml.push('  <span class="cuesor title_radio1"></span>');
							// list_twohtml.push('  <b class="title_checkbox1 cuesor" data-code="'+tree_two_data[j].code+'" data-type="'+tree_two_data[j].id+'"></b>');
							list_twohtml.push('  <em class="topic_name cuesor" data-code="'+tree_two_data[j].code+'" title="'+tree_two_data[j].name+'">'+tree_two_data[j].name+'</em>');
							list_twohtml.push(' </div>');
							list_twohtml.push(' <ul class="three_section dash_line">');
							list_twohtml.push(' </ul>');
							list_twohtml.push('</li>');

							tree_red_data.push(tree_two_data[j]);
							// 将第二阶梯插入页面
							$('#'+is_id).children('.one_title').find('span').addClass('title_up');
							$('#'+is_id).find('.two_section').append(list_twohtml.join(''));
						}
					}
				}

				// 循环出第三级数据
				for(var i=0; i<tree_two_data.length; i++){
					var is_reduce = true;
					for(var j=0; j < tree_red_data.length; j++){
						if(tree_two_data[i] == tree_red_data[j])
							is_reduce = false;
					}
					if(is_reduce)
						tree_three_data.push(tree_two_data[i]);
				}

				// 循环第三阶梯
				for(var j=0; j<tree_three_data.length; j++){
					var is_pid = tree_three_data[j].pId;
					if($('#'+is_pid).length>0){
						var list_twohtml = [];
						list_twohtml.push('<li id="'+tree_three_data[j].id+'">');
						list_twohtml.push(' <div class="one_title" data-type="'+tree_three_data[j].id+'">');
						list_twohtml.push('  <span class=""></span>');
						// list_twohtml.push('  <b class="title_checkbox1 cuesor" data-code="'+tree_three_data[j].code+'" data-type="'+tree_three_data[j].id+'"></b>');
						list_twohtml.push('  <em class="topic_name cuesor" data-code="'+tree_three_data[j].code+'" title="'+tree_three_data[j].name+'">'+tree_three_data[j].name+'</em>');
						list_twohtml.push(' </div>');
						list_twohtml.push('</li>');
						// 将第三阶梯插入页面
						$('#'+is_pid).children('.one_title').find('span').addClass('title_up');
						$('#'+is_pid).find('.three_section').append(list_twohtml.join(''));
					}

				}
                var slim_scroll_height = $(window).height()-80;
                $(".one_section").height(slim_scroll_height);
				$(".one_section").slimScroll({
					color:'#E4E4E4'
				});

				// 添加章节
				$('.title_up').off('click').on('click',textCenter.titleUp);   //展开下级菜单
				$('.topic_name').off('click').on('click',textCenter.selectTopic);   //选中第一节章节

			}

		});
	},
	// 展开知识点
	titleUp:function(){
		var next_ulcont = $(this).parent('.one_title ').next('ul');
		var this_tispan = $(this).parent('.one_title ').find('span');
		if(this_tispan.hasClass('title_radio1')){
			this_tispan.removeClass('title_radio1').addClass('title_radio2');
			next_ulcont.slideDown();
		}else{
			this_tispan.removeClass('title_radio2').addClass('title_radio1');
			next_ulcont.slideUp();
		}
	},
	selectTopic:function(){
		var next_ulcont = $(this).parent('.one_title ').next('ul');
		var next_titlecont = next_ulcont.find('.one_title');

		var this_html = $(this).parent('.one_title').find('em').html();   //知识名称
		var this_type = $(this).attr('data-type'); //类型
		var this_code = $(this).attr('data-code'); //编号

		if(!$(this).hasClass('active')){
			$('.one_title em').removeClass('active');
			$(this).addClass('active');
			var topicId = $(this).data('code');

			$("#topictValue").val(topicId);
			$("#pageNo").val("1");

			$("#questionListDiv").html("");
			$("#pagehtml").html("");
			textCenter.treeDate("");


		}
	},
	// 滚动条快滚动到底部时，知识点窗口折叠
	slideUpTopic:function(){
		function BottomJumpPage() {
			var scrollTop = $(this).scrollTop();
			var scrollHeight = $(document).height()-375;
			var windowHeight = $(this).height();
			if (scrollTop + windowHeight >= scrollHeight) { //滚动到底部执行事件
				$('.slide_up_topic ').slideUp();
			}else{
				$('.slide_up_topic ').slideDown();
			}
		}
		// $(window).scroll(BottomJumpPage);
		$(window).scroll(function () {
			BottomJumpPage();
			if ($(window).scrollTop() > 90) {
				$('#bo_fl').addClass('pos');

			} else {
				$('#bo_fl').removeClass('pos');
			}
		});
	}
};
//分页
function page(pageno, pagesize) {
	var hidtype = $("#hidType").val();
	if(hidtype == 0) {
		$("#pageNo").val(pageno);
		textCenter.treeDate("");
	} else {
		$("#pageNoSingle").val(pageno);
		textCenter.treeDateSingle("");
	}
}
function delDisabled(){
	var length = $('#pagehtml a').length;
	for(var i=0;i<length;i++ ){
		if($('#pagehtml a').eq(i).html() == '...'){
			$('#pagehtml a').eq(i).removeClass('disabled');
		}
	}
}
//加载试题栏已有的试题
function basketQuestions(bas){
    for(var i = 0;i<bas.length;i++){
        var selquestion = [];
        selquestion.push('<li id="h-'+bas[i].qid+'">');
        selquestion.push(' <input name="p_question_scores_'+bas[i].qtype+'" value="0" type="hidden">');
        selquestion.push(' <input name="p_question_types_'+bas[i].qtype+'" value="'+bas[i].qtype+'" type="hidden">');
        selquestion.push(' <input name="p_question_ids_'+bas[i].qtype+'" value="'+bas[i].qid+'" type="hidden">');
        selquestion.push('</li>');
        $('#basket_id_'+bas[i].qtype).append(selquestion.join(""));
    }
}