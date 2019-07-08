$(function() {
	testRecords.init();
});
var testRecords = {
	//初始化
	init: function() {
		testRecords.getData();
	},
	getData: function() {
		var pageNo = $("#pageNo").val();
		var keyword = $("#keyword").val();
		var paperType = $("#paperType").val();
		var newtimes = new Date().getTime();     //获取当前时间戳

		$.ajax({
			url: urlpath + '/user/paper/history.jhtml',
			type: "GET",
			async: false,
			data: {
				pageNo: pageNo,
				pageSize: 10,
				papername: keyword,
				'paper.papertype': paperType
			},
			success: function(t) {
				var success = t.success;
				var datas = t.data.list;
				// console.log(t);

				if(success) {
					if(!datas) {
						if(top.hei)
							top.hei();
						$("#tableContent").html('');
						$("#tableContentPage").html('');
						$("#tableContent").addClass('no_info');
						return;
					}else{
						$("#tableContent").removeClass('no_info');
					}

					var html = [];
					for(i = 0; i < datas.length; i++) {
						//判断是否放卷
						// if(datas[i].paper){
						// 	var times = datas[i].paper.showtime;
						// }else{
						// 	var times = datas[i].endtime;
						// }
						var times = (datas[i].paper.showtime || 0);
						var showtimes = Date.parse(new Date(times));  //将发放试卷时间转化为时间戳
						var differ = showtimes - newtimes ;

						//判断及格分数
						var ispassscore = datas[i].score - datas[i].paper.passscore;
						var no_pass_score = '';
						if(differ <= 0 && datas[i].paper.showtime){
							if(ispassscore >= 0){
								no_pass_score = '';
							}else{
								no_pass_score = 'no_pass_score';
							}
						}
						html.push('<li class="'+no_pass_score+'">');
						html.push(' <div class="search-list-left">');
						html.push('  <div class="test-pic"> <i class="icona-test"></i> </div>');
						html.push('  <div class="test-txt">');
						html.push('		<p class="test-txt-p1"><a href="javascript:void(0);" data-cut="30">' + datas[i].papername + '</a></p>');
						html.push('		<p><span><i class="icona-time2"></i>考试日期 :' + datas[i].starttime + '</span>');
						if(datas[i].paper.showtime){
							html.push('			<span><i class="icona-time3"></i>公布成绩日期 :' + times + '</span>');
						}else{
							html.push('			<span><i class="icona-time4"></i>试卷类型 : 线下卷</span>');
						}

						if(differ <= 0  && datas[i].paper.showtime){
							if(ispassscore >= 0){
								html.push('     	<span style="color:#3db06e"><i class="icona-time1"></i>成绩 :'+datas[i].score+'分</span>');
							}else{
								html.push('     	<span style=""><i></i>成绩 : '+datas[i].score+'分</span>');
							}
						}
						html.push('     </p>');
						html.push('	 </div>');
						html.push(' </div>');
						html.push('	<div class="search-list-right">');
						if(differ > 0){
							html.push('		<a href="javascript:void(0)" class="noshow" title="未到放卷时间">---------</a>');
						}else{
							html.push('		<a href="../questions/question_details/examinationDetail.html?id=' + datas[i].id + '&pid=' + datas[i].pid + '" target="_blank"><i class="icona-ceshi"></i>查看详情</a>');
						}
						html.push('	</div>');
						html.push('</li>');
					}
					$("#tableContent").html(html.join(""));
					$("#tableContentPage").html(t.data.frontPageHtml);
					delDisabled();
					if(top.hei)
						top.hei();
				}
			}
		});
	},

	//搜索
	searchContent: function() {
		testRecords.getData();
	}
};
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	testRecords.getData();
}
function delDisabled(){
	var length = $('#tableContentPage a').length;
	for(var i=0;i<length;i++ ){
		if($('#tableContentPage a').eq(i).html() == '...'){
			$('#tableContentPage a').eq(i).removeClass('disabled');
		}
	}
}