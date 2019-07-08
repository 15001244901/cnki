$(function() {
	lookBank.init();
});

var lookBank = {
	//初始化
	init: function() {
		//获取id
		var id = lookBank.getQueryString("id");
		$("#hidQid").val(id);

		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		$.ajax({
			url: urlpath_a + '/exam/question/' + id + '/view.jhtml',
			type: "GET",
			data: {
				id: id
			},
			success: function(t) {
				// console.log(t);
				var success = t.success;
				var datas = t.datax;
				var dat = t.data;
				if(success) {
					var subjectName = dat.subjectName || ' ';
					var levelName = dat.levelName || ' ';
					var typeName = dat.typeName || ' ';
					var postName = dat.postName || ' ';
					var topicName = dat.topicName || ' ';
					var stdNo = dat.stdNo || ' ';
					$("#spanQType").html("题型："+typeName+"<i class='line'></i>知识点："+topicName+"<i class='line'></i>难易度："+levelName+"<i class='line'></i>依据标准："+stdNo);
					$("#divQContent").html(lookBank.delDiv(datas.qcontent));

					if(datas.qtype == 1 || datas.qtype == 2) {
						$("#spantrueAnswered").html(datas.qkey);
						$("#divAnswered").html(datas.qresolve);

						var alisahtml = [];
						var qdatajsons = datas.options;
						//alert(qdatajsons)
						for(var i = 0; i < qdatajsons.length; i++) {
							var alisa = qdatajsons[i].alisa;
							var alisaContent = qdatajsons[i].text;
							alisahtml.push('<div style="clear: both;">');
							alisahtml.push('<div style="float:left">');
							alisahtml.push(alisa + "&nbsp;、&nbsp;");
							alisahtml.push('</div>');

							alisahtml.push('<div>');
							alisahtml.push(lookBank.delP(alisaContent));
							alisahtml.push('</div>');
							alisahtml.push('</div>')
						}
						$("#divAlisa").html(alisahtml.join(""));
					}else if(datas.qtype == 3) {
						var alisahtml = [];
						alisahtml.push('<div style="clear: both;">');
						alisahtml.push("Y&nbsp;、&nbsp;正确");
						alisahtml.push('</div>');
						alisahtml.push('<div style="clear: both;">');
						alisahtml.push("N&nbsp;、&nbsp;错误");
						alisahtml.push('</div>');
						$("#spantrueAnswered").html(datas.qkey);
						$("#divAnswered").html(datas.qresolve);
						$("#divAlisa").html(alisahtml.join(""));
					} else if(datas.qtype == 4) {
						$("#divQContent").html(lookBank.replaceInput(datas.qcontent));
						$("#spantrueAnswered").html("见答案解析");
						$("#divAnswered").html(datas.qkey);
					} else if(datas.qtype == 5 || datas.qtype == 6) {
						// $("#spanQType").html(datas.typeName+"题");
						// $("#divQContent").html(datas.typeName+"题："+lookBank.delP(datas.qcontent));
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
							if(datas[i].userphoto) {
								nodeshtml.push('    <span class="spanUserPhoto"><img src="' + userphotopath + datas[i].userphoto + '"/></span>');
							} else {
								nodeshtml.push('    <span class="spanUserPhoto"><img src="' + projectname + '/static/images/userphoto.jpg"/></span>');
							}
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
	//替换输入框
	replaceInput: function(qt) {
			return qt.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<u style="letter-spacing:60px;">&nbsp;</u>&nbsp;&nbsp;');
		// return qt.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text"  class="questionInput"/>&nbsp;&nbsp;')

	},
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//去除p标签
	delP:function(str){
		if(str) {
			str = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
			str = str.replace(/&nbsp;/g,"");
		}
		return str;
	},
	//去除div标签
	delDiv:function(str){
		if(str) {
			str = str.replace(/<\/{0,}[div](.+?)>[\s\S]*?<\/{0,}[div](.+?)>/g,"");//去掉
			str = str.replace(/&nbsp;/g,"");
		}
		return str;
	}
};
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