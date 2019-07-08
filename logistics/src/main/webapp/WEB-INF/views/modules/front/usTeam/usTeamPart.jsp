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
			
			<!-- 图表 -->
			<div id="main_chart"></div>

			<!-- 人员列表 -->
			<div class="personnel_title bg1">
				<i class="icon iconfont icon-paihangbang2"></i> <span class="partname">答题榜</span>
			</div>
			<div class="personnel_list">

			</div>

			<%--榜单分类--%>
			<div class="rank_type">
				<div class="rank_type_list">
					<div class="rank_type_radiu" data-rankid="1">
						<a href="javascript:void(0);"><i class="icon iconfont icon-lianxijilu"></i>
							答题榜</a>
					</div>
				</div>
				<div class="rank_type_list">
					<div class="rank_type_radiu" data-rankid="2">
						<a href="javascript:void(0);"><i class="icon iconfont icon-wenda"></i>
							活跃榜
						</a>
					</div>
				</div>
				<div class="rank_type_list">
					<div class="rank_type_radiu" data-rankid="3">
						<a href="javascript:void(0);"><i class="icon iconfont icon-msnui-times"></i>
							勤奋榜
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

    <script id="user_model_0" type="text/template">
        <div class="media" id="scroll-{{uid}}">
            <div class="media-left media-middle">
                <img class="media-object" src="{{photo}}" alt="{{uname}}">
            </div>
            <div class="media-body media-middle">
                <h4 class="media-heading">{{index}}{{uname}}<span>&nbsp;&nbsp;[{{oname}}]</span></h4>
                <span>共做题：{{do_num}}道</span>&nbsp;&nbsp;<span>正确数：{{do_oknum}}道</span>
            </div>
            <%--<div class="media-right media-middle">--%>
                <%--<span class="glyphicon glyphicon-menu-right"></span>--%>
            <%--</div>--%>
        </div>
        <hr>
    </script>
    <script id="user_model_1" type="text/template">
        <div class="media" id="scroll-{{uid}}">
            <div class="media-left media-middle">
                <img class="media-object" src="{{photo}}" alt="{{uname}}">
            </div>
            <div class="media-body media-middle">
                <h4 class="media-heading">{{index}}{{uname}}<span>&nbsp;&nbsp;[{{oname}}]</span></h4>
                <span>问答次数：{{qa_num}}道</span>
            </div>
        </div>
        <hr>
    </script>
    <script id="user_model_2" type="text/template">
        <div class="media" id="scroll-{{uid}}">
            <div class="media-left media-middle">
                <img class="media-object" src="{{photo}}" alt="{{uname}}">
            </div>
            <div class="media-body media-middle">
                <h4 class="media-heading">{{index}}{{uname}}<span>&nbsp;&nbsp;[{{oname}}]</span></h4>
                <div class="media-bodying">
                    <span>总计时长：{{kshs}}分钟</span><span>考试用时：{{kshs}}分钟</span><span>练习用时：{{lxhs}}分钟</span>
                    <span>视频用时：{{play_nums}}分钟</span>
                </div>
            </div>
        </div>
        <hr>
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
            var dom = document.getElementById("main_chart");
            var myChart = echarts.init(dom);
            var app = {};
            option = null;

            var peopelnum  = 4;
            var gridleft = '15%';
            var gridright = '15%';
            if(especial_public){
                peopelnum = 10;
                gridleft = '10%';
                gridright  = '10%';
            }
            app.config = {
                rotate: 90,
                align: 'left',
                verticalAlign: 'middle',
                position: 'top',
                distance: 2,
                onChange: function () {
                    var labelOption = {
                        normal: {
                            rotate: app.config.rotate,
                            align: app.config.align,
                            verticalAlign: app.config.verticalAlign,
                            position: app.config.position,
                            distance: app.config.distance
                        }
                    };
                    myChart.setOption({
                        series: [{
                            label: labelOption
                        }, {
                            label: labelOption
                        }, {
                            label: labelOption
                        }, {
                            label: labelOption
                        }]
                    });
                }
            };


            var labelOption = {
                normal: {
                    show: true,
                    position: app.config.position,
                    distance: app.config.distance,
                    align: app.config.align,
                    verticalAlign: app.config.verticalAlign,
                    rotate: app.config.rotate,
                    // formatter: '{c}  {name|{a}}',
                    formatter: '{c}',
                    fontSize: 12,
                    rich: {
                        name: {
                            textBorderColor: '#fff'
                        }
                    }
                }
            };

            var option = {
                color: [ '#337ab7', '#5cb85c', '#5bc0de','#f0ad4e'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    data: ['正确率']
                },
                toolbox: {
                    show: true,
                    orient: 'vertical',
                    left: 'right',
                    top: 'center',
                    feature: {
                        mark: {show: true},
                        dataView: {show: true, readOnly: false},
                        magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                dataZoom: [
                    {
                        id: 'dataZoomX',
                        type: 'slider',
                        xAxisIndex: [0],
                        filterMode: 'filter', // 设定为 'filter' 从而 X 的窗口变化会影响 Y 的范围。
//                        start: 0,
//                        end: 100
                        startValue:0,
                        endValue:peopelnum
                    }
                ],
                grid: {
                    left:gridleft,
                    right:gridright
                },
                calculable: true,
                xAxis: [
                    {
                        name:'姓名',
                        type: 'category',
                        axisTick: {show: false},
                        data: [],
                        axisLabel:{
                            interval:0//横轴信息全部显示
                        }
                    }
                ],
                yAxis: [
                    {
                        name:'',
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '正确率(%)',
                        type: 'bar',
                        barGap: 0,
                        label: labelOption,
                        data: []
                    }
                ]
            };
            var series2 = [
                {
                    name: '活跃次数',
                    type: 'bar',
                    barGap: 0,
                    label: labelOption,
                    data: []
                }
            ];
            var series3 = [
                {
                    name: '考试用时',
                    type: 'bar',
                    barGap: 0,
                    label: labelOption,
                    data: []
                },
                {
                    name: '练习用时',
                    type: 'bar',
                    label: labelOption,
                    data: []
                },
                {
                    name: '视频用时',
                    type: 'bar',
                    label: labelOption,
                    data: []
                }
            ];

            function getQueryString(key) {
                var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
                var result = window.location.search.substr(1).match(reg);
                return result ? decodeURIComponent(result[2]) : null;
            };
            var dtype = getQueryString('dtype');
            var time =  getQueryString('date');

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
                this.personnel_list = $('.personnel_list');  //排行榜容器

                this.dtb_user_model = $('#user_model_0').html(); //人员模板
                this.hyb_user_model = $('#user_model_1').html(); //人员模板
                this.qfb_user_model = $('#user_model_2').html(); //人员模板

                this.partid = '';
                this.ranktype = '';
                this.rank_type_radiu = $('.rank_type_radiu'); //切换榜单

                this.get_time_style = $('.get_time_style'); //查询方式
                this.seled_month  = $('#seled_month');      //限定的月份
                this.seled_week= $('.seled_week');           //选定的星期

                this.nodata_model = $('#nodata_model').html();  //暂无数据

        		this.loadUserFun = function(datajson){
        		    var hid = that.getQueryString('partid');
                    var ranktype = that.getQueryString('ranktype');
                    that.partid = hid || '';
                    that.ranktype = ranktype;

        			$.ajax({
						url: urlpath+'/user/team/countList.jhtml?hid='+(hid || ''),
						type: "GET",
                        data:(datajson || ''),
						success:function(t){
							//console.log(t);
                            that.personnel_list.html('');
                            $('#main_chart').removeClass('no_data');

                            if(ranktype == 1){

                                $('.personnel_title').addClass('bg1');
                                if(t.DTB.length<=0){
                                    that.personnel_list.append(that.nodata_model);
                                    $('.personnel_title .partname').html(' 答题榜 ');
                                    myChart.clear();
                                    $('#main_chart').addClass('no_data');
                                    return;
                                }

                                var partname = t.DTB[0].hname;
                                $('.personnel_title .partname').html(' 答题榜 - '+partname);
                                that.addUserFun(t.DTB,that.dtb_user_model,1);
                            }else if(ranktype == 2){

                                $('.personnel_title').addClass('bg2').removeClass('bg1');
                                if(t.HYB.length<=0){
                                    that.personnel_list.append(that.nodata_model);
                                    $('.personnel_title .partname').html(' 活跃榜 ');
                                    myChart.clear();
                                    $('#main_chart').addClass('no_data');
                                    return;
                                }
                                var partname = t.HYB[0].hname;
                                $('.personnel_title .partname').html(' 活跃榜 - '+partname);
                                that.addUserFun(t.HYB,that.hyb_user_model,2);
                            }else if(ranktype == 3){

                                $('.personnel_title').addClass('bg3').removeClass('bg1');

                                if(t.QFB.length<=0){
                                    that.personnel_list.append(that.nodata_model);
                                    $('.personnel_title .partname').html(' 勤奋榜');
                                    myChart.clear();
                                    $('#main_chart').addClass('no_data');
                                    return;
                                }
                                var partname = t.QFB[0].hname;
                                $('.personnel_title .partname').html(' 勤奋榜 - '+partname);
                                that.addUserFun(t.QFB,that.qfb_user_model,3);
                            }
						}
					});

        			
        		};

                this.addUserFun = function(json,model,rtype){
                    var datas = json;
                    var userString = ' ';
                    var default_photo = '${ctxStatic}/images/userphoto.jpg';

                    var username = [];
                    var totlnum = [];
                    var oknum = [];
                    var ok_total = [];

                    var hynum = [];

                    var totaletime = [];
                    var kstime = [];
                    var lxtime = [];
                    var sptime = [];

                    for(var i=0; i<datas.length; i++){
                        var dictionary = datas[i];
                        var index = i+1;
                        if(!dictionary.photo){
                            dictionary.photo = default_photo;
                        }

                        username .push(dictionary.uname);
                        if(rtype == 1){
                            var zql = (dictionary.do_oknum/dictionary.do_num)*100;
                            zql = zql.toFixed(0);
                            totlnum.push(dictionary.do_num);
                            oknum.push(dictionary.do_oknum);
                            ok_total.push(zql);
                        }else if(rtype == 2){
                            hynum.push(dictionary.do_num);
                        }


                        if(i<3){
                            dictionary.index = '<i class="icon iconfont icon-class'+index+'"></i> ';
                        }else{
                            dictionary.index = '<i>'+index+'</i>';
                        }
                        if(rtype == 3){
                            if(!dictionary.kshs){
                                dictionary.kshs = 0;
                            }
                            if(!dictionary.lxhs){
                                dictionary.lxhs = 0;
                            }
                            if(!dictionary.play_nums){
                                dictionary.play_nums = 0;
                            }
                            dictionary.totalhs = dictionary.kshs + dictionary.lxhs + dictionary.play_nums;
                            totaletime.push(dictionary.totalhs);
                            kstime.push(dictionary.kshs);
                            lxtime.push(dictionary.lxhs);
                            sptime.push(dictionary.play_nums);
                        }
                        userString += that.comPile(model,dictionary)
                    }
                    that.personnel_list.html(userString);


                    if(rtype == 1){
                        option.yAxis[0].name = '';
                        option.legend.data = ['正确率(%)'];
                        option.series[0].data = ok_total;
                        //option.series[1].data = oknum;
                    }else if(rtype == 2){
                        option.yAxis[0].name = '次数';
                        option.legend.data = ['活跃次数'];
                        option.series = series2;
                        option.series[0].data = hynum;

                    }else if(rtype == 3){
                        option.yAxis[0].name = '分钟';
                        option.legend.data = ['考试用时','练习用时','视频用时'];
                        option.series = series3;
                        option.series[0].data = kstime;
                        option.series[1].data = lxtime;
                        option.series[2].data = sptime;

                    }
                    option.xAxis[0].data = username;

                    if (option && typeof option === "object") {
                        myChart.setOption(option, true);
                    }

                    var uid = that.getQueryString('uid');
                    if(uid){
                        //window.location.hash = "#scroll-"+uid;
                        var istop = $('#scroll-'+uid).position().top -10;
                        $('body,html').animate({scrollTop:istop},300)
                    }
                };

                this.jumpPageFun = function(){

                    var ranktype = $(this).data('rankid');
                    var dtype = that.get_time_style.val();
                    var time = '';
                    if(dtype == 1){
                        time = that.seled_month.html();
                    }else if(dtype == 2){
                        time = that.seled_week.html();
                    }
                    window.location.href="usTeamPart.html?ranktype="+ranktype+'&partid='+that.partid+"&dtype="+dtype+"&date="+time;
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
        			//this.loadUserFun();
                    this.rank_type_radiu.off('click').on('click',this.jumpPageFun);
        		}
        	};
        	var usTeam = new usTeamFun;
        	usTeam.init();
            calendar.init();
        })

    </script>
</body>
</html>