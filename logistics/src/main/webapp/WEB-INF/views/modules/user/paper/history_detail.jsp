<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<!doctype html>
<html>
<head>
	<title>我的考试</title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />

	<style>
		.div-key-container{margin:5px 25px; border:dotted 0px #ddd; padding:0px;}
		.div-key-container span{font-weight:bold; clear:both}

		.div-key-container fieldset{border:solid 1px #ddd; margin-top:5px}
		.div-key-container fieldset legend{font-weight:bold}
		.div-key-container fieldset p{display:inline}

		.tm_question_tools{list-style:none; padding:0; margin:0; }
		.tm_question_tools li{list-style:none; padding:0; margin:0; width:40px; float:left; background:#eee; text-align:center; height:35px}
		.tm_question_tools li img{margin-top:8px;}
		.tm_question_tools li span{line-height:30px;}
		.tm_question_tools li span a{color:#00a; text-decoration:underline}

	</style>

	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/layer/layer.js" type="text/javascript"></script>
    
	<script type="text/javascript">

		var tm_pid = "${paper.id}";
		var tm_uid = "${fns:getUser().id}";
		var tm_layerid = 0;


		$(document).ready(function() {
			tmUserPaper.initPaper();
			$(".tm_paper_section h1").click(function(){
				$(this).parent().children(".tm_paper_question").toggle();
			});
			tm_resetPosition();
			tmUserDataCache.removeCache(tm_uid, tm_pid);
		});

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
	
		//创建弹出层
		function makeAddForm(qid, userkey){
			//var tm_html_options = [];
			//tm_html_options.push('<select class="tm_select" style="min-width:200px" name="c_tid">');
			<c:forEach var="category" items="${categories}">
			//tm_html_options.push('	<option value="${category.id}">${category.name}</option>');
			</c:forEach>
			//tm_html_options.push('<select>');

			var html = [];
			html.push('<div style="margin:10px">');
			html.push('	<table width="100%" cellpadding="5" border="0" class="tm_table_form">');
//			html.push('	<tr>');
//			html.push('		<th width="100">所属分类</th>');
//			html.push('		<td>'+tm_html_options+'</td>');
//			html.push('	</tr>');
			html.push('	<tr>');
			html.push('		<th>收藏说明</th>');
			html.push('		<td><input type="text" class="tm_txt" size="50" maxlength="50" name="c_remark" /></td>');
			html.push('	</tr>');
			html.push('	<tr>');
			html.push('		<th></th>');
			html.push('		<td><button class="tm_btn tm_btn_primary" type="button" onclick="tmUserPaper.doAddFav();">提交</button></td>');
			html.push('	</tr>');
			html.push('	</table>');
			html.push('</div>');
			html.push('<input type="hidden" name="c_qid" value="'+qid+'" />');
			html.push('<input type="hidden" name="c_userkey" value="'+userkey+'" />');
			return html.join("");
		}
		

		
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
			},


			moveToQuestion : function(thetop){
				$("html:not(:animated),body:not(:animated)").animate({ scrollTop: thetop}, 500);
			},
			
			addFavorite : function(qid, userkey){
				tm_layerid = layer.open({
					title: '添加收藏',
					type: 1,
					area: ['500px', '250px'],
					shadeClose: true,
					content: makeAddForm(qid, userkey)
				});
			},
			
			doAddFav : function(){
				var c_remark = $("input[name='c_remark']").val();
				var c_tid = $("select[name='c_tid']").val();
				var c_qid = $("input[name='c_qid']").val();
				var c_userkey = $("input[name='c_userkey']").val();
				$.ajax({
					type: "POST",
					url: "${basectx}/user/question/"+c_qid+"/collect.jhtml",
					data: {"tid":c_tid, "uid":tm_uid, "qid":c_qid, "userkey":c_userkey, "remark":c_remark, "t":Math.random()},
					dataType: "json",
					success: function(ret){
						alert(ret['msg']);
						layer.close(tm_layerid);
					},
					error:function(ret){
						console.log(ret);
						alert('系统忙，请稍后再试');
					}
				}); 
			}
		};

		//本地缓存操作
		var tmUserDataCache = {
			support : function(){
				if(window.localStorage){
					return true;
				}else{
					return false;
				}
			},
			removeCache : function(uid, pid){
				if(!tmUserDataCache.support()){
					return;
				}
				var cacheKey = "C" + uid + pid;
				localStorage.removeItem(cacheKey);
			}
		};
		
	</script>
  </head>
  
<body>

	<c:set var="var_nowDate">  
		<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMddHHmmss" type="date"/>  
	</c:set>  
	<c:set var="var_showDate">  
		<fmt:formatDate value="${paper_basic.showtime}" pattern="yyyyMMddHHmmss" type="date"/>  
	</c:set> 
	<c:set var="var_showScore" value="${var_nowDate>=var_showDate}"></c:set>

	<div class="tm_main">
    	
		<div class="tm_container">
			<ul class="tm_breadcrumb">
				<li><a href="${ctx}/sys/user/info">首页</a> <span class="divider">&gt;</span></li>
				<li><a href="${basectx}/user/paper/history">考试记录</a> <span class="divider">&gt;</span></li>
				<li class="active">${paper_basic.name}</li>
			</ul>
		</div>
        
        <div class="tm_container">

			<table border="0" width="100%" cellpadding="0" style="min-width:860px;">
				<tr>
					<!-- left -->
					<td valign="top">
                    	<div class="tm_paper">
                            <div class="tm_paper_head">
                                <h1>${paper_basic.name}</h1>
								<h2 style="background:#ddd; padding:5px 0; font-size:14px; font-weight:bold">
									试卷信息
								</h2>
                                <h2>
									<b>时间设定</b> :
									<fmt:formatDate value="${paper.starttime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /> -- 
									<fmt:formatDate value="${paper.endtime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /> 

									&nbsp;&nbsp;
									<b>考试时长</b> : ${paper.duration} 分钟
									
									&nbsp;&nbsp;
									<b>卷面总分</b> : ${paper.totalscore}
									&nbsp;&nbsp;
									<b>及格分数</b> : ${paper.passscore}
								</h2>
								<h2 style="background:#ddd; padding:5px 0; font-size:14px; font-weight:bold">
									考生信息
								</h2>
								<h2>
									<b>开考时间</b> :
									<fmt:formatDate value="${detail.starttime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
									
									&nbsp;&nbsp;
									<b>交卷时间</b> :
									<fmt:formatDate value="${detail.endtime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
									
									<c:if test="${var_showScore == true}">
										<br/><br/>
										<b>耗时(分钟) </b> :
										<c:set var="interval" value="${detail.endtime.time - detail.starttime.time}" />
										<span class="tm_label"><fmt:formatNumber value= "${interval/1000/60}" pattern= "#0" /></span>
										分钟

										&nbsp;&nbsp;
										<b>得分</b> : <span id="tm_span_score" class="tm_label">${detail.score}</span>
									</c:if>
									
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
															<tomtag:Util action="formatBlank" data="${question.QContent}" ext=" ________ "></tomtag:Util>
														</c:when>
														<c:otherwise>   
															${question.QContent}
														</c:otherwise> 
													</c:choose>
												</td>
												<td width="125" valign="top">
													<c:if test="${var_showScore == true}">
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
															<span><b>${check[v_questionid]}</b></span>
														</li>
														<li><span><a href="javascript:void(0);" 
														onclick="javascript:tmUserPaper.addFavorite('${question.id}', '${data[v_questionid]}');">收藏</a></span></li>
													</ul>
													</c:if>
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

															<c:if test="${var_showscore == 1 && paper_basic.showkey == 1}">
															<div class="div-key-container">
																 <fieldset>
																	<legend>标准答案 :</legend>
																	<p>${question.QKey}</p>
																 </fieldset>
																 <fieldset>
																	<legend>试题解析 :</legend>
																	<p>${question.QResolve}</p>
																 </fieldset>
															</div>
															</c:if>
														</c:when>

														<c:when test="${question.QType == '2'}">
															<ul>
															<c:forEach var="option" items="${question.options}">
																<li><label>${option.alisa} . ${option.text}</label></li>
															</c:forEach>
															</ul>

															<c:if test="${var_showscore == 1 && paper_basic.showkey == 1}">
															<div class="div-key-container">
																 <fieldset>
																	<legend>标准答案 :</legend>
																	<p>${question.QKey}</p>
																 </fieldset>
																 <fieldset>
																	<legend>试题解析 :</legend>
																	<p>${question.QResolve}</p>
																 </fieldset>
															</div>
															</c:if>
														</c:when>

														<c:when test="${question.QType == '3'}">
															<c:if test="${var_showscore == 1 && paper_basic.showkey == 1}">
															<div class="div-key-container">
																<fieldset>
																	<legend>标准答案 :</legend>
																	<p>${question.QKey}</p>
																 </fieldset>
																 <fieldset>
																	<legend>试题解析 :</legend>
																	<p>${question.QResolve}</p>
																 </fieldset>
															</div>
															</c:if>
														</c:when>

														<c:when test="${question.QType == '4'}">
															<c:if test="${var_showscore == 1 && paper_basic.showkey == 1}">
															<div class="div-key-container">
																<fieldset>
																	<legend>标准答案 :</legend>
																	<p><c:forEach var="blank" items="${question.blanks}">
																		${blank.value}
																		</c:forEach>
																	</p>
																 </fieldset>
																 <fieldset>
																	<legend>试题解析 :</legend>
																	<p>${question.QResolve}</p>
																 </fieldset>
															</div>
															</c:if>
														</c:when>

														<c:when test="${question.QType == '5'||question.QType == '6'}">
															<c:if test="${var_showscore == 1 && paper_basic.showkey == 1}">
															<div class="div-key-container">
																<fieldset>
																	<legend>标准答案 :</legend>
																	<p>${question.QKey}</p>
																 </fieldset>
																 <fieldset>
																	<legend>试题解析 :</legend>
																	<p>${question.QResolve}</p>
																 </fieldset>
															</div>
															</c:if>
														</c:when>
													</c:choose>
														
													
													<div class="div-key-container tm_userkey">
														<fieldset>
															<legend>用户答案 :</legend>
															<p>
															<c:choose>
																<c:when test="${question.QType == '2'}">
																	${fn:replace(data[v_questionid], '`', '')}
																</c:when>
																<c:when test="${question.QType == '4'}">
																	${fn:replace(data[v_questionid], '`', ' ')}
																</c:when>
																<c:otherwise>
																	${data[v_questionid]}
																</c:otherwise> 
															</c:choose>
															</p>
														</fieldset>
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
			<button class="tm_btn tm_btn_primary" type="button" onclick="history.go(-1)">返回</button>
		</div>
	</div>
	
	
</body>
</html>
