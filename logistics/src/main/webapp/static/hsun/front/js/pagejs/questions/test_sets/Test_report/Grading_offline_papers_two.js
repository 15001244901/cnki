$(function () {
    gradingPaperTwo.init();
    gradingPaperTwo.alterTotal();
    gradingPaperTwo.upUserCar();
    gradingPaperTwo.clickAddUser();
    gradingPaperTwo.clickCloseUser();
    $('#reseach').off('click').on('click', function () {
        gradingPaperTwo.init();
    });
    $(".users").click(function(event){
        event.stopPropagation();
    });
    $(".users_cont").slimScroll({
        color:'#333333'
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

                // 试卷id
                var paperId = paper.id;

                if (success) {
                    //获取试卷信息
                    $("#exam_name").html(paper.name);
                    $('#startime b').html(paper.starttime);
                    $('#endtime b').html(paper.endtime);
                    $("#during b").html(paper.duration + "分钟");
                    $("#total b").html(paper.totalscore + "分(及格分数" + paper.passscore + "分)");
                    $('#hide_total').val(paper.totalscore);

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
                    var userId = [];
                    if (typeof(datas) != "undefined") {
                        for (var i = 0; i < datas.length; i++) {
                            userId.push(datas[i].uid);

                            users.push('<tr>');
                            users.push(' <td class="y_name">' + datas[i].urealname + '</td>');
                            users.push(' <td class="y_part">' + datas[i].office.name + '</td>');
                            users.push(' <td>' + datas[i].starttime + '</td>');
                            users.push(' <td>' + datas[i].timecost + '</td>');
                            users.push(' <td class="for_score">' + datas[i].score + '</td>');
                            users.push(' <td>');
                            users.push('  <form class="for_data">');
                            users.push('    <input class="for_checks" type="hidden" value="2" name="status">');
                            // users.push('    <input class="for_checks" type="hidden" value="'+datas[i].checks+'" name="checks">');
                            users.push('    <input class="for_pid" type="hidden" value="'+datas[i].pid+'" name="pid">');
                            users.push('    <input class="for_uid" type="hidden" value="'+datas[i].uid+'" name="uid">');
                            users.push('    <input class="for_uid" type="hidden" value="'+datas[i].id+'" name="id">');
                            users.push('    <input class="for_uid" type="hidden" value="'+datas[i].starttime+'" name="starttime">');
                            users.push('    <input class="for_uid" type="hidden" value="'+datas[i].endtime+'" name="endtime">');
                            users.push('  </form>');

                            // users.push('  <a class="alter" href="Grading_papers_detail.html?eid=' + datas[i].id + '&pid=' + datas[i].pid + '" title="批改试卷"></a>');
                            users.push('  <a class="alter" href="javascript:void(0);" title="批改试卷"></a>');
                            users.push('  <a class="exam_del" data-id="'+datas[i].id+'" href="javascript:void(0);" title="删除此条信息"></a>');
                            users.push(' </td>');
                            users.push('</tr>');

                        }
                        //循环部门信息
                        var obj = true;
                        for (var i = 0; i < offices.length; i++) {

                            officesSel.push('<div class="users_title">'+ offices[i].name +'<span class="fa fa-angle-down up_class"></span></div>');
                            officesSel.push('<ul>');
                            if(offices[i].users){
                                var offices_users = offices[i].users;
                                for(var j=0;j<offices_users.length ;j++){
                                    obj = true;
                                    for(var k=0;k<userId.length;k++){
                                        if(offices_users[j].id == userId[k]){
                                            obj = false;
                                        }
                                    }
                                    if(obj){
                                        officesSel.push('<li>');
                                        officesSel.push(' <span class="input_name">'+offices_users[j].name+'</span><span class="input_score">录入分数：<input type="text" value="0"></span><span class="fr pr20 add_people" data-uid="'+offices_users[j].id+'">添加</span>');
                                        officesSel.push('</li>');
                                    }else{
                                        officesSel.push('<li>');
                                        officesSel.push(' <span class="input_name">'+offices_users[j].name+'</span><span class="fr pr20 add_people color_red">已添加</span>');
                                        officesSel.push('</li>');
                                    }

                                }
                            }

                            officesSel.push('</ul>');
                            officesSel.push('<hr>');
                        }

                        $(".users_cont").html(officesSel.join(""));
                        $('.users_cont input').inputmask('9{1,6}',{placeholder:"", clearMaskOnLostFocus: false });
                        $("#usersTable tbody").html(users.join(""));
                        gradingPaperTwo.addUser(paperId,paper.starttime,paper.endtime,paper.duration);
                        gradingPaperTwo.delExam();
                    }
                }

            }
        });
    },
    //点击显示添加人员
    clickAddUser:function(){
        $('#add_user').click(function(){
            $('#users').fadeIn(function(){
                $('.users').addClass('check');
            });
        });
    },
    //点击关闭添加人员面板
    clickCloseUser:function(){
        $('#users').click(function(){
            $('.users').removeClass('check');
            $('#users').hide();
        });
        $('.users_title_name span').click(function(){
            $('.users').removeClass('check');
            $('#users').hide();
        })
    },
    // 点击修改
    alterTotal:function(){
        $('#exam_list').off('click').on('click','.alter',function(){
            var serializeData = $(this).parent('td').find('.for_data').serialize();
            var that = $(this).parents('tr').find('.for_score');
            var is_score = that.html();  //原分数
            var isname = $(this).parents('tr').find('.y_name').html();    //姓名
            var ispart = $(this).parents('tr').find('.y_part').html();    //所在部门

            layer.open({
                type: 1,
                title:ispart + ' - '+isname +' -分数设置',
                skin: 'layui-layer-molv', //样式类名
                anim: 1,
                area: ['420px', '240px'], //宽高
                shadeClose: true, //开启遮罩关闭
                btn: ['确定', '取消'],
                content: $('#alert_layer').html(),
                success: function(layero, index){
                    $('#alert_score').val(is_score);
                    $('#alert_score').inputmask('9{1,6}',{placeholder:"", clearMaskOnLostFocus: false });
                },
                yes: function(index, layero){
                    var score = $('#alert_score').val();
                    var istotal =  $('#hide_total').val();
                    if(score - istotal >0){
                        layer.msg(
                            '录入分数不能大于卷面总分',
                            {
                                time:2000,
                                anim:4
                            }
                        );
                        return;
                    }
                    serializeData = serializeData +'&score='+score;
                    // console.log(serializeData);
                    // layer.closeAll();
                    $.ajax({
                        url: urlpath_a + '/exam/examHistory/save.jhtml',
                        type: "post",
                        data: serializeData,
                        success:function(ret){
                            layer.closeAll();
                            that.html(score);
                            layer.msg(
                                '修改成功',
                                {
                                    time:2000,
                                    anim:4
                                }
                            );
                        }
                    })
                }

            });
        });
    },
    // 点击添加
    addUser:function(pid,stime,etime,timecost){
       $('.add_people').click(function(){
           if($(this).hasClass('color_red'))
               return;
           var that = $(this);
           var uid = $(this).data('uid');
           var isScore = $(this).parents('li').find('input').val();
           $.ajax({
               url: urlpath_a + '/exam/examHistory/save.jhtml',
               type: "post",
               data: {
                   'uid':uid,
                   'pid':pid,
                   'starttime':stime,
                   'endtime':etime,
                   'status':'2',
                   'score':isScore
               },
               success:function(ret){
                   gradingPaperTwo.loadUserList();
                   that.addClass('color_red').html('已添加');
                   layer.closeAll();
                   layer.msg(
                       '添加成功',
                       {
                           time:2000,
                           anim:4
                       }
                   );

               }
           })
       });
    },
    //涮新成员列表
    loadUserList:function(){
        var pid = gradingPaperTwo.getQueryString('pid');
        $.ajax({
            url: urlpath_a + '/exam/examHistory/list.jhtml',
            type: "GET",
            async: false,
            data: {
                'pid': pid,
                'orderBy': '',
                'office.id': '',
                'urealname': ''
            },
            success:function(t){
                var users = [];
                var datas = t.data.list;

                for (var i = 0; i < datas.length; i++) {
                    users.push('<tr>');
                    users.push(' <td>' + datas[i].urealname + '</td>');
                    users.push(' <td>' + datas[i].office.name + '</td>');
                    users.push(' <td>' + datas[i].starttime + '</td>');
                    users.push(' <td>' + datas[i].timecost + '</td>');
                    users.push(' <td class="for_score">' + datas[i].score + '</td>');
                    users.push(' <td>');
                    users.push('  <form class="for_data">');
                    users.push('    <input class="for_checks" type="hidden" value="2" name="status">');
                    users.push('    <input class="for_checks" type="hidden" value="'+datas[i].checks+'" name="checks">');
                    users.push('    <input class="for_pid" type="hidden" value="'+datas[i].pid+'" name="pid">');
                    users.push('    <input class="for_uid" type="hidden" value="'+datas[i].uid+'" name="uid">');
                    users.push('    <input class="for_uid" type="hidden" value="'+datas[i].id+'" name="id">');
                    users.push('    <input class="for_uid" type="hidden" value="'+datas[i].starttime+'" name="starttime">');
                    users.push('    <input class="for_uid" type="hidden" value="'+datas[i].endtime+'" name="endtime">');
                    users.push('  </form>');

                    // users.push('  <a class="alter" href="Grading_papers_detail.html?eid=' + datas[i].id + '&pid=' + datas[i].pid + '" title="批改试卷"></a>');
                    users.push('  <a class="alter" href="javascript:void(0);" title="批改试卷"></a>');
                    users.push('  <a class="exam_del" data-id="'+datas[i].id+'" href="javascript:void(0);" title="删除此条信息"></a>');
                    users.push(' </td>');
                    users.push('</tr>');

                }
                $("#usersTable tbody").html(users.join(""));
                gradingPaperTwo.delExam();
            }
        })

    },
    //展开、折叠用户表
    upUserCar:function(){
        $('.users').on('click','.up_class',function(){
            var hide = $(this).parent('.users_title').next('ul').css('display');
            if(hide == 'none'){
                $(this).parent('.users_title').next('ul').slideDown();
                $(this).removeClass('check');
            }else{
                $(this).parent('.users_title').next('ul').slideUp();
                $(this).addClass('check');
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
            $('.confirm_container').fadeIn(0,function(){
                $('.confirm').addClass('check');
            });
            gradingPaperTwo.confirmDel(this_id);
            gradingPaperTwo.confirmQx();


        })
    },
    confirmDel:function (id) {
        $('.confirm_del').click(function(){
            $.ajax({
                url: urlpath_a + '/exam/examHistory/delete.jhtml?id='+id,
                type: "post",
                async: false,
                success:function(ret){
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
                    gradingPaperTwo.init();
                }
            })
        });
    },
    confirmQx:function(){
        $('.confirm_qx').click(function(){
            $('.confirm').removeClass('check');
            $('.confirm_container').fadeOut(0);
        });
    },
};