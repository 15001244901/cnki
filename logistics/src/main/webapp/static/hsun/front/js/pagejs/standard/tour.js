$(function() {
	tour.init();
});
var tour = {
	//初始化
	init: function() {
		var ipaddress = path_pdf;
		var id = tour.getQueryString("id");
		$("#standardid").val(id);
		$("#divheader").load(projectname + "/page/include/headerstandard.html"+timestamps);
		$.ajax({
			url: urlpath_a + '/standard/yWStandard/pdf/preview.jhtml',
			type: "GET",
			data: {
				id: id
			},
			success: function(t) {
				console.log(t);
				var success = t.success;
				var pdfPath = t.data.files;
				//alert(success)
				if(success) {
					$("#spanSno").html(t.data.sno);
					$("#spanName").html(t.data.name);
					if(!pdfPath){
						$('.no_data').show();
						return;
					}
					if($.browser.safari) {
						PDFObject.embed(ipaddress + pdfPath.replace("|", ""), "#pdfDiv");
					} else {
						var pdfPath = pdfPath.replace("|", "");
						$('#pdfDiv').html('<iframe  src="'+imgUrl+'/js/pdfjs/web/viewer.html?file='+pdfPath+'" width="100%" height="100%"></iframe>');
						tour.fullScreen(imgUrl+'/js/pdfjs/web/viewer.html?file='+pdfPath); //全屏查看
					}
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
	//跳转标准详情
	standardDetail: function() {
		var standardid = $("#standardid").val();
		window.location.href = "details.html?id=" + standardid;
	},
	// 全屏查看
	fullScreen:function(url){
		$('#full_screen').off('click').on('click',function(){
			window.open(url,'_blank');
		});
	}
}