$(function () {
    gradingPaperTwo.init();
    $('#reseach').off('click').on('click', function () {
        gradingPaperTwo.init();

    });
});

var gradingPaperTwo = {
    //初始化
    init: function () {
        var pid = gradingPaperTwo.getQueryString('pid');
        // var selOrder = $("#selOrder").val();
        // var officesSels = $('#officesSel').val();
        // if (!officesSels)
        //     officesSels = '';
        var uname = $("#uname").val();
        if (!uname)
            uname = '';
        $("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
        $.ajax({
            url: urlpath_a + '/exam/examHistory/list.jhtml',
            type: "GET",
            async: false,
            data: {
                'pid': pid,
                'orderBy': '',
                'office.id': '',
                'urealname':uname
            },
            success: function (t) {
                console.log(t);
                var success = t.success;
                var datas = t.data.list;
                var offices = t.offices;
                var paper = t.paper;
                var settime = paper.duration;
                var progress = t.progress;
                var officesSel = [];
                if (success) {
                    //循环部门信息
                    // officesSel.push('<option value="">所有部门</option>')
                    // for (var i = 0; i < offices.length; i++) {
                    //     officesSel.push('<option value="' + offices[i].id + '">' + offices[i].name + '</option>')
                    // }
                    // $("#officesSel").html(officesSel.join(""));
                    //获取试卷信息
                    $("#exam_name").html(paper.name);
                    $('#startime b').html(paper.starttime);
                    $('#endtime b').html(paper.endtime);
                    $("#during b").html(paper.duration + "分钟");
                    $("#total b").html(paper.totalscore + "分(及格分数" + paper.passscore + "分)");

                    if(!t.data.list){
                        $("#usersTable tbody").html('');
                        $("#exam_list").addClass('no_info');
                    }else{
                        $("#exam_list").removeClass('no_info');
                    }



                    //获取批改进度
                    var tm_checked_percent = 0;
                    var totalprogress = progress.wait + progress.testing + progress.checked;
                    if (totalprogress == 0) {
                        tm_checked_percent = 0;
                    } else {
                        tm_checked_percent = progress.checked * 200 / totalprogress;
                    }
                    document.getElementById("percent").style.width = tm_checked_percent + "px";
                    $("#percentage").html(gradingPaperTwo.toDecimal(tm_checked_percent/2) + "%");
                    //获取用户列表
                    var users = [];
                    if (typeof(datas) != "undefined") {
                        for (var i = 0; i < datas.length; i++) {
                            var bj = i + 1;
                            users.push('<tr>');
                            users.push(' <td>' + datas[i].urealname + '</td>');
                            users.push(' <td>' + datas[i].office.name + '</td>');
                            users.push(' <td>' + datas[i].starttime + '</td>');

                            // if (settime - Number(datas[i].timecost) < 0) {
                            //     users.push(' <td><span class="black" style="color:red;">超时未提交</span></td>');
                            //     users.push(' <td  style="color:red;">超时未提交</td>');
                            //     users.push(' <td class="black1">' + datas[i].score + '</td>');
                            // } else {
                            //     if (datas[i].status == 0) {
                            //         users.push(' <td><span class="black" style="color: darkgreen;">考试进行中</span></td>');
                            //         users.push(' <td style="color: darkgreen;">考试进行中</td>');
                            //         users.push(' <td class="black1" style="color: darkgreen;">考试进行中</td>');
                            //     } else {
                            //         //计算耗时
                            //         var end_str = datas[i].endtime.replace(/-/g, "/");
                            //         var end_date = new Date(end_str);
                            //         var sta_str = datas[i].starttime.replace(/-/g, "/");
                            //         var sta_date = new Date(sta_str);
                            //         var numminute = (end_date - sta_date) / (1000);
                            //         var numscond = (end_date - sta_date) / (1000 * 60);
                            //         // console.log(numscond);
                            //
                            //         if (numscond <= 1) {
                            //             users.push(' <td><span class="black">' + (numminute || '0') + '</span>秒</td>');
                            //         } else {
                            //             users.push(' <td><span class="black">' + (datas[i].timecost || '0') + '</span>分钟</td>');
                            //
                            //         }
                            //         if (datas[i].status == 1) {
                            //             users.push(' <td>等待批改</td>');
                            //         } else if (datas[i].status == 2) {
                            //             users.push(' <td>已经批改</td>');
                            //         } else {
                            //             users.push(' <td style="color: red;">已经批改</td>');
                            //         }
                            //         users.push(' <td class="black1">' + datas[i].score + '</td>');
                            //     }
                            //
                            //
                            // }
                            // users.push(' <td>' + datas[i].ip + '</td>');
                            // if (datas[i].status !== '2') {
                            //     users.push(' <td>');
                            //     users.push('  <a class="exam_over" href="javascript:void(0);"><span class="nolook" title="批改试卷"></span></a>');
                            //     users.push(' </td>');
                            // } else {
                            //     users.push(' <td>');
                            //     users.push('  <a class="exam" href="Grading_papers_detail.html?eid=' + datas[i].id + '&pid=' + datas[i].pid + '" title="批改试卷"><span class="look"></span></a>');
                            //     users.push(' </td>');
                            // }


                            if(datas[i].status == 0){
                                var end_data = Date.parse(paper.endtime);  //考试结束时间
                                var now_data = new Date().getTime();        //先在时间
                                var timecha = now_data - end_data;
                                if(timecha <= 0){
                                    users.push(' <td><span class="black" style="color: darkgreen;">考试进行中</span></td>');
                                    users.push(' <td style="color: darkgreen;">考试进行中</td>');
                                    users.push(' <td class="black1" style="color: darkgreen;">考试进行中</td>');
                                }else{
                                    users.push(' <td><span class="black" style="color:red;">超时未提交</span></td>');
                                    users.push(' <td  style="color:red;">超时未提交</td>');
                                    users.push(' <td class="black1">' + datas[i].score + '</td>');
                                }
                                users.push(' <td>' + datas[i].ip + '</td>');
                                users.push(' <td>');
                                users.push('  <a class="exam_over" href="javascript:void(0);"><span class="nolook" title="批改试卷"></span></a>');

                            }else if(datas[i].status == 1){
                                //计算耗时
                                var end_str = datas[i].endtime.replace(/-/g, "/");
                                var end_date = new Date(end_str);
                                var sta_str = datas[i].starttime.replace(/-/g, "/");
                                var sta_date = new Date(sta_str);
                                var numminute = (end_date - sta_date) / (1000);
                                var numscond = (end_date - sta_date) / (1000 * 60);
                                // console.log(numscond);

                                if (numscond <= 1) {
                                    users.push(' <td><span class="black">' + (numminute || '0') + '</span>秒</td>');
                                } else {
                                    users.push(' <td><span class="black">' + (datas[i].timecost || '0') + '</span>分钟</td>');

                                }
                                users.push(' <td>等待批改</td>');
                                users.push(' <td class="black1">' + datas[i].score + '</td>');
                                users.push(' <td>' + datas[i].ip + '</td>');
                                users.push(' <td>');
                                users.push('  <a class="exam_over" href="javascript:void(0);"><span class="nolook" title="批改试卷"></span></a>');
                            }
                            else if(datas[i].status == 2){
                                //计算耗时
                                var end_str = datas[i].endtime.replace(/-/g, "/");
                                var end_date = new Date(end_str);
                                var sta_str = datas[i].starttime.replace(/-/g, "/");
                                var sta_date = new Date(sta_str);
                                var numminute = (end_date - sta_date) / (1000);
                                var numscond = (end_date - sta_date) / (1000 * 60);
                                // console.log(numscond);

                                if (numscond <= 1) {
                                    users.push(' <td><span class="black">' + (numminute || '0') + '</span>秒</td>');
                                } else {
                                    users.push(' <td><span class="black">' + (datas[i].timecost || '0') + '</span>分钟</td>');

                                }
                                users.push(' <td>已经批改</td>');
                                users.push(' <td class="black1">' + datas[i].score + '</td>');
                                users.push(' <td>' + datas[i].ip + '</td>');
                                users.push(' <td>');
                                users.push('  <a class="exam" href="Grading_papers_detail.html?eid=' + datas[i].id + '&pid=' + datas[i].pid + '" title="批改试卷"><span class="look"></span></a>');
                                // users.push('  <a href="Grading_papers_detail.html?eid=' + datas[i].id + '&pid=' + datas[i].pid +'&nexteid='+ datas[bj].id+ '&nextpid=' + datas[bj].pid+ '"><span class="look">查看详情</span></a>');


                            }
                            users.push('  <a class="exam_del" data-id="'+datas[i].id+'" href="javascript:void(0);" title="删除此条信息"></a>');
                            users.push(' </td>');
                            users.push('</tr>');
                        }
                        $("#usersTable tbody").html(users.join(""));
                        gradingPaperTwo.delExam();
                    }
                }

            }
        });
    },
    //保留两位小数
    toDecimal: function (x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return;
        }
        f = Math.round(x * 100) / 100;
        return f;
    },
    //获取url参数 传值url中的key
    getQueryString: function (key) {
        var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
        var result = window.location.search.substr(1).match(reg);
        return result ? decodeURIComponent(result[2]) : null;
    },
    //删除记录
    delExam:function(){
        $('#usersTable').off('click').on('click','.exam_del',function(){
            var this_id = $(this).attr('data-id');
            $.ajax({
                url: urlpath_a + '/exam/examHistory/delete.jhtml?id='+this_id,
                type: "post",
                async: false,
                success:function(ret){
                    layer.msg(
                        '删除成功',
                        {
                            time:2000,
                            anim:4
                            // title:'系统提示',
                        }
                    );
                    gradingPaperTwo.init();
                }
            })
        })
    }
};