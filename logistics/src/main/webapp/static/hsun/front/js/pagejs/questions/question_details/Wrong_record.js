$(function() {
	wrongRecord.init();
});
var wrongRecord = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		wrongRecord.getData();
	},
	getData: function() {
		var pageNo = $("#pageNo").val();
		$.ajax({
			url: urlpath + '/user/question/wrong.jhtml',
			type: "GET",
			async: false,
			data: {
				pageNo: pageNo,
				pageSize: 10
			},
			success: function(t) {
				var success = t.success;
				if(success) {
					var datas = t.data.list;

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
						contenthtml.push('      ' + wrongRecord.replaceInput(datas[i].qcontent) + '');
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
						contenthtml.push('      <span class="exam-point">【用户】</span>');
						contenthtml.push('      <div class="analyticbox-body"> ' + (datas[i].userQuestion.ukey|'') + ' </div>');
						contenthtml.push('    </div>');
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
						contenthtml.push('      <a href="javascript:;" onclick="wrongRecord.seeResolve(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiexi"></i>查看解析');
						contenthtml.push('      </a>');
						// Todo：收藏注释
						// contenthtml.push('      <a href="javascript:;" class="'+datas[i].id+'" onclick="wrongRecord.collection(\'' + datas[i].id + '\')">');
						// if(datas[i].iscollected == "0"){
						// 	contenthtml.push('        <i class="icona-shoucang"></i><span>收藏</span>');
						// }else{
						// 	contenthtml.push('        <i class="icona-quxiaosc"></i><span>取消收藏</span>');
						// }
						// contenthtml.push('      </a>');

						contenthtml.push('      <a href="javascript:;" onclick="wrongRecord.errorcorrection(\'' + datas[i].id + '\')">');
						contenthtml.push('        <i class="icona-jiucuo"></i>纠错');
						contenthtml.push('      </a>');
						contenthtml.push('      <a href="Wrong_content.html?id=' + datas[i].id + '">');
						contenthtml.push('        <i class="icona-biji"></i>笔记');
						contenthtml.push('      </a>');
						contenthtml.push('    </p>');
						contenthtml.push('  </div>');
						
						contenthtml.push('</div>');
					}
					$("#questionListDiv").html(contenthtml.join(""));
					$("#pagehtml").html(t.data.frontPageHtml);
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
	//收藏 Todo：收藏方法注释
	collection: function(id) {
		var uid = useruid;
		$.ajax({
			url: urlpath + '/user/question/' + id + '/collect.jhtml',
			type: "GET",
			data: {
				// uid: uid,
				id: id,
				iscollected:isid
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
			content: 'errorcorrection.html?id=' + qid
		});
	}

}
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	wrongRecord.getData();
}