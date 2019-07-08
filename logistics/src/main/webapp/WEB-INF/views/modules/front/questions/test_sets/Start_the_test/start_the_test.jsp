<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<title>地理云课堂</title>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/start_the_test/start_the_test.css${v}" />
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
		<!--表头引用-->
		<!--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />-->
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/My97DatePicker/WdatePicker.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

	</head>

	<body>
		<div id="divheader"></div>
		<div id="div">
			<div>

				<div class="one" ></div>

				<div class="set_container">
					<div class="div2">
						<span>选择考试人员：</span>
						<span id="spanall" class="one2" onclick="startTheTest.spanAll(this);">所有人员</span>
						<span class="one3" onclick="startTheTest.clearAll()">全部清除</span>
						<span class="show_list"><i class="fa fa-list-ul" aria-hidden="true"></i></span>
					</div>
					<div class="div1">
						<div class="pos_put div1_title">
							试卷信息
						</div>
						<div class="div1_cont">
							<span class="pos_put">
								<span style="float: left;">试卷名称：</span><span id="divName" style="display: block;width: 195px;line-height: 24px;float: right;padding-top: 11px;"></span>
							</span>
							<span class="pos_put" style="clear:both;">
								试题数量：<span id="txtTotalScore"></span>
							</span>
							<span class="pos_put">
								试题数量：<span id="txtCount"></span>
							</span>
							<span class="pos_put">
								考试时间：<span id="txtDuration"></span>分钟
							</span>
						</div>
						<div class="pos_put div1_title">
							试卷设置
						</div>
						<div class="div1_cont">
							<span class="pos_put">
								<span>考试类型：</span>
								<input type="radio" name="linepaper" checked="checked" value="0" id="linepaper1"/> <label for="linepaper1">线上考试</label>
								<input type="radio" name="linepaper" value="1"  id="linepaper2"/> <label for="linepaper2">线下考试</label>
							</span>
							<span>
								<span>开考时间：</span>
							<%--<input type="text" class="style1" id="txtStarttime" onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="" />--%>
								<input type="text" class="style1" id="txtStarttime" onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss',onpicking: cDayFunc});" value="" />
							</span>
							<span>
								<span>结束时间：</span>
							<input type="text" class="style1" id="txtEndtime" onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="" />
							</span>
							<span class="put_time">
								<span>成绩公布：</span>
							<input type="text" class="style1" id="txtShowtime" onfocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="" />
							</span>

							<span class="pos_put put_time">
								<span>答题方式：</span>
								<input type="radio" name="showmode" id="showmode_list" checked="checked" value="1" /> 列表
								<input type="radio" name="showmode" id="showmode_one" value="2" /> 逐一
							</span>
							<span class="iskey pos_put put_time">
								<input type="checkbox" id="ckbShowkey" value="" checked="checked"/>
									是否公布答案、解析
							</span>
							<%--<span class="iskey">--%>
								<%--<input type="checkbox" id="line_paper" value=""/>--%>
									<%--线下考试--%>
							<%--</span>--%>

							<div class="div5">
								<!--<span><a href="javascript:;">重新选择</a></span>-->
								<span class="active"  onclick="startTheTest.start();"><a href="javascript:;">发起考试</a></span>
							</div>
						</div>
					</div>
					<div id="divOffices" class="pos_put" style="">

					</div>
					<div class="offices_list">
						<div class="offices_list_title">部门列表 <i class="fa fa-angle-double-right hide_list" aria-hidden="true"></i></div>
						<ul class="offices_list_container">

						</ul>
					</div>
				</div>

				<input type="hidden" id="hidid" name="id" />
				<input type="hidden" id="hidAllOffices" />
				<input type="hidden" id="hidAllUsers" />
				<input type="hidden" id="hidPassScore" />
				<input type="hidden" id="hidOrderType" />
				<input type="hidden" id="hidPaperType" />
				<input type="hidden" id="hidRemark" />
				<input type="hidden" id="hidCid" />
				<input type="hidden" id="hidState" />

				<%--<div class="div5">--%>
					<%--<!--<span><a href="javascript:;">重新选择</a></span>-->--%>
					<%--<span class="active"  onclick="startTheTest.start();"><a href="javascript:;">发起考试</a></span>--%>
				<%--</div>--%>
			</div>
		</div>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/Start_the_test/start_the_test.js${v}"></script>
		<script>
			$(function () {
				var putpapertime = function(){
					var that = this;
					var during = $('#txtDuration').html();

					this.countTime = function(days){
						var is_timestamp = formatDate(days,1).replace(/-/g,"/");
						var timestamp2 = Date.parse(is_timestamp);
						days = new Date(timestamp2 + during * 60 * 1000);
						return days;
					};

					function double(num) {
						if (num < 10) {
							num = '0' + num;
						}
						return num;
					}

					function formatDate(nows,over) {
						var now = new Date(nows);
						var year = now.getFullYear();
						var month = now.getMonth() + 1;
						var date = now.getDate();

						now.setDate(now.getDate()+1);
						var dated = now.getDate();

						var hour = now.getHours();
						var minute = now.getMinutes();
						var second = now.getSeconds();
						if(over == 1){
							return year + "-" + double(month) + "-" + double(date) + " " + double(hour) + ":" + double(minute) + ":" + double(second);
						}else if(over == 2){
							return year + "-" + double(month) + "-" + double(dated) + " 00:00:00";
						}else{
							return year + "-" + double(month) + "-" + double(date) + " 00:00:00";
						}
					}

					var timestamp = new Date().getTime();

					var day = new Date(timestamp);
					// var dayt = new Date(timestamp + during * 60 * 1000);
					var dayt = formatDate(that.countTime(day),1);
					$('#txtStarttime').val(formatDate(day));
					$('#txtEndtime').val(formatDate(that.countTime($('#txtStarttime').val().replace(/-/g,"/")),1));
					$('#txtShowtime').val(formatDate(day,2));

					cDayFunc = function(dp){
						var newbengin = dp.cal.getNewDateStr().replace(/-/g,"/");
						$('#txtEndtime').val(formatDate(that.countTime(newbengin),1));
						$('#txtShowtime').val(formatDate(that.countTime(newbengin),2));
					};

					this.init = function(){

					};
				};

				var putPaperTime = new putpapertime;
				putPaperTime.init();
			});
		</script>
	</body>

</html>
