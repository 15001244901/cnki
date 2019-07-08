$(function() {
	textCenter.init();
	textCenter.initTopic();
	textCenter.slideUpTopic();
});
var keyword;
var textCenter = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		keyword = textCenter.getQueryString('keyword');
		$("#keyword").val(keyword);
		//科目类别
		// $.ajax({
		// 	url: urlpath_a + '/sys/dict/listData.jhtml',
		// 	type: "GET",
		// 	async: false,
		// 	dataType: "jsonp",
		// 	jsonp: "callback",
		// 	jsonpCallback: "successCallback",
		// 	data: {
		// 		type: 'dic_exam_questionsubject' //科目
		// 	},
		// 	success: function(t) {
		// 		//var t = JSON.parse(data);
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
		// 			$("#ulSubject").html(ulSubject.join(""));

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
														textCenter.treeDate(keyword);
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
	},
	//获取题库列表
	treeDate: function(keyword) {
		$("#questionListDiv").removeClass('no_info');
		nowLoadData('#questionListDiv');

		var pageNo = $("#pageNo").val();
		var subjectValue = $("#subjectType").val();
		var questionValue = $("#questionType").val();
		var levelValue = $("#levelType").val();
		var postValue = $("#postType").val();
		var topictValue = $("#topictValue").val();

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
				qKeyword: keyword, //关键字
				// subject: subjectValue, //科目
				QType: questionValue, //题型
				qLevel: levelValue, //难度
				post: postValue, //岗位
				topic:topictValue //知识点
			},
			success: function(t) {
				// console.log(t);
				var success = t.success;

				$("#questionListDiv").html('');
				if(!t.data.list){
					setTimeout(function(){
						$("#questionListDiv").addClass('no_info');
					},300);
					$("#pagehtml").html('');
					return;
				}
				if(success) {
					$("#questionListDiv").html("");
					$("#pagehtml").html("");
					var datas = t.datax;
					var da    = t.data.list;
					var contenthtml = [];
					for(var i = 0; i < datas.length; i++) {

						//去除题干的html
						datas[i].qcontent = textCenter.delP(datas[i].qcontent);

						contenthtml.push('<div style="border: 1px solid #dcdcdc;margin-top: 10px;">');
						contenthtml.push('  <div class="exam-head">');
						contenthtml.push('    <p class="exam-head-left">');
						contenthtml.push('      <span>题型：' + datas[i].typeName + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>知识点：' + (datas[i].topicName||'') + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>难易度：' + (datas[i].levelName||'') + '</span>');
						contenthtml.push('    </p>');
						// contenthtml.push('    <p class="exam-head-right">');
						// contenthtml.push('      <span>');
						// contenthtml.push('      本题正确率：61%&nbsp;&nbsp;&nbsp;&nbsp;此题被做次数：7348次');
						// contenthtml.push('      </span>');
						// contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-con">');
						contenthtml.push('    <div class="exam-q">');
						contenthtml.push('      ' + textCenter.replaceInput(datas[i].qcontent) + '');
						contenthtml.push('    </div>');
						contenthtml.push('    <div class="exam-s" >');
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
						contenthtml.push('      <div class="analyticbox-body"> ' + (datas[i].qresolve||'') + '</div>');
						contenthtml.push('    </div>');

						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-foot">');
						contenthtml.push('    <p class="exam-foot-left">');
						contenthtml.push('      <a href="javascript:;" onclick="textCenter.seeResolve(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiexi"></i>查看解析');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="javascript:;"  class="'+datas[i].id+'" onclick="textCenter.collection(\'' + datas[i].id + '\',\'' + (da[i].iscollected||'') + '\')">');

						if(!da[i].iscollected){
							contenthtml.push('        <i class="icona-shoucang"></i><span>收藏</span>');
						}else{
							contenthtml.push('        <i class="icona-quxiaosc"></i><span>取消收藏</span>');
						}

						contenthtml.push('      </a>');
						contenthtml.push('      <a href="javascript:;" onclick="textCenter.errorcorrection(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiucuo"></i>纠错');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="look_bank.html?id=' + datas[i].id + '">');
						contenthtml.push('        <i class="icona-biji"></i>笔记');
						contenthtml.push('      </a>');
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
				loadFail("#questionListDiv");
			}
		});

	},
	//获取url参数传值
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//替换输入框
	replaceInput: function(qcontent) {
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//去掉html
	delHtml:function(str){
		// return str.replace(/<[^>]+>/g,"");
		str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
		bstr=str.replace(/<\/?.+?>/g,"");//去掉
		return bstr;
	},
	delP:function(str){
		if(!str){
			return str;
		}
		str = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
		str = str.replace(/&nbsp;/g,"");
		return str;
	},
	//查看解析
	seeResolve: function(id) {
		if(document.getElementById("R-" + id).style.display == "block"){
			// document.getElementById("R-" + id).style.display = "none";
			$("#R-" + id).slideUp();
		}else{
			$("#R-" + id).slideDown();
			document.getElementById("R-" + id).style.display = "block";
		}
		
	},
	//收藏
	collection: function(id,isid) {
		var uid = useruid;
		$.ajax({
			url: urlpath + '/user/question/' + id + '/collect.jhtml',//delete
			type: "GET",
			dataType: "jsonp",
			jsonp: "callback",
			jsonpCallback: "successCallback",
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
							anim:4,
							time:3000
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
							anim:4,
							time:3000
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
			content: '../question_details/errorcorrection.html?id=' + qid
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
			textCenter.treeDate(keyword);
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
			textCenter.treeDate(keyword);
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
			textCenter.treeDate(keyword);
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
			textCenter.treeDate(keyword);
		}
	},
	//查询
	searchLibrary: function() {
		keyword = $("#keyword").val();
		$("#pageNo").val("1");
		$("#pageNoSingle").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			textCenter.treeDate(keyword);
		}
	},
	// 新添知识点树层结构===================================================================
	initTopic:function(){
		var tree_one_data = [];
		var tree_two_data = [];
		var tree_red_data = [];
		var tree_three_data = [];

		var list_html = [];
		$.ajax({
			url:urlpath_a+'/sys/dict/treeData.jhtml?type=dic_exam_questiontopic',
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
					color:'#E4E4E4',
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
			textCenter.treeDate(keyword);
		}
	},
	// 滚动条快滚动到底部时，知识点窗口折叠
	slideUpTopic:function(){
		function BottomJumpPage() {
			var scrollTop = $(this).scrollTop();
			var scrollHeight = $(document).height()-300;
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

