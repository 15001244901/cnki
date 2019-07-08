$(function() {
	gradingPapers.init();
});
var gradingPapers = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		gradingPapers.getData();
	},
	//获取数据列表
	getData: function() {
		$('#tableContent').removeClass('no_info');
		nowLoadData('#tableContent');

		var uid = useruid;
		var pageNo = $("#pageNo").val(); //当前页
		var keyword = $("#keyword").val();
		var questionType = $("#questionType").val();
		$.ajax({
			url: urlpath_a + '/exam/paper/list.jhtml',
			type: "POST",
			data: {
				pageNo: pageNo,
				pageSize: 10,
				tid: uid,
				status: 1,
				name: keyword
			},
			success: function(t) {
				console.log(t);
				var success = t.success;
				if(!t.data.list){
					$('#tableContent').html('');
					$("#pagehtml").html('');
					$('#tableContent').addClass('no_info');
					return;
				}
				var datas = t.data.list;
				var contenthtml = [];

				if(success) {
					for(i = 0; i < datas.length; i++) {
						var paper_type;
						paper_type = datas[i].isoffline == '1' ? '线下考试': '线上考试';
						if(datas[i].isoffline == '1'){
							datas[i].showtime = '无'
						}
						
						contenthtml.push('<li class="table_list">');
						contenthtml.push('	<div class="table_fr">');
						contenthtml.push('		<p>' + datas[i].name + '</p>');
						contenthtml.push('      <div class="table_list_gai">');
						if(datas[i].isoffline == '0'){
							contenthtml.push('      	<a href="Test_report/Grading_papers_two.html?pid=' + datas[i].id +'"><i></i><span>批改试卷</span></a>');
						}else if(datas[i].isoffline == '1'){
							contenthtml.push('      	<a href="Test_report/Grading_offline_papers_two.html?pid=' + datas[i].id +'"><i></i><span>录入成绩</span></a>');
						}
						contenthtml.push('      </div class="table_list_gai">');
						contenthtml.push('		<div class="table_list_infor">');
						contenthtml.push('			<i class="begin_time"></i><span>考试时间：' + datas[i].starttime + '</span>');
						contenthtml.push('			<i class="over_time"></i><span>公布成绩考试时间：' + datas[i].showtime + '</span>');
						contenthtml.push('			<i class="men_num"></i><span>考试类型：' + paper_type + '</span>');
						contenthtml.push('		</div>');
						contenthtml.push('	</div>');
						contenthtml.push('</li>');
					}
					$("#tableContent").html(contenthtml.join(""));
					$("#pagehtml").html(t.data.frontPageHtml);
					delDisabled();
				}
			},
			error:function(){
				$('#tableContent img').hide();
				loadFail('#tableContent');
			}
		});
	},
	//搜索
	searchContent: function() {
		$("#pageNo").val("1");
		gradingPapers.getData();
	}
};
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	gradingPapers.getData();
}
function delDisabled(){
	var length = $('#pagehtml a').length;
	for(var i=0;i<length;i++ ){
		if($('#pagehtml a').eq(i).html() == '...'){
			$('#pagehtml a').eq(i).removeClass('disabled');
		}
	}
}