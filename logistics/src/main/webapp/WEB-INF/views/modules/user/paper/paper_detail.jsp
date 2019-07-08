<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="basectx" value="<%=request.getContextPath()%>"/>
<!doctype html>
<html>
<head>
	<title>我的试卷</title>
	<link rel="shortcut icon" href="favicon.ico" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/ywork/exam/exam-admin-style.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/baseutil.js" type="text/javascript"></script>

	<link rel="stylesheet" href="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/css/validationEngine.jquery.css" />
	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/jquery.validationEngine.js"></script>

	<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery-validation-engine/js/languages/jquery.validationEngine-zh_CN.js"></script>

	<script type="text/javascript">

		var tm_maxtime = 0;
		var tm_timer = null;
		var tm_pid = "${paper.id}";
		var tm_uid = "${fns:getUser().id}";
		var tm_page_confirm = false;


		$(document).ready(function() {
			tm_resetPosition();
			tmUserPaper.initPaper();
			$(".tm_paper_section h1").click(function(){
				$(this).parent().children(".tm_paper_question").toggle();
			});
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
	
		
		var tmUserPaper = {
			initPaper : function(){
				//追加导航按钮
				var html = [];
				$(".span-quick-nav").each(function(idx, itm){
					var question_id = $(this).data("questionid");
					var nid = idx + 1;
					var thetop = $(this).offset().top;

					html.push('<a href="javascript:;" id="fast_'+question_id+'"');
					html.push(' onclick="javascript:tmUserPaper.moveToQuestion('+thetop+')" ');
					html.push('>' + nid + '</a>');
				});
				$("#div_processor_fastto").html(html.join(""));
				
				var stimer = "<span class='tm_label'>00:00:00</span>";
				$("#div_processor_timer").html(stimer);

				//获取剩余时间(分钟)
				tmUserPaper.getLeftTime();
				
				//绑定输入提示
				tmUserPaper.bindQuickTip();

				//自动加载本地缓存
				tmLoadUserPaperCache(tm_uid, tm_pid);
			},

			submitPaper : function(){
				var formcheck = $("#form_paper_detail").validationEngine('validate', {showOneMessage: true});
				if(formcheck){
					var wcm = window.confirm('试卷没有提交，确定要离开吗？');
					if(!wcm){
						return;
					}
					
					$(".tm_btn").attr("disabled","disabled");
					$(".tm_btn").val('试卷提交中...');

					window.onbeforeunload = null;
					tm_page_confirm = true;
					
					$("form").attr("action","${basectx}/user/paper/submitPaper.jhtml");
					$("form").submit();


				}else{
					return false;
				}
				
			},

			moveToQuestion : function(thetop){
				$("html:not(:animated),body:not(:animated)").animate({ scrollTop: thetop}, 500);
			},
			
			countDown : function(){
				var tm_msg;
				if(tm_maxtime>0){

					tm_msg = "<span class='tm_label'>"+ tm_fn_formatSeconds(tm_maxtime) + "</span>";
					//alert(tm_msg);
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
					tm_page_confirm = true;
					clearInterval(tm_timer);   
					$("#div_processor_timer").html('考试时间到，试卷将自动提交!');
					$("form").attr("action","${basectx}/user/paper/submitPaper.jhtml");
					$("form").submit();
				}
			},

			getLeftTime : function(){
				$.ajax({
					type: "POST",
					url: "${basectx}/user/paper/${paper.id}/leftTime.jhtml",
					data: {"t":Math.random()},
					dataType: "json",
					success: function(ret){
						tm_maxtime = parseInt(ret["data"]);
						if(tm_maxtime == -9){
							alert('获取剩余时间失败,请联系管理员');
							top.location.reload();
						}else{
							tm_timer = setInterval("tmUserPaper.countDown()",1000); 
						}
					},
					error:function(){
						alert('获取剩余时间失败,请联系管理员');
						top.location.reload();
					}
				}); 
			},

			bindQuickTip : function(){
				//选择题绑定
				$(".qk-choice").click(function(){
					var thename = $(this).attr("name");
					var theqid = $(this).data("qid");
					var chval = "";

					$.each($('input[name='+thename+']:checked'), function(idx, item){
						chval += $(this).val();
					});

					//增加到本地缓存
					tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "choice", chval);

					if(baseutil.isNull(chval)){
						$("#fast_"+theqid).prop("class","");
					}else{
						$("#fast_"+theqid).prop("class","finished");
					}

				});
				//填空题绑定
				$(".qk-blank").blur(function(){
					var thename = $(this).attr("name");
					var theqid = $(this).data("qid");
					var charrval = [];

					$.each($('input[name='+thename+']'), function(idx, item){
						charrval.push($(this).val());
					});

					//增加到本地缓存
					tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "blank", charrval);

					if(tm_checker_blanker_filled(thename)){
						$("#fast_"+theqid).prop("class","finished");
					}else{
						$("#fast_"+theqid).prop("class","");
					}

				});
				//问答题绑定
				$(".qk-txt").blur(function(){
					var thename = $(this).attr("name");
					var theqid = $(this).data("qid");
					var chval = $(this).val();

					//增加到本地缓存
					tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "essay", chval);
					
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
		
		//本地缓存操作
		var tmUserDataCache = {
			support : function(){
				try{
					if(window.localStorage){
						return true;
					}else{
						return false;
					}
				}catch(e){
					return false;
				}
				
			},

			addCache : function(uid, pid, qid, qtype, val){
				if(!tmUserDataCache.support()){
					return;
				}
				var cacheData = tmUserDataCache.getCache(uid, pid);
				var cacheKey = "C" + uid + pid;
				var cacheJson = [];

				try{
					if(!baseutil.isNull(cacheData)){
						cacheJson = JSON.parse(cacheData);
					}

					$(cacheJson).each(function(idx, item){
						var _name = "Q-" + qid;
						if(_name == item["name"]){
							cacheJson.splice(idx, 1);
						}
					});
					cacheJson.push({"name" : "Q-" + qid, "type" : qtype, "value" : val});
					
					var strCacheData = JSON.stringify(cacheJson);
					localStorage.setItem(cacheKey, strCacheData);

				}catch(e){
					//BROWSER DOESN'T SUPPORTED
				}

			},

			getCache : function(uid, pid){
				if(!tmUserDataCache.support()){
					return;
				}
				var cacheKey = "C" + uid + pid;
				return localStorage.getItem(cacheKey);
			}
		};

		
		//加载本地缓存
		function tmLoadUserPaperCache(uid, pid){
			var cacheData = tmUserDataCache.getCache(uid, pid);
			if(baseutil.isNull(cacheData)){
				return;
			}
			try{
				var cacheJson = JSON.parse(cacheData);
				$.each(cacheJson, function(idx, item){

					if(item["type"]=="blank"){
						$("input[name='"+item["name"]+"']").each(function(ii, iblank){
							$(this).val(item["value"][ii]);
						});

					}else if(item["type"]=="choice"){
						$("input[name='"+item["name"]+"']").val(item["value"].split(""));

					}else if(item["type"]=="essay"){
						$("textarea[name='"+item["name"]+"']").val(item["value"]);
					}
					
					try{
						var theqid = item["name"].replace("Q-","");
						$("#fast_"+theqid).prop("class","finished");
					}catch(e){}
					
				});
				
			}catch(e){
				//BROWSER DOESN'T SUPPORTED
			}
			
		}

		function tm_checkUnsubmit(){
			if(tm_page_confirm == false){ 
				return '试卷没有提交，确定要离开吗？';
			}
		}

//		document.oncontextmenu= function(){return false;}

	</script>
  </head>
  
<body onbeforeunload="return tm_checkUnsubmit();">

	<div class="tm_main">

		<div class="tm_container">
			<ul class="tm_breadcrumb">
				<li><a href="common/welcome.thtml">首页</a> <span class="divider">&gt;</span></li>
				<li><a href="${ctx}/user/paper/list.jhtml">我的试卷</a> <span class="divider">&gt;</span></li>
				<li class="active">${paper.name}</li>
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
								<h2 style="background:#ddd; padding:5px 0;">
									${paper.remark}
								</h2>
								<h2>
									<b>时间设定</b> :
									<fmt:formatDate value="${paper.starttime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /> --
									<fmt:formatDate value="${paper.endtime}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /> &nbsp;&nbsp;
									<b>考试时长</b> : ${paper.duration} 分钟
								</h2>
								<h3>
									<b>卷面总分</b> : ${paper.totalscore}
									&nbsp;&nbsp;
									<b>及格分数</b> : ${paper.passscore}
								</h3>
							</div>

                            <div class="tm_paper_body">
								
								<c:set value="0" var="varQuestionId"/>

                            	<c:forEach var="section" items="${paper.sections}">
                            	<div class="tm_paper_section">
                                	<h1>${section.name}</h1>
                                    <h2>${section.remark}</h2>
                                    
                                    <c:forEach var="question" items="${section.questions}">
									<c:set var="varQuestionId" value="${varQuestionId+1}"></c:set>
									<span class="span-quick-nav" data-questionid="${question.id}"></span>

                                    <table border="0" cellpadding="0" cellspacing="0" class="tm_paper_question" style="table-layout:fixed;">
                                    	<thead>
                                        	<tr>
                                            	<th valign="top" class="tm_question_lineheight"><cite>${varQuestionId}</cite></th>
                                                <td class="tm_question_lineheight">
													<c:choose>
														<c:when test="${question.QType == 4}">
                                                            <c:set var="targetStr"><input type="text" class="validate[required] tm_txt qk-blank" name="Q-${question.id}" data-qid="${question.id}"></c:set>
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
                                                            <li><label><input type="radio" class="validate[required] qk-choice" value="${option.alisa}" data-qid="${question.id}" name="Q-${question.id}" />
																${option.alisa} . ${option.text}</label></li>
                                                        </c:forEach>
                                                        </ul>
                                                    </c:when>
                                                    <c:when test="${question.QType == 2}">
                                                        <ul>
                                                        <c:forEach var="option" items="${question.options}">
                                                            <li><label><input type="checkbox" class="validate[required] qk-choice" value="${option.alisa}" data-qid="${question.id}" name="Q-${question.id}" />
																${option.alisa} . ${option.text}</label></li>
                                                        </c:forEach>
                                                        </ul>
                                                    </c:when>
													<c:when test="${question.QType == 3}">
														<ul>
															<li><label><input type="radio" class="validate[required] qk-choice" value="Y" data-qid="${question.id}" name="Q-${question.id}" />
																正确</label></li>
															<li><label><input type="radio" class="validate[required] qk-choice" value="N" data-qid="${question.id}" name="Q-${question.id}" />
																错误</label></li>
														</ul>
													</c:when>
                                                    <c:when test="${question.QType == 5}">
														<div class="tm_marleft20"><textarea rows="5" cols="80" data-qid="${question.id}" name="Q-${question.id}" class="validate[required] tm_txtx qk-txt"></textarea></div>
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
                            	<button class="tm_btn tm_btn_primary" type="button" onclick="tmUserPaper.submitPaper();">提交</button>
								<button class="tm_btn" type="button" onclick="javascript:history.go(-1);">取消</button>
                            </div>

							<input type="hidden" name="pid" value="${paper.id}" />
							<input type="hidden" name="uid" value="${fns:getUser().id}" />

                        </div>
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
			<input type="button" value='提交' class="tm_btn" onclick="tmUserPaper.submitPaper();" />
		</div>
	</div>


</body>
</html>
