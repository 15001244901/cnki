$(function() {
	textSets.init();
});
var textSets = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		textSets.getData();
	},
	//获取数据列表
	getData: function() {
		var uid = useruid;
		var pageNo = $("#pageNo").val(); //当前页
		$.ajax({
			url: urlpath_a + '/exam/paper/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				tid: uid,
				status: 1
			},
			success: function(t) {
				console.log(t);
				if(!t.data.list){
					$('#contents img').hide();
					return;
				}
				var success = t.success;
				var datas = t.data.list;
				if(!datas){
					return;
				}
				var typehtml = [];
				if(success) {
					for(i = 0; i < datas.length; i++) {
						typehtml.push('<div class="section">');

						typehtml.push(' <div class="div5">');
						typehtml.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + datas[i].name + '</a></span>');
						typehtml.push('  <span class="three2">创建日期 : ' + datas[i].createDate + '</span>');
						typehtml.push(' </div>');

						typehtml.push(' <div class="div6">');


						// if(datas[i].iscomplete == "0" || typeof(datas[i].iscomplete)=="undefined") {
						// 	typehtml.push('  <span class="one6">试卷状态 ：  创建中</span>');
						// 	if(datas[i].papertype == "0") {
						// 		typehtml.push(' <a class="two6"  href="javascript:;"  onclick="textSets.normal(\'' + datas[i].id + timestampv+'\')">试卷编辑</a>');
						// 	} else if(datas[i].papertype == "2") {
						// 		typehtml.push(' <a class="two6"  href="javascript:;"  onclick="textSets.random(\'' + datas[i].id +timestampv +'\')">试卷编辑</a>');
						// 	}
						// } else {
							typehtml.push('  <span class="one6">试卷状态 ：  已完成</span>');
							typehtml.push(' <a class="two6"  href="javascript:;"  onclick="textSets.random(\'' + datas[i].id +timestampv +'\')">查看试卷</a>');
						// }
						typehtml.push(' </div>');

						typehtml.push('</div>');

					}
					$("#contents").html(typehtml.join(""));
					$("#pagehtml").html(t.data.frontPageHtml);

				}

			},
			error:function () {
				$('#contents img').hide();
			}
		});
	},
	//跳转到修改试卷页面模式一
	normal: function(pid) {
		// window.location.href = "paper/paper_edit_normal.html?pid=" + pid;
		window.location.href = "edit_item_page/edit_item_page_next_over.html?pid=" + pid + timestampv;
	},
	//跳转到修改试卷页面模式二
	random: function(pid) {
		//window.location.href = "edit_item_page/Edit_item_two.html?id=" + pid;
		window.location.href = "edit_item_page/edit_item_page_next_over.html?pid=" + pid + timestampv;
	}
};
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	textSets.getData();
}