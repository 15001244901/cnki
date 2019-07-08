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
		<script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
		<script src="${ctxStatic}/jquery/jquery.inputmask.bundle.js${v}" type="text/javascript" charset="utf-8"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/questions/question_bank.css${v}" />

		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.css${v}">

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
		<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search_select.css">
		<style>
            /*组卷提示框*/
            .layui-layer-title{
                padding-right:20px;
                background: #3db06e;
            }
		</style>
	</head>

	<body>
		<div id="divheader"></div>

		<div id="banner" style="padding-top:1px;">

			<div class="img">
				<img src="${ctxStatic}/hsun/front/img/banner/banner20.png" style="width:1200px;margin-top: 20px;" />
			</div>
		</div>
		<div id="divcontent">
			<div class="border2">
				<div id="title_search">
					<div id="title_search_name"><i class="fa fa-pencil"></i>&nbsp;&nbsp;题库选择</div>
					<%--搜索--%>

					<div class="bo_search">
						<div>
							<div id="select_reseach">
						<span class="text_select">
							<em class="">试题</em>
							<i class="iconfont icon-jiantouxiangxia"></i>
						</span>
								<p class="select_items" >
									<%--<shiro:hasPermission name="exam:question:view">--%>
									<a href="javascript:;">
										<input class="search_type" name="searchtype" value="0" checked type="radio">
										<span class="bor_bottom">试题</span>
									</a>
									<%--</shiro:hasPermission>--%>
									<a href="javascript:;">
										<input class="search_type" name="searchtype" value="1" type="radio">
										<span>试卷</span>
									</a>
								</p>
							</div>
							<input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
							<c:if test="${not empty fns:getUser().id}">
								<span class="spansearch"><a href="javascript:;"  <shiro:hasPermission name="exam:paper:edit">data-power="1"</shiro:hasPermission> onclick="questionBank.searchLibrary(this);"><i class="fa fa-search fa-lg"></i></a></span>
							</c:if>
							<c:if test="${empty fns:getUser().id}">
								<span class="spansearch"><a href="javascript:;" onclick="isNoLogin();"><i class="fa fa-search fa-lg"></i></a></span>
							</c:if>
						</div>
					</div>

				</div>

				<ul class="nav">
					<%--<li>--%>
						<%--<img class="no_power" onclick="javascript:window.location.href='test_center/text_center.html'+timestamps" src="${ctxStatic}/hsun/front/img/question/1_2.png" onmouseover="questionBank.mouseOver(this,1)" onmouseout="questionBank.mouseOut(this,1)" /><br />题库中心--%>
					<%--</li>--%>
					<li>
						<img class="no_power now_is_login" src="${ctxStatic}/hsun/front/img/question/1_2.png" data-url="10" <shiro:hasPermission name="exam:question:view"> data-power="1" </shiro:hasPermission>  onmouseover="questionBank.mouseOver(this,1)" onmouseout="questionBank.mouseOut(this,1)" /><br />题库中心
					</li>
                    <li>
                        <img class="no_power now_is_login" data-url="1" src="${ctxStatic}/hsun/front/img/question/6_2.png" onmouseover="questionBank.mouseOver(this,6)" onmouseout="questionBank.mouseOut(this,6)" /><br />在线考试
                    </li>
                    <li>
                        <img class="no_power now_is_login" data-url="2" src="${ctxStatic}/hsun/front/img/question/7_2.png" onmouseover="questionBank.mouseOver(this,7)" onmouseout="questionBank.mouseOut(this,7)" /><br />模拟练习
                    </li>
                    <li>
                        <img class="no_power now_is_login" data-url="3"  src="${ctxStatic}/hsun/front/img/question/8_2.png" onmouseover="questionBank.mouseOver(this,8)" onmouseout="questionBank.mouseOut(this,8)" /><br />每日一练
                    </li>

                    <li>
                        <img class="no_power now_is_login" data-url="4" <shiro:hasPermission name="exam:paper:edit"> data-power="1" </shiro:hasPermission> src="${ctxStatic}/hsun/front/img/question/4_2.png" onmouseover="questionBank.mouseOver(this,4)" onmouseout="questionBank.mouseOut(this,4)" /><br />试卷库
                    </li>


					<%--登录判断--%>
                    <%--<c:if test="${not empty fns:getUser().id}">--%>
                    <li>
						<img class="no_power now_is_login" data-url="5" <shiro:hasPermission name="exam:paper:edit"> data-power="1" </shiro:hasPermission> src="${ctxStatic}/hsun/front/img/question/2_2.png" onmouseover="questionBank.mouseOver(this,2)" onmouseout="questionBank.mouseOut(this,2)" /><br />手动组卷
                    </li>
                    <li>
						<img class="no_power now_is_login" data-url="6" <shiro:hasPermission name="exam:paper:edit"> data-power="1" </shiro:hasPermission> src="${ctxStatic}/hsun/front/img/question/3_2.png" onmouseover="questionBank.mouseOver(this,3)" onmouseout="questionBank.mouseOut(this,3)" /><br />智能组卷
                    </li>
                    <li>
                        <img class="no_power now_is_login" data-url="7" <shiro:hasPermission name="exam:paper:edit"> data-power="1" </shiro:hasPermission> src="${ctxStatic}/hsun/front/img/question/5_2.png" onmouseover="questionBank.mouseOver(this,5)" onmouseout="questionBank.mouseOut(this,5)" /><br />我的组卷
                    </li>
                    <li>
                        <img class="no_power now_is_login" data-url="8" <shiro:hasPermission name="exam:paper:edit"> data-power="1" </shiro:hasPermission> src="${ctxStatic}/hsun/front/img/question/10_2.png" onmouseover="questionBank.mouseOver(this,10)" onmouseout="questionBank.mouseOut(this,10)" /><br/>试卷批改
                    </li>
					<li>
						<img class="no_power now_is_login" data-url="9" src="${ctxStatic}/hsun/front/img/question/9_2.png" onmouseover="questionBank.mouseOver(this,9)" onmouseout="questionBank.mouseOut(this,9)" /><br />个人中心
					</li>
				</ul>
			</div>
		</div>

		<script type="text/template" id="hand_test">
			<form id="form_hand_test" class="form_test">
				<ul>
					<li>
						<%--<span>试卷名称：</span>--%>
						<input type="text" style="color: #333;" class="txtinput" id="txtName" name="name" placeholder="请输入试卷名称"/>
					</li>
					<li>
						<%--<span>答题时间(分钟)：</span>--%>
						<input type="text" style="color: #333;" class="txtinput" id="txtDuration"  placeholder="请输入答题时间(分钟)"/>
					</li>
				</ul>
				<div id="btn_hand_test">
					<a href="javascript:;"  class="active create_btn" onclick="questionBank.submitPaper('0','edit_item_page')">创建试卷</a>
				</div>
			</form>
		</script>
		<script type="text/template" id="auto_test">
			<form id="form_auto_test" class="form_test">
				<ul>
					<li>
						<%--<span>试卷名称：</span>--%>
						<input type="text" style="color: #333;" class="txtinput" id="txtName" name="name" placeholder="请输入试卷名称"/>
					</li>
					<li>
						<%--<span>答题时间(分钟)：</span>--%>
						<input type="text" style="color: #333;" class="txtinput" id="txtDuration" placeholder="请输入答题时间(分钟)"/>
					</li>
				</ul>
				<div id="btn_auto_test">
					<a href="javascript:;"  class="active create_btn" onclick="questionBank.submitPaper('2','edit_item_random_two')">创建试卷</a>
				</div>
			</form>
		</script>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/question_bank.js${v}"></script>