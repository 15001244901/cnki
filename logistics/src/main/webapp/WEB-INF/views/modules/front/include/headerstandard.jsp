<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>地理云课堂</title>
	</head>

	<body style=" min-width: 1200px; text-align:center">
		<!--头部部分-->
		<header id="header">
			<div class="center">
				<div class="logo">
					<img src="${ctxStatic}/hsun/front/img/logo.png${v}" alt="地理云课堂" />
				</div>
				<div class="link" id="header_nav">
					<ul>
						<div id="hender_bot"></div>
						<li name="liTitle" onclick="titleClick(this,1)">
							<a href="javascript:;">课程</a>
						</li>
						<li name="liTitle" onclick="titleClick(this,2)">
							<a href="javascript:;">知识</a>
						</li>
						<li name="liTitle" onclick="titleClick(this,3)">
							<a href="javascript:;">问答</a>
						</li>
					</ul>
				</div>
				<c:if test="${not empty fns:getUser().id}">
				<div class="divinfo">
					<div class="is_chat_news" style="">
						我的消息
						<i class="fa fa-commenting-o" style=""></i>
						<span id="ischats">0</span>
					</div>
					<%--<div class="username">--%>
						<%--<ul class="one">--%>
							<%--<li class="firstChild">--%>
								<%--<div class="header1">--%>
									<%--<div class="userhead" style="z-index: 99;">--%>
										<%--<c:set var="userphoto" value="${ctxStatic}/images/userphoto.jpg${v}"/>--%>
										<%--<c:if test="${not empty fns:getUser().photo}">--%>
											<%--<c:set var="userphoto" value="${fns:getUser().photo}"/>--%>
										<%--</c:if>--%>
										<%--<img src="${userphoto}" style="width: 43px;height: 43px;margin-top: 45px;border-radius: 50%;" />--%>
									<%--</div>--%>
									<%--<span style="color: #A5A5A5; z-index: 99;" id="welcome">欢迎回来!</span>--%>
									<%--<div id="put_bottom" style="position: relative;" onclick="displaySubMenu(this)" onclick="hideSubMenu(this)">--%>
										<%--<div class="more" style="position: absolute; z-index: 99;">--%>
											<%--<div style="position: relative;right: -80px !important; top: 8px; font-size: 12px;float: left;">--%>
												<%--${fns:getUser().name} &nbsp;&nbsp;--%>
												<%--<a href="javascript:;"><i class="iconfont icon-jiantouxiangxia" style="font-size: 8px;"></i></a><br />--%>
											<%--</div>--%>
											<%--<!--<div style="left:0px; bottom:0px;float:right;margin-left: 75px; margin-top: -18px;">--%>
												<%--</div>-->--%>
										<%--</div>--%>
										<%--<div id="family1" style="position: absolute;">--%>
											<%--<ul class="pull-down2" style="list-style:none; display:none;">--%>

												<%--<li><span class="head_portrait"><img src="${ctxStatic}/hsun/front/img/personal_center.png${v}"/></span><span class="family"><a href="${ctxRoot}/page/usercenter/usercenter.html">个人中心</a></span></li>--%>

												<%--&lt;%&ndash;<li><span class="head_portrait"><img src="${ctxStatic}/hsun/front/img/alter.png"/></span><span class="family">修改资料</span></li>&ndash;%&gt;--%>

												<%--<li onclick="frontLogout()"><span class="head_portrait"><img src="${ctxStatic}/hsun/front/img/exit.png${v}"/></span><span class="family">退出登入</span></li>--%>

											<%--</ul>--%>

										<%--</div>--%>
									<%--</div>--%>
								<%--</div>--%>
							<%--</li>--%>
						<%--</ul>--%>
					<%--</div>--%>
					<c:set var="userphoto" value="${ctxStatic}/images/userphoto.jpg${v}"/>
					<c:if test="${not empty fns:getUser().photo}">
						<c:set var="userphoto" value="${fns:getUser().photo}"/>
					</c:if>
					<div class="user_name">
						<div class="user_photo">
							<span><img src="${userphoto}" alt=""></span>
							<span class="user_title">
								<span class="user_title_name">${fns:getUser().name}</span><br>
								<span class="user_title_sys">欢迎回来！</span>
							</span>

						</div>

						<ul class="user_list">
							<li onclick="headerCenter(1)"><span><img src="${ctxStatic}/hsun/front/img/personal_center.png${v}"/></span><span><a href="javascript:void(0);">个人中心</a></span></li>
								<%--<li><span class="head_portrait"><img src="${ctxStatic}/hsun/front/img/alter.png"/></span><span class="family">修改资料</span></li>--%>
							<shiro:hasAnyRoles name="ROLE_CUS_ADMIN,ROLE_CUS_SUBADMIN,dept">
								<li onclick="headerCenter(2)"><span><img src="${ctxStatic}/hsun/front/img/alter.png${v}"/></span><span><a href="javascript:void(0);">通讯录</a></span></li>
							</shiro:hasAnyRoles>
							<c:if test="${fns:getUser().userType eq '1'}">
								<li onclick="headerCenter(3)"><span><img src="${ctxStatic}/hsun/front/img/alter.png${v}"/></span><span><a href="javascript:void(0);">控制台</a></span></li>
							</c:if>
							<shiro:hasAnyRoles name="ROLE_CUS_JGLD,ROLE_CUS_ADMIN,ROLE_CUS_SUBADMIN,dept">
								<li onclick="headerCenter(4)"><span><img src="${ctxStatic}/hsun/front/img/alter.png${v}"/></span><span><a href="javascript:void(0);">我的团队</a></span></li>
							</shiro:hasAnyRoles>
							<li onclick="frontLogout()"><span><img src="${ctxStatic}/hsun/front/img/exit.png${v}"/></span><span>退出登入</span></li>
						</ul>
						<div id="user_top">

						</div>
					</div>
				</div>
				</c:if>
				<c:if test="${empty fns:getUser().id}">
					<div class="no_login">
						<a href="javascript:void(0);" class="help"> 帮助中心<i style="background:url(${ctxRoot}/static/hsun/front/img/spriter-a.png) no-repeat -427px -309px;"></i></a>
						<span class="active">登录</span>
						<a class="no_res" href="${ctxRoot}/register;" target="_blank">注册</a>
					</div>
				</c:if>
			</div>
			<input type="hidden" id="getUserId" value="${fns:getUser().id}">
		</header>
		<script>
			headerNav();
		</script>
	</body>

</html>