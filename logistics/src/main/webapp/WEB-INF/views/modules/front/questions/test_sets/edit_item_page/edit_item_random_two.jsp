<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<title></title>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/test_sets/create_test_paper/edit_item_page/edit_item_random_two.css${v}" />
	<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery/jquery.inputmask.bundle.js${v}" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
</head>
<body>
	<div id="divheader"></div>
	<div id="auto_model" class="auto_model">	
		<div id="bo_fl">
			<div class="sel">
				<div class="sel_title">
					<i>选择知识点</i>
					<span style="display: none;">
						<i class="fa fa-exchange"></i>
						<div class="select_style">
							<div id="point_up"></div>
							<div class="select_style_cont">
								<p>选择科目</p>
								<p>选择知识点</p>
							</div>
						</div>
					</span>
				</div>
				
				<ul id="sel_types" class="sel_types dash_line">

				</ul>
				<%--新增章节--%>
				<ul class="one_section dash_line" style="height: 385px;">

				</ul>
			</div>
		</div>
		<div id="bo_fr">
			<form id="select-form">
				<div id="coner">
					<h3 class="fr_title">已选<em class="toggel_name">知识点</em>：(<b id="fr_title_num">0</b>)  个 <span id="remove"><i class="icona-del1"></i>清空</span></h3>
					<div class="sel_style">
						<p class="smart-empty-tip">您未选择相应内容！ </p>
					</div>
					<h3 class="fr_title">试卷设置</h3>
					<div class="smart-paper-setting">
						<%--<div id="J_topic" class="q-set f-usn"><em>　知识点：</em>--%>
							<%--<div id="topics">--%>

							<%--</div>--%>
							<%--<!-- <span class="checkbox">--%>
                                <%--<i class="icona-check"></i>--%>
                                <%--<input name="grade_id"  value="7" style="display:none;" type="checkbox">采样--%>
                            <%--</span> -->--%>

						<%--</div>--%>
	                    <div id="J_Difficulty" class="q-set f-usn"><em>试卷难度：</em>
	                    	<div id="easys">
								<span class="radiobox checked">
		                            <i class="icona-radio"></i>
		                            <input name="p_levels" value="" style="display:none" checked type="radio">不限
		                        </span>
		                       <!--  <span class="radiobox checked">
		                            <i class="icona-radio"></i>
		                            <input name="difficult_index" value="" style="display:none" checked type="radio">不限
		                        </span>
		                        <span class="radiobox ">
		                            <i class="icona-radio"></i>
		                            <input name="difficult_index" value="1" style="display:none" type="radio">容易
		                        </span>
		                        <span class="radiobox ">
		                            <i class="icona-radio"></i>
		                            <input name="difficult_index" value="3" style="display:none" type="radio">普通
		                        </span>
		                        <span class="radiobox ">
		                            <i class="icona-radio"></i>
		                            <input name="difficult_index" value="5" style="display:none" type="radio">困难
		                        </span> -->
	                        </div>
	                    </div>
	                    
	                    <div id="J_Nj" class="q-set f-usn"><em>适用岗位：</em>
	                    	<div id="dutys">
	                    		
	                    	</div>
	                        <!-- <span class="checkbox">
	                            <i class="icona-check"></i>
	                            <input name="grade_id"  value="7" style="display:none;" type="checkbox">采样                       
	                        </span> -->
	                        
	                    </div>
	                </div>
	                <h3 class="fr_title">题型/分数/题量设置</h3>
	                <div class="section-table">
	                    <div class="qtype-zone f-cb" id="J_TypeItems">
	                        <div class="w f-fl">
	                            <div class="qtype-selected">
	                                <ul id="queType">
	                                    <!-- type-item -->
	                                   <!--  <li class="t-item">
	                                    	<span>单选题 </span>
											<b class="t-mark"><i>0</i> 道试题可用</b>
											
											<div>
												<span>每题</span><input name="p_scores" value="1" type="text"><span style="padding-right:20px;">分</span><span>共</span>
												<input name="p_qnums" value="1" type="text">道<a href="javascript:;"><i class="icona-del1"></i></a>

												<input type="hidden" name="p_section_ids" value="1">
												<input type="hidden" name="p_section_names" value="1">
												<input id="remark_1" type="hidden" name="p_section_remarks" value="(共5小题，每题2分)">
												<input type="hidden" name="p_qtypes" value="1">
											</div>
										</li>
										<li class="t-item">
											<b class="t-mark">0 道试题可用</b>
											<span>填空题 </span>
											<div><input name="question_channel_type[4]" value="1" type="text">道<a href="javascript:;"><i class="icona-del1"></i></a></div>
										</li> -->
									</ul>
	                            </div>
	                        </div>
	                        <div class="qtype-list f-fr">
	                            <dl>
	                                <dd id="qtype_cont"><!-- 学科题型种类 -->
	                                    <!-- <a class="put_qus p0" data-type='0' href="javascript:void(0);" >单选题</a>
	                                    <a class="put_qus p1" data-type='1' href="javascript:void(0);" >填空题</a>
	                                    <a class="put_qus p2 active" data-type='2' href="javascript:void(0);">计算题</a>
	                                    <a class="put_qus p3 active" data-type='3' href="javascript:void(0);">解答题</a>
	                                    <a class="put_qus p4 active" data-type='4' href="javascript:void(0);">作图题</a>
	                                    <a class="put_qus p5 active" data-type='5' href="javascript:void(0);">综合题</a> -->
	                                </dd>
	                            </dl>
	                        </div>
	                    </div>

	                </div>
				</div>
				<input type="hidden" id="hidID" name="id" value="1"/>
				<input type="hidden" id="hidName" name="name" value="1"/>
				<input type="hidden" id="hidOrderType" name="ordertype" value="1"/>
				<input type="hidden" id="hidPaperType" name="papertype" value="1"/>
				<input type="hidden" id="hidStatus" name="status" value="0" value="1"/>

				<input id="txtDuration" name="duration" type="hidden" /></span>
				<input id="txtTotalScore" name="totalscore" type="hidden"/></span>
				<input id="txtPassScore" name="passscore" type="hidden"/></span>

                <div class="smarter-footer">
                    <button class="set-btn" type="submit">生成试卷</button>
                </div>
			</form>
		</div>
	</div>
	<!-- 知识点 -->
	<script type="text/template" id="types">
		<li id="{{id}}">
			<div class="one_title">
				<span class=" cuesor title_radio1"></span>
				<b class="title_checkbox1 cuesor" data-type="{{id}}" data-code="{{value}}"></b>
				<em class=" cuesor">{{label}}</em>
			</div>
		</li>
		<%--<li id="k{{value}}"><a class="get_types" href="javascript:void(0);" data-type="{{value}}">{{label}}</a></li>--%>
	</script>
	<!-- 添加科目模块 -->
	<script type="text/template" id="items">
		<div class="section-items q{{qid}}" >
			<p class="section-itemstxt">{{name}}</p>
			<p class="section-itemsclose J_DelBtn">
				<span onclick="iconaCha2(this,'{{qid}}')" >
					<i class="icona-cha2"></i>
				</span>
			</p>
			<input name="p_subjects" value="{{num}}" type="hidden">
		</div>
	</script>
	<!-- 添加知识点模块 -->
	<script type="text/template" id="item_topic">
		<div class="section-items q{{qid}}" >
			<p class="section-itemstxt">{{name}}</p>
			<p class="section-itemsclose J_DelBtn">
				<span onclick="iconaCha2(this,'{{qid}}')" >
					<i class="icona-cha2"></i>
				</span>
			</p>
			<input name="p_topics" value="{{num}}" type="hidden">
		</div>
	</script>
	<!-- 试卷难度 -->
	<script type="text/template" id="easy">
		<span class="radiobox ">
	        <i class="icona-radio"></i>
	        <input name="p_levels" value="{{value}}" style="display:none" type="radio">{{label}}
	    </span>
	</script>
	<!-- 知识点选择 -->
	<script type="text/template" id="topic">
		<span class="checkbox checkboxtopic {{disno}}">
	        <i class="icona-check"></i>
	        <input name="p_topics"  value="{{value}}" style="display:none;" type="checkbox">{{label}}
	    </span>
	</script>
	<!-- 岗位选择 -->
	<script type="text/template" id="duty">
		<span class="checkbox checkboxduty">
	        <i class="icona-check"></i>
	        <input name="p_posts"  value="{{value}}" style="display:none;" type="checkbox">{{label}}                    
	    </span>
	</script>
	<!-- 试题种类 -->
	<script type="text/template" id="qtcontainer">
		<a class="put_qus p{{value}} active" data-type="{{value}}" data-name="{{label}}" href="javascript:void(0);" >{{label}}</a>
	</script>
	<!-- 题型和题量 -->
	<script type="text/template" id="putQuestion">
		<li class="t-item" data-type="{{number}}">
			<span>{{qtyname}} </span>
			<b class="t-mark"><i id="i{{number}}">0</i> 道试题可用</b>
			<div>
				<span>每题</span><input class="scores" id="s_{{number}}" onblur="qnumBlur('{{number}}','p_qnums');" name="p_scores" value="2" type="text" ><span style="padding-right:20px;">分</span><span>共</span>
				<input class="qnums" id="p_{{number}}" name="p_qnums" value="1" type="text" onblur="scoresBlur('{{number}}','p_qnums');">道
				<a href="javascript:;"><i class="icona-del1" onclick="queDelet(this,'{{number}}');"></i></a>

				<input type="hidden" name="p_section_names" value="{{label}}">
				<input type="hidden" name="p_section_ids" value="{{number}}">
				<input id="remark_{{number}}" class="remark_class" type="hidden" name="p_section_remarks" value="每题（2）分">
				<input type="hidden" name="p_qtypes" value="{{number}}">
			</div>
		</li>
	</script>
	<script type="text/template" id="localtopic">
		<p class="smart-empty-tip">您未选择相应内容！</p>
	</script>
	<script type="text/template" id="localkno">
		<p class="smart-empty-tip">您未选择相应内容！</p>
	</script>
	<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/jquery.slimscroll.min.js${v}" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_sets/edit_item_page/edit_item_random_two.js${v}"></script>
</body>
</html>