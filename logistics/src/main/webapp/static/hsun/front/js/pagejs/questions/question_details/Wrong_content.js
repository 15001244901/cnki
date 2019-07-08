$(function() {
	wrongContent.init();
});
var wrongContent = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		var pid = wrongContent.getQueryString("id")
		$("#hidQid").val(pid);
		$.ajax({
			url: urlpath_a + '/exam/question/' + pid + '/view.jhtml',
			type: "GET",
			data: {
				id: pid
			},
			success: function(t) {
				var success = t.success;
				if(success) {
					var datas = t.datax;
					if(datas.qtype == 1) {
						$("#spanQType").html("单选题");
						$("#divQContent").html(datas.qcontent);
						$("#spantrueAnswered").html(datas.qkey);
						$("#spananswer").html(datas.userQuestion.ukey);

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
						//$("#spanQType").html("多选题");
						$("#divQContent").html(datas.qcontent);
						//$("#divQContenttwo").html(datas.qcontent);
						$("#spantrueAnswered").html(datas.qkey);
						$("#spananswer").html(datas.userQuestion.ukey);

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
						$("#spananswer").html(datas.userQuestion.ukey);

						$("#divAnswered").html(datas.qresolve);
					} else if(datas.qtype == 4) {
						$("#spanQType").html("填空题");
						$("#divQContent").html(replaceInput(datas.qcontent));
						//$("#divQContenttwo").html(datas.qcontent);
						$("#spantrueAnswered").html("见答案解析");
						$("#spananswer").html(datas.userQuestion.ukey);

						$("#divAnswered").html(datas.qkey);
					} else if(datas.qtype == 5) {
						$("#spanQType").html("简答题");
						$("#divQContent").html(datas.qcontent);
						//$("#divQContenttwo").html(datas.qcontent);

						$("#spantrueAnswered").html("见答案解析");
						$("#spananswer").html(datas.userQuestion.ukey);
						$("#divAnswered").html(datas.qkey);
					}
					wrongContent.getData();
				}
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
				ctype: 2,
				qid: qid,
				content: nodescontent,
				validateCode: code,
				ispublic: ispublic
			},
			success: function(t) {
				var success = t.success;
				if(success) {
					alert(t.msg);
					$("#nodesTable").html("");
					$("#pageNo").val("1")
					wrongContent.getData();
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
	getData: function() {
		var qid = $("#hidQid").val();
		var pageNo = $("#pageNo").val();
		$.ajax({
			url: urlpath_a + '/exam/question/comment.jhtml',
			type: "GET",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				qid: qid,
				ctype: 2
			},
			success: function(t) {
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
							nodeshtml.push('    <br/>');
							nodeshtml.push('    <span class="spanContent">' + datas[i].content + '</span>');
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
	//计算器
	Calculator: function() {
		layer.open({
			type: 2,
			area: ['550px', '400px'],
			title: '<span style="font-size:16px;margin-left:20px">计算器</span>',
			shade: 0.6,
			maxmin: false,
			anim: -1 //0-6的动画形式，-1不开启
				,
			content: '../../calculator/calculator.html'
		});
	},
	//纠错
	errorcorrection: function() {
		var qid = $("#hidQid").val();
		layer.open({
			type: 2,
			area: ['600px', '300px'],
			title: '<span style="font-size:16px;margin-left:20px">试题纠错</span>',
			shade: 0.6,
			maxmin: false,
			anim: -1 //0-6的动画形式，-1不开启
				,
			content: 'errorcorrection.html?id=' + qid
		});
	},
	//收藏接口
	collection: function() {
		var uid = useruid;
		var qid = $("#hidQid").val();
		$.ajax({
			url: urlpath + '/user/question/' + qid + '/collect.jhtml',
			type: "GET",
			data: {
				uid: uid,
				id: qid
			},
			success: function(t) {
				if(t.success) {
					alert(t.msg);
				} else {
					alert(t.msg)
				}
			}
		});
	}
}
//分页
function page(pageno, pagesize) {
	var pageNo = $("#pageNo").val();
	$("#pageNo").val(parseInt(pageNo) + 1);

	var totalpage = $("#totalPageCount").val();
	if(parseInt(pageNo) + 1 >= totalpage) {
		document.getElementById("pagehtml").style.display = "none";
		document.getElementById("pagehtml_all").style.display = "block";
	} else {
		wrongContent.getData();
	}
}