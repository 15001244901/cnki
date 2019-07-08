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

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/downPaper/down_paper.css${v}" />
		<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<%--<style type="text/css">--%>
			<%--.paper_adjust li .icona-check{--%>
				<%--padding:7px 10px 8px;--%>
				<%--background: url(${ctxStatic}/hsun/front/img/edit_item_random_two/selbg1.png) no-repeat left center;--%>
			<%--}--%>
			<%--.paper_adjust li .check .icona-check{--%>
				<%--background: url(${ctxStatic}/hsun/front/img/edit_item_random_two/selbg2.png) no-repeat left center;--%>
			<%--}--%>
		<%--</style>--%>
		<script type="text/javascript">
			var ctx_addr = '<%=ctx_addr%>';
		</script>
	</head>

	<body>
		<div id="divheader"></div>
		<div id="div">
			
			<div>
				<form id="form">
					<div class="left">
						<div class="item_infor">
							<p class="ess_infor_title"><span class="fl">试卷结构调整</span> <pan class="fr ess_up">收起</pan></p>
							<ul class="paper_adjust">
								<%--<li>--%>
									<%--<span class="" data-class="editcon-silder">--%>
										<%--<i class="icona-check"></i>--%>
										<%--<input name="" value="1" style="display: none;" type="checkbox">--%>
										<%--密封线--%>
									<%--</span>--%>
								<%--</li>--%>
								<li>
									<span class="" data-class="class_scord">
										<i class="icona-check"></i>
										大题评分区
									</span>
								</li>
								<li>
									<span class="check" data-class="paperName">
										<i class="icona-check"></i>
										主标题
									</span>
								</li>
								<li>
									<span class="check" data-class="paper_rule">
										<i class="icona-check"></i>
										注意事项
									</span>
								</li>
								<li>
									<span class="check" data-class="paper_title_name">
										<i class="icona-check"></i>
										副标题
									</span>
								</li>
								<li>
									<span class="check" data-class="exam_time">
										<i class="icona-check"></i>
										考试时间
									</span>
								</li>
								<li>
									<span class="check" data-class="stu_write">
										<i class="icona-check"></i>
										考生填写
									</span>
								</li>
								<li>
									<span class="check" data-class="one1">
										<i class="icona-check"></i>
										分大题
									</span>
								<li>
									<span class="check" data-class="paper_score">
										<i class="icona-check"></i>
										总评分
									</span>
								</li>
								<li>
									<span class="check" data-class="one1_remark">
										<i class="icona-check"></i>
										大题注释
									</span>
								</li>
								<%--<li>--%>
									<%--<span class="down_paper_key">--%>
										<%--<i class="icona-check"></i>--%>
										<%--答案--%>
									<%--</span>--%>
								<%--</li>--%>

							</ul>
						</div>
						<div class="item_infor">
							<p class="ess_infor_title"><span class="fl">试题统计</span> <pan class="fr ess_up">收起</pan></p>
							<ul class="" id="questionCard1">

								
							</ul>
							<div id="next_adr">
								<span onclick="window.location.href='../questions/test_sets/text_sets.html';">返回列表</span>
								<span onclick="gradingPaperDetail.showPaperSize();">下载试卷</span>
								<span onclick="gradingPaperDetail.downPaperAnswer();" style="margin-right: 0;">下载答案</span>
							</div>
						</div>

					</div>

					<div class="paper_right">
                        <table cellpadding="0" cellspacing="0" style="font-family: '微软雅黑';width: 100%;">
                            <tr>
                                <%--<td class="editcon-silder" style="display: none;width: 50px;height:100%;background:url(${ctxStatic}/hsun/front/img/editing.png) no-repeat scroll 20px 180px;border-right:1px dashed #dcdcdc;"></td>--%>
                                <td class="paper_cont" style="padding-left:10px;">
                                    <%--试卷头部信息--%>
                                    <div id="infor_list" style="margin-top:20px;min-height:60px;overflow:hidden;text-align:center;">
                                        <div id="divName" class="paperName"></div>
										<input class="paper_name" type="text" value="">
										<br>
										<div class="paper_title_name">副标题</div>
										<input class="reset_paper_title_name" type="text" value="副标题">
										<div class="exam_time" style="font-size:14px;padding:10px 0;">
                                            考试时间：<span class="reset_paper_time">* *</span>分钟 &nbsp;&nbsp;&nbsp;
                                            满分：<span class="reset_paper_resord">* * </span>分
                                        </div>
                                        <div class="stu_write" style="font-size:14px;padding:10px 0 0;margin-bottom:20px;">
                                            姓名：<span style="vertical-align: bottom">_________________</span> &nbsp;&nbsp;&nbsp;
                                            部门：<span style="">_________________</span> &nbsp;&nbsp;&nbsp;
                                            考号：<span style="">_________________</span>
                                        </div>
                                        <table class="paper_score" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                                            <tr class="paper_score_title" >
                                                <%--<th>题号</th>--%>
                                                <%--<td>一</td>--%>
                                                <%--<td>二</td>--%>
                                                <%--<td>一</td>--%>
                                                <%--<td>二</td>--%>
                                                <%--<td>一</td>--%>
                                                <%--<td>二</td>--%>
                                                <%--<td>总分</td>--%>
                                            </tr>
                                            <tr class="paper_score_stu">
                                                <%--<th>得分</th>--%>
                                                <%--<td>一</td>--%>
                                                <%--<td>二</td>--%>
                                                <%--<td>一</td>--%>
                                                <%--<td>二</td>--%>
                                                <%--<td>一</td>--%>
                                                <%--<td>二</td>--%>
                                                <%--<td>100</td>--%>
                                            </tr>
                                        </table>
                                        <div class="paper_rule" style="text-align:left;font-size:14px;margin-bottom:15px;color:#333;">
                                            <p style="margin-bottom:0;">* 注意事项：</p>
                                            <div class="reset_title contenteditable" data-edit="notes" style="margin-bottom:0cm;line-height:22.0pt;">
												保持答题卷清洁、不得在答题卷上做任何标记，也不得将答题卷折叠、污损。
                                            </div>
											<textarea class="reset_title_name" style="min-width:300px;min-height:100px;display:none;">保持答题卷清洁、不得在答题卷上做任何标记，也不得将答题卷折叠、污损。
                                            </textarea>
                                        </div>
                                    </div>
                                    <%--试题列表--%>
                                    <div class="right" id="divContent" style="overflow:visible;clear:both;height:auto;padding-top:5px;padding-bottom:20px;">
                                        <div class="exam_list">
                                        </div>
                                    </div>
									<%--试题答案--%>
									<div class="paper_qkey" style="display: none">

									</div>
									<div class="paper_qkey_bei" style="display: none">

									</div>
                                </td>
                            </tr>
                        </table>
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
		<div id="creatPaper" style="display:none" class="creatPaper">
			<div style="margin-top:20px;min-height:60px;overflow:hidden;text-align:center;font-weight:500;font-family:宋体">
				<div class="paperName" style="font-size:18px;font-weight:bold;margin:20px auto 10px;max-width:80%;min-width:200px;text-align:center;"></div>
				<div class="paper_title_name" style="font-size:14px;margin-top:15px;margin-bottom:5px;">副标题</div>
				<div class="exam_time" style="font-size:14px;margin-bottom: 15px;">
					考试时间：<span class="reset_paper_time">* *</span>分钟 &nbsp;&nbsp;&nbsp;
					满分：<span class="reset_paper_resord">* * </span>分
				</div>
				<div class="stu_write" style="font-size:14px;margin-bottom:20px;">
					姓名：<span>_________________</span> &nbsp;
					部门：<span>_________________</span> &nbsp;
					考号：<span>_________________</span>
				</div>
				<table class="paper_score" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
					<tr class="paper_score_title" >
					</tr>
					<tr class="paper_score_stu">
					</tr>
				</table>

				<div class="paper_rule" style="text-align:left;font-size:14px;color:#333;margin-bottom:20px;">
					<p style="line-height:22px;margin-bottom:5px;margin-top:20px;">* 注意事项：</p>
					<div class="reset_title" data-edit="notes" style="margin-bottom:30px;line-height:22px;">
						保持答题卷清洁、不得在答题卷上做任何标记，也不得将答题卷折叠、污损。
					</div>
				</div>
			</div>
			<%--试题列表--%>
			<div id="br" style="display: none"><br><br></div>
			<div class="right" style="font-family: 宋体">
				<div class="exam_list">
				</div>
			</div>
		</div>
		<input type="hidden" id="question_style_now" />

		<%--打印试卷--%>
		<form action="${ctx}/exam/paper/exportWord.jhtml" method="post">
			<input id="down_paper_name" type="hidden" name="name" value="">
			<input id="down_paper_size" type="hidden" name="paperSize" value="a4">
			<input id="down_paper_cont" type="hidden" name="paperHtml" value="">
			<input id="down_paper" style="display: none" type="submit" value="提交">
		</form>
		<%--打印答案--%>
		<form action="${ctx}/exam/paper/exportWord.jhtml" method="post">
			<input id="down_qkey_name" type="hidden" name="name" value="">
			<input id="down_qkey_cont" type="hidden" name="paperHtml" value="">
			<input id="down_qkey" style="display: none" type="submit" value="提交">
		</form>

		<div id="sel_psize">
			<div class="sel_psize">
				<div class="sel_psize_title">
					<span>下载word试卷</span>
					<span class="sel_psize_close">×</span>
				</div>
				<div class="sel_psize_cont">
					<div class="sel_psize_cont_title">
						纸张大小
					</div>
					<ul class="sel_psize_cont_list">
						<li data-size="a4">
							<span class="paper_img size1">
							</span>
							<p><span class="sel_inp has_sel"></span>A4</p>
						</li>
						<li class="two" data-size="a3">
							<span class="paper_img size2">
							</span>
							<p><span class="sel_inp no_sel"></span>A3(双栏)</p>
						</li>
						<li data-size="b4">
							<span class="paper_img size2">
							</span>
							<p><span class="sel_inp no_sel"></span>B4(双栏)</p>
						</li>
					</ul>
					<button class="sel_psize_save" onclick="gradingPaperDetail.downPaper();">确定</button>
				</div>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/downPaper/down_paper.js${v}"></script>