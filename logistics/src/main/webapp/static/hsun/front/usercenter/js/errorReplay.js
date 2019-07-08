$(function() {
	lookBank.init();
});

var lookBank = {
	//初始化
	init: function() {
		//获取id
		var id = lookBank.getQueryString("id");
		$("#hidQid").val(id);

		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		$.ajax({
			url: urlpath_a + '/exam/question/' + id + '/view.jhtml',
			type: "GET",
			data: {
				id: id
			},
			success: function(t) {
				console.log(t);
				var success = t.success;
				var datas = t.datax;
				if(success) {
					if(datas.qtype == 1) {
						$("#spanQType").html("单选题");
						$("#divQContent").html(datas.qcontent);
						//$("#divQContenttwo").html(datas.qcontent);
						$("#spantrueAnswered").html(datas.qkey);

						$("#divAnswered").html(datas.qresolve);

						var alisahtml = [];
						var qdatajsons = datas.options;
						//alert(qdatajsons)
						for(var i = 0; i < qdatajsons.length; i++) {
							var alisa = qdatajsons[i].alisa;
							var alisaContent = qdatajsons[i].text;

							alisahtml.push('<div style="float:left">');
							alisahtml.push(alisa + "&nbsp;、&nbsp;");
							alisahtml.push('</div>');

							alisahtml.push('<div>');
							alisahtml.push(alisaContent);
							alisahtml.push('</div>');
						}
						$("#divAlisa").html(alisahtml.join(""));
					} else if(datas.qtype == 2) {
						$("#spanQType").html("多选题");
						$("#divQContent").html(datas.qcontent);
						//$("#divQContenttwo").html(datas.qcontent);
						$("#spantrueAnswered").html(datas.qkey);

						$("#divAnswered").html(datas.qresolve);

						var alisahtml = [];
						var qdatajsons = datas.options;
						//alert(qdatajsons)
						for(var i = 0; i < qdatajsons.length; i++) {
							var alisa = qdatajsons[i].alisa;
							var alisaContent = qdatajsons[i].text;

							alisahtml.push('<div style="float:left">');
							alisahtml.push(alisa + "&nbsp;、&nbsp;");
							alisahtml.push('</div>');

							alisahtml.push('<div>');
							alisahtml.push(alisaContent);
							alisahtml.push('</div>');
						}
						$("#divAlisa").html(alisahtml.join(""));
					} else if(datas.qtype == 3) {
						$("#spanQType").html("判断题");
						$("#divQContent").html(datas.qcontent);
						//$("#divQContenttwo").html(datas.qcontent);
						$("#spantrueAnswered").html(datas.qkey);

						$("#divAnswered").html(datas.qresolve);
					} else if(datas.qtype == 4) {
						$("#spanQType").html("填空题");
						$("#divQContent").html(replaceInput(datas.qcontent));
						//$("#divQContenttwo").html(datas.qcontent);
						$("#spantrueAnswered").html("见答案解析");

						$("#divAnswered").html(datas.qkey);
					} else if(datas.qtype == 5) {
						$("#spanQType").html("简答题");
						$("#divQContent").html(datas.qcontent);
						//$("#divQContenttwo").html(datas.qcontent);

						$("#spantrueAnswered").html("见答案解析");
						$("#divAnswered").html(datas.qkey);
					}
					lookBank.getData();

				}
			}
		});
	},
	//提交笔记
	submitNodes: function() {
		var ispublic = document.getElementById("chkpublic").checked;
		if(ispublic) {
			ispublic = 1;
		} else {
			ispublic = 0;
		}
		var nodescontent = $("#nodesContent").val();
		if(nodescontent == "") {
			alert("笔记内容不能为空");
			return;
		}
		var code = $("#inp_text").val();
		if(code == "") {
			alert("验证码不能为空");
			return;
		}
		var qid = $("#hidQid").val();

		$.ajax({
			url: urlpath_a + '/exam/question/commentsave.jhtml',
			type: "GET",
			data: {
				ctype: 3,
				qid: qid,
				content: nodescontent,
				validateCode: code,
				ispublic: ispublic
			},
			success: function(t) {
				var success = t.success;
				if(success) {

					// alert(t.msg);
					$("#nodesTable").html("");
					$("#pageNo").val("1");
					lookBank.getData();
				} else {
					alert(t.msg);
				}
			}
		});

	},
	//做笔记按钮
	nodesClick: function() {
		document.getElementById("nodesDiv").style.display = "block";
		//getData();
	},
	//获取笔记列表接口
	getData: function() {
		var pageNo = $("#pageNo").val();
		var qid = $("#hidQid").val();
		
		$.ajax({
			url: urlpath_a + '/exam/question/comment.jhtml',
			type: "GET",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				qid: qid,
				ctype: 3
			},
			success: function(t) {
				console.log(t);
				var success = t.success;
				$("#spannodes").html(t.data.count);
				if(success) {
					var nodeshtml = [];
					var datas = t.data.list;
					if(typeof(datas) != "undefined" || t.data.count > 0) {
						$("#totalPageCount").val(t.data.totalPageCount);
						for(var i = 0; i < datas.length; i++) {
							nodeshtml.push('<tr>');
							nodeshtml.push('  <td>');
							nodeshtml.push('    <span class="spanUserPhoto"><img src="' + userphotopath + datas[i].userphoto + '"/></span>');
							nodeshtml.push('    <span class="spanName">' + datas[i].name + '</span>');
							nodeshtml.push('    <span class="spanTime">' + datas[i].createDate + '</span>');
							nodeshtml.push('    <a href="javasscript:void(0)" class="replay" onclick="lookBank.showAsk(\''+datas[i].id+'\')">回复</a>');
							nodeshtml.push('    <span class="spanContent">' + datas[i].content + '</span>');
							nodeshtml.push('     <div class="error_replay" id="a_'+datas[i].id+'"></div>');

							nodeshtml.push('    <div id="alert_replay">');
							nodeshtml.push('     <div class="error_replay_cont">');
							nodeshtml.push('       <textarea name="message" placeholder="说点什么吧…"></textarea>');
							nodeshtml.push('       <div class="issue"><a title="点击收起" href="javascript:void(0);" onclick="lookBank.slideUp()"></a><span title="点击发布">发布</span></div>')
							nodeshtml.push('     </div>');
							nodeshtml.push('    </div>');

							nodeshtml.push('    <div class="error_replay-infor padnum1">');
							nodeshtml.push('     <span class="spanUserPhoto"><img src="' + userphotopath + datas[i].userphoto + '"/></span>');
							nodeshtml.push('     <span class="spanName">' + datas[i].name + '</span>');
							nodeshtml.push('     <span class="spanTime">' + datas[i].createDate + '</span>');
							nodeshtml.push('     <a href="javasscript:void(0)" class="replay" onclick="lookBank.showReplay(\''+datas[i].id+'\')">回复</a>');
							nodeshtml.push('     <span class="spanContent">' + datas[i].content + '</span>');
							nodeshtml.push('     <div class="error_replay" id="r_'+datas[i].id+'"></div>');
							nodeshtml.push('    </div>');

							nodeshtml.push('  </td>');
							nodeshtml.push('</tr>');
						}
						$("#nodesTable").append(nodeshtml.join(""));
					} else {
						document.getElementById("pagehtml").style.display = "none";
						document.getElementById("pagehtml_all").style.display = "none";
					}
					//$("#pagehtml").html(t.data.frontPageHtml);
				}
			}
		});
	},
	//替换输入框
	replaceInput: function(qcontent) {
		//return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text"  class="questionInput"/>&nbsp;&nbsp;')
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;')
	},
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	showReplay: function(num){
		$('.error_replay').html('');
		if($('#r_'+num).html()){
			$('#r_'+num).html('');
		}else{
			$('#r_'+num).html($('#alert_replay').html());
		}
		
	},
	showAsk: function(num){
		$('.error_replay').html('');
		if($('#a_'+num).html()){
			$('#a_'+num).html('');
		}else{
			$('#a_'+num).html($('#alert_replay').html());
		}
	},
	slideUp:function(){
		$('.error_replay').html('');
	},

}
//分页
function page(pageno, pagesize) {
	var pageNo = $("#pageNo").val();
	var totalpage = $("#totalPageCount").val();
	$("#pageNo").val(parseInt(pageNo) + 1);

	if(parseInt(pageNo) + 1 >= totalpage) {
		document.getElementById("pagehtml").style.display = "none";
		document.getElementById("pagehtml_all").style.display = "block";
	} else {
		lookBank.getData();
	}
}