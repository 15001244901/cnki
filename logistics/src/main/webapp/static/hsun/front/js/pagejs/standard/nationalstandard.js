$(function() {
	standard.initTitle();

});
var globalrtype; //科目类型ID
var keyword; //关键字
var standard = {
	//初始化
	initTitle:function(){
		$("#divheader").load(projectname + "/page/include/headerstandard.html"+timestamps);

		$.ajax({
			url: urlpath_a + '/sys/dict/listData.jhtml',
			type: "GET",
			data: {
				type: 'std_category' //标准科目
			},
			success: function(t) {
				// console.log(t);
				var data = t.data;
				var title = [];
				for(var i=0 ; i<data.length ; i++){
					if(i == 0){
						title.push('<span class="one1 active" data-id="'+data[i].id+'" data-value="'+data[i].value+'"><a href="javascript:void(0);">'+data[i].description+'</a></span>')
					}else{
						title.push('<span class="one1" data-id="'+data[i].id+'" data-value="'+data[i].value+'"><a href="javascript:void(0);">'+data[i].description+'</a></span>')
					}
				}
				$('.divtitle_container').append(title.join(''));
				if($('.divtitle_container span').length>0){
					var pos_x = $('.divtitle_container span').eq('0').position().left+2;
					$('#bottom_line').css('left',pos_x);
					standard.hoverTitle();
				}else{
					$('#bottom_line').hide();
				}
				$('#now_category').val(data[0].value); //存储标准分类
				standard.init(data[0].id);



			}
		});
	},
	init: function(pids) {

		$.ajax({
			url: urlpath_a + '/sys/dict/listData.jhtml',
			type: "GET",
			data: {
				//type: 'std_type' //标准科目
				parentId:pids
			},
			success: function(t) {
				//var t = JSON.parse(data);
				// console.log(t);
				var success = t.success;
				var datas = t.data;
				if(success) {
					globalrtype = '';
					$("#spanType").html('不限');
					var typehtml = [];
					typehtml.push('<li name="rli" class="active" onclick="standard.chooseRType(this,\'\',\'不限\')">');
					typehtml.push('<a href="javascript:;" ><span>不限</span></a>');
					typehtml.push('</li>');
					for(i = 0; i < datas.length; i++) {
						// if(i == 0) {
						// 	typehtml.push('<li name="rli" onclick="standard.chooseRType(this,\'' + datas[i].value + '\',\'' + datas[i].label + '\')">');
						// } else {
							typehtml.push('<li name="rli" onclick="standard.chooseRType(this,\'' + datas[i].value + '\',\'' + datas[i].label + '\')">');
						// }
						typehtml.push('<a href="javascript:;" ><span>' + datas[i].label + '</span></a>');
						typehtml.push('</li>');
					}
					$("#typeul").html(typehtml.join(""));
				}

				// standard.treeDate(globalrtype, "");
				standard.treeDate("", "");

			}
		});
	},
	//获取标准列表-摘要模式
	treeDate: function(rtype, keyword) {
		$("#contents").removeClass('no_info');
		var pageNo = $("#pageNo").val(); //当前页
		$.ajax({
			url: urlpath_a + '/standard/yWStandard/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				category: $('#now_category').val(),
				sno: keyword,
				name: keyword,
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
							contenthtml.push('    <span class="three1"><a href="'+urlpath+'/page/standard/tour.html?id=' + datas[i].id + '" style="color:#30bf89">标准编号：' + datas[i].sno + '</a></span>');
							contenthtml.push('    <span class="three2">实施日期 : ' + standard.formatDate(datas[i].executedate) + '</span>');
							contenthtml.push('  </div>');
							contenthtml.push('  <div class="div6">');
							contenthtml.push('    <span class="one6">标准名称：' + (datas[i].name||'') + '</span>');
							contenthtml.push('    <span class="two6">' + (datas[i].status||'') + ' </span>');
							contenthtml.push('  </div>');
//							contenthtml.push('  <div class="div7">');
//							contenthtml.push('    <span>' + datas[i].title + '</span>');
//							contenthtml.push('  </div>');
//							contenthtml.push('  <div class="div8">');
//							contenthtml.push('  </div>');
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
	//获取标准列表
	treeDateSingle: function(rtype, keyword) {
		$("#tbNationlstandard").removeClass('no_info');
		var pageNo = $("#pageNoList").val(); //当前页
		$.ajax({
			url: urlpath_a + '/standard/yWStandard/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 30,
				category: $('#now_category').val(),
				sno: keyword,
				name: keyword,
				typesys: rtype
			},
			success: function(t) {
				// console.log(t);
				var success = t.success;
				if(success) {
					var pagehtml = t.data.frontPageHtml;
					var datas = t.data.list;
					if(typeof(datas) == "undefined") {
						$("#tbNationlstandard").html("");
						$("#pagehtml").html("");
						$("#tbNationlstandard").addClass('no_info');
					} else {
						var contenthtml = [];
						contenthtml.push('<tr>');
						contenthtml.push('  <td class="td1"><strong>标准号</strong></td>');
						contenthtml.push('  <td class="td2"><strong>标准名称</strong></td>');
						contenthtml.push('  <td class="td3"><strong>标准年号</strong></td>');
						contenthtml.push('  <td class="td4"><strong>状态</strong></td>');
						contenthtml.push('  <td class="td5"><strong>中标分类</strong></td>');
						contenthtml.push('</tr>');
						for(var i = 0; i < datas.length; i++) {
							contenthtml.push('<tr>');
							contenthtml.push('  <td class="td1"><a href="'+urlpath+'/page/standard/tour.html?id=' + datas[i].id + '" style="color:#30bf89">' + datas[i].sno + '</a></td>');
							contenthtml.push('  <td class="td2">' + datas[i].name + '</td>');
							contenthtml.push('  <td class="td3">' + datas[i].yearno + '</td>');
							contenthtml.push('  <td class="td4">' + datas[i].status + '</td>');
							contenthtml.push('  <td class="td5">' + datas[i].typezh + '</td>');
							contenthtml.push('</tr>');
						}
						$("#tbNationlstandard").html(contenthtml.join(""));
						$("#pagehtml").html(pagehtml);
						delDisableds();
					}
				}

			}
		});
	},
	//摘要模式
	todivlist: function() {
		document.getElementById("divlist").style.display = "block";
		document.getElementById("divview").style.display = "none";

		$("#hidType").val("0");
		document.getElementById("spanSummary").style.opacity = "1";
		document.getElementById("spanList").style.opacity = "0.6";
		standard.treeDate(globalrtype, "");
	},
	//列表模式
	todivview: function() {
		document.getElementById("divview").style.display = "block";
		document.getElementById("divlist").style.display = "none";
		$("#hidType").val("1");
		document.getElementById("spanSummary").style.opacity = "0.6";
		document.getElementById("spanList").style.opacity = "1";
		standard.treeDateSingle(globalrtype, "");
	},
	//点击科目获取点击科目切换文库列表
	chooseRType: function(athis, id, name) {
		var rtypea = document.getElementsByName("rli");
		for(var i = 0; i < rtypea.length; i++) {
			rtypea[i].className = "";
		}
		athis.className = "active";
		$("#spanType").html(name);
		globalrtype = id;

		$("#pageNo").val("1");
		$("#pageNoList").val("1");
		var hidtype = $("#hidType").val();
		if(hidtype == 0) {
			standard.treeDate(globalrtype, "");
		} else {
			standard.treeDateSingle(globalrtype, "");
		}
	},
	//查询
	searchLibrary: function() {
		globalrtype = '';
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
		var now_x = $('.divtitle_container span').eq('0').position().left+2;
		$('.divtitle span').hover(function(){
			var pos_x = $(this).position().left+2;
			$('#bottom_line').stop().animate({
				'left':pos_x
			},100);
		},function(){
			$('#bottom_line').stop().animate({
				'left':now_x
			},100);
		});

		// 鼠标点击大标题效果
		$('.divtitle_container span').off('click').on('click',function(){
			$('.divtitle_container span').removeClass('active');
			$(this).addClass('active');
			now_x =  $(this).position().left+2;
			$("#pageNo").val("1");
			$("#pageNoList").val("1");
			var thisid = $(this).data('id');
			$('#now_category').val($(this).data('value'));  //存储标准类型
			standard.init(thisid);

		});
	}

};

function page(pageno, pagesize) {
	var hidtype = $("#hidType").val();
	if(hidtype == 0) {
		$("#pageNo").val(pageno);
		standard.treeDate(globalrtype, "");
	} else {
		$("#pageNoList").val(pageno);
		standard.treeDateSingle(globalrtype, "");
	}
}
function delDisabled(){
	var length = $('#pageSinglehtml a').length;
	for(var i=0;i<length;i++ ){
		if($('#pageSinglehtml a').eq(i).html() == '...'){
			$('#pageSinglehtml a').eq(i).removeClass('disabled');
		}
	}
}
function delDisableds(){
	var length = $('#pagehtml a').length;
	for(var i=0;i<length;i++ ){
		if($('#pagehtml a').eq(i).html() == '...'){
			$('#pagehtml a').eq(i).removeClass('disabled');
		}
	}
}