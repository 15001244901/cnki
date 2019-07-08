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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/create_test_paper/edit_item_page/edit_item_page_next.css${v}" />
		<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<!--<link rel="stylesheet" type="text/css" href="../../../../css/questions/test_sets/start_the_test/Grading_papers_detail_bo.css" />-->
		<style type="text/css">
			* {
				moz-user-select: -moz-none;
				-moz-user-select: none;
				-o-user-select: none;
				-khtml-user-select: none;
				-webkit-user-select: none;
				-ms-user-select: none;
				user-select: none;
			}
			.two1>p{
				width: 775px;;
				display:inline-block;
			}
		</style>

	</head>

	<body>
		<div id="divheader"></div>
		<div id="div">
			
			<div>
				<form id="form">
					<div class="left">
						<div class="item_infor">
							<p class="ess_infor_title"><span class="fl">试卷信息</span> <pan class="fr ess_up">收起</pan></p>
							<ul class="information">
								<span>规定时长： <input id="txtDuration" name="duration" type="text" disabled/></span>
								<span>卷面总分： <input id="txtTotalScore" name="totalscore" type="text" disabled/></span>
								<span>及格分数： <input id="txtPassScore" name="passscore" type="text" disabled/></span>
							</ul>
							
						</div>
						<div class="item_infor">
							<p class="ess_infor_title"><span class="fl">试题统计</span> <pan class="fr ess_up">收起</pan></p>
							<ul class="" id="questionCard1">

								
							</ul>
						</div>

					</div>
					<div id="infor_list">
						<div id="divName"></div>
					</div>
					<div class="right" id="divContent" style="overflow: visible;">
						
						<div class="div2">

						</div>
					</div>
					<div id="left_hide">展开信息</div>
					<div id="divsetter" style="z-index: 999;"></div>
					<input type="hidden" id="hidID" name="id" />
					<input type="hidden" id="hidName" name="name" />
					<input type="hidden" name="starttime" />
					<input type="hidden" name="endtime" />
					<input type="hidden" name="showtime" />
					<input type="hidden" id="hidOrderType" name="ordertype" />
					<input type="hidden" id="hidPaperType" name="papertype" />
					<input type="hidden" name="remark" />
				</form>
			</div>
			
		</div>
		<div style="clear: both;"></div>
		<input type="hidden" id="question_style_now" />
		<div id="next_adr">
			<span onclick="history.back();">返回列表</span>
		</div>

	</body>

	<!--单独设置得分-->
	<%--<div id="alert_layer">--%>
	    <%--<form action="javascript:;" id="dialog-score-form">--%>
	        <%--<p><label>该题：</label><input id="alert_score" value="5" name="score" type="text"> 分</p>--%>
	    <%--</form>--%>
	<%--</div>--%>
	<!--批量设置得分-->
	<%--<div id="alert_layers">--%>
	    <%--<form action="javascript:;" id="dialog-score-form">--%>
	        <%--<p><label>每题：</label><input id="alert_scores" value="5" name="score" type="text"> 分</p>--%>
	    <%--</form>--%>
	<%--</div>--%>

    <%--试题种类数据模板--%>
    <script type="text/template" id="que_style_1">
        <div class="div2" id="style-1">
            <div class="one1">一、单选&nbsp;&nbsp;&nbsp; <span class="one1_remark">每题0分 </span>
                <div class="p_section">
                    <input type="hidden" name="p_section_names" value="单选">
                    <input type="hidden" name="p_section_ids" value="1">
                    <input type="hidden" name="p_section_remarks" value="每题0分"> </div>
                <div class="get_class_set">
                    <span class="add_tis add_example" onclick="gradingPaperDetail.addSet('2')">加题</span>
                    <span class="de_fens" onclick="gradingPaperDetail.alertScodes('2','是非')">批量设置得分</span>
                </div>
            </div>

        </div>
    </script>
	
</html>

<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/edit_item_page/edit_item_page_next_over.js${v}"></script>