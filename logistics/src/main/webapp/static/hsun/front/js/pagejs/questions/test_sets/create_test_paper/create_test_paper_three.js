$(function() {
	createTestPaperThree.init();
});
var createTestPaperThree = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		createTestPaperThree.getData("");
	},
	//查询
	searchContent: function() {
		var keyword = $("#keyword").val();
		$("#pageNo").val("1");
		createTestPaperThree.getData(keyword);
	},
	//获取数据
	getData: function(keyword) {
		$('#tableContent').removeClass('no_info');
		nowLoadData('#tableContent');

		var pageNo = $("#pageNo").val(); //当前页
		$.ajax({
			url: urlpath_a + '/exam/paper/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				name: keyword,
				category: 2
			},
			success: function(t) {
				//var t = JSON.parse(data);
				if(!t.data.list){
					$('#tableContent').html('');
					$("#tableContentPage").html('');
					$('#tableContent').addClass('no_info');
					return;
				}
				var success = t.success;
				var datas = t.data.list;
				var html = [];
				if(success) {
					for(i = 0; i < datas.length; i++) {
						html.push('<div class="section">');

						html.push(' <div class="div5">');
						html.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + datas[i].name + '</a></span>');
						html.push('  <span class="three2">创建日期 : ' + datas[i].createDate + '</span>');
						html.push(' </div>');

						html.push(' <div class="div6">');
						html.push('  <span class="one6">分数 ：  ' + datas[i].totalscore + ' 分</span>');
						// html.push('  <a class="two6"  href="javascript:;"  onclick="createTestPaperThree.ShowDiv(\'' + datas[i].id + '\')">选择试题</a>');
						html.push('  <a class="two6 exam" title="开始组卷" href="javascript:;"  onclick="createTestPaperThree.ShowDiv(\'' + datas[i].id + '\')"></a>');

						html.push(' </div>');

						html.push('</div>');

						// html.push('<tr>');
						// html.push(' <td class="td1">' + datas[i].name + '</td>');
						// html.push(' <td class="td2"><a href="javascript:;" onclick="createTestPaperThree.ShowDiv(\'' + datas[i].id + '\')">选择试题</a></td>');
						// html.push('</tr>');
					}
					$("#tableContent").html(html.join(""));
					$("#tableContentPage").html(t.data.frontPageHtml);
					delDisabled();
				}

			},
			error:function(){
				loadFail('#tableContent')
			}
		});
	},
	//保存试题
	saveQuestionThree: function() {
		//试卷ID
		var questionid = $("#hidQuestionId").val();
		//试卷名称
		var questionName = $(".layui-layer-content #questionName").val();
		if(questionName == "" || questionName == "请输入试卷名称") {
			layer.tips('试卷名称不能为空', '.layui-layer-content #questionName', {
				tips: [1, '#3595CC'],
				time: 2000
			});
			return;
		}
		$.ajax({
			url: urlpath_a + '/exam/paper/copypaper.jhtml',
			type: "GET",
			data: {
				copyid: questionid,
				copyname: questionName
			},
			success: function(t) {
				//var t = JSON.parse(data);
				var success = t.success;
				if(success) {
					// layer.open({
					// 	title: '系统提示',
					// 	closeBtn: 1,
					// 	skin: 'layui-layer-molv',
					// 	content: '<div style="text-align:center;">'+t.msg+'</div>',
					// 	yes: function(index, layero){
					// 		layer.close(index);
					// 		window.location.href = "../text_sets.html"+timestamps;
					// 	}
					// });
					window.location.href = "../text_sets.html"+timestamps;
				} else {
					// layer.open({
					// 	title: '系统提示',
					// 	closeBtn: 1,
					// 	skin: 'layui-layer-molv',
					// 	content: '<div style="text-align:center;">'+t.msg+'</div>',
					// 	yes: function(index, layero){
					// 		layer.close(index);
					// 	}
					// });
				}
			}
		});

	},
	//显示div层
	ShowDiv: function(id) {
		$("#hidQuestionId").val(id);
		// document.getElementById("div5").style.display = 'block';
		layer.open({
			type:1,
			title: '<p style="font-size: 16px;font-weight: bold;text-align: center;color: #fff;">重命名试卷名称</p>',
			shadeClose: true,
			shade: 0.8,
			shadeClose:false,
			area: ['400px', '200px'],
			content: $('#hand_test').html()
		});
	},
	//关闭弹出层
	CloseDiv: function(show_div) {
		document.getElementById(show_div).style.display = 'none';
	}
}
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	createTestPaperThree.getData("");
}
function delDisabled(){
	var length = $('#tableContentPage a').length;
	for(var i=0;i<length;i++ ){
		if($('#tableContentPage a').eq(i).html() == '...'){
			$('#tableContentPage a').eq(i).removeClass('disabled');
		}
	}
}