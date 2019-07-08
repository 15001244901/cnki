$(function() {
	library.init();
});
var ipaddress = path_pdf;

var htmlList;
var pdfPath;
var type = 0;
var library = {
	//初始化
	init: function() {
		var id = library.getQueryString("id");
		$("#divheader").load(projectname + "/page/include/header.html"+timestamps);
		// 初始化默认为网页模式
		// $.ajax({
		// 	url: urlpath_a + '/doc/docInfo/preview.jhtml',
		// 	type: "GET",
		// 	data: {
		// 		id: id,
		// 		showType: 'html'
		// 	},
		// 	success: function(t) {
		// 		var success = t.success;
		// 		if(success) {
		// 			$("#spanTitle").html(t.data.title);
		// 			htmlList = t.page.list;
		// 			$("#hidPageCount").val(t.page.count);
		// 			document.getElementById("htmlIframe").src = ipaddress + t.htmlURL;
        //
		// 			$('#pagehtml').html(t.page.frontPageHtml);
		// 			library.isPn();
		// 		} else {
		// 			window.location.href = "knowledge_library.html";
		// 		}
		// 	}
		// });
		// 初始化为ptf模式
		$.ajax({
			url: urlpath_a + '/doc/docInfo/preview.jhtml',
			type: "GET",
			data: {
				id: id,
				showType: 'file'
			},
			success: function(t) {
				var success = t.success;
				if(success) {
					$("#spanTitle").html(t.directoryName);
					if(!t.targetFileURL){
						$('.no_data').show();
						return;
					}
					// PDFObject.embed(ipaddress + t.targetFileURL, "#contentDiv");
					$('#contentDiv').html('<iframe  src="'+imgUrl+'/js/pdfjs/web/viewer.html?file='+t.targetFileURL+'" width="100%" height="100%"></iframe>');
					library.fullScreen(imgUrl+'/js/pdfjs/web/viewer.html?file='+t.targetFileURL); //全屏查看
				}
			}
		});
	},
	//上一页
	before: function() {
		var pageNo = $("#hidPageNo").val();
		var pageCount = $("#hidPageCount").val();
		if(pageNo == 1) {
			return;
		} else {
			pageNo--;
			page(pageNo);
			$("#hidPageNo").val(pageNo);
			// document.getElementById("htmlIframe").src = ipaddress + htmlList[pageNo - 1];
		}
		library.isPn();
	},
	//下一页
	next: function() {
		var pageNo = $("#hidPageNo").val();
		var pageCount = $("#hidPageCount").val();
		if(pageNo == pageCount) {
			return;
		} else {
			pageNo++;
			page(pageNo);
			$("#hidPageNo").val(pageNo);
			// document.getElementById("htmlIframe").src = ipaddress + htmlList[pageNo - 1];
		}
		library.isPn();
	},
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	toPDFPage: function() {
		var id = library.getQueryString("id");
		if(type == 0) {
			$.ajax({
				url: urlpath_a + '/doc/docInfo/preview.jhtml',
				type: "GET",
				data: {
					id: id,
					showType: 'file'
				},
				success: function(t) {
					var success = t.success;
					if(success) {
						// document.getElementById("leftDiv").style.visibility = "hidden";
						// document.getElementById("rightDiv").style.visibility = "hidden";
						// $("#spanTitle").html(t.data.title);
						// PDFObject.embed(ipaddress + t.targetFileURL, "#contentDiv");
						// type = 1;
						// $("#typeSpan").html("PDF模式");

						document.getElementById("leftDiv").style.visibility = "hidden";
						document.getElementById("rightDiv").style.visibility = "hidden";
						$("#spanTitle").html(t.data.title);
						PDFObject.embed(ipaddress + t.targetFileURL, "#contentDiv");
						type = 1;
						$("#typeSpan").html("经典模式");
						$('#pagehtml').hide();
					}
				}
			});

		} else {
			document.getElementById("leftDiv").style.visibility = "visible";
			document.getElementById("rightDiv").style.visibility = "visible";
			var pageNo = $("#hidPageNo").val();
			var html = [];
			html.push('<center>');
			html.push('	<iframe id="htmlIframe" frameborder="0" width="100%" height="720" src="' + ipaddress + htmlList[pageNo - 1] + '" scrolling="no"></iframe>');
			html.push('</center>');
			$("#contentDiv").html(html.join(""));
			type = 0;
			$("#typeSpan").html("PDF模式");
			$('#pagehtml').show();
		}

	},
	//返回
	goBack: function() {
		//window.location.href = "knowledge_library.html";
		window.history.go(-1);
	},
	isPn:function(){
		var pageNo = $("#hidPageNo").val();
		var pageCount = $("#hidPageCount").val();
		if(pageNo == 1){
			$('#leftDiv img').hide();
		}else{
			$('#leftDiv img').show();
		};
		if(pageNo == pageCount){
			$('#rightDiv img').hide();
		}else{
			$('#rightDiv img').show();
		}
	},
	// 全屏查看
	fullScreen:function(url){
		$('#full_screen').off('click').on('click',function(){
			window.open(url,'_blank');
		});
	}
};
//分页
function page(pageno, pagesize) {
	var id = library.getQueryString("id");
	$.ajax({
		url: urlpath_a + '/doc/docInfo/preview.jhtml',
		type: "GET",
		data: {
			'id': id,
			'showType': 'html',
			'pageNo':pageno
		},
		success: function(t) {
			console.log(t);
			var success = t.success;
			if(success) {
				document.getElementById("htmlIframe").src = ipaddress + t.htmlURL;
				// document.getElementById("htmlIframe").src = ipaddress + htmlList[pageno - 1];
				//
				$('#pagehtml').html(t.page.frontPageHtml);
				$("#hidPageNo").val(pageno);

				library.isPn();
			}
		}
	});
}
