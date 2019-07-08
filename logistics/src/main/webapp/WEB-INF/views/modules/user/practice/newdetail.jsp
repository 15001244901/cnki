<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<!doctype html>
<html>
<head>
	<title>组卷练习</title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>

	<link rel="stylesheet" href="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/css/validationEngine.jquery.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/jquery.validationEngine.js"></script>

	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/languages/jquery.validationEngine-zh_CN.js"></script>

	<style>
		.div-key-container{margin:5px 25px; border:dotted 1px #ddd; padding:5px;}
		.div-key-container span{font-weight:bold}
	</style>
    
	<script type="text/javascript">

		var tm_pid = "${paper.id}";
		var tm_cost_seconds = 0;
		var tm_maxtime = eval("${paper.duration}") * 60;
		var tm_timer = null;


		$(document).ready(function() {
			tmUserPaper.initPaper();
			$(".tm_paper_section h1").click(function(){
				$(this).parent().children(".tm_paper_question").toggle();
			});
			tm_resetPosition();

			//计时器
			tm_timer = setInterval(function(){
				tm_countdown();
			}, 1000);

		});

		function tm_countdown(){
			//记录消耗的时间
			tm_cost_seconds = tm_cost_seconds + 1;
			$("#t_timecost").val(parseInt(tm_cost_seconds/60));

			//倒计时牌
			var tm_msg;
			if(tm_maxtime>0){
				tm_msg = "<span class='tm_label'>"+ tm_fn_formatSeconds(tm_maxtime) + "</span>";
				if(tm_maxtime <= 30){
					var ss = '试卷提交中...';
					tm_msg += "<br/><font color='red'><b>"+ss+"</b></font>";
				}

				$("#div_processor_timer").html(tm_msg);

				if(tm_maxtime == 5*60) {
					alert('注意，还有5分钟!\\n时间结束后，如您没有交卷，试卷将自动提交。');
				}

				--tm_maxtime;

			}else{
				clearInterval(tm_timer);
				$("#div_processor_timer").html('考试时间到，试卷将自动提交!');
				$("form").attr("action","${basectx}/user/practice/submit");
				$("form").submit();
			}
		}


		function tm_resetPosition(){
			var nw = $(".tm_paper_head").width() + 45;
			$("#div_processor").css("left",nw + "px");
		}

		$(window).resize(function(){
			tm_resetPosition();
		});
		 
		$(window).scroll(function(){
			var tp = $(window).scrollTop();
			if(tp > 240){
				$("#div_processor").css("top", "20px");
			}else{
				var ntp = 240 - tp;
				$("#div_processor").css("top", ntp + "px");
			}
		});
	
		
		var tmUserPaper = {
			initPaper : function(){
				//追加导航按钮
				var html = [];
				$(".span-quick-nav").each(function(idx, itm){
					var question_id = $(this).data("qid");
					var nid = idx + 1;
					var thetop = $(this).offset().top;

					html.push('<a href="javascript:;" id="fast_'+question_id+'"');
					html.push(' onclick="javascript:tmUserPaper.moveToQuestion('+thetop+')" ');
					html.push('>' + nid + '</a>');
				});
				$("#div_processor_fastto").html(html.join(""));
				//绑定输入提示
				tmUserPaper.bindQuickTip();
			},
			
			submitPaper : function(){
				var formcheck = $("#form_paper_detail").validationEngine('validate');
				if(formcheck){
					var wcm = window.confirm('确定要提交试卷吗？');
					if(!wcm){
						return;
					}
					
					$(".tm_btn").attr("disabled", true);
					$(".tm_btn").val('试卷提交中...');

					window.onbeforeunload = null;
					
					$("form").attr("action","${basectx}/user/practice/submit");
					$("form").submit();

				}else{
					return false;
				}
				
			},

			moveToQuestion : function(thetop){
				$("html:not(:animated),body:not(:animated)").animate({ scrollTop: thetop}, 500);
			},

			bindQuickTip : function(){
				//选择题绑定
				$(".qk-choice").click(function(){
					var thename = $(this).attr("name");
					var theqid = $(this).data("qid");
					var chval = $('input[name='+thename+']:checked').val();

					if(baseutil.isNull(chval)){
						$("#fast_"+theqid).prop("class","");
					}else{
						$("#fast_"+theqid).prop("class","finished");
					}
				});
				//填空题绑定
				$(".qk-blank").keyup(function(){
					var thename = $(this).attr("name");
					var theqid = $(this).data("qid");
					if(tm_checker_blanker_filled(thename)){
						$("#fast_"+theqid).prop("class","finished");
					}else{
						$("#fast_"+theqid).prop("class","");
					}
				});
				//问答题绑定
				$(".qk-txt").keyup(function(){
					var thename = $(this).attr("name");
					var theqid = $(this).data("qid");
					var chval = $(this).val();
					
					if(baseutil.isNull(chval)){
						$("#fast_"+theqid).prop("class","");
					}else{
						$("#fast_"+theqid).prop("class","finished");
					}
				});
			}
		};

		//填空题的输入判断
		function tm_checker_blanker_filled(n){
			var len = $("input[name='"+n+"']").length;
			var mylen = 0;
			$("input[name='"+n+"']").each(function(){
				var chval = $(this).val();
				if(baseutil.isNull(chval)){

				}else{
					mylen ++;
				}
			});
			return len == mylen;
		}

		
		
	</script>
  </head>
  
<body>

	<div class="tm_main">
    	
		<div class="tm_container">
			<ul class="tm_breadcrumb">
				<li><a href="${ctx}/sys/user/info">首页</a> <span class="divider">&gt;</span></li>
				<li><a href="${basectx}/user/practice/new">模拟练习</a> <span class="divider">&gt;</span></li>
				<li class="active">${param.name}</li>
			</ul>
		</div>
        
        <div class="tm_container">

			<table border="0" width="100%" cellpadding="0" style="min-width:860px;">
				<tr>
					<!-- left -->
					<td valign="top">
						<form method="post" id="form_paper_detail">
                    	<div class="tm_paper">
                            <div class="tm_paper_head">
                                <h1>${paper.name}</h1>
								<h2 style="background:#ddd; padding:5px 0; font-size:14px; font-weight:bold">
									试卷信息
								</h2>
                                <h2>
									<b>考试时长</b> : ${paper.duration} 分钟
									&nbsp;&nbsp;
									<b>卷面总分</b> : ${paper.totalscore}
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
															<c:set var="targetStr"><input type="text" class="tm_txt qk-blank" name="Q-${question.id}" data-qid="${question.id}"></c:set>
															${fns:formatBlanks(question.QContent,targetStr , "\\[BlankArea.+?]")}
														</c:when>
														<c:otherwise>   
															${question.QContent}
														</c:otherwise> 
													</c:choose>
												</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<tr>
                                            	<td colspan="2">
                                                <c:choose>
                                                    <c:when test="${question.QType == 1}">
                                                        <ul>
                                                        <c:forEach var="option" items="${question.options}">
                                                            <li><label><input type="radio" class="qk-choice" value="${option.alisa}" data-qid="${question.id}" name="Q-${question.id}" />
																${option.alisa} . ${option.text}</label></li>
                                                        </c:forEach>
                                                        </ul>
                                                    </c:when>
                                                    <c:when test="${question.QType == 2}">
                                                        <ul>
                                                        <c:forEach var="option" items="${question.options}">
                                                            <li><label><input type="checkbox" class="qk-choice" value="${option.alisa}" data-qid="${question.id}" name="Q-${question.id}" />
																${option.alisa} . ${option.text}</label></li>
                                                        </c:forEach>
                                                        </ul>
                                                    </c:when>
                                                    <c:when test="${question.QType == 3}">
                                                        <ul>
															<li><label><input type="radio" class="qk-choice" value="Y" data-qid="${question.id}" name="Q-${question.id}" />
																正确</label></li>
															<li><label><input type="radio" class="qk-choice" value="N" data-qid="${question.id}" name="Q-${question.id}" />
																错误</label></li>
                                                        </ul>
                                                    </c:when>
                                                </c:choose>
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
								<button class="tm_btn tm_btn_primary" type="button"  onclick="tmUserPaper.submitPaper();">提交</button>
                            </div>


                        </div>

						<input type="hidden" id="t_timecost" name="t_timecost" value="0" />
						<input type="hidden" id="t_duration" name="t_duration" value="${paper.duration}" />
						
						</form>

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
			<button class="tm_btn tm_btn_primary" type="button" onclick="tmUserPaper.submitPaper();">提交</button>
		</div>
	</div>



</body>
</html>
