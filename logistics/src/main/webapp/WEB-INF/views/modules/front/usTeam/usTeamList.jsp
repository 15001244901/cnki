<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name ="viewport" content ="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

    <link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/font/iconfont.css">
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/usTeam/css/main.css">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/usTeam/css/media.css">

    <script src="${ctxStatic}/hsun/front/usTeam/js/echarts.min.js"></script>
    <script src="${ctxStatic}/hsun/front/usTeam/js/jquery.min.js"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_public.js${v}"></script>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

</head>
<body>
<div id="divheader"></div>

<div class="body_container">
    <div class="container-fluid">
        <div class="timer">
            <div class="btn-toolbar timer_btn" role="toolbar" aria-label="...">
                <div class="timer_name">时间:</div>
                <div class="time_style">
                    <select class="form-control get_time_style">
                        <option value="1">按月份</option>
                        <option value="2">按星期</option>
                    </select>
                    <div class="go_back go_back1" onclick="window.history.go(-1)">
                        <span class="btn btn-default">返回</span>
                    </div>
                </div>
                <div class="isweek hide">
                    <div class="btn-group week" role="group" aria-label="...">
                        <button type="button" class="btn btn-default prev_week">上周</button>
                        <button type="button" class="btn btn-default now_week">本周</button>
                        <button type="button" class="btn btn-default next_week">下周</button>
                    </div>
                    <div class="form-group week_year">
                        <span class="form-control"><em class="seled_year"></em>年第<b class="seled_week">  </b>周</span>
                    </div>
                </div>

                <div class="ismonth ">
                    <div class="btn-group month" role="group" aria-label="...">
                        <button type="button" class="btn btn-default prev_month">上月</button>
                        <button type="button" class="btn btn-default now_month">本月</button>
                        <button type="button" class="btn btn-default next_month">下月</button>
                    </div>
                    <div class="form-group now_time">
                        <span class="form-control" id="seled_month"></span>
                    </div>
                </div>

                <div class="go_back go_back2" onclick="window.history.go(-1)">
                    <span class="btn btn-default">返回</span>
                </div>

            </div>
            <!-- <div class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control form_datetime" value="2018-01-01">
                </div>
                    -
                <div class="form-group">
                    <input type="text" class="form-control" value="2018-01-30">
                </div>
            </div> -->
        </div>

        <!-- 排行榜 -->
        <div class="row rank_list rank_list_container">

        </div>

        <%--榜单分类--%>
        <div class="rank_type">
            <div class="rank_type_list">
                <div class="rank_type_radiu" data-rankid = "1">
                    <a href="javascript:void(0);"><i class="icon iconfont icon-lianxijilu"></i>
                        答题榜</a>
                </div>
            </div>
            <div class="rank_type_list">
                <div class="rank_type_radiu" data-rankid = "2">
                    <a href="javascript:void(0);"><i class="icon iconfont icon-wenda"></i>
                        活跃榜
                    </a>
                </div>
            </div>
            <div class="rank_type_list">
                <div class="rank_type_radiu" data-rankid = "3">
                    <a href="javascript:void(0);"><i class="icon iconfont icon-msnui-times"></i>
                        勤奋榜
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script id="rank_model" type="text/template">
    <div class="col-md-4 col-sm-4 rank0">
        <div class="list-group">
            <a href="usTeamPart.html?partid={{id}}&ranktype={{typeid}}&dtype={{dtype}}&date={{date}}" class="list-group-item bg{{typeid}}">
                <i class="icon iconfont icon-paihangbang2"></i>{{title}}<span class="pull-right">更多﹥</span>
            </a>
            <div class="level">
                {{userlist}}
            </div>

        </div>
    </div>
</script>
<script id="user_model" type="text/template">
    <a href="usTeamPart.html?partid={{hid}}&ranktype={{typeid}}&uid={{uid}}&dtype={{dtype}}&date={{date}}" class="list-group-item level_color{{index}}"><i class="icon iconfont icon-class{{index}}"></i>{{uname}} <span class="badge">{{totalnum}}</span></a>
</script>
<%--暂无数据--%>
<script id="nodata_model" type="text/template">
    <div class="no_user">
        <i class="icon iconfont icon-loadfail"></i>
        无人上榜
    </div>
</script>

<script src="${ctxStatic}/hsun/front/usTeam/layDate-v5.0.9/laydate.js"></script>
<script type="text/javascript">


    if(especial_public){
        $("#divheader").load(projectname + "/page/include/header.html");
    }else{
        $("#divheader").remove();
    }
    $(function(){

        var calendarFun = function(){
            var that = this;

            var now_week = '';
            var now_month = '';
            var now_year = '';

            var isweek = '';
            var ismonth = '';
            var isyear = '';

            const initialdate = '2017-01-01';
            const initialyear = 2017;
            const initialmonth = 1;

            this.get_time_style = $('.get_time_style'); //查询方式
            //周选项
            this.prev_week = $('.prev_week');
            this.now_week  = $('.now_week');
            this.next_week = $('.next_week');
            this.seled_week= $('.seled_week');
            //月选项
            this.prev_month   = $('.prev_month');
            this.now_month    = $('.now_month');
            this.next_month   = $('.next_month');
            this.seled_month  = $('#seled_month');
            this.seled_year  = $('.seled_year');

            this.getQueryString = function(key) {
                var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
                var result = window.location.search.substr(1).match(reg);
                return result ? decodeURIComponent(result[2]) : null;
            };
            var dtype = that.getQueryString('dtype');
            var time =  that.getQueryString('date');

            this.dataMonthFun = function(){
                var is_now_month =(now_month <10 ? "0"+now_month:now_month);
                var data_month = {
                    'month':now_year + '-' + is_now_month

                };
                usTeam.loadUserFun(data_month);
            };

            this.dataWeekFun = function () {
                var is_now_week = (now_week <10 ? "0"+now_week:now_week);
                var data_week = {
                    'yearweek':now_year + is_now_week
                };
                usTeam.loadUserFun(data_week);
            };

            //切换查询方式
            this.getTimeStyle = function(){
                var style = $(this).val();
                if(style == 1){
                    $('.isweek').addClass('hide');
                    $('.ismonth').removeClass('hide');
                    that.dataMonthFun();
                }else if(style == 2){
                    $('.ismonth').addClass('hide');
                    $('.isweek').removeClass('hide');
                    that.dataWeekFun();
                }
            };

            //上一周
            this.prevWeeekFun = function(){
                if(!now_week || now_week == 1) {
                    layer.msg('已到第一周');
                    return;
                }
                now_week = now_week - 1;
                that.seled_week.html(now_week);

                that.dataWeekFun();
            };
            //下一周
            this.nextWeeekFun = function(){
                if(!now_week || now_week == isweek) {
                    layer.msg('已到当前周');
                    return;
                }
                now_week = now_week + 1;
                that.seled_week.html(now_week);

                that.dataWeekFun();
            };
            //本周
            this.nowWeeekFun = function(){
                now_week = isweek;
                that.seled_week.html(now_week);

                that.dataWeekFun();
            };

            //上一月
            this.prevMonthFun = function(){
                if(now_year == initialyear &&  now_month == initialmonth){
                    layer.msg('已到数据统计初始时间');
                    return;
                }
                if(now_month == 1){
                    now_month = 12;
                    now_year = now_year - 1;
                }else{
                    now_month = now_month - 1;
                }
                that.seled_month.html(now_year+'-'+now_month);

                that.dataMonthFun();
            };
            //下一月
            this.nextMonthFun = function () {
                if(now_year == isyear && now_month == ismonth) {
                    layer.msg('已到当前月份');
                    return;
                }

                if(now_month == 12){
                    now_month = 1;
                    now_year = now_year + 1;
                }else{
                    now_month = now_month + 1;
                }
                that.seled_month.html(now_year+'-'+now_month);

                that.dataMonthFun();
            };
            //现在月
            this.nowMonthFun = function () {
                now_month = ismonth;
                now_year = isyear;
                that.seled_month.html(now_year+'-'+now_month);

                that.dataMonthFun();
            };

            //获取星期
            this.hasWeekFun = function(){
                var d1 = new Date();
                var d2 = new Date();
                d2.setMonth(0);
                d2.setDate(1);
                var rq = d1-d2;
                var s1 = Math.ceil(rq/(24*60*60*1000));
                var s2 = Math.ceil(s1/7);

                isweek = s2;
                now_week = s2;
                that.seled_week.html(s2);
                that.get_time_style.val('1');
            };
            //获取当前年和月份
            this.hasMonthFun = function () {
                var date = new Date;
                var year=date.getFullYear();
                var month=date.getMonth()+1;
                //month =(month<10 ? "0"+month:month);
                ismonth = month;
                isyear = year;

                if(month == 1){
                    now_month == 12
                    now_year = year - 1;
                }else{
                    now_month = month - 1;
                    now_year = year;
                }
                that.seled_month.html(now_year+'-'+(now_month<10 ? "0"+now_month:now_month));
                that.seled_year.html(now_year);

                if(dtype && time){
                    if(dtype == 1){
                        that.seled_month.html(time);
                        usTeam.loadUserFun({'month':time});

                        var getyear = time.slice(0,4) || isyear;
                        time = time.slice(5);
                        now_month = parseInt(time);
                        now_year =  parseInt(getyear);
                    }else if(dtype == 2){
                        that.seled_week.html(time);
                        var timex = (time <10 ? "0"+time:time);
                        that.get_time_style.val('2');
                        $('.ismonth').addClass('hide');
                        $('.isweek').removeClass('hide');
                        usTeam.loadUserFun({'yearweek':isyear+timex});

                        now_week = Number(time);
                    }
                }else{
                    that.dataMonthFun();
                }
            };

            this.riLi = function () {
                laydate.render({
                    elem: '#seled_month',
                    type: 'month',
                    btns: ['now', 'confirm'],
                    min:initialdate,
                    max:isyear+'-'+ismonth,
                    done: function(value, date, endDate){
                        now_year = date.year;
                        now_month = date.month;
                        that.dataMonthFun();
                    }
                });
            };

            this.monthString = function(num){


                return num;
            };

            this.init = function(){
                this.hasWeekFun();
                this.hasMonthFun();
                this.riLi();
                this.get_time_style.on('change',this.getTimeStyle);

                this.prev_week.off('click').on('click',this.prevWeeekFun);
                this.now_week.off('click').on('click',this.nowWeeekFun);
                this.next_week.off('click').on('click',this.nextWeeekFun);

                this.prev_month.off('click').on('click',this.prevMonthFun);
                this.now_month.off('click').on('click',this.nowMonthFun);
                this.next_month.off('click').on('click',this.nextMonthFun);
            }
        };
        var calendar = new calendarFun;

        var usTeamFun = function(){
            var that = this;

            this.rank_list = $('.rank_list');  //排行榜容器
            this.rank_model = $('#rank_model').html(); //排行榜模板
            this.user_model = $('#user_model').html(); //人员模板

            this.nodata_model = $('#nodata_model').html();  //暂无数据

            this.rank_type_radiu = $('.rank_type_radiu');   //选择榜单按钮

            this.get_time_style = $('.get_time_style'); //查询方式
            this.seled_month  = $('#seled_month');      //限定的月份
            this.seled_week= $('.seled_week');           //选定的星期

            this.parts_name_list = [];
            //获取组织机构
            this.getPartBody = function () {
                $.ajax({
                    'url':urlpath_a+'/sys/office/listOffices4Manager.jhtml',
                    'type':'get',
                    'async':false,
                    'dataType': "json",
                    success:function(ret){
                        if(ret.success){
                            //console.log(ret);
                            var company_id = ret.company.id;
                            var datas = ret.data;
                            var part_list = [];
                            var doString = '';
                            for(var i=0; i<datas.length; i++){
                                if(datas[i].parentId == company_id){
                                    var dictionary = datas[i];
                                    part_list.push(datas[i]);

                                }
                            }
                            that.parts_name_list = part_list;

                        }else{
                            alert('网络连接失败');
                        }

                    }
                })
            };

            this.loadUserFun = function(datajson){

                $.ajax({
                    url: urlpath+'/user/team/countList.jhtml',
                    type: "GET",
                    data:(datajson || ''),
                    success:function(t){
                        //console.log(t);
                        if(t.success){
                            var ranktype = that.getQueryString('ranktype');
                            var default_photo = '${ctxStatic}/images/userphoto.jpg';
                            that.rank_list.html('');

                            var datas = t.DTB;
                            if(ranktype == 1){
                                datas = t.DTB;
                            }else if(ranktype == 2){
                                datas = t.HYB;
                            }else if(ranktype == 3){
                                datas = t.QFB;
                            }
                            if(that.parts_name_list.length<=0){
                                that.rank_list.append(that.nodata_model);
                                return;
                            }
                            //console.log(that.parts_name_list);

                            if(ranktype == 1){
                                that.textRankTypeFun(that.parts_name_list,t.DTB,1);
                            }else if(ranktype == 2){
                                that.textRankTypeFun(that.parts_name_list,t.HYB,2);
                            }else if(ranktype == 3){
                                that.textRankTypeFun(that.parts_name_list,t.QFB,3);
                            }
                        }
                    }
                });


            };

            this.textRankTypeFun = function(partjson,datasjson,ranktype){
                var part = partjson;
                var datas = datasjson;

                var dtype = that.get_time_style.val();
                var time = '';
                if(dtype == 1){
                    time = that.seled_month.html();
                }else if(dtype == 2){
                    time = that.seled_week.html();
                }

                for(var i=0; i<part.length; i++){
                    var partString = ' ';
                    var dictionary = part[i];
                    dictionary.typeid = ranktype;

                    dictionary.dtype = dtype;
                    dictionary.date = time;

                    if(ranktype == 1){
                        dictionary.title = '答题榜-'+dictionary.name;
                    }else if(ranktype == 2){
                        dictionary.title = '活跃榜-'+dictionary.name;
                    }else if(ranktype == 3){
                        dictionary.title = '勤奋榜-'+dictionary.name;
                    }

                    var userString = ' ';
                    var userLength = 0;

                    var hasdatas = false;

                    for(var j=0; j<datas.length; j++){
                        var userDictionary = datas[j];
                        if(dictionary.id == userDictionary.hid){
                            hasdatas = true;

                            userLength++;
                            userDictionary.index = userLength;
                            userDictionary.typeid = ranktype;

                            userDictionary.dtype = dtype;
                            userDictionary.date = time;

                            if(ranktype == 1){
                                userDictionary.totalnum = userDictionary.do_num + '道';
                            }else if(ranktype == 2){
                                userDictionary.totalnum = userDictionary.qa_num + '次';
                            }else if(ranktype == 3){
                                if(!userDictionary.kshs) userDictionary.kshs = 0;
                                if(!userDictionary.lxhs) userDictionary.lxhs = 0;
                                if(!userDictionary.play_nums) userDictionary.play_nums = 0;
                                userDictionary.totalnum = (userDictionary.kshs+userDictionary.lxhs+userDictionary.play_nums) + '分钟';
                            }


                            if(userLength > 5){
                                break;
                            }
                            userString += that.comPile(that.user_model,userDictionary);
                        }
                    }

                    if(!hasdatas){
                        dictionary.userlist = that.nodata_model;
                    }else{
                        dictionary.userlist = userString;
                    }

                    partString = that.comPile(that.rank_model,dictionary);
                    that.rank_list.append(partString);
                }
            };

            this.selRankFun = function(){
                var ranktype = $(this).data('rankid');
                var dtype = that.get_time_style.val();
                var time = '';
                if(dtype == 1){
                    time = that.seled_month.html();
                }else if(dtype == 2){
                    time = that.seled_week.html();
                }
                window.location.href="usTeamList.html?ranktype="+ranktype+"&dtype="+dtype+"&date="+time;
            };

            this.getQueryString = function(key) {
                var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
                var result = window.location.search.substr(1).match(reg);
                return result ? decodeURIComponent(result[2]) : null;
            };

            this.comPile = function(templateString , dictionary){
                return templateString.replace(/\{{([\w]+)\}}/g , function(match,$1,index,string){
                    return dictionary[$1];
                });
            };

            this.init = function(){
                this.getPartBody();
                this.rank_type_radiu.off('click').on('click',this.selRankFun);
                //this.loadUserFun();
            }
        };
        var usTeam = new usTeamFun;
        usTeam.init();
        calendar.init();
    })

</script>
</body>
</html>