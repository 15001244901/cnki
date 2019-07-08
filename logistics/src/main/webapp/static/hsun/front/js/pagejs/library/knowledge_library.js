$(function() {
	// updataNews();
	library.init();
	library.lobraryCollection();
	library.hoverTitle();
});
var globalrtype; //科目类型ID
var keyword; //关键字
var library = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/header.html"+timestamps);

		$.ajax({
			url: urlpath_a + '/sys/dict/listData.jhtml?type=dic_domain',
			type: "GET",
			success: function(t) {
				// console.log(t);
				var success = t.success;
				var datas = t.data;
				if(success) {
					globalrtype = datas[0].value;
					$("#spanType").html(datas[0].label);
					var typehtml = [];
					for(i = 0; i < datas.length; i++) {
						if(i == 0) {
							typehtml.push('<li name="rli" class="active" onclick="library.chooseRType(this,\'' + datas[i].value + '\',\'' + datas[i].label + '\')">');
						} else {
							typehtml.push('<li name="rli" onclick="library.chooseRType(this,\'' + datas[i].value + '\',\'' + datas[i].label + '\')">');
						}
						typehtml.push('<a href="javascript:;" ><span>' + datas[i].label + '</span></a>');
						typehtml.push('</li>');
					}
					$("#typeul").append(typehtml.join(""));
					library.treeDate(globalrtype, "");
				} else {
					layer.msg(
						"操作失败",
						{
							icon:1,
							time:3000
							// title:'系统提示',
						}
					);
				}
			}
		});
	},
	//获取文章列表
	treeDate: function(rtype, keyword) {
		$("#contents").removeClass('no_info');
		$.ajax({
			url: urlpath_a + '/doc/docInfoDirectory/treeData.jhtml',
			type: "GET",
			data: {
				dtype: 1, //知识文库
				rtype: rtype //科目value
			},
			success: function(t) {
                // console.log(t);
				var success = t.success;
				var datas = t.data;
				if(t.data.length <= 0){
					$("#contents").addClass('no_info');
				}
				if(success) {
					var contenthtml = [];
					for(j = 0; j < datas.length; j++) {
						if(datas[j].pId == 0) {
							var count = 0;
							for(x = 0; x < datas.length; x++) {
								if(datas[x].pId == datas[j].id) {
									count = count + 1;
								}
							}
							contenthtml.push('<li class="firstChild">');
							contenthtml.push(' <div class="header">');
							contenthtml.push('   <i class="fa fa-plus-square"></i>');
							if(rtype == "1"){
								contenthtml.push('   <span class="txt cursor" onclick="library.technicalGuidelines(\''+datas[j].docId+'\')">&nbsp;&nbsp;&nbsp;&nbsp;' + datas[j].name + '</span>');
							}else{
								contenthtml.push('   <span class="txt">&nbsp;&nbsp;&nbsp;&nbsp;' + datas[j].name + '</span>');
							}
							contenthtml.push('    <span class="arrow"></span>');
							if(rtype == "1"){
								contenthtml.push('    <div class="center_js">');
								if(datas[j].iscollected == ''){
									contenthtml.push('  <a href="javascript:;" id="coll-'+datas[j].id+'" data-collected="'+datas[j].iscollected+'" onclick="library.collection(this,\'' + datas[j].id + '\',\'' + datas[j].pId + '\',\'' + datas[j].iscollected + '\')"><span class="icona-shoucang" title="收藏"></span></a>');
								}else{
									contenthtml.push('  <a href="javascript:;" id="coll-'+datas[j].id+'" data-collected="'+datas[j].iscollected+'" onclick="library.collection(this,\'' + datas[j].id + '\',\'' + datas[j].pId + '\',\'' + datas[j].iscollected + '\')"><span class="icona-quxiaosc" title="取消收藏"></span></a>');
								}
								contenthtml.push('  <a href="'+urlpath+'/page/library/knowledge_detail.html?id=' + datas[j].docId + '"><span class="icona-jiexi" title="查看"></span></a>');
								contenthtml.push('    </div>');
							}else{
								contenthtml.push('    <div class="center">');
								contenthtml.push('     <span class="right">' + count + '篇文章</span>');
								contenthtml.push('    </div>');
							}
							contenthtml.push(' </div>');
							contenthtml.push(' <ul class="menu-two">');

							for(x = 0; x < datas.length; x++) {
								if(datas[x].pId == datas[j].id) {
									contenthtml.push('<li>');
									contenthtml.push('  <a style="" href="'+urlpath+'/page/library/knowledge_detail.html?id=' + datas[x].docId + '">' + datas[x].name + '</a>');
									if(datas[x].iscollected == ''){
										contenthtml.push('  <a href="javascript:;" id="coll-'+datas[x].id+'" data-collected="'+datas[x].iscollected+'" onclick="library.collection(this,\'' + datas[x].id + '\',\'' + datas[x].pId + '\',\'' + datas[x].iscollected + '\')"><span class="icona-shoucang" title="收藏"></span></a>');
									}else{
										contenthtml.push('  <a href="javascript:;" id="coll-'+datas[x].id+'" data-collected="'+datas[x].iscollected+'" onclick="library.collection(this,\'' + datas[x].id + '\',\'' + datas[x].pId + '\',\'' + datas[x].iscollected + '\')"><span class="icona-quxiaosc" title="取消收藏"></span></a>');
									}

									contenthtml.push('  <a href="'+urlpath+'/page/library/knowledge_detail.html?id=' + datas[x].docId + '"><span class="icona-jiexi" title="查看"></span></a>');
									contenthtml.push('</li>');
									contenthtml.push('<hr />');
								}
							}
							contenthtml.push('</ul>');
							contenthtml.push('</li>');
						}

					}
					$("#contents").html(contenthtml.join(""));
					var aMenuOneLi = $(".menu-one > li");
					var aMenuTwo = $(".menu-two");
					var iii = $(".menu-one > li > .header > i");
					$(".menu-one > li > .header > i").each(function(i) {
						if(rtype == "1"){
							return;
						}
						$(this).click(function() {
							if($(aMenuTwo[i]).css("display") == "block") {
								$(aMenuTwo[i]).slideUp(300);
								$(aMenuOneLi[i]).removeClass("menu-show");
								$(iii)[i].className = "fa fa-plus-square";
							} else {
								for(var j = 0; j < aMenuTwo.length; j++) {
									$(aMenuTwo[j]).slideUp(300);
									$(aMenuOneLi[j]).removeClass("menu-show");
									$(iii)[j].className = "fa fa-plus-square";
								}
								$(aMenuTwo[i]).slideDown(300);
								$(aMenuOneLi[i]).addClass("menu-show");
								$(iii)[i].className = "fa fa-minus-square";
							}
						});
					});
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
	//选择科目
	chooseRType: function(athis, id, name) {
		var rtypea = document.getElementsByName("rli");
		for(var i = 0; i < rtypea.length; i++) {
			rtypea[i].className = "";
		}
		athis.className = "active";
		$("#spanType").html(name);
		globalrtype = id;
		$('#knowledge_style').val(id);   // 将选择的科目放到隐藏域能，应用于查找文章的收藏历史
		library.treeDate(globalrtype, "");
	},
	//查询
	searchLibrary: function() {
		var keyword = $("#keyword").val();
		if(!keyword)
			return;
		window.open(projectname+'/page/searchResult/library_result.html?keyword='+ keyword,'_blank');
	},
	//鼠标放到达标题上的效果
	hoverTitle:function(){
		$('#section span').hover(function(){
			var pos_x = $(this).position().left;
			$('#bottom_line').stop().animate({
				'left':pos_x
			},100);
		},function(){
			$('#bottom_line').stop().animate({
				'left':0
			},100);
		});
	},
	// 点击技术指南
	technicalGuidelines:function(code){
		window.location.href= urlpath+'/page/library/knowledge_detail.html?id='+ code;
	}
};