$(function() {
	library.init();
});
var globalrtype; //科目类型ID
var keyword; //关键字
var library = {
	//初始化
	init: function() {
		$.ajax({
			url: urlpath_a + '/sys/dict/listData.jhtml?type=dic_domain',
			type: "GET",
			success: function(t) {
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
							time:3000,
							skin: 'layui-layer-molv',
							// title:'系统提示',
						}
					);
				}
			}
		});
	},
	//获取文章列表
	treeDate: function(rtype, keyword) {
		$.ajax({
			url: urlpath_a + '/doc/docInfoDirectory/userTreeData.jhtml',
			type: "GET",
			data: {
				dtype: 2, //内部文库
				rtype: rtype //科目value
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data;
				if(!t.data[0]){
					$("#contents").addClass('no_info');
				}else{
					$("#contents").removeClass('no_info');
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
							contenthtml.push(' <div class="headers">');
							contenthtml.push('   <i class="fa fa-plus-square"></i><span class="txt">' + datas[j].name + '</span>');
							contenthtml.push('    <span class="arrow"></span>');
							contenthtml.push('    <div class="center">');
							contenthtml.push('     <span class="right">' + count + '篇文章</span>');
							contenthtml.push('    </div>');
							contenthtml.push(' </div>');
							contenthtml.push(' <ul class="menu-two">');

							for(x = 0; x < datas.length; x++) {
								if(datas[x].pId == datas[j].id) {
									contenthtml.push('<li>');
									contenthtml.push('  <a style="" href="../library/inside_detail.html?id=' + datas[x].docId + '">' + datas[x].name + '</a>');
									// contenthtml.push('  <a href="javascript:;" onclick="library.collection(\'' + datas[x].id + '\')"><span class="icona-shoucang" title="收藏"></span></a>');
									contenthtml.push('  <a href="javascript:;" onclick="library.collection(this,\'' + datas[x].id + '\',\'' + datas[x].pId + '\',\'' + datas[x].iscollected + '\')"><span class="icona-quxiaosc" title="取消收藏"></span></a>');
									contenthtml.push('  <a href="../library/knowledge_detail.html?id=' + datas[x].docId + '"><span class="icona-jiexi" title="查看"></span></a>');
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
					var iii = $(".menu-one > li > .headers > i");
					$(".menu-one > li > .headers > i").each(function(i) {
						$(this).click(function() {
							if($(aMenuTwo[i]).css("display") == "block") {
								$(aMenuTwo[i]).slideUp(300);
								$(aMenuOneLi[i]).removeClass("menu-show")
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

		$.ajax({
			url: urlpath_a + '/doc/docInfo/collect.jhtml',
			type: "GET",
			data: {
				uid: uid,
				did: did,
				pid: pid,
				iscollected:isid
			},
			success: function(t) {
				// console.log(t);

				if(t.success) {
					// if(isid == ""){
					// 	alert('收藏成功');
					// 	library.treeDate(globalrtype, "");
					// }else{
					// 	alert('取消收藏成功');
					// 	library.treeDate(globalrtype, "");
					// }
					layer.msg(
						t.msg,
						{
							icon:1,
							time:3000,
							skin: 'layui-layer-molv',
							// title:'系统提示',
						}
					);
					$(is).parent('li').next('hr').remove();
					$(is).parent('li').remove();
				} else {
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
	//	点击科目获取点击科目切换文库列表
	chooseRType: function(athis, id, name) {
		var rtypea = document.getElementsByName("rli");
		for(var i = 0; i < rtypea.length; i++) {
			rtypea[i].className = "";
		}
		athis.className = "active";
		// $("#spanType").html(name);
		globalrtype = id;
		library.treeDate(globalrtype, "");
	},
	//查询
	searchLibrary: function() {
		var keyword = $("#keyword").val();
		library.treeDate(globalrtype, keyword);
	}
}