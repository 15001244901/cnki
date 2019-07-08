$(function() {
	testRecords.init();
});
var testRecords = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		testRecords.getData();
	},
	getData: function() {
		var pageNo = $("#pageNo").val();
		var keyword = $("#keyword").val();
		var paperType = $("#paperType").val();
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
				console.log(t);
				var success = t.success;
				var datas = t.data.list;
				if(success) {
					var html = [];
					for(i = 0; i < datas.length; i++) {
						html.push('<div class="sections">');

						html.push(' <div class="div5">');
						html.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + (datas[i].papername||'') + '</a></span>');
						html.push('  <span class="three2">' + datas[i].starttime + '</span>');
						html.push(' </div>');

						html.push(' <div class="div6">');
						html.push('  <span class="one6">得分 ：  ' + datas[i].score + ' 分</span>');
						html.push('  <a class="two6"  href="examinationDetail.html?id=' + datas[i].id + '&pid=' + datas[i].pid + '">查看详情</a>');
						// html.push('  <a class="two6"  href="../test_sets/Test_report/Grading_papers_detail_1.html?id=' + datas[i].id + '&pid=' + datas[i].pid + '">查看详情</a>');
						html.push(' </div>');

						html.push('</div>');

						// html.push('<tr>');
						// html.push(' <td class="td1">' + datas[i].papername + '</td>');
						// html.push(' <td class="td2">' + datas[i].starttime + '</td>');
						// //html.push(' <td class="td4"><a href="Individual_reports.html?id='+datas[i].id+'"><span class="last">考试报告</span></a></td>');
						// html.push(' <td class="td4"><a href="examinationDetail.html?id=' + datas[i].id + '&pid=' + datas[i].pid + '"><span class="last">查看详情</span></a></td>');
						// html.push('</tr>');
					}
					$("#tableContent").html(html.join(""));
					$("#tableContentPage").html(t.data.frontPageHtml);
				}
			}
		});
	},

	//搜索
	searchContent: function() {
		testRecords.getData();
	}
}
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	testRecords.getData();
}