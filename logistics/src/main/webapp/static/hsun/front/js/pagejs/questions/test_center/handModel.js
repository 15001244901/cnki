$(function() {
	textCenter.init();
	$(window).scroll(function () {
		if ($(window).scrollTop() > 135) {
			$('#bo_fl').addClass('pos');

		} else {
			$('#bo_fl').removeClass('pos');
		}

	});
});
var stop = false;
var textCenter = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		//科目类别
		$.ajax({
			url: urlpath_a + '/sys/dict/listData.jhtml',
			type: "GET",
			async: false,
			dataType: "jsonp",
			jsonp: "callback",
			jsonpCallback: "successCallback",
			data: {
				type: 'dic_exam_questionsubject' //科目
			},
			success: function(t) {
				console.log(t);
				//var t = JSON.parse(data);
				var success = t.success;
				var datas = t.data;
				var ulSubject = [];
				if(success) {
					ulSubject.push('<li class="active" name="liSubject" onclick="textCenter.chooseSubjectType(this,\'\')">');
					ulSubject.push('  <a href=\"javascript:;\"><span>不限</span></a>');
					ulSubject.push('</li>');
					for(i = 0; i < datas.length; i++) {
						ulSubject.push('<li name="liSubject" onclick="textCenter.chooseSubjectType(this,\'' + datas[i].value + '\')">');
						ulSubject.push('  <a href=\"javascript:;\"><span>' + datas[i].label + '</span></a>');
						ulSubject.push('</li>');
					}
					$("#ulSubject").html(ulSubject.join(""));

					//题型类型
					$.ajax({
						url: urlpath_a + '/sys/dict/listData.jhtml',
						type: "GET",
						async: false,
						dataType: "jsonp",
						jsonp: "callback",
						jsonpCallback: "successCallback",
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
									dataType: "jsonp",
									jsonp: "callback",
									jsonpCallback: "successCallback",
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
												url: urlpath_a + '/sys/dict/listData.jhtml',
												type: "GET",
												async: false,
												dataType: "jsonp",
												jsonp: "callback",
												jsonpCallback: "successCallback",
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

				}
			}
		});
	},
	//获取题库列表
	treeDate: function(keyword) {
		var pageNo = $("#pageNo").val();
		var subjectValue = $("#subjectType").val();
		var questionValue = $("#questionType").val();
		var levelValue = $("#levelType").val();
		var postValue = $("#postType").val();

		$.ajax({
			url: urlpath_a + '/exam/question/list.jhtml',
			type: "GET",
			dataType: "jsonp",
			jsonp: "callback",
			jsonpCallback: "successCallback",
			data: {
				pageNo: pageNo,
				pageSize: 10, //每页记录数
				qStatus: 1, //0未审核；1已审核；2待定
				qContent: keyword, //关键字
				subject: subjectValue, //科目
				QType: questionValue, //题型
				qLevel: levelValue, //难度
				post: postValue //岗位
			},
			success: function(t) {
				console.log(t);
				var success = t.success;
				if(success) {
					$("#questionListDiv").html("");
					$("#pagehtml").html("");
					var datas = t.datax;
					var contenthtml = [];
					for(var i = 0; i < datas.length; i++) {

						contenthtml.push('<div id="b-' + datas[i].id + '" style="border: 1px solid #dcdcdc;margin-top: 10px;">');
						contenthtml.push('  <div class="exam-head">');
						contenthtml.push('    <p class="exam-head-left">');
						contenthtml.push('      <span>题型：' + datas[i].typeName + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>知识点：' + datas[i].subjectName + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>难易度：' + datas[i].levelName + '</span>');
						contenthtml.push('    </p>');
						contenthtml.push('    <p class="exam-head-right">');
						contenthtml.push('      <span>');
						contenthtml.push('      本题正确率：61%&nbsp;&nbsp;&nbsp;&nbsp;此题被做次数：7348次');
						contenthtml.push('      </span>');
						contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-con">');
						contenthtml.push('    <div class="exam-q">');
						contenthtml.push('      ' + textCenter.replaceInput(datas[i].qcontent) + '');
						contenthtml.push('    </div>');
						contenthtml.push('    <div class="exam-s">');
						if(datas[i].qtype == "1" || datas[i].qtype == "2") {
							var qdatajsons = datas[i].options;
							for(var j = 0; j < qdatajsons.length; j++) {
								var alisa = qdatajsons[j].alisa;
								var alisaContent = qdatajsons[j].text;

								contenthtml.push('<div style="float:left">');
								contenthtml.push(alisa + "&nbsp;、&nbsp;");
								contenthtml.push('</div>');

								contenthtml.push('<div>');
								contenthtml.push(alisaContent);
								contenthtml.push('</div>');
							}
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
						contenthtml.push('      <div class="analyticbox-body"> ' + datas[i].qresolve + '</div>');
						contenthtml.push('    </div>');

						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-foot">');
						contenthtml.push('    <p class="exam-foot-left">');
						contenthtml.push('      <a href="javascript:;" onclick="textCenter.seeResolve(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiexi"></i>查看解析');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="javascript:;" class="'+datas[i].id+'" onclick="textCenter.collection(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-shoucang"></i><span>收藏</span>');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="javascript:;" onclick="textCenter.errorcorrection(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiucuo"></i>纠错');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="look_bank.html?id=' + datas[i].id + '">');
						contenthtml.push('        <i class="icona-biji"></i>笔记');
						contenthtml.push('      </a>');
						contenthtml.push('      <a class="bo_addbtn" id="a-' + datas[i].id + '" href="javascript:void(0);" onclick="textCenter.adds(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-up"></i><span id="o-' + datas[i].id + '">选题</span>');
						contenthtml.push('      </a>');
						contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						
						contenthtml.push('</div>');
					}
					$("#questionListDiv").html(contenthtml.join(""));
					$("#pagehtml").html(t.data.frontPageHtml);
					delDisabled();
				}

			}
		});
	},
	//替换输入框
	replaceInput: function(qcontent) {
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//查看解析
	seeResolve: function(id) {
		if(document.getElementById("R-" + id).style.display == "block"){
			document.getElementById("R-" + id).style.display = "none";
		}else{
			document.getElementById("R-" + id).style.display = "block";
		}
		
	},
	//收藏
	collection: function(id) {
		var uid = useruid;
		$.ajax({
			url: urlpath + '/user/question/' + id + '/collect.jhtml',
			type: "GET",
			dataType: "jsonp",
			jsonp: "callback",
			jsonpCallback: "successCallback",
			data: {
				uid: uid,
				id: id
			},
			success: function(t) {
				if(t.success) {
					alert(t.msg);
					$('.'+id).find('span').html('已收藏');
				} else {
					alert(t.msg)
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
			content: '../question_details/errorcorrection.html?id=' + qid
		});
	},
	
	//上一道
	beforeQuestion: function() {
		var pageNo = $("#pageNoSingle").val();
		if(pageNo == 1) {
			alert("已经是第一条数据了")
		} else {
			var newpageNo = parseInt(pageNo) - 1;
			$("#pageNoSingle").val(newpageNo);

			textCenter.treeDateSingle("");
		}

	},
	//下一道
	nextQuestion: function() {
		var totalpagecount = $("#totalPageCount").val();
		var pageNo = $("#pageNoSingle").val();
		if(pageNo == totalpagecount) {
			alert("已经是最后一条数据了");
		} else {
			var newpageNo = parseInt(pageNo) + 1;
			$("#pageNoSingle").val(newpageNo);

			textCenter.treeDateSingle("");
		}
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
	adds:function(e){

		var endTop = $('#J_Basket').offset().top;
		var endLeft = $('#J_Basket').offset().left;
		var startTop = $('#b-'+e).offset().top;
		var startLeft =$('#b-'+e).offset().left;
		
		var text = $('#o-'+e).html();
		if(text == '选题'){
			stop = false;
			$('#o-'+e).html('移出');
			$('#o-'+e).parent('.bo_addbtn').addClass('bo_addbtn_bg');
		}else{
			stop = true;
			$('#o-'+e).html('选题');
			$('#o-'+e).parent('.bo_addbtn').removeClass('bo_addbtn_bg');
		}
		if(stop == 0){
			stop = true;
			$('body').append('<div class="app" style="position:absolute;overflow:hidden;width:920px;"></div>');
			$('.app').css({'top':startTop,'left':startLeft});
			$('.app').append($('#b-'+e).clone(true));
			$('.app').animate({
				top:endTop,
				left:endLeft,
				width:100,
				height:50,
				//opacity:1
				
			},function(){
				$('.app').remove();
				stop = false;
			});
			
			
			
		}
		

		
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