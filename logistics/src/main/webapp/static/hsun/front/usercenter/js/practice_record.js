$(function() {
	testRecords.init();
});
var testRecords = {
	//初始化
	init: function() {
		testRecords.getData();
	},
	getData: function() {
		var pageNo = $("#pageNo").val();
		// var keyword = $("#keyword").val();
		// var paperType = $("#paperType").val();
		$.ajax({
			url: urlpath + '/user/practice/history.jhtml',
			type: "GET",
			async: false,
			data: {
				pageNo: pageNo,
				pageSize: 10
				// keyword: keyword,
				// paperType: 3
			},
			success: function(t) {
				// console.log(t);
				var success = t.success;
				var datas = t.data.list;
				if(!datas){
					if(top.hei)
						top.hei();
					$("#tableContent").addClass('no_info');
					return;
				}else{
					$("#tableContent").removeClass('no_info');
				}
				if(success) {
					var html = [];
					for(i = 0; i < datas.length; i++) {
						html.push('<li>');
						html.push(' <div class="search-list-left">');
						html.push('  <div class="test-pic"> <i class="icona-test"></i> </div>');
						html.push('  <div class="test-txt">');
						html.push('		<p class="test-txt-p1"><a href="javascript:void(0);" target="_blank" data-cut="30">' + datas[i].name + '</a></p>');
						html.push('		<p><span><i class="icona-time2"></i>考试日期 :' + datas[i].testdate + '</span></p>');
						html.push('	 </div>');
						html.push(' </div>');
						html.push('	<div class="search-list-right">');
						html.push('		<a class="a_jiexi" href="../questions/question_details/practiveDetail.html?id=' + datas[i].id + '" target="_blank"><i class="icona-jiexi"></i>查看详情</a>');
						html.push('		<a class="a_del" href="javascript:;" onclick="testRecords.delQuestion(\'' + datas[i].id+ '\',this)"><i class="icona-del"></i>删除</a>');
						html.push('	</div>');
						html.push('</li>');
					}
					$("#tableContent").html(html.join(""));
					$("#tableContentPage").html(t.data.frontPageHtml);
					delDisabled();
					top.hei();
				}
			}
		});
	},
	//跳转
	skip: function(divId, divName, zDivCount) {
		for(i = 0; i <= zDivCount; i++) {
			document.getElementById(divName + i).style.display = "none";
			//将所有的层都隐藏 
		}
		document.getElementById(divName + divId).style.display = "block";
		//显示当前层 
	},
	// 删除此条记录
	delQuestion:function(id,is){
		$.ajax({
			url: urlpath + '/user/practice/delete.jhtml?id='+id,
			type: "GET",
			success:function(ret){
				// console.log(ret);
				if(ret.success){
					if(top.alertAnim){
						top.alertAnim(ret.msg)
					}
					$(is).parent('.search-list-right').parent('li').remove();
				}else{
					if(top.alertAnim){
						top.alertAnim(ret.msg)
					}
				}
			}
		})
	}
	//搜索
	// searchContent: function() {
	// 	testRecords.getData();
	// }
}
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	testRecords.getData();
}
function delDisabled(){
	var length = $('#tableContentPage a').length;
	for(var i=0;i<length;i++ ){
		if($('#tableContentPage a').eq(i).html() == '...'){
			$('#tableContentPage a').eq(i).removeClass('disabled');
		}
	}
}