$(function() {
	textSets.init();
});
var keyword;
var textSets = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		keyword = textSets.getQueryString('keyword');
		textSets.getData(keyword);
	},
	//获取数据列表
	getData: function(key) {
		$('#contents').removeClass('no_info');
		var load_img = '<img id="load_img" style="margin: 140px auto 0;display: block;" src="'+imgUrl+'/usercenter/images/loading.gif" alt="">';
		$('#contents').html(load_img);
		var uid = useruid;
		var pageNo = $("#pageNo").val(); //当前页
		$.ajax({
			url: urlpath_a + '/exam/paper/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				tid: uid,
				status: '',
				name:key
			},
			success: function(t) {
				console.log(t);
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
							typehtml.push(' </div>');
							typehtml.push('</div>');
						}else{
							typehtml.push('<div class="section">');
							typehtml.push(' <div class="div5">');
							typehtml.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + datas[i].name + '</a></span>');
							typehtml.push('  <span class="three2">创建日期 : ' + datas[i].createDate + '</span>');
							typehtml.push(' </div>');
							typehtml.push(' <div class="div6">');
							typehtml.push('  <span class="one6">试卷状态 ：  已发起考试</span>');
							typehtml.push('  <a class="two6 is_exam"  href="javascript:;" title="转为成套卷" onclick="textSets.ShowDiv(\'' + datas[i].id +'\')"></a>');
							typehtml.push('  <a class="two6 see"  href="javascript:;" title="查看试卷" onclick="textSets.randomOver(\'' + datas[i].id +'\')"></a>');
							typehtml.push(' </div>');
							typehtml.push('</div>');
						}

					}

					// $('#load_img').hide();

					$("#contents").html(typehtml.join(""));
					$("#pagehtml").html(t.data.frontPageHtml);
					delDisabled();
				}
			},
			error:function(){
				$('#contents img').hide();
			}
		});
	},
	//跳转到修改试卷页面模式一
	normal: function(pid) {
		// window.location.href = "paper/paper_edit_normal.html?pid=" + pid;
		window.location.href = "../questions/test_sets/edit_item_page/edit_item_page_next.html?pid=" + pid;
	},
	//跳转到修改试卷页面模式二
	random: function(pid) {
		//window.location.href = "edit_item_page/Edit_item_two.html?id=" + pid;
		window.location.href = "../questions/test_sets/edit_item_page/edit_item_page_next.html?pid=" + pid ;
	},
	randomOver: function(pid) {
		window.location.href = "../questions/test_sets/edit_item_page/edit_item_page_next_over.html?pid=" + pid ;
	},
	//删除未完成的组卷
	delExam:function(id){
		$.ajax({
			url: urlpath_a + '/exam/paper/delete.jhtml?id='+id,
			type: "POST",
			success: function(t){
				layer.msg(
					'删除成功',
					{
						time:2000,
						anim:4
						// title:'系统提示',
					}
				);
				textSets.getData();
			}
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
	//获取url参数传值
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},
	//查询
	searchLibrary: function() {
		$("#contents").removeClass('no_info');
		keywords = $("#keyword").val();
		textSets.getData(keywords);
	}
};

//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	textSets.getData(keyword);
}
function delDisabled(){
	var length = $('#pagehtml a').length;
	for(var i=0;i<length;i++ ){
		if($('#pagehtml a').eq(i).html() == '...'){
			$('#pagehtml a').eq(i).removeClass('disabled');
		}
	}
}