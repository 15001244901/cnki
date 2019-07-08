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

	<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>--%>
	<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>--%>
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
			<%--隐藏的排行榜选项--%>
			<%--<div class="display_rank">--%>
				<%--<span class="pull-left action">答题榜</span>--%>
				<%--<span class="pull-left">活跃榜</span>--%>
				<%--<span class="pull-left">勤奋榜</span>--%>
			<%--</div>--%>

			<%--实验室列表--%>
			<div class="parts_list">
				<ul class="row">

				</ul>
			</div>
			<!-- 排行榜 -->
			<div class="row rank_list">
				<div class="col-md-4 col-sm-4 rank0">

					<div class="list-group">
						<a href="javascript:void(0);"  data-rankid="1" class="list-group-item bg1">
							<i class="icon iconfont icon-paihangbang2"></i><span class="low_title1">总答题榜</span> <span class="pull-right link_next">各单位榜 ﹥</span>
						</a>
                        <%--<div class="rank_list_title">--%>

                        <%--</div>--%>
						<div class="level">

						</div>
					</div>
				</div>
				<div class="col-md-4 col-sm-4 rank1">
					<%--<div class="rank_list_title">--%>
					<%--</div>--%>
					<div class="list-group">
						<a href="javascript:void(0);" data-rankid="2" class="list-group-item bg2">
							<i class="icon iconfont icon-paihangbang2"></i><span class="low_title2">总活跃榜</span><span class="pull-right link_next">各单位榜 ﹥</span>
						</a>
						<div class="level">
						</div>
					</div>
				</div>
				<div class="col-md-4 col-sm-4 rank2">
					<%--<div class="rank_list_title">--%>
					<%--</div>--%>
					<div class="list-group">
						<a href="javascript:void(0);" data-rankid="3" class="list-group-item bg3">
							<i class="icon iconfont icon-paihangbang2"></i><span class="low_title3">总勤奋榜</span><span class="pull-right link_next">各单位榜 ﹥</span>
						</a>
						<div class="level">
						</div>
					</div>
				</div>
			</div>

			<%--榜单分类--%>
			<div class="rank_type index_rank_type">
				<div class="rank_type_list">
					<div class="rank_type_radiu" data-rankid="1">
						<a href="javascript:void(0)"><i class="icon iconfont icon-lianxijilu"></i>
							总答题榜</a>
					</div>
				</div>
				<div class="rank_type_list">
					<div class="rank_type_radiu" data-rankid="2">
						<a href="javascript:void(0)"><i class="icon iconfont icon-wenda"></i>
						总活跃榜
						</a>
					</div>
				</div>
				<div class="rank_type_list">
					<div class="rank_type_radiu" data-rankid="3">
						<a href="javascript:void(0)"><i class="icon iconfont icon-msnui-times"></i>
						总勤奋榜
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%--答题榜模板--%>
	<script id="dtb_top_model" type="text/template">
        <div class="rank_list_title" onclick="window.location.href='usTeamPart.html?partid={{hid}}&ranktype={{typeid}}&uid={{uid}}&dtype={{dtype}}&date={{date}}'">
            <div class="rank_type_first_name">
                <span class="img pull-left"><img class="border1" src="{{photo}}" alt=""></span>
                <span class="rank_type_top_title pull-left">
                    <p  class="rank_color1"><i class="icon iconfont icon-class{{index}}"></i></p>
                    <p>{{uname}}</p>
                </span>
            </div>
            <div class="rank_type_first_infor clearfix ">
                <p>共做题：{{do_num}}道</p>
                <p>正确数：{{do_oknum}}道</p>
                <p>正确率：{{zql}}%</p>
                <p>单&emsp;位：{{hname}}</p>
            </div>
        </div>
	</script>
	<script id="dtb_list_model" type="text/template">
		<a href="usTeamPart.html?partid={{hid}}&ranktype={{typeid}}&uid={{uid}}&dtype={{dtype}}&date={{date}}" class="list-group-item level_color{{index}}">
            <i class="icon iconfont icon-class{{index}}"></i>{{uname}}<span class="badge">{{do_num}}道</span>
            <p>所属科室：{{hname}}</p>
        </a>
	</script>
	<%--活跃榜模板--%>
	<script id="hyb_top_model" type="text/template">
        <div class="rank_list_title" onclick="window.location.href='usTeamPart.html?partid={{hid}}&ranktype={{typeid}}&uid={{uid}}&dtype={{dtype}}&date={{date}}'">
            <div class="rank_type_first_name">
                <span class="img pull-left"><img class="border2" src="{{photo}}" alt=""></span>
                <span class="rank_type_top_title pull-left">
                    <p  class="rank_color2"><i class="icon iconfont icon-class{{index}}"></i></p>
                    <p>{{uname}}</p>
                </span>
            </div>
            <div class="rank_type_first_infor clearfix ">
                <p>问答次数：{{qa_num}}次</p>
                <p>单&emsp;&emsp;位：{{hname}}</p>
            </div>
        </div>
	</script>
	<script id="hyb_list_model" type="text/template">
		<a href="usTeamPart.html?partid={{hid}}&ranktype={{typeid}}&uid={{uid}}&dtype={{dtype}}&date={{date}}" class="list-group-item level_color{{index}}"><i class="icon iconfont icon-class{{index}}"></i>{{uname}}<span class="badge">{{qa_num}}次</span><p>所属科室：{{hname}}</p></a>
	</script>
	<%--勤奋榜模板--%>
	<script id="qfb_top_model" type="text/template">
        <div class="rank_list_title" onclick="window.location.href='usTeamPart.html?partid={{hid}}&ranktype={{typeid}}&uid={{uid}}&dtype={{dtype}}&date={{date}}'">
            <div class="rank_type_first_name">
                <span class="img pull-left"><img class="border1" src="{{photo}}" alt=""></span>
                <span class="rank_type_top_title pull-left">
                        <p  class="rank_color3"><i class="icon iconfont icon-class{{index}}"></i></p>
                        <p>{{uname}}</p>
                    </span>
            </div>
            <div class="rank_type_first_infor clearfix ">
                <p>考试用时：{{kshs}}分钟</p>
                <p>练习用时：{{lxhs}}分钟</p>
                <p>视频用时：{{play_nums}}分钟</p>
                <p>总计时长：{{totalhs}}分钟</p>
                <p>单&emsp;&emsp;位：{{hname}}</p>
            </div>
        </div>
	</script>
	<script id="qfb_list_model" type="text/template">
		<a href="usTeamPart.html?partid={{hid}}&ranktype={{typeid}}&uid={{uid}}&dtype={{dtype}}&date={{date}}" class="list-group-item level_color{{index}}"><i class="icon iconfont icon-class{{index}}"></i>{{uname}}<span class="badge">{{totalhs}}分钟</span><p>所属科室：{{hname}}</p></a>
	</script>

	<%--暂无数据--%>
	<script id="nodata_model" type="text/template">
		<div class="no_user">
			<i class="icon iconfont icon-loadfail"></i>
			无人上榜
		</div>
	</script>

	<%--实验室列表模板--%>
	<script id="parts_list" type="text/template">
		<li class="col-md-3 col-sm-6"><a href="javascript:void(0);" onclick="goPart('{{id}}')">{{name}}</a></li>
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
            var option = null;

            app.config = {
                rotate: 90,
                align: 'left',
                verticalAlign: 'middle',
                position: 'top',
                distance: 5,
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

            option = {

                color: [ '#337ab7', '#5cb85c', '#5bc0de','#f0ad4e'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    data: ['答题数量', '活跃次数', '学习时间(小时)']
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
//                        end: 50
                        startValue:0,
                        endValue:3
                    }
                ],
                calculable: true,
                grid: {
                    bottom:'35%'
                },
                xAxis: [
                    {
                        //name:'默认',
                        type: 'category',
                        axisTick: {show: false},
                        //nameRotate:15,
                        //axisLine: {onZero: false},
                        //boundaryGap : false,
                        data: [],
                        axisLabel:{
                            interval:0,//横轴信息全部显示
                            rotate:-45//-45度角倾斜显示
                        }
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '答题数量',
                        type: 'bar',
                        barGap: 0,
                        label: labelOption,
                        data: []
                    },
                    {
                        name: '活跃次数',
                        type: 'bar',
                        label: labelOption,
                        data: []
                    },
                    {
                        name: '学习时间(小时)',
                        type: 'bar',
                        label: labelOption,
                        data: []
                    }
                ]
            };
            var partname = [];
            var partdtb = [];
            var parthyb = [];
            var partqfb = [];

        	var calendarFun = function(){
				var that = this;

				//变量初十日期
				var now_week = '';
				var now_month = '';
				var now_year = '';
				//初始日期
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

					that.dataMonthFun();
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

				this.switch_rank_btn = $('.display_rank span'); //切换榜单按钮
				this.nodata_model = $('#nodata_model').html();   //无人上榜模板

				this.dtb_top_model = $('#dtb_top_model').html(); //答题榜榜首模板
				this.dtb_list_model = $('#dtb_list_model').html(); //答题榜列表模板
				this.dtb_top_container = $('.rank0 .rank_list_title');     //答题榜榜首容器
				this.dtb_list_container = $('.rank0 .level');               //答题榜列表容器

				this.hyb_top_model = $('#hyb_top_model').html();
				this.hyb_list_model = $('#hyb_list_model').html();
				this.hyb_top_container = $('.rank1 .rank_list_title');
				this.hyb_list_container = $('.rank1 .level');

				this.qfb_top_model = $('#qfb_top_model').html();
				this.qfb_list_model = $('#qfb_list_model').html();
				this.qfb_top_container = $('.rank2 .rank_list_title');
				this.qfb_list_container = $('.rank2 .level');

                this.rank_type_radiu = $('.rank_type_radiu');   //跳转到科室
                this.gjld = false;

                this.list_grou_item = $('.list-group-item');

				this.get_time_style = $('.get_time_style'); //查询方式
				this.seled_month  = $('#seled_month');      //限定的月份
				this.seled_week= $('.seled_week');           //选定的星期

				this.parts_list = $('.parts_list');
				this.parts_list_model = $('#parts_list').html();         //实验室列表模板
				this.parts_list_container = $('.parts_list ul');         //实验室列表容器
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
                                if(datas.length<2 || especial_public){
                                    option.xAxis[0].axisLabel.rotate = 0;
                                    option.grid.bottom = '20%';
                                }
								var part_list = [];
								var doString = '';
								for(var i=0; i<datas.length; i++){
									if(datas[i].parentId == company_id){
										var dictionary = datas[i];
										part_list.push(datas[i]);
										partname.push(datas[i].name);
										doString += that.comPile(that.parts_list_model,dictionary);
									}
								}

								that.parts_name_list = part_list;
								that.parts_list_container.html(doString);

								if(!ret.JGLD){
									that.parts_list.remove();
									$('.low_title1').html('答题榜 - '+part_list[0].name);
									$('.low_title1').next('span').html('更多 ﹥');
									$('.low_title2').html('活跃榜 - '+part_list[0].name);
									$('.low_title2').next('span').html('更多 ﹥');
									$('.low_title3').html('勤奋榜 - '+part_list[0].name);
									$('.low_title3').next('span').html('更多 ﹥');
								}
							}else{
								alert('网络连接失败');
							}

						}
					})
				};

				goPart = function(ids){
					var dtype = that.get_time_style.val();
					var time = '';
					if(dtype == 1){
						time = that.seled_month.html();
						window.location.href='usTeamPart.html?ranktype=1&partid='+ids+'&dtype=1&date='+time;
					}else if(dtype == 2){
						time = that.seled_week.html();
						window.location.href='usTeamPart.html?ranktype=1&partid='+ids+'&dtype=2&date='+time;
					}

				};

				this.loadUserFun = function(datajson){
        			$.ajax({
						url: urlpath+'/user/team/countList.jhtml',
						type: "GET",
						data:(datajson || ''),
						success:function(t){
							//console.log(t);
							var dtype = '';
							var date ='';
							if(datajson.yearweek){
								dtype = 2;
								date = $('.seled_week').html();
							}else if(datajson.month){
								dtype = 1;
								date = datajson.month;
							}

							if(t.success){
							    that.jgld = t.JGLD;
								var default_photo = '${ctxStatic}/images/userphoto.jpg';
								//答题榜
								var dtb_rank = t.DTB;
								var dtbTopString = ' ';
								var dtbListString = ' ';
								var dtb_rank_length = dtb_rank.length >= 5 ? 5 : dtb_rank.length;

								if(dtb_rank_length>0){
									for (var i = 0; i < dtb_rank_length; i++) {
										var dictionary = dtb_rank[i];
										if(!dictionary.photo){
											dictionary.photo = default_photo;
										}
										dictionary.date = date;
										dictionary.dtype = dtype;

										if(dictionary.do_num != 0 ){
											dictionary.zql = (dictionary.do_oknum/dictionary.do_num)*100;
											dictionary.zql = dictionary.zql.toFixed(2);
										}else{
											dictionary.zql = 0;
										}
										dictionary.index = i+1;
										dictionary.typeid = 1;

                                        if(i == 0){
                                            dtbListString += that.comPile(that.dtb_top_model,dictionary);
                                        }else{
                                            dtbListString += that.comPile(that.dtb_list_model,dictionary);
                                        }


									}
									//tbTopString = that.comPile(that.dtb_top_model,dtb_rank[0]);
								}else{
									dtbListString = that.nodata_model;
									//dtbTopString = that.nodata_model;
								}
								//that.dtb_top_container.html(dtbTopString);
								that.dtb_list_container.html(dtbListString);

								//活跃榜
								var hyb_rank = t.HYB;
								var hybTopString = ' ';
								var hybListString = ' ';
								var hyb_rank_length = hyb_rank.length >= 5 ? 5 : hyb_rank.length;

								if(hyb_rank_length >0 ){
									for (var i = 0; i < hyb_rank_length; i++) {
										var dictionary = hyb_rank[i];
										if(!dictionary.photo){
											dictionary.photo = default_photo;
										}
										dictionary.date = date;
										dictionary.dtype = dtype;

										dictionary.index = i+1;
										dictionary.typeid = 2;

                                        if(i == 0){
                                            hybListString += that.comPile(that.hyb_top_model,dictionary);
                                        }else{
                                            hybListString += that.comPile(that.hyb_list_model,dictionary);
                                        }
									}
									//hybTopString = that.comPile(that.hyb_top_model,hyb_rank[0]);
								}else{
									hybListString = that.nodata_model;
									//hybTopString = that.nodata_model;
								}
								//that.hyb_top_container.html(hybTopString);
								that.hyb_list_container.html(hybListString);

								//勤奋榜
								var qfb_rank = t.QFB;
								var qfbTopString = ' ';
								var qfbListString = ' ';
								var qfb_rank_length = qfb_rank.length >= 5 ? 5 : qfb_rank.length;

								if(qfb_rank_length>0){
									for (var i = 0; i < qfb_rank_length; i++) {
										var dictionary = qfb_rank[i];
										if(!dictionary.photo){
											dictionary.photo = default_photo;
										}

										if(!dictionary.kshs) dictionary.kshs = 0;
										if(!dictionary.lxhs) dictionary.lxhs = 0;
										if(!dictionary.play_nums) dictionary.play_nums = 0;

										dictionary.date = date;
										dictionary.dtype = dtype;

										dictionary.totalhs = dictionary.kshs + dictionary.lxhs + dictionary.play_nums;
										dictionary.index = i+1;
										dictionary.typeid = 3;

                                        if(i == 0){
                                            qfbListString = that.comPile(that.qfb_top_model,dictionary);
                                        }else{
                                            qfbListString += that.comPile(that.qfb_list_model,dictionary);
                                        }

									}

								}else{
									qfbListString = that.nodata_model;
									//qfbTopString = that.nodata_model;
								}
								//that.qfb_top_container.html(qfbTopString);
								that.qfb_list_container.html(qfbListString);

                                that.countPartDate(t);

                            }
						}
					});

        			
        		};

        		this.countPartDate = function(json){
                    //console.log(json);
                    var dtb = json.DTB;
                    var hyb = json.HYB;
                    var qfb = json.QFB;

					var parts_datas = that.parts_name_list;

					var datas = [];
                    //var name = [];
                    //var nameJson = [];

                    //partname = [];
                    partdtb = [];
                    parthyb = [];
                    partqfb = [];

                    $('#main_chart').removeClass('no_data');

                    if(dtb.length > 0){
                        for(var i=0; i<dtb.length; i++){
                            datas.push(dtb[i]);
                        }
                    }
                    if(hyb.length > 0){
                        for(var i=0; i<hyb.length; i++){
                            datas.push(hyb[i]);
                        }
                    }
                    if(qfb.length > 0){
                        for(var i=0; i<qfb.length; i++){
                            datas.push(qfb[i]);
                        }
                    }

					//判断如果没有可是则显示无数据
					if(!parts_datas || parts_datas.length <= 0){
						myChart.clear();
                        $('#main_chart').addClass('no_data');
						return;
					}

					//有科室的情况先，判断有没有上榜数据，如果没有上榜数据，则每个科室的榜单都是0；
					if(datas.length >0 ){
						for( j=0; j<parts_datas.length; j++){
							var adddtb = 0;
							var addhyb = 0;
							var addqfb = 0;

							var hasdatas = false;

							for(var i=0; i<datas.length; i++){
								if(!datas[i].do_num){
									datas[i].do_num = 0;
								}
								if(!datas[i].qa_num){
									datas[i].qa_num = 0;
								}
								if(!datas[i].totalhs){
									datas[i].totalhs = 0;
								}

								if(datas[i].hid == parts_datas[j].id){
									hasdatas = true;
									adddtb = adddtb + datas[i].do_num;
									addhyb = addhyb + datas[i].qa_num;
									addqfb = addqfb + parseFloat((datas[i].totalhs/60).toFixed(2));
								}

							}

							if(!hasdatas){
								partdtb.push(0);
								parthyb.push(0);
								partqfb.push(0);
							}else{
								partdtb.push(adddtb);
								parthyb.push(addhyb);
								partqfb.push(addqfb);
							}

						}


					}else{

						for(var i=0; i<parts_datas.length; i++){
							partdtb.push(0);
                            parthyb.push(0);
                            partqfb.push(0);
						}


					}


					option.xAxis[0].data = partname;
					option.series[0].data = partdtb;
					option.series[1].data = parthyb;
					option.series[2].data = partqfb;
					if (option && typeof option === "object") {
						myChart.setOption(option, true);
					}

				};


                this.unique = function (arr) {
                    var result = [], hash = {};
                    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
                        if (!hash[elem.id]) {
                            result.push(elem);
                            hash[elem.id] = true;
                        }
                    }
                    return result;
                };

				//在移动端切换榜单
				this.switchRankFun = function () {
					var is_index = $(this).parent('div').index();
					//that.switch_rank_btn.removeClass('action');
					//$(this).addClass('action');
					$('.rank_list .col-md-4').hide();
					$('.rank_list .col-md-4').eq(is_index).fadeIn();
				};

                this.moreRankFun = function(){
                    var rankid = $(this).data('rankid');

					var datestyle = that.get_time_style.val();
					var ismonth = that.seled_month.html();
					var isweek = that.seled_week.html();

					if(datestyle == 1){
						if(that.jgld){
							that.jumpPageFun(rankid,'usTeamList.html',1,ismonth)
						}else{
							that.jumpPageFun(rankid,'usTeamPart.html',1,ismonth)
						}
					}else if(datestyle == 2){
						if(that.jgld){
							that.jumpPageFun(rankid,'usTeamList.html',2,isweek)
						}else{
							that.jumpPageFun(rankid,'usTeamPart.html',2,isweek)
						}
					}
                };

                this.jumpPageFun = function(num , url, dtype, date){
                    switch(num)
                    {
                        case 1:
                            window.location.href= url+'?ranktype=1&dtype='+dtype+'&date='+date;
                            break;
                        case 2:
                            window.location.href= url+'?ranktype=2&dtype='+dtype+'&date='+date;
                            break;
                        case 3:
                            window.location.href= url+'?ranktype=3&dtype='+dtype+'&date='+date;
                            break
                    }
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
					this.getPartBody();

					this.rank_type_radiu.off('click').on('click',this.switchRankFun);
                    this.list_grou_item.off('click').on('click',this.moreRankFun);
        		}
        	};
        	var usTeam = new usTeamFun;
        	usTeam.init();
			calendar.init();
        })

    </script>
</body>
</html>