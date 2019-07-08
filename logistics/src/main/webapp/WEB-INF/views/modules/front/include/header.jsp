<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>地理云课堂</title>
	</head>

	<body style="min-width: 1200px; text-align:center">
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
						<li name="liTitle" class="active" onclick="titleClick(this,2)">
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
							<shiro:hasAnyRoles name="ROLE_CUS_ADMIN,ROLE_CUS_SUBADMIN,dept">
								<li onclick="headerCenter(2)"><span><img src="${ctxStatic}/hsun/front/img/alter.png${v}"/></span><span><a href="javascript:void(0);">通讯录</a></span></li>
							</shiro:hasAnyRoles>
							<c:if test="${fns:getUser().userType eq '1'}">
								<li onclick="headerCenter(3)"><span><img src="${ctxStatic}/hsun/front/img/alter.png${v}"/></span><span><a href="javascript:void(0);">控制台</a></span></li>
							</c:if>
							<shiro:hasAnyRoles name="ROLE_CUS_JGLD,ROLE_CUS_ADMIN,ROLE_CUS_SUBADMIN,dept">
								<li onclick="headerCenter(4)"><span><img src="${ctxStatic}/hsun/front/img/alter.png${v}"/></span><span><a href="javascript:void(0);">我的团队</a></span></li>
							</shiro:hasAnyRoles>
								<%--<li><span class="head_portrait"><img src="${ctxStatic}/hsun/front/img/alter.png"/></span><span class="family">修改资料</span></li>--%>
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
					<span class="no_log active">登录</span>
					<a class="no_res" href="${ctxRoot}/register;" target="_blank">注册</a>
				</div>
				</c:if>
			</div>
            <input type="hidden" id="getUserId" value="${fns:getUser().id}">
			<script>
				headerNav();
			</script>
		</header>
	</body>

</html>