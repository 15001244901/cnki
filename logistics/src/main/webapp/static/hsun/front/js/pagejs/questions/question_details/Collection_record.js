$(function() {
	collectionRecord.init();
});
var collectionRecord = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		//获取知识点
		$.ajax({
			url: urlpath_a + '/sys/dict/listData.jhtml',
			type: "GET",
			async: false,
			data: {
				type: 'dic_exam_questionsubject' //科目
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data;
				var ulSubject = [];
				if(success) {
					ulSubject.push('<span>');
					ulSubject.push('  <a href="javascript:;" name="asubjectType" onclick="collectionRecord.chooseSubjectType(this,\'\')" class="active">不限</a>');
					ulSubject.push('</span>');
					for(i = 0; i < datas.length; i++) {
						ulSubject.push('<span>');
						ulSubject.push('  <a href="javascript:;" name="asubjectType" onclick="collectionRecord.chooseSubjectType(this,\'' + datas[i].value + '\')">' + datas[i].label + '</a>');
						ulSubject.push('</span>');
					}
					$("#subjectDiv").html(ulSubject.join(""));

					//题型
					$.ajax({
						url: urlpath_a + '/sys/dict/listData.jhtml',
						type: "GET",
						async: false,
						data: {
							type: 'dic_exam_questiontype' //题型
						},
						success: function(t) {
							var success = t.success;
							var datas = t.data;
							var questionhtml = [];
							if(success) {
								questionhtml.push('<span>');
								questionhtml.push('  <a href="javascript:;" name="aquestionType" onclick="collectionRecord.chooseQuestionType(this,\'\')" class="active">不限</a>');
								questionhtml.push('</span>');
								for(i = 0; i < datas.length; i++) {
									questionhtml.push('<span>');
									questionhtml.push('  <a href="javascript:;" name="aquestionType" onclick="collectionRecord.chooseQuestionType(this,\'' + datas[i].value + '\')">' + datas[i].label + '</a>');
									questionhtml.push('</span>');
								}
								$("#questionTypeDiv").html(questionhtml.join(""));
								collectionRecord.subjectList();
							}
						}
					});
				}
			}
		});
	},
	//知识点列表
	subjectList: function() {
		var pageNo = $("#pageNo").val();
		var subjecttype = $("#subjectType").val();
		var questionType = $("#questionType").val();
		$.ajax({
			url: urlpath + '/user/question/favorite.jhtml',
			type: "GET",
			data: {
				subject: subjecttype,
				qType: questionType,
				pageNo: pageNo,
				pageSize: 10, //每页记录数
			},
			success: function(t) {
				var success = t.success;
				console.log(t);
				if(success) {
					var datas = t.data.list;
					var da    = t.data.list;
					var contenthtml = [];
					for(var i = 0; i < datas.length; i++) {

						contenthtml.push('<div style="border: 1px solid #dcdcdc;margin-top: 10px;">');
						contenthtml.push('  <div class="exam-head">');
						contenthtml.push('    <p class="exam-head-left">');
						contenthtml.push('      <span>题型：' + datas[i].typeName + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>知识点：' + (datas[i].subjectName||'') + '</span>');
						contenthtml.push('      <i class="line"></i>');
						contenthtml.push('      <span>难易度：' + (datas[i].levelName||'') + '</span>');
						contenthtml.push('    </p>');
						contenthtml.push('    <p class="exam-head-right">');
						contenthtml.push('      <span>');
						contenthtml.push('      本题正确率：61%&nbsp;&nbsp;&nbsp;&nbsp;此题被做次数：7348次');
						contenthtml.push('      </span>');
						contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-con">');
						contenthtml.push('    <div class="exam-q">');
						contenthtml.push('      ' + collectionRecord.replaceInput(datas[i].qcontent) + '');
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
						contenthtml.push('      <div class="analyticbox-body"> ' + (datas[i].qresolve||'') + '</div>');
						contenthtml.push('    </div>');

						contenthtml.push('  </div>');
						contenthtml.push('  <div class="exam-foot">');
						contenthtml.push('    <p class="exam-foot-left">');
						contenthtml.push('      <a href="javascript:;" onclick="collectionRecord.seeResolve(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiexi"></i>查看解析');
						contenthtml.push('      </a>');
						// Todo:收藏模块先注释
						// contenthtml.push('      <a href="javascript:;" onclick="collectionRecord.collection(\'' + datas[i].id + '\',\'' + (da[i].iscollected||'') + '\')">');
						// if(!datas[i].iscollected){
						// 	contenthtml.push('        <i class="icona-shoucang"></i><span>收藏</span>');
						// }else{
						// 	contenthtml.push('        <i class="icona-quxiaosc"></i><span>取消收藏</span>');
						// }
						// contenthtml.push('      </a>');
						contenthtml.push('      <a href="javascript:;" onclick="collectionRecord.errorcorrection(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiucuo"></i>纠错');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="Collection_content.html?id=' + datas[i].id + '">');
						contenthtml.push('        <i class="icona-biji"></i>笔记');
						contenthtml.push('      </a>');
						contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						
						contenthtml.push('</div>');
					}
					$("#loreContent").html(contenthtml.join(""));
					$("#loreContentPage").html(t.data.frontPageHtml);
				}
			}
		});
	},
	//替换输入框
	replaceInput: function(qcontent) {
		//return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text"  class="questionInput"/>&nbsp;&nbsp;')
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//查看详情
	seeDetail: function(qid) {
		//alert(qid)
		window.location.href = "Collection_content.html?id=" + qid;
	},
	//点击知识点
	chooseSubjectType: function(athis, id) {
		var subjectType = document.getElementsByName("asubjectType");
		for(var i = 0; i < subjectType.length; i++) {
			subjectType[i].className = "";
		}
		athis.className = "active";
		$("#pageNo").val("1");
		$("#subjectType").val(id);
		$("#loreContent").html("");
		$("#loreContentPage").html("");
		collectionRecord.subjectList();
	},
	//点击题型
	chooseQuestionType: function(athis, id) {
		var subjectType = document.getElementsByName("aquestionType");
		for(var i = 0; i < subjectType.length; i++) {
			subjectType[i].className = "";
		}
		athis.className = "active";
		$("#pageNo").val("1");
		$("#questionType").val(id);
		$("#loreContent").html("");
		$("#loreContentPage").html("");
		collectionRecord.subjectList();
		//collectionRecord.qTypeList();
	},
	//知识点
	//		toDivLore: function() {
	//			document.getElementById("JKDiv_0").style.display = "block";
	//			document.getElementById("JKDiv_1").style.display = "none";
	//
	//			document.getElementById("hidType").value = "0";
	//			document.getElementById("pageNo").value = "1";
	//			collectionRecord.subjectList();
	//		},
	//题型
	//		toDivQuestions: function() {
	//			document.getElementById("JKDiv_1").style.display = "block";
	//			document.getElementById("JKDiv_0").style.display = "none";
	//
	//			document.getElementById("hidType").value = "1";
	//			document.getElementById("pageNoQuestion").value = "1";
	//			collectionRecord.qTypeList();
	//		},
	//查看解析
	seeResolve: function(id) {
		if(document.getElementById("R-" + id).style.display == "block"){
			document.getElementById("R-" + id).style.display = "none";
		}else{
			document.getElementById("R-" + id).style.display = "block";
		}
	},
	//收藏 Todo收藏方法注释
	// collection: function(id,isid) {
	// 	var uid = useruid;
	// 	$.ajax({
	// 		url: urlpath + '/user/question/' + id + '/collect.jhtml',
	// 		type: "GET",
	// 		data: {
	// 			// uid: uid,
	// 			id: id ,
	// 			iscollected:isid
	// 		},
	// 		success: function(t) {
	// 			if(t.success) {
	// 				alert(t.msg);
	// 				collectionRecord.subjectList();
	// 			} else {
	// 				alert(t.msg)
	// 			}
	// 		}
	// 	});
	// },
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
			content: 'errorcorrection.html?id=' + qid
		});
	}

}
//分页
function page(pageno, pagesize) {
	var hidtype = $("#hidType").val();
	if(hidtype == 0) {
		$("#pageNo").val(pageno);
		collectionRecord.subjectList();
	} else {
		$("#pageNoQuestion").val(pageno);
		collectionRecord.qTypeList();
	}
}