$(function() {
	onlineTest.init();

});
var now_time_during = 0;
var now_timestamps = 0;
var late_exam = '';
var time_plus_arr = [];
var onlineTest = {
	//初始化
	init: function() {

		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		onlineTest.getData();
        onlineTest.clickStyle();
	},
	getData: function() {
		nowLoadData("#table");
		// var uid = useruid;
		var pageNo = $("#pageNo").val();
		$.ajax({
			url: urlpath + '/user/paper/list.jhtml',
			type: "get",
			dataType:'json',
			// async: false,
			data: {
				// uid: uid,
				pageNo: pageNo,
				pageSize: 10,
				orderBy:'starttime asc',
				isExpired:0
			},
			success: function(t) {
				// console.log(t);

				// 获取当前时间戳
				// var timestamp = new Date().getTime();

                var timestamp = t.nowDate;
                timestamp = timestamp.replace(/-/g,"/");
                timestamp = Date.parse(timestamp);
				// console.log(timestamp);

				if(!t.data.list){
					$("#table").html('');
					$("#pagehtml").html('');
					$('#number2-1').addClass('no_info');
					return
				}else{
					$('#number2-1').removeClass('no_info');
				}
				var success = t.success;
				if(success) {
					var datas = t.data.list;
					if(typeof(datas) != "undefined") {
						var html = [];
						// 使用心得数据结构迭代数据
						for(var i = 0; i < datas.length; i++) {
							// 考试开始时间
							var ie_starttime = datas[i].starttime;
							ie_starttime = ie_starttime.replace(/-/g,"/");
							// 考试结束时间
							var ie_endtime = datas[i].endtime;
							ie_endtime =  ie_endtime.replace(/-/g,"/");
							// 考试结束时间戳
							var timeover = Date.parse(ie_endtime);
							// 考试开始时间戳
							var dates = Date.parse(ie_starttime);
							//判断考试是否开始
							var timecha = dates - timestamp ;
							// console.log(timecha);
							//判断考试是否结束
							var overcha = timeover - timestamp;

                            time_plus_arr.push(timecha);
							// if(i==0){
							// 	now_time_during = timecha;
							// }
                            if(!now_time_during){
                                if(timecha>0){
                                    now_time_during = timecha;
                                    late_exam = i;
                                }
                            }

							html.push('<div class="section">');
							html.push(' <div class="div5">');
							html.push('  <span class="three1"><a style="color:#30bf89">'+ datas[i].name + '</a></span>');
							html.push('  <span class="three2"> ' + datas[i].starttime + '</span>');
							html.push(' </div>');
							html.push(' <div class="div6">');
							html.push('  <span class="one6">试卷分数 ：  ' + datas[i].totalscore + ' 分</span>');
							if(overcha >= 0){
								if(timecha <= 0 ){
									html.push('  <span class="one6 ml15 colorred">考试已开始</span>');

								}else if(timecha <= 600000){
									html.push('  <span class="one6 ml15 coloryellow timecost">距离考试开始时间 ：  <i class="timecost'+i+'">' + onlineTest.ShowCountDown(timecha,dates) + ' </i></span>');
								}else{
									html.push('  <span class="one6 ml15 timecost">距离考试开始时间 ：  <i class="timecost'+i+'">' + onlineTest.ShowCountDown(timecha,dates) + ' </i></span>');
								}

								var hide;
								(timecha > 0) ? hide = 'hide': hide = ' ';
								if(datas[i].showmode == 1) {
									html.push('  <a class="two6 exam '+hide+'" title="开始考试"  href="In_the_test.html?id=' + datas[i].id + timestampv + '"> </a>');
								} else {
									html.push('  <a class="two6 exam '+hide+'" title="开始考试"  href="In_the_test2.html?id=' + datas[i].id + timestampv + '"> </a>');
								}

							} else{
								html.push('  <span class="one6 ml15">考试结束时间 ：  ' + datas[i].endtime + ' </span>');
								html.push('  <a class="two6 exam_over" title="考试结束"  href="javascript:void(0);"> </a>');
							}

							html.push(' </div>');
							html.push('</div>');
						}

						$("#table").html(html.join(""));
						$("#pagehtml").html(t.data.frontPageHtml);

                        if(now_time_during > 0){
                            now_timestamps = new Date().getTime();
                            setTimeout(onlineTest.oneceTimeCost,1000);
                        }
                        delDisabled();
					}
				}
			},
			error:function(){
				loadFail('#table');
			}
		});
	},
	ShowCountDown: function(str,tis) {
		var is_plus = str;
		str = Math.abs(str);
		str = str/1000;
		var day1 = Math.floor(str / (60 * 60 * 24));
		var hour = Math.floor((str - day1 * 24 * 60 * 60) / 3600);
		var minute = Math.floor((str - day1 * 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(str - day1 * 24 * 60 * 60 - hour * 3600 - minute * 60);

		if(hour.toString().length == 1) {
			hour = "0" + "" + hour;
		}
		if(minute.toString().length == 1) {
			minute = "0" + "" + minute;
		}
		if(second.toString().length == 1) {
			second = "0" + "" + second;
		}

		var time = (day1 || 0) + ' 天 ' + (hour || 0) + ' 时 ' + (minute || 0) + ' 分 ' + (second || 0) + ' 秒';
		if(!day1){
			var time = (hour || 0) + ' 时 ' + (minute || 0) + ' 分 ' + (second || 0) + ' 秒';
		}else if(!hour){
			var time = (minute || 0) + ' 分 ' + (second || 0) + ' 秒';
		}else if(!minute){
			var time = (second || 0) + ' 秒';
		}

		if(is_plus<0){
			time = '-&nbsp;'+time;
		}
		return time;
	},
	//倒计时
	oneceTimeCost:function(timer){
		var is_nowtime = new Date().getTime();
		var is_duringtime =  is_nowtime- now_timestamps;
		var copy_time_during  = now_time_during - is_duringtime;

        if(copy_time_during<=1000*60*10 && copy_time_during>0){
            if(! $('.timecost'+late_exam).parent('span').hasClass('coloryellow')){
                $('.timecost'+late_exam).parent('span').addClass('coloryellow')
            }
        }else if(copy_time_during <= 0){
            if(! $('.timecost'+late_exam).parent('span').hasClass('colorred')){
                $('.timecost'+late_exam).parent('span').addClass('colorred').removeClass('coloryellow');
				$('.timecost'+late_exam).closest('.div6').find('.exam ').removeClass('hide');
            }
        }
		if(copy_time_during > 0){
			$('.timecost'+late_exam).html(onlineTest.ShowCountDown(Math.abs(copy_time_during)));
            setTimeout(onlineTest.oneceTimeCost,1000);
		}else{
            $('.timecost'+late_exam).parent('span').html('考试已开始');
		    if((late_exam + 1) <= time_plus_arr.length){
                late_exam = late_exam +1;
                now_time_during = Number(time_plus_arr[late_exam ]);
                setTimeout(onlineTest.oneceTimeCost,1000);
            }
		}

	},
    //类型转换
    clickStyle:function(){
        var indexNum = 0 ;
        $('#section_title span').click(function(){
            $('#section_title span').removeClass('colorblur');
            $(this).addClass('colorblur');
            indexNum = $(this).index();
			$('#pageStype').val(indexNum);
            var setLeft = $(this).position().left + 5;
            $('#bottom').animate({
                'left':setLeft
            },100);

			$("#pageNo").val(1);
            if(indexNum == 0){
                onlineTest.getData();
            }else{
                onlineTest.getDataOver();
            }
        });
        $('#section_title span').hover(function(){
            var setLeft = $(this).position().left + 5;
            $('#bottom').stop().animate({
                'left':setLeft
            },100)
        },function(){
            var setLeft = $('#section_title span').eq(indexNum).position().left + 5;
            $('#bottom').stop().animate({
                'left':setLeft
            },100)
        });
    },
    //加载已过期的考试
    getDataOver:function () {
		$('#number2-1').removeClass('no_info');
		nowLoadData("#table");
        // var uid = useruid;
        var pageNo = $("#pageNo").val();
        $.ajax({
            url: urlpath + '/user/paper/list.jhtml',
            type: "GET",
            // async: false,
            data: {
                // uid: uid,
                pageNo: pageNo,
                pageSize: 10,
                orderBy:'starttime asc',
				isExpired:1
            },
            success: function(t) {
            	// console.log(t);
                // 获取当前时间戳
                var timestamp = new Date().getTime();
                // console.log(timestamp);

                if(!t.data.list){
					$("#table").html('');
					$("#pagehtml").html('');
                    $('#number2-1').addClass('no_info');
                    return
                }else{
					$('#number2-1').removeClass('no_info');
				}
                var success = t.success;
                if(success) {
                    var datas = t.data.list;
                    if(typeof(datas) != "undefined") {
                        var html = [];
                        // 使用心得数据结构迭代数据
                        for(var i = 0; i < datas.length; i++) {
                            var dates = Date.parse(datas[i].starttime);
                            var timeover = Date.parse(datas[i].endtime);
                            var timecha = dates - timestamp ;
                            var overcha = timeover - timestamp;

                            html.push('<div class="section">');
                            html.push(' <div class="div5">');
                            html.push('  <span class="three1"><a style="color:#30bf89">'+ datas[i].name + '</a></span>');
                            html.push('  <span class="three2"> ' + datas[i].starttime + '</span>');
                            html.push(' </div>');
                            html.push(' <div class="div6">');
                            html.push('  <span class="one6">试卷分数 ：  ' + datas[i].totalscore + ' 分</span>');
                            if(overcha < 0){
                                html.push('  <span class="one6 ml15">考试结束时间 ：  ' + datas[i].endtime + ' </span>');
                                html.push('  <a class="two6 exam_over" title="考试结束"  href="javascript:void(0);"> </a>');
                            }


                            html.push(' </div>');
                            html.push('</div>');
                        }

                        $("#table").html(html.join(""));
                        $("#pagehtml").html(t.data.frontPageHtml);
                        delDisabled();
                    }
                }
            },
			error:function(){
				loadFail('#table');
			}
        });
    }
};
//分页
function page(pageno, pagesize) {
	$("#pageNo").val(pageno);
	if($('#pageStype').val() == '1'){
		onlineTest.getDataOver();
	}else{
		onlineTest.getData();
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