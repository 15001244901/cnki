$(function() {
	practiceRecords.init();
});
var practiceRecords = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		practiceRecords.getData();
	},
	getData: function() {
		var pageNo = $("#pageNo").val();
		$.ajax({
			url: urlpath + '/user/practice/history.jhtml',
			type: "GET",
			async: false,
			data: {
				pageNo: pageNo,
				pageSize: 10
			},
			success: function(t) {
				console.log(t);
				var success = t.success;

				if(success) {
					var datas = t.data.list;
					var html = [];
					for(i = 0; i < datas.length; i++) {
						html.push('<div class="section">');

						html.push(' <div class="div5">');
						html.push('  <span class="three1">试卷名称：<a style="color:#30bf89">' + (datas[i].name||'') + '</a></span>');
						html.push('  <span class="three2">' + datas[i].testdate + '</span>');
						html.push(' </div>');

						html.push(' <div class="div6">');
						html.push('  <span class="one6">分数 ：  ' + datas[i].userscore + ' 分</span>');
						html.push('  <a class="two6"  href="practiveDetail.html?id=' + datas[i].id + '&pid=' + datas[i].pid + '">查看详情</a>');
						 // html.push('  <a class="two6"  href="../test_sets/Test_report/Grading_papers_detail_1.html?id=' + datas[i].id + '&pid=' + datas[i].pid + '">查看详情</a>');

						html.push(' </div>');

						html.push('</div>');


						// html.push('<tr>');
						// html.push(' <td class="td1">' + datas[i].papername + '</td>');
						// html.push(' <td class="td2">' + datas[i].starttime + '</td>');
						// html.push(' <td class="td4"><a href="practiveDetail.html?id=' + datas[i].id + '&pid=' + datas[i].pid + '"><span class="last">查看详情</span></a></td>');
						// html.push('</tr>');



					}
					$("#tableContent").html(html.join(""));
					$("#tableContentPage").html(t.data.frontPageHtml);
				}
			}
		});
	},
	//跳转
	skip: function(divId, divName, zDivCount) {
		for(i = 0; i <= zDivCount; i++) {
			document.getElementById(divName + i).style.display = "none";
			//将所有的层都隐藏 
		}
		document.getElementById(divName + divId).style.display = "block";
		//显示当前层 
	}
}
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	practiceRecords.getData();
}