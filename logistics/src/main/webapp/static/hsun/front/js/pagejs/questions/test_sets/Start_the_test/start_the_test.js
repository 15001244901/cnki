
$(function () {
    startTheTest.init();
    startTheTest.selectPaper();

    $('.show_list').off('click').on('click',function(){
        $('.offices_list').animate({
            'opacity':1,
            'right':0
        },1000);
    });
    $('.hide_list').off('click').on('click',function(){
        $('.offices_list').animate({
            'opacity':0,
            'right':'-100%'
        },1000);
    });
    // 固定右侧

    // $(window).scroll(function(){
    //     var winWidth = $(window).width();
    //     var poswidth = (winWidth - 1200)/2;
    //     if ($(window).scrollTop() > 135){
    //         $('.div1').addClass('pos');
    //         $('.div1').css('right',poswidth)
    //     } else {
    //         $('.div1').removeClass('pos');
    //     }
    //
    // });
});
var globalType = 0;
var startTheTest = {
    //初始化
    init: function () {
        $("#divheader").load(projectname + "/page/include/headerquestion.html" + timestamps);
        var id = startTheTest.getQueryString('id');
        $.ajax({
            url: urlpath_a + '/exam/paper/view.jhtml',
            type: "GET",
            async: false,
            data: {
                id: id //试卷ID
            },
            success: function (t) {
                //console.log(t);
                var success = t.success;
                var datas = t.data;
                if (success) {
                    $("#hidid").val(datas.id);
                    $("#divName").html(datas.name);

                    $("#txtDuration").html(datas.duration);
                    $("#txtTotalScore").html(datas.totalscore);
                    // $("#txtStarttime").val(datas.starttime);

                    // $("#txtEndtime").val(datas.endtime);
                    // $("#txtShowtime").val(datas.showtime);
                    $("#hidPassScore").val(datas.passscore);
                    $("#hidOrderType").val(datas.ordertype);
                    $("#hidPaperType").val(datas.papertype);
                    $("#hidRemark").val(datas.remark);
                    $("#hidCid").val(datas.cid);
                    $("#hidState").val(datas.status);

                    var pnums = 0;
                    var sections = t.data.sections;
                    if (typeof(sections) != "undefined") {
                        for (var i = 0; i < sections.length; i++) {
                            var questions = sections[i].questions;
                            if (typeof(questions) != "undefined") {
                                pnums = pnums + questions.length;
                            }
                        }
                    }
                    $("#txtCount").html(pnums);

                    var html = [];
                    var html_list = [];
                    // var off = [];
                    // var use = [];
                    var offices = t.offices;
                    var top_length = [];
                    for (var i = 0; i < offices.length; i++){
                        top_length.push(offices[i].parentIds.split(",").length);
                    }
                    var minN = Math.min.apply(null,top_length);


                    for (var i = 0; i < offices.length; i++) {
                        var test_class = offices[i].parentIds.split(",");
                        if(test_class.length == minN){

                            // off.push(offices[i].id);
                            html.push('<div class="part_list mt20 dis_'+offices[i].id+'">');
                            html.push('<div class="div3">');
                            html.push('  <label for="o-'+offices[i].id+'">' + offices[i].name + '</label>');
                            //html.push('  <span class="check_all">全选</span>');
                            html.push('  <input type="checkbox" name="selectOffices" id="o-'+offices[i].id+'" value="' + offices[i].id + '"/>');
                            if(offices[i].users){
                                html.push('<span class="div3_togger fa fa-angle-up fa-lg"></span>');
                            }
                            html.push('</div>');
                            if(offices[i].users){
                                html.push('<div class="div4">');
                                var users = offices[i].users;
                                if (typeof(users) != "undefined") {
                                    for (var j = 0; j < users.length; j++) {
                                        // use.push(users[j].id);
                                        html.push('  <label for="u-'+users[j].id+'">' + users[j].name);
                                        html.push('  <input type="checkbox" name="selectUsers" id="u-'+users[j].id+'" value="' + users[j].id + '"/>');
                                        html.push('  </label>');
                                    }
                                }
                                html.push('</div>');
                            }
                            html.push('</div>');

                            var child_html = startTheTest.getChildPart(offices[i].id,offices);

                            if(child_html.html && child_html.html.length>0){
                                html.push(child_html.html.join(""));
                            }

                            html_list.push('<li>');
                            html_list.push(' <div class="list_title" data-id="'+offices[i].id+'" onclick="startTheTest.displayPart(this,\''+offices[i].id+'\')"><label >'+offices[i].name+'<input type="checkbox" checked> </label></div>');
                            if(child_html.html_list && child_html.html_list.length>0){
                                html_list.push('<ul class="ml20">');
                                if(child_html.html_list || child_html.html_list.length>0){
                                    html_list.push(child_html.html_list.join(""));
                                }
                                html_list.push('</ul>');
                            }
                            html_list.push('</li>');

                        }
                    }
                    // $("#hidAllOffices").val(off);
                    // $("#hidAllUsers").val(use);
                    $("#divOffices").html(html.join(""));
                    $('.offices_list_container').html(html_list.join(""));
                    startTheTest.clickSelectOffices();
                    startTheTest.userTogger();
                }
            }
        });
    },
    displayPart : function(is,id){
        if($(is).find('input').css('display') == 'none'){
            return;
        }
        var isparent = $(is).parent('li');
        var seled = isparent.find('input').attr('checked');
        var idarr = [];
        isparent.find('.list_title').each(function(){
            var dataid = $(this).data('id');
            if(seled){
                $('.dis_'+dataid).hide();
            }else{
                $('.dis_'+dataid).show();
            }
        });
        if(seled){
            isparent.find('input').removeAttr('checked');
            isparent.find('ul input').hide();
        }else{
            isparent.find('input').attr('checked','checked');
            isparent.find('ul input').show();
        }

    },
    getChildPart : function(id,json){
        if(!json || json.length<1){
            return false;
        }

        var ids = id;
        var offices = json;
        var html = [];
        var html_list = [];

        for (var i=0; i<offices.length; i++){

            if(offices[i].parentId == ids){
                var top_length = offices[i].parentIds.split(",").length-3;

                html.push('<div class="part_list ml'+(30*top_length)+' dis_'+offices[i].id+'">');
                html.push('<div class="div3">');
                html.push('  <label for="o-'+offices[i].id+'">' + offices[i].name + '</label>');
                //html.push('  <span class="check_all">全选</span>');
                html.push('  <input type="checkbox" name="selectOffices" id="o-'+offices[i].id+'" value="' + offices[i].id + '"/>');
                if(offices[i].users){
                    html.push('<span class="div3_togger fa fa-angle-up fa-lg"></span>');
                }
                html.push('</div>');
                if(offices[i].users){
                    html.push('<div class="div4">');
                    var users = offices[i].users;
                    if (typeof(users) != "undefined") {
                        for (var j = 0; j < users.length; j++) {
                            // use.push(users[j].id);
                            html.push('  <label for="u-'+users[j].id+'">' + users[j].name);
                            html.push('  <input type="checkbox" name="selectUsers" id="u-'+users[j].id+'" value="' + users[j].id + '"/>');
                            html.push('  </label>');
                        }
                    }
                    html.push('</div>');
                }
                html.push('</div>');

                var child_html = startTheTest.getChildPart(offices[i].id,offices);
                if(child_html.html && child_html.html.length>0){
                    html.push(child_html.html.join(""));
                }

                html_list.push('<li>');
                html_list.push(' <div class="list_title" data-id="'+offices[i].id+'" onclick="startTheTest.displayPart(this,\''+offices[i].id+'\')"><label >'+offices[i].name+'<input type="checkbox" checked> </label></div>');
                if(child_html.html_list && child_html.html_list.length>0){
                    html_list.push('<ul class="ml20">');
                        html_list.push(child_html.html_list.join(""));
                    html_list.push('</ul>');
                }
                html_list.push('</li>');
            }
        }

        var isjson = {'html':html,'html_list':html_list};

        return isjson;
    },
    //折叠人员
    userTogger : function(){
        $('.div3_togger').off('click').on('click',function(){
            var isnext = $(this).closest('.div3').next('.div4');
            if(isnext.css('display') == 'none'){
                isnext.slideDown();
                $(this).addClass('fa-angle-up').removeClass('fa-angle-down');
            }else{
                isnext.slideUp();
                $(this).addClass('fa-angle-down').removeClass('fa-angle-up');

            }
        });
    },
    //管理分类点击
    clickSelectOffices: function () {
        $('[name=selectOffices]').off('click').on('click', function () {
            if ($(this).attr('checked')) {
                $(this).parent('.div3').next('.div4').find('input').attr('checked', 'true');
            } else {
                $(this).parent('.div3').next('.div4').find('input').removeAttr("checked");
            }
        });
    },
    //点击试卷类型
    selectPaper:function(){
        $('input[name=linepaper]').click(function(){
            $('input[name=linepaper]').removeAttr('checked');
            $(this).attr('checked','checked');

            if($(this).val() == '0'){
                $('.put_time').slideDown();
            }else{
                $('.put_time').slideUp();
            }
            // console.log($(this).val())
        })
    },
    //开始考试
    start: function () {
        // 获取试卷类型
        var line_paper = $('input[name=linepaper][checked=checked]').val();

        var departments = "";
        var userss = "";
        var offices = document.getElementsByName("selectOffices");
        for (var i = 0; i < offices.length; i++) {
            if (offices[i].checked) {
                departments = departments + offices[i].value + ","
            }
        }
        if (departments.length > 0) {
            departments = departments.substring(0, departments.length - 1);
        }
        var users = document.getElementsByName("selectUsers");
        for (var i = 0; i < users.length; i++) {
            if (users[i].checked) {
                userss = userss + users[i].value + ",";
            }
        }
        if (userss.length > 0) {
            userss = userss.substring(0, userss.length - 1);
        }else{
            layer.open({
                title: '系统提示',
                closeBtn: 1,
                skin: 'layui-layer-molv',
                content: '<div style="text-align:center;">您还没有选择参考人员！</div>',
                yes: function (index, layero) {
                    layer.close(index);
                }
            });
            return;
        }
        // var off = $("#hidAllOffices").val();
        // var use = $("#hidAllUsers").val();



        var id = $("#hidid").val();
        var name = $("#divName").html();
        var cid = $("#hidCid").val();
        var status = $("#hidState").val();
        var starttime = $("#txtStarttime").val();            //获取开始日期
        var starttimetamps = Date.parse(new Date(starttime));  //将开始时间转化为时间戳

        if (starttime == '' || starttime == 'undefine') {
            layer.open({
                title: '系统提示',
                closeBtn: 1,
                skin: 'layui-layer-molv',
                content: '<div style="text-align:center;">开始考试时间不能为空</div>',
                yes: function (index, layero) {
                    layer.close(index);
                }
            });
            return;

        }
        var endtime = $("#txtEndtime").val();            //获取结束日期
        var endtimetamps = Date.parse(new Date(endtime));  //将结束时间转化为时间戳
        var start_end_time = endtimetamps - starttimetamps;
        if (endtime == '' || endtime == 'undefine') {
            layer.open({
                title: '系统提示',
                closeBtn: 1,
                skin: 'layui-layer-molv',
                content: '<div style="text-align:center;">结束考试时间不能为空</div>',
                yes: function (index, layero) {
                    layer.close(index);
                }
            });
            return;
        } else if (start_end_time <= 0) {
            layer.open({
                title: '系统提示',
                closeBtn: 1,
                skin: 'layui-layer-molv',
                content: '<div style="text-align:center;">考试结束时间不能晚于考试开始时间</div>',
                yes: function (index, layero) {
                    layer.close(index);
                }
            });
            return;
        }
        var duration = $("#txtDuration").html();
        var showtime = $("#txtShowtime").val();           //获取公布成绩时间
        var showtimetamps = Date.parse(new Date(showtime));  //将公布成绩时间转化为时间戳
        var show_end_time = showtimetamps - endtimetamps;
        if(line_paper == '0'){
            if (showtime == '' || showtime == 'undefine') {
                layer.open({
                    title: '系统提示',
                    closeBtn: 1,
                    skin: 'layui-layer-molv',
                    content: '<div style="text-align:center;">放卷时间不能为空</div>',
                    yes: function (index, layero) {
                        layer.close(index);
                    }
                });
                return;
            } else if (show_end_time <= 0) {
                layer.open({
                    title: '系统提示',
                    closeBtn: 1,
                    skin: 'layui-layer-molv',
                    content: '<div style="text-align:center;">放卷时间不能晚于考试结束时间</div>',
                    yes: function (index, layero) {
                        layer.close(index);
                    }
                });
                return;
            }
        }else{
            showtime = "";
        }

        var totalscore = $("#txtTotalScore").html();
        var passscore = $("#hidPassScore").val();
        var ordertype = $("#hidOrderType").val();
        var papertype = $("#hidPaperType").val();
        var remark = $("#hidRemark").val();
        var showkey = document.getElementById("ckbShowkey").checked;
        if (showkey) {
            showkey = 1;
        } else {
            showkey = 0;
        }
        if(line_paper == "1"){
            showkey = 1;
        }

        var showmode = document.getElementById("showmode_list").checked;
        if (showmode) {
            showmode = 1;
        } else {
            showmode = 2;
        }
        //alert(status);
        // console.log(userss);
        // return;
        $.ajax({
            url: urlpath_a + '/exam/paper/startexam.jhtml',
            type: "GET",
            async: false,
            data: {
                id: id,
                name: name,
                cid: cid,
                status: status,
                starttime: starttime,
                endtime: endtime,
                duration: duration,
                showtime: showtime,
                totalscore: totalscore,
                passscore: passscore,
                ordertype: ordertype,
                papertype: papertype,
                remark: remark,
                showkey: showkey,
                showmode: showmode,
                // departments: departments,
                users: userss,
                isoffline:line_paper

            },
            success: function (t) {
                var success = t.success;
                var datas = t.data;
                if (success) {
                    layer.open({
                        title: '系统提示',
                        closeBtn: 1,
                        skin: 'layui-layer-molv',
                        content: '<div style="text-align:center;">' + t.msg + '</div>',
                        yes: function (index, layero) {
                            layer.close(index);
                            if(line_paper == '0'){
                                window.location.href = "../text_sets.html" + timestamps;
                            }else{
                                window.location.href = projectname + "/page/downPaper/down_paper.html?pid=" + id ;
                            }
                        }
                    });

                } else {
                    layer.open({
                        title: '系统提示',
                        closeBtn: 1,
                        skin: 'layui-layer-molv',
                        content: '<div style="text-align:center;">' + t.msg + '</div>',
                        yes: function (index, layero) {
                            layer.close(index);
                        }
                    });
                }
            }
        });
    },
    //清除全部
    clearAll: function () {
        var offices = document.getElementsByName("selectOffices");
        for (var i = 0; i < offices.length; i++) {
            offices[i].checked = "";
        }
        var users = document.getElementsByName("selectUsers");
        for (var i = 0; i < users.length; i++) {
            users[i].checked = "";
        }
    },
    //所有人员
    spanAll: function (spanthis) {
        // globalType = 0;
        // spanthis.className = "one2";
        // document.getElementById("spanOppoint").className = "one1";
        // document.getElementById("divOffices").style.display = "none";
         $('.div4').find('input').attr('checked', 'true');
        $('.div3').find('input').attr('checked', 'true');
    },
    //指定人员
    spanOppoint: function (spanthis) {
        globalType = 1;
        spanthis.className = "one2";
        document.getElementById("spanall").className = "one1";
        document.getElementById("divOffices").style.display = "block";
    },
    //获取url参数 传值url中的key
    getQueryString: function (key) {
        var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
        var result = window.location.search.substr(1).match(reg);
        return result ? decodeURIComponent(result[2]) : null;
    }

    
}