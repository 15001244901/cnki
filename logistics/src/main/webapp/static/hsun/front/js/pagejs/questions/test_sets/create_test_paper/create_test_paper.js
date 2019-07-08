$(function() {
	createTestpaper.init();
});
//获取岗位信息
var globalPost;
var createTestpaper = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		//		$.ajax({
		//			url: urlpath_a + '/sys/dict/listData.jhtml',
		//			type: "GET",
		//			async: false,
		//			data: {
		//				type: 'dic_exam_questionpost' //科目
		//			},
		//			success: function(t) {
		//				var success = t.success;
		//				var datas = t.data;
		//				var questionhtml = [];
		//				if(success) {
		//					for(i = 0; i < datas.length; i++) {
		//						if(i == 0) {
		//							globalPost = datas[i].value;
		//							questionhtml.push('<span><a href="javascript:;" class="active" name="postName" onclick="createTestpaper.choosePost(this,\'' + datas[i].value + '\')" value="' + datas[i].label + '">' + datas[i].label + '</a></span>');
		//						} else {
		//							questionhtml.push('<span><a href="javascript:;" name="postName" onclick="choosePost(this,\'' + datas[i].value + '\')" value="' + datas[i].label + '">' + datas[i].label + '</a></span>');
		//						}
		//					}
		//					$("#divPost").html(questionhtml.join(""));
		//				}
		//			}
		//		});
	},
	//重置
	spanReset: function() {
		$("#txtName").val("");
		$("#pnums").val("");
		$("#txtTotalScore").val("");
		$("#txtPassScore").val("");
		$("#txtDuration").val("");
	},
	//创建试卷
	submitPaper: function() {
		var name = $("#txtName").val();
		var totalscore = $("#txtTotalScore").val();
		var passscore = $("#txtPassScore").val();
		var duration = $("#txtDuration").val();
		if(name == "") {
			layer.open({
				title: '系统提示',
				closeBtn: 1,
				skin: 'layui-layer-molv',
				content: '<div style="text-align:center;">试卷名称不能为空</div>',
				yes: function(index, layero){
					layer.close(index);
				}
			});
			return;
		}

		$.ajax({
			url: urlpath_a + '/exam/paper/save.jhtml',
			type: "GET",
			data: {
				"id": "",
				"name": name,
				"status": "0",
				"duration": duration,
				"totalscore": totalscore,
				"passscore": passscore,
				"ordertype": "1",
				"papertype": "0" //,
				//"departments": globalPost
			},
			success: function(t) {
				//alert(t.success)
				var datas = t.data;
				if(t.success) {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+t.msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
							var id = datas.id;
							window.location.href = "../edit_item_page/edit_item_page.html?id=" + id;
						}
					});

				} else {
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">'+t.msg+'</div>',
						yes: function(index, layero){
							layer.close(index);
						}
					});
				}
			}
		});
	},
	//选择岗位
	choosePost: function(postThis, value) {
		var postName = document.getElementsByName("postName");
		for(var i = 0; i < postName.length; i++) {
			postName[i].className = "";
		}
		postThis.className = "active";
		globalPost = value;
	}
}