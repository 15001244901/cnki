$(function() {
	majorpageQuestion.init();
});
var majorpageQuestion = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		majorpageQuestion.getData();
	},
	//获取成套试卷列表
	getData: function() {
		var pageNo = $("#pageNo").val();
		var paperName = $("#txtPaperName").val();
		var paperType = $("#selPaperType").val();
		nowLoadData('#table3');
		$.ajax({
			url: urlpath + '/user/practice/practice.jhtml',
			type: "GET",
			data: {
				// name:paperName,
				ptype: 3,
				pageNo: pageNo,
				pageSize: 10
			},
			success: function(t) {
				// console.log(t);
				if(!t.data.list){
					$("#table3").html('');
					$("#table3").addClass('no_info');
					return;
				}
				var success = t.success;
				if(success) {
					var datas = t.data.list;
					var questionhtml = [];
					for(var i = 0; i < datas.length; i++) {
						questionhtml.push('<div class="section">');

						questionhtml.push(' <div class="div5">');
						questionhtml.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + datas[i].name + '</a></span>');
						questionhtml.push('  <span class="three2">创建日期 : ' + datas[i].createDate + '</span>');
						questionhtml.push(' </div>');

						questionhtml.push(' <div class="div6">');
						questionhtml.push('  <span class="one6">分数 ：  ' + datas[i].totalscore + ' 分</span>');
						questionhtml.push('  <a class="two6 exam" title="开始做题" href="javascript:;"  onclick="majorpageQuestion.ShowDiv(\'' + datas[i].id + '\')"></a>');
						questionhtml.push(' </div>');

						questionhtml.push('</div>');



					}
					$("#table3").html(questionhtml.join(""));
					$("#tableContentPage").html(t.data.frontPageHtml);
					delDisabled();
				} else {
					// alert(t.msg);
				}
			},
			error:function(){
				loadFail('#table3');
			}
		});
	},
	//查询
	searchPaper: function() {
		$("#pageNo").val("1");
		majorpageQuestion.getData();
	},
	//显示div输入试卷名称
	ShowDiv: function(id) {
		$("#hidQuestionId").val(id);
		// document.getElementById("divPaperName").style.display = 'block';
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
	//关闭div
	CloseDiv: function() {
		document.getElementById("divPaperName").style.display = "none";
	},
	//保存试卷名称
	saveQuestionThree: function() {
		var questionid = $("#hidQuestionId").val();
		//试卷名称
		var questionName = $(".layui-layer-content #questionName").val();
		if(questionName == "" || questionName == "请输入试卷名称") {
			// layer.open({
			// 	title: '系统提示',
			// 	closeBtn: 1,
			// 	skin: 'layui-layer-molv',
			// 	content: '<div style="text-align:center;">请输入试卷名称</div>',
			// 	yes: function(index, layero){
			// 		layer.close(index);
			// 	}
			// });
			layer.tips('试卷名称不能为空', '.layui-layer-content #questionName', {
				tips: [1, '#3595CC'],
				time: 2000
			});
			return;
		}
		$.ajax({
			url: urlpath + '/user/practice/startPractice.jhtml',
			type: "GET",
			data: {
				ptype: 3,
				copyid: questionid,
				copyname: questionName
			},
			success: function(t) {
				var success = t.success;
				if(success) {
					//window.location.href = "simulation_test2.html";
					window.location.href = "simulation_test.html";
				} else {
					// alert(t.msg);
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
	//跳转
	skip: function(type) {
		if(!validateUser()){
			validateLogin();
			return;
		}
		if(type == 1) {
			window.location.href = "auto_creat_practice_paper.html";
		} else if(type == 2) {
			window.location.href = "majorpageQuestion.html";
		} else if(type == 0) {
			window.location.href = "majorpage.html";
		}
	}
}
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	majorpageQuestion.getData();
}
function delDisabled(){
	var length = $('#tableContentPage a').length;
	for(var i=0;i<length;i++ ){
		if($('#tableContentPage a').eq(i).html() == '...'){
			$('#tableContentPage a').eq(i).removeClass('disabled');
		}
	}
}