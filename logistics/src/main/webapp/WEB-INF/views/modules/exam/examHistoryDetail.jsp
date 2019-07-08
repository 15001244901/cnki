<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!doctype html>
<html>
<head>
	<title>批改试卷</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />

	<style>
		.div-key-container{margin:5px 25px; border:dotted 1px #ddd; padding:5px;}
		.div-key-container span{font-weight:bold}
		.div-score-maker{margin-top:5px;; text-align:center}
		.tm_user_score{background:#eee}

		.tm_qks{font-size:14px; text-decoration:underline; color:#00a; display:block; line-height:30px; font-weight:bold}
		.tm_qks:hover{background:#fff}
		
		#divsetter{position:absolute;border:none; padding:3px; display:none; }
		.tm_lnk_score{display:block; float:left; padding:2px; border:solid 1px #f00; margin-right:2px; margin-bottom:2px; 
			width:17px; height:17px; text-align:center; text-decoration:none; background:#fff}
		.tm_lnk_score:hover{ background:#f00; color:#fff; font-weight:bold}

		.tm_question_tools{list-style:none; padding:0; margin:0; }
		.tm_question_tools li{list-style:none; padding:0; margin:0; width:40px; float:left; background:#eee; text-align:center; height:35px}
		.tm_question_tools li img{margin-top:8px;}
		.tm_question_tools li span{line-height:30px;margin:2px 2px 0 0; display:block}

	</style>

	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>
    
	<script type="text/javascript">

		var tm_pid = "${paper.id}";


		$(document).ready(function() {

//			$('.questionContent').each(function(i,e){
//				$(e).html($(e).html().replace(/\[BlankArea[A-Za-z0-9]+\]/g,'<u style="letter-spacing:60px;">&nbsp;</u>'));
//			});

			tmUserPaper.initPaper();
			$(".tm_paper_section h1").click(function(){
				$(this).parent().children(".tm_paper_question").toggle();
			});
			tm_resetPosition();

			//隐藏小操作面板
			$("body").click(function(){
				$("#divsetter").hide();
			});

			$("#div_processor").css("top", "20px");
		});

		function tm_resetPosition(){
			var nw = $(".tm_paper_head").width() + 45;
			$("#div_processor").css("left",nw + "px");
		}

		$(window).resize(function(){
			tm_resetPosition();
		});
		 
		$(window).scroll(function(){
			/**
			var tp = $(window).scrollTop();
			if(tp > 240){
				$("#div_processor").css("top", "20px");
			}else{
				var ntp = 240 - tp;
				$("#div_processor").css("top", ntp + "px");
			}
			**/
		});
	
		
		var tmUserPaper = {
			initPaper : function(){
				//追加导航按钮
				var html = [];
				$(".span-quick-nav").each(function(idx, itm){
					var question_id = $(this).data("id");
					var nid = idx + 1;
					var thetop = $(this).offset().top;

					html.push('<a href="javascript:;" id="fast_'+question_id+'"');
					html.push(' onclick="javascript:tmUserPaper.moveToQuestion('+thetop+')" ');
					html.push('>' + nid + '</a>');
				});
				$("#div_processor_fastto").html(html.join(""));
				
				
			},


			moveToQuestion : function(thetop){
				$("html:not(:animated),body:not(:animated)").animate({ scrollTop: thetop}, 500);
			}
		};


		function tm_buildSetter(eid, qid, score, obj){
			var offset = $(obj).offset();
			var the_top = offset.top + 30;
			var the_left = offset.left - 5;

			var btns = '';
			for(var i=0; i<=eval(score); i++){
				btns += '<a href="javascript:;" onclick="tm_setScore(\''+eid+'\',\''+qid+'\','+i+');" class="tm_lnk_score">'+i+'</a> ';
			}
			
			$("#divsetter").css("width","100px");
			$("#divsetter").css("height","auto");
			$("#divsetter").css("top",the_top+"px");
			$("#divsetter").css("left",the_left+"px");
			$("#divsetter").html(btns);
			$("#divsetter").show();
		}
		
		function tm_setScore(eid, qid, score){
			$.ajax({
				type: "POST",
				url: "${ctx}/exam/examHistory/check",
				data: {"eid":eid, "qid":qid, "score":score, "t":Math.random()},
				dataType: "json",
				success: function(ret){
					if("ok" == ret["code"]){
						var current_obj = $(".tm_qks[qid="+qid+"]");
						var old_score = current_obj.text();
						var total_score = $("#tm_span_score").text();
						var new_score = eval(total_score - old_score + score);

						current_obj.html(score);
						$("#tm_span_score").html(new_score);

						alert('操作成功');

					}else{
						alert('系统忙，请稍后再试');
					}
				},
				error:function(){
					alert('系统忙，请稍后再试');
				}
			}); 
		}

		function tm_closeDetail(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index); 
		}
		
	</script>
  </head>
  
<body>

	<div class="tm_main">
        
        <div class="tm_container">

			<table border="0" width="100%" cellpadding="0" style="min-width:860px;">
				<tr>
					<!-- left -->
					<td valign="top">
                    	<div class="tm_paper">
                            <div class="tm_paper_head">
                                <h1>${paper.name}</h1>
								<h2 style="background:#ddd; padding:5px 0; font-size:14px; font-weight:bold">
									试卷信息
								</h2>
                                <h2>
									<b>时间设定</b> :
									<fmt:formatDate value="${paper.starttime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /> -- 
									<fmt:formatDate value="${paper.endtime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /> 

									&nbsp;&nbsp;
									<b>考试时长</b> : ${paper.duration} <tomtag:Message key="txt.other.units.minute" />
									
								</h2>
								<h2>
									<b>卷面总分</b> : ${paper.totalscore}
									&nbsp;&nbsp;
									<b>及格分数</b> : ${paper.passscore}
								</h2>
								<h2 style="background:#ddd; padding:5px 0; font-size:14px; font-weight:bold">
									考生信息
								</h2>
								<h2>
									<b>考生</b> : ${user.loginName} (${user.name})

									&nbsp;&nbsp;
									<b>考生编号</b> : ${user.no}
								</h2>
								<h2>
									<b>开考时间</b> :
									<fmt:formatDate value="${detail.starttime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
									
									&nbsp;&nbsp;
									<b>交卷时间</b> :
									<fmt:formatDate value="${detail.endtime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
									
									&nbsp;&nbsp;
									<b>耗时(分钟)</b> :
									<c:set var="interval" value="${detail.endtime.time - detail.starttime.time}" />
									<fmt:formatNumber value= "${interval/1000/60}" pattern= "#0" />
									分钟
									
									&nbsp;&nbsp;
									<b>得分</b> : <span id="tm_span_score">${detail.score}</span>
								</h2>
                            </div>

                            <div class="tm_paper_body">
								
								<c:set value="0" var="varQuestionId"/>

                            	<c:forEach var="section" items="${paper.sections}">
                            	<div class="tm_paper_section">
                                	<h1>${section.name}</h1>
                                    <h2>${section.remark}</h2>
                                    
                                    <c:forEach var="question" items="${section.questions}">
									<c:set var="v_questionid" value="Q-${question.id}" />
									<c:set var="varQuestionId" value="${varQuestionId+1}"></c:set>
									<span class="span-quick-nav" data-qid="${question.id}"></span>

                                    <table border="0" cellpadding="0" cellspacing="0" class="tm_paper_question" style="table-layout:fixed;">
                                    	<thead>
                                        	<tr>
                                            	<th valign="top" class="tm_question_lineheight"><cite>${varQuestionId}</cite></th>
                                                <td class="tm_question_lineheight">
													<c:choose>
														<c:when test="${question.QType == 4}">
                                                            ${fns:formatBlanks(question.QContent," ________ " , "\\[BlankArea.+?]")}
														</c:when>
														<c:otherwise>   
															${question.QContent}
														</c:otherwise> 
													</c:choose>
												</td>
												<td width="85" valign="top">
													<ul class="tm_question_tools">
														<li>
															<c:choose>
															<c:when test="${question.QType == '5'}">
																<img src='${ctxStatic}/hsun/ywork/images/help.png' width='20' />
															</c:when>
															<c:otherwise>   
																<c:choose>
																	<c:when test="${check[v_questionid] > 0}">
																		<img src='${ctxStatic}/hsun/ywork/images/success.png' width='20' />
																	</c:when>
																	<c:otherwise>
																		<img src='${ctxStatic}/hsun/ywork/images/error.png' width='20' />
																	</c:otherwise> 
																</c:choose>
															</c:otherwise> 
														</c:choose>
														</li>
														<li>
															<span><a href="javascript:void(0);" class="tm_qks" qid="${v_questionid}" onmouseover="tm_buildSetter('${detail.id}', '${v_questionid}', '${question.QScore}', this);">${check[v_questionid]}</a></span>
														</li>
													</ul>
												</td>

                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<tr>
                                            	<td colspan="3">
													<c:choose>
														<c:when test="${question.QType == '1'}">
															<ul>
															<c:forEach var="option" items="${question.options}">
																<li><label>${option.alisa} . ${option.text}</label></li>
															</c:forEach>
															</ul>
															<div class="div-key-container">
																<span>标准答案 :</span> ${question.QKey}
															</div>
														</c:when>

														<c:when test="${question.QType == '2'}">
															<ul>
															<c:forEach var="option" items="${question.options}">
																<li><label>${option.alisa} . ${option.text}</label></li>
															</c:forEach>
															</ul>
															<div class="div-key-container">
																<span>标准答案 :</span> ${question.QKey}
															</div>
														</c:when>

														<c:when test="${question.QType == '3'}">
															<div class="div-key-container">
																<span>标准答案 :</span> ${question.QKey eq 'Y'?'正确':'错误'}
															</div>
														</c:when>

														<c:when test="${question.QType == '4'}">
															<div class="div-key-container">
																<span>标准答案 :</span>
																<c:forEach var="blank" items="${question.blanks}">
																${blank.value}
																</c:forEach>
															</div>
														</c:when>

														<c:when test="${question.QType == '5'}">
															<div class="div-key-container">
																<span>标准答案 :</span> ${question.QKey}
															</div>
														</c:when>
													</c:choose>

													<div class="div-key-container tm_userkey">
														<span>考生答案 :</span>

														<c:choose>
															<c:when test="${question.QType == '2'}">
																${fn:replace(data[v_questionid], '`', '')}
															</c:when>
															<c:when test="${question.QType == '3'}">
																${data[v_questionid] eq 'Y'?'正确':'错误'}
															</c:when>
															<c:when test="${question.QType == '4'}">
																${fn:replace(data[v_questionid], '`', ' ')}
															</c:when>
															<c:otherwise>
																${data[v_questionid]}
															</c:otherwise> 
														</c:choose>

													</div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    </c:forEach>
                                    
                                </div>
                                </c:forEach>
                                
                            </div>
                            <!-- /tm_paper_body -->
                            
                            <div class="tm_adm_paper_foot">
								<button class="tm_btn tm_btn_primary" type="button" onclick="history.go(-1)">返回</button>
                            </div>


                        </div>
					</td><!-- /left -->

					<td width="10">&nbsp;</td>

					<!--  right-->
					<td width="220" valign="top">
						
					</td>
					<!--  /right-->
				</tr>
			</table>

        	
			
        </div>
        
        
    </div>


	<div id="div_processor">
		<div id="div_processor_timer" style="margin-top:5px;"></div>
		<div id="div_processor_fastto"></div>
		<div id="div_processor_ops">
			<button class="tm_btn tm_btn_primary" type="button" onclick="tm_closeDetail()">关闭</button>
		</div>
	</div>

	<div id="divsetter"></div>


</body>
</html>
