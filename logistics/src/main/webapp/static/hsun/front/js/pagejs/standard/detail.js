$(function() {
	standarddetail.init();
});
var standarddetail = {
	//初始化
	init: function() {
		var id = standarddetail.getQueryString("id");
		$("#standardid").val(id);
		$("#divheader").load(projectname + "/page/include/headerstandard.html");
		$.ajax({
			url: urlpath_a + '/standard/yWStandard/pdf/preview.jhtml',
			type: "GET",
			data: {
				id: id
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data;
				if(success) {
					$("#spanSno").html(datas.sno);
					$("#spanName").html(datas.name);
					$("#spanEnname").html(datas.enname);
					$("#spanTypezh").html(datas.typezh);
					$("#spanCategory").html(datas.category);
					$("#spanIcs").html(datas.ics);
					$("#spanTypeNo").html(datas.typeno);
					$("#spanPageNo").html(datas.pagenum);
					$("#spanIssuedate").html(datas.issuedate);
					$("#spanExecutedate").html(datas.executedate);
					$("#spanReplacedby").html(datas.replacedby);
					$("#spanReplacestd").html(datas.replacestd);
					$("#spanCitestd").html(datas.citestd);
					$("#spanUsestd").html(datas.usestd);
					$("#spanDraftcompany").html(datas.draftcompany);
					$("#spanGkcompany").html(datas.gkcompany);
					$("#spanTitle").html(datas.title);
					$("#spanRecheckresult").html(datas.recheckresult);
					$("#spanAccording").html(datas.according);
					$("#spanSupplement").html(datas.supplement);
					$("#spanRemark").html(datas.remark);
					$("#spanStdrange").html(datas.stdrange);
				}
			}
		});
	},
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//跳转到PDF阅读页面
	tour: function() {
		var standardid = $("#standardid").val();
		window.location.href = "tour.html?id=" + standardid;
	}
}