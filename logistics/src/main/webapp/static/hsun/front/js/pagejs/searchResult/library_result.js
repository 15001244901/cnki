$(function() {
	library.init();
	// library.lobraryCollection();

});
var keywords;
var library = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/header.html");
		keywords = library.getQueryString('keyword');
		library.treeDate(1,keywords);
	},
	//获取文章列表
	treeDate: function( pagenum,keyword) {
		$("#contents").removeClass('no_info');
		$.ajax({
			url: urlpath_a + '/doc/docInfo/list.jhtml',
			type: "GET",
			data: {
				doctype: 1,
				pageNo:pagenum,
				pageSize:10,
				keywords:keyword
			},
			success: function(t) {
                // console.log(t);
				var success = t.success;
				var datas = t.data;
				if(!t.data.list){
					$("#contents").html('');
					$('#page').html('');
					$("#contents").addClass('no_info');
					return;
				}
				var list = t.data.list;
				if(success) {
					var search = [];
					for (var i=0; i<t.data.list.length;i++){
						search.push('<li class="search_list">');
						search.push(' <div class="search_list_img">');
						search.push('  <img src="'+projectname+'/static/hsun/front/img/zhaiyao.png" alt="">');
						search.push(' </div>');
						search.push(' <div class="search_list_infor">');
						search.push('  <p class="search_list_infor_name"><a href="../library/knowledge_detail.html?id=' + t.data.list[i].id + '">'+t.data.list[i].title+'</a></p>');
						search.push('  <p class="search_list_infor_type">摘要：'+delMore(t.data.list[i].summary)+'</p>');
						search.push(' </div>');
						search.push('</li>');
					}
					$("#contents").html(search.join(""));
					$('#page').html(t.data.frontPageHtml);
					delDisabled()
				}

			}
		});
	},
	//收藏文库
	collection: function(is,did,pid,isid) {
		var uid = useruid;
		var iscollected = $(is).attr('data-collected');
		$.ajax({
			url: urlpath_a + '/doc/docInfo/collect.jhtml',
			type: "GET",
			data: {
				'uid': uid,
				'did': did,
				'pid': pid,
				'iscollected':iscollected
			},
			success: function(t) {
				// console.log(t);

				if(t.success) {
					layer.msg(
						t.msg,
						{
							icon:1,
							time:3000
						}
					);
					if(iscollected){
						$(is).find('span').removeClass('icona-quxiaosc').addClass('icona-shoucang');
						$(is).find('span').attr('title','点击收藏');
						$(is).attr('data-collected','');
					}else{
						$(is).find('span').removeClass('icona-shoucang').addClass('icona-quxiaosc');
						$(is).find('span').attr('title','取消收藏');
						library.lobraryCollection(did);
					}
				} else {
					layer.msg(
						t.msg,
						{
							icon:1,
							time:3000
						}
					);
				}
			}
		});

	},
	//调取收藏历史
	lobraryCollection:function(id){
		var rtype = $('#knowledge_style').val();
		$.ajax({
			url: urlpath_a + '/doc/docInfoDirectory/userTreeData.jhtml',
			type: "GET",
			data: {
				dtype: 1, //知识文库
				rtype: rtype //科目value
			},
			success: function (t) {
				// console.log(t);
				var data = t.data;
				for(var i = 0; i < data.length; i++ ){
					if(id == data[i].id){
						$('#coll-'+id).attr('data-collected',data[i].iscollected);
					}
				}

			}
		});
	},
	//查询
	searchLibrary: function() {
		$("#contents").removeClass('no_info');
		keywords = $("#keyword").val();
		library.treeDate(1,keywords);

	},
	//获取url参数传值
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	}

};
function page(pageno, pagesize) {
	library.treeDate(pageno,keywords);
}
function delDisabled(){
	var length = $('#page a').length;
	for(var i=0;i<length;i++ ){
		if($('#page a').eq(i).html() == '...'){
			$('#page a').eq(i).removeClass('disabled');
		}
	}
}
// 限制字数
function delMore(ret){
	var maxwidth=120;
	var ase = ret;
	if(ase && ase.length>maxwidth){
		ase = ase.substring(0,maxwidth);
		ase = ase + '......';
	}
	if(!ase) ase='';
	return ase;
}

