$(function() {
	$('#bott_left').val(0);
	textSets.init();
	textSets.linkbot();
	textSets.onclickData();
});
var keyword;
var textSets = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		keyword = textSets.getQueryString('keyword');
		if(keyword){
			// 搜索试卷时跳转到该页面，不限搜索条件，并去除标题样式
			textSets.getData('',keyword);
			$('#section span').removeClass('colorblue');
			$('#bott').hide();
		}else{
			textSets.getData('0',keyword);
		}
	},
	//获取数据列表
	getData: function(istype,key) {
        $('#contents').removeClass('no_info');
		nowLoadData('#contents');

		var uid = useruid;
		var pageNo = $("#pageNo").val(); //当前页
		$.ajax({
			url: urlpath_a + '/exam/paper/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				tid: uid,
				status: istype,
				name:key
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data.list;
				if(!t.data.list){
					$('#contents').html('');
					$("#pagehtml").html('');
					$('#contents').addClass('no_info');
					return;
				}
				var typehtml = [];
				if(success) {
					for(i = 0; i < datas.length; i++) {
						if(datas[i].status == 0){
							typehtml.push('<div class="section">');
							typehtml.push(' <div class="div5">');
							typehtml.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + datas[i].name + '</a></span>');
							typehtml.push('  <span class="three2">创建日期 : ' + datas[i].createDate + '</span>');
							typehtml.push(' </div>');
							typehtml.push(' <div class="div6">');
							typehtml.push(' <a class="two6 del"  href="javascript:;" title="删除" onclick="textSets.delExam(\'' + datas[i].id +'\')"></a>');
							if(datas[i].iscomplete == "0" || typeof(datas[i].iscomplete)=="undefined") {
								typehtml.push('  <span class="one6">试卷状态 ：  创建中</span>');
								if(datas[i].papertype == "0") {
									typehtml.push(' <a class="two6 edit"  href="javascript:;" title="试卷编辑"  onclick="textSets.normal(\'' + datas[i].id +'\')"></a>');
								} else if(datas[i].papertype == "2") {
									typehtml.push(' <a class="two6 edit"  href="javascript:;" title="试卷编辑"  onclick="textSets.random(\'' + datas[i].id  +'\')"></a>');
								}
							} else {
								typehtml.push('  <span class="one6">试卷状态 ：  已完成</span>');
								typehtml.push(' <a class="two6 edit"  href="javascript:;" title="试卷编辑"  onclick="textSets.normal(\'' + datas[i].id +'\')"></a>');
								typehtml.push(' <a class="two6 exam"  title="发起考试" href="../test_sets/Start_the_test/start_the_test.html?id=' + datas[i].id  +'"></a>');
							}
						}else if(datas[i].status == 1){
							typehtml.push('<div class="section">');
							typehtml.push(' <div class="div5">');
							typehtml.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + datas[i].name + '</a></span>');
							typehtml.push('  <span class="three2">创建日期 : ' + datas[i].createDate + '</span>');
							typehtml.push(' </div>');
							typehtml.push(' <div class="div6">');
							typehtml.push('  <span class="one6">试卷状态 ：  已发起考试</span>');
							typehtml.push('  <a class="two6 down_paper"  href="javascript:;" title="下载试卷" onclick="textSets.downPaper(\'' + datas[i].id +'\')"></a>');
							typehtml.push('  <a class="two6 is_exam"  href="javascript:;" title="转为成套卷" onclick="textSets.ShowDiv(\'' + datas[i].id +'\')"></a>');
							typehtml.push('  <a class="two6 see"  href="javascript:;" title="查看试卷" onclick="textSets.randomOver(\'' + datas[i].id +'\')"></a>');
							typehtml.push(' </div>');
							typehtml.push('</div>');
						}
						typehtml.push(' </div>');
						typehtml.push('</div>');
					}
					// $('#load_img').hide();
					$("#contents").html(typehtml.join(""));
					$("#pagehtml").html(t.data.frontPageHtml);
                    delDisabled();
				}

			},
			error:function(){
				$('#contents img').hide();
				loadFail('#contents');
			}
		});
	},
	//跳转到修改试卷页面模式一
	normal: function(pid) {
		// window.location.href = "paper/paper_edit_normal.html?pid=" + pid;
		window.location.href = "edit_item_page/edit_item_page_next.html?pid=" + pid;
	},
	//跳转到修改试卷页面模式二
	random: function(pid) {
		//window.location.href = "edit_item_page/Edit_item_two.html?id=" + pid;
		window.location.href = "edit_item_page/edit_item_page_next.html?pid=" + pid ;
	},
	randomOver: function(pid) {
		window.location.href = "edit_item_page/edit_item_page_next_over.html?pid=" + pid ;
	},
	//跳转到下载试卷页面
	downPaper:function(pid){
		window.location.href = projectname + "/page/downPaper/down_paper.html?pid=" + pid ;
	},
	//弹出选择考试类型模态窗口
	// linePaper:function(){
	// 	layer.open({
	// 		type:1,
	// 		title: '<p style="font-size: 16px;font-weight: bold;text-align: center;color: #fff;">选择考试类型</p>',
	// 		shadeClose: true,
	// 		shade: 0.8,
	// 		shadeClose:false,
	// 		area: ['400px', '200px'],
	// 		content: $('#line_exam').html()
	// 	});
    //
	// 	textSets.selectPaper();
	// },
	// 选择考试类型
	// selectPaper:function(){
	// 	$('.line_paper_type').on('click','span',function(){
	// 		$('.line_paper_type span').removeClass('check');
	// 		$(this).addClass('check');
    //
	// 		var paper_type = $(this).data('type');
	// 	});
    //
	// 	$('.line_paper_dow').on('click','')
	// },
	// 组卷类型跳转
	linkbot:function(){
		$('#section span').hover(function(){
			var pos_x = $(this).position().left;
			$('#bott').stop().animate({
				'left':pos_x
			},100);
		},function(){
			var bott_x = $('#bott_left').val();
			$('#bott').stop().animate({
				'left':bott_x
			},100);
		});
	},
	// 选择组卷类型
	onclickData:function(){
		var index = $('#section span').index();
		$('#section span').click(function(){
			$('#bott').show();  //显示标记下划线
			$('#section span').removeClass('colorblue');
			$(this).addClass('colorblue');
			$('#bott').attr('data-index',$(this).index());
			$('#bott_left').val($(this).position().left);
			$("#pageNo").val(1);
			textSets.linkbot();

			// var loading = '<img id="load_img" style="margin: 140px auto 0;display: block" src="'+imgUrl+'/usercenter/images/loading.gif" alt="">';
			// $('#contents').html(loading);

			if($(this).index() == 0){
				$('#style').val('0');
				textSets.getData(0,'');
			}else{
				$('#style').val('1');
				textSets.getData(1,'');
			}

		})
	},
	//删除未完成的组卷
	delExam:function(id){
		$('.confirm_container').fadeIn(0,function(){
			$('.confirm').addClass('check');
		});
		textSets.confirmDel(id);
		textSets.confirmQx();
	},
	confirmDel:function (id) {
		$('.confirm_del').off('click').on('click',function(){
			$.ajax({
				url: urlpath_a + '/exam/paper/delete.jhtml?id='+id,
				type: "get",
				success: function(t){
					$('.confirm').removeClass('check');
					$('.confirm_container').fadeOut(0);
					layer.msg(
						'删除成功',
						{
							time:2000,
							anim:4
							// title:'系统提示',
						}
					);
					textSets.getData(0,'');
				}
			});
		});

	},
	confirmQx:function(){
		$('.confirm_qx').off('click').on('click',function(){
			$('.confirm').removeClass('check');
			$('.confirm_container').fadeOut(0);
		});
	},
	//显示转换成成套卷窗口
	ShowDiv: function(id) {

		$("#hidQuestionId").val(id);
		// document.getElementById("div5").style.display = 'block';
		layer.open({
			type:1,
			title: '<p style="font-size: 16px;font-weight: bold;text-align: center;color: #fff;">重命名试卷名称</p>',
			shadeClose: true,
			shade: 0.8,
			shadeClose:false,
			area: ['400px', '200px'],
			content: $('#hand_test').html()
		});
	},
	// 保存成套卷信息
	saveExam:function(){
		var name = $('#questionName').val();
		$.ajax({
			url: urlpath_a + '/exam/paper/copypaper.jhtml',
			type: "POST",
			data: {
				copyid:$("#hidQuestionId").val(),
				category:2,
				copyname:name
			},
			success:function(){
				layer.closeAll();
				layer.msg(
					'转化成功',
					{
						time:2000,
						anim:4
						// title:'系统提示',
					}
				);
			}
		});
	},
	//查询
	searchLibrary: function() {
		// $("#contents").removeClass('no_info');
		var keys = $("#keyword").val();
		var style = $('#style').val();
		if(!style){
			$('#style').val('0');
			style = 0;
		}
		textSets.getData(style,keys);

	},
	//获取url参数传值
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	}
};

//分页
function page(pageno, pagesize) {
	// var loading = '<img id="load_img" style="margin: 140px auto 0;display: block" src="'+imgUrl+'/usercenter/images/loading.gif" alt="">';
	// $('#contents').html(loading);
	var style = $('#style').val();
	$("#pageNo").val(pageno);
	if(style == '0'){
		textSets.getData(0,keyword);
	}else if(style == '1'){
		// textSets.getDataOver();
		textSets.getData(1,keyword);
	}else{
		textSets.getData('',keyword);
	}

}
function delDisabled(){
    var length = $('#pagehtml a').length;
    for(var i=0;i<length;i++ ){
        if($('#pagehtml a').eq(i).html() == '...'){
            $('#pagehtml a').eq(i).removeClass('disabled');
        }
    }
}