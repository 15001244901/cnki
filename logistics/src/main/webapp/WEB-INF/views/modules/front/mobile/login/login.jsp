<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<!-- UC强制全屏 -->
	<meta name="full-screen" content="yes">
	<!-- QQ强制全屏 -->
	<meta name="x5-fullscreen" content="true">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/font/iconfont.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/animate.min.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/flexible.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/header.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/mobile/css/login/login.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script src="${ctxStatic}/hsun/front/mobile/js/flexible.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/publicPath.js${v}"></script>
</head>
<body>
	<article class="login">
		<header class="bg1 color1">
			<i class="icon iconfont icon-jt-left" onclick="window.location.href='${ctxRoot}/page/mobile/home.html';"></i>
			<span>登录</span>
		</header>
		<div class="login_cont">
			<form id="loginForm" class="login_form" action="${ctx}/login" method="post">
				<div class="login_list bwid">
					<i class="logo_input icon iconfont icon-yonghuming"></i><input type="text" required name="username" placeholder="输入账号/手机号">
				</div>
				<p class="form_err color4 username_err">用户名格式不正确</p>

				<div class="login_list bwid">
					<i class="logo_input icon iconfont icon-mima"></i><input type="password" name="password" required placeholder="输入密码"><i class="icon iconfont icon-yanjing" onclick="changeText(this)"></i>
				</div>
				<p class="form_err color4 password_err">密码不能为空</p>
				<c:if test="${isValidateCodeLogin}">
					<div class="login_list bwid">
						<i class="logo_input icon iconfont icon-yanzhengma1"></i>
						<sys:validateCode name="validateCode" inputCssStyle="width:4rem;"/>
					</div>
					<p class="form_err color4 code_err">验证码不能为空</p>
				</c:if>
				<div class="rememberMe flex flex-cols-center">
					<span class="${rememberMe ? 'seleced' : ''}"></span><label for="rememberMe" onclick="rememberFun(this);">记住我（公共场所慎用）<input id="rememberMe" name="rememberMe" type="checkbox" ${rememberMe ? 'checked' : ''}></label>
				</div>

				<input type="hidden" name="loginConsole" value="0"/>
				<input type="hidden" name="mobileLogin" value="true"/>
				<input id="back_url" type="hidden" name="backURL">

				<input type="submit" class="sure login_btn disabled" id="login" value="登&nbsp;录">
			</form>

		</div>
	</article>
	
	
	<script src="${ctxStatic}/hsun/front/mobile/js/faskclick.js${v}"></script>
	<script src="${ctxStatic}/hsun/front/mobile/js/jquery.min.js${v}"></script>
	<script>
		$(function(){
			//优化click事件
			FastClick.attach(document.body);
			var loginFormFun = function(){
				var that = this;
				this.remove_login = $('.remove_login');
				this.back_url = $('#back_url');

				this.username = $('input[name=username]');
				this.password = $('input[name=password]');
				this.validateCode = $('input[name=validateCode]');

				this.isinput = $('.login_list input');

				this.login_btn = $('.login_btn');

				rememberFun = function(is){
					var checked = $(is).find('input').prop('checked');
					if(checked){
						$(is).parent('.rememberMe').find('span').addClass('seleced');
					}else{
						$(is).parent('.rememberMe').find('span').removeClass('seleced');
					}
				};

				//控制显示密码；
				changeText = function(is){
					var input = $(is).parent().find('input');

					if(input.attr('type') == 'password'){
						input.attr('type','text');
						$(is).css('color','#03CFD6');
					}else{
						input.attr('type','password');
						$(is).css('color','#888');
					}
				};

				this.alertBox = function(text,bj){
					var clasname = 'icon-success1';
					if(bj){
						clasname = 'icon-error2';
					}

					var alert_box = $('<div class="alert_box animated"></div>');
					$('body').append(alert_box);

					alert_box.html('<div><i class="icon iconfont '+clasname+'"></i>'+text+'</div>');
					alert_box.show().addClass('bounceInDown');

					setTimeout(function (argument) {
						alert_box.addClass('fadeOutDown').removeClass('bounceInDown');
						setTimeout(function (argument) {
							alert_box.remove();
						},1000);
					},3000);
				};

				this.removeLoginFun = function(){
					var islogin = $('.login_container', parent.document);
					islogin.animate({
						'left': '100%'},
					300, function() {
						islogin.remove();
					});
				};
				
				this.showLoginFun = function () {
					var islogin = $('.login_container', parent.document);
					if(islogin){
						islogin.animate({
							'left': 0},
						300);
					}
				};

				//获取地址
				this.getWindowUrl = function(){
					var isWinUrl = window.location.pathname;
					isWinUrl = isWinUrl.substr(isWinUrl.indexOf('/page/')+1);
					that.back_url.val(isWinUrl);
				};

				this.inputFocus = function(){
					$(this).closest('.login_list').next('.form_err').hide();
				};

				this.changeFun = function(){
					var isname = that.username.val();
					var ispass = that.password.val();

					if($.trim(isname) && $.trim(ispass)){
						that.login_btn.removeClass('disabled ');
					}else{
						that.login_btn.addClass('disabled ');
					}
				};

				this.formSublime = function(){
					var username = that.username.val();
					var password = that.password.val();
					isobj.addClass('bgbtn');
					setTimeout(function(){
						isobj.removeClass('bgbtn');
					},150);

					if(!$.trim(username)){
						$('.username_err').show();
						return false;
					}
					if(!$.trim(password)){
						$('.password_err').show();
						return false;
					}
					if(that.validateCode.length>0 && !$.trim(that.validateCode.val())){
						$('.code_err').show();
						return false;
					}
				};

				this.init = function(){
					this.remove_login.off('click').on('click',this.removeLoginFun);
					this.showLoginFun();
					//this.getWindowUrl();
					this.login_btn.off('click').on('click',this.formSublime);
					this.isinput.off('focus').on('focus',this.inputFocus);

					this.username.on('input propertychange',this.changeFun);
					this.password.on('input propertychange',this.changeFun);
				}
			};

			var loginForm = new loginFormFun;
			loginForm.init();

			var errorMessage = '${message}';
			if(errorMessage){
				loginForm.alertBox(errorMessage,'1');
			}
		});
	</script>
</body>
</html>