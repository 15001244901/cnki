$(function() {
	standard.init();
	standard.hoverTitle();
});
var globalrtype; //科目类型ID
var keyword; //关键字
var standard = {

	init: function() {
		$("#divheader").load(projectname + "/page/include/header.html"+timestamps);
		standard.treeDate("", "");

		// $.ajax({
		// 	url: urlpath_a + '/sys/dict/listData.jhtml',
		// 	type: "GET",
		// 	data: {
		// 		type: 'std_type' 标准科目
		// 	},
		// 	success: function(t) {
		// 		console.log(t);
		// 		var success = t.success;
		// 		var datas = t.data;
		// 		if(success) {
		// 			globalrtype = '';
		// 			$("#spanType").html('不限');
		// 			var typehtml = [];
		// 			typehtml.push('<li name="rli" class="active" onclick="standard.chooseRType(this,\'\',\'不限\')">');
		// 			typehtml.push('<a href="javascript:;" ><span>不限</span></a>');
		// 			typehtml.push('</li>');
		// 			for(i = 0; i < datas.length; i++) {
		// 				typehtml.push('<li name="rli" onclick="standard.chooseRType(this,\'' + datas[i].value + '\',\'' + datas[i].label + '\')">');
		// 				typehtml.push('<a href="javascript:;" ><span>' + datas[i].label + '</span></a>');
		// 				typehtml.push('</li>');
		// 			}
		// 			$("#typeul").append(typehtml.join(""));
		// 		}
		// 		standard.treeDate("", "");
		// 	}
		// });
	},
	//获取标准列表-摘要模式
	treeDate: function(rtype, keyword) {
		$("#contents").removeClass('no_info');
		var pageNo = $("#pageNo").val(); //当前页
		$.ajax({
			url: urlpath_a + '/bk/encyclopedia/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				category: 1,
				sno: keyword,
				title: keyword,
				typesys: rtype
			},
			success: function(t) {
				// console.log(t);
				var success = t.success;
				if(success) {
					var pagehtml = t.data.frontPageHtml;
					var datas = t.data.list;
					if(typeof(datas) == "undefined") {
						$("#contents").html("");
						$("#pageSinglehtml").html("");
						$("#contents").addClass('no_info');
					} else {
						var contenthtml = [];
						for(var i = 0; i < datas.length; i++) {
							contenthtml.push('<div class="section">');
							contenthtml.push('  <div class="div5">');
							contenthtml.push('    <span class="three1"><a title="'+datas[i].title+'" href="'+urlpath+'/page/baike/baike_cont.html?id=' + datas[i].id + '">' + datas[i].title + '</a></span>');
							contenthtml.push('  </div>');
							contenthtml.push('  <div class="div6">');
							contenthtml.push('    <span class="one6">' + standard.limitWord(standard.delHtml(datas[i].content)) + '</span>');
							contenthtml.push('  </div>');
							// contenthtml.push('  <div class="relate-words">');
							// contenthtml.push('    <span>');
							// contenthtml.push('    	');
							// contenthtml.push('    </span>');
							// contenthtml.push('    <a>煤炭</a>');
							// contenthtml.push('  </div>');
							contenthtml.push('</div>');
						}
						$("#contents").html(contenthtml.join(""));
						$("#pageSinglehtml").html(pagehtml);
						delDisabled();
					}
				}

			}
		});
	},
	//查询
	searchLibrary: function() {
		$('#typeul li').removeClass('active');
		$('#spanType').html('查询结果');
		var keyword = $("#keyword").val();
		$("#pageNo").val("1");
		$("#pageNoList").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			standard.treeDate('', keyword);
		} else {
			standard.treeDateSingle('', keyword);
		}
	},
	formatDate:function(date) {
		if(typeof(date)!="undefined")
		{
			date = date.replace(/-/g,"/");
			var d = new Date(date),
				month = '' + (d.getMonth() + 1),
				day = '' + d.getDate(),
				year = d.getFullYear();
			if(month.length < 2) month = '0' + month;
			
			if(day.length < 2) day = '0' + day;
			return [year, month, day].join('-');
		}
		else
		{
			return "";
		}
	},
	//鼠标放到达标题上的效果
	hoverTitle:function(){
		$('.divtitle span').hover(function(){
			var pos_x = $(this).position().left+2;
			$('#bottom_line').stop().animate({
				'left':pos_x
			},100);
		},function(){
			$('#bottom_line').stop().animate({
				'left':'112px'
			},100);
		});
	},
	//去掉html
	delHtml:function(str){
		// return str.replace(/<[^>]+>/g,"");
		if(str) {
			str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
			bstr=str.replace(/<\/?.+?>/g,"");//去掉
			return bstr;
		}
		return '';
	},

	//限制字数
	limitWord:function(str){
		if(!str){
			return str;
		}
		var maxwidth=120;
		if(str.length>maxwidth){
			str = str.substring(0,maxwidth);
			str = str+'...';
		}
		return str;
	}

};

function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	standard.treeDate(globalrtype, "");

}
function delDisabled(){
	var length = $('#pageSinglehtml a').length;
	for(var i=0;i<length;i++ ){
		if($('#pageSinglehtml a').eq(i).html() == '...'){
			$('#pageSinglehtml a').eq(i).removeClass('disabled');
		}
	}
}
