<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>${fns:getConfig('productName')} 登录</title>
    <%@include file="/WEB-INF/views/include/head_materialize.jsp" %>
    <link href="${ctxStatic}/materialize/css/page-center.css" type="text/css" rel="stylesheet" media="screen,projection">
    <style>
        .has-error input {
            border-bottom-color: #f44336;
        }

        .has-error .help-block {
            color: #f44336;
            opacity: 1;
        }
    </style>
</head>
<body class="cyan">
<!-- Start Page Loading -->
<div id="loader-wrapper">
    <div id="loader"></div>
    <div class="loader-section section-left"></div>
    <div class="loader-section section-right"></div>
</div>
<!-- End Page Loading -->
<div id="login-page" class="row">
    <div class="col s12 z-depth-4 card-panel">
        <form class="login-form" id="loginForm" action="${ctx}/login" method="post">
            <div class="row">
                <div class="input-field col s12 center">
                    <img src="${ctxStatic}/materialize/images/user-bg-2.jpg" alt="" class="circle responsive-img valign profile-image-login">
                    <p class="center login-form-text">欢迎使用加贝物流管理系统</p>
                </div>
            </div>
            <div class="row margin">
                <div class="input-field col s12">
                    <i class="mdi-social-person-outline prefix"></i>
                    <input id="username" type="text" name="username" class="required">
                    <label for="username" class="center-align">帐号</label>
                </div>
            </div>
            <div class="row margin">
                <div class="input-field col s12">
                    <i class="mdi-action-lock-outline prefix"></i>
                    <input id="password" type="password" name="password" class="required">
                    <label for="password">密码</label>
                </div>
            </div>
            <c:if test="${isValidateCodeLogin}"><div class="row margin validateCode">
                <div class="input-field col s12">
                    <i class="mdi-action-lock-outline prefix"></i>
                    <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                    <label class="input-label mid" for="validateCode">验证码</label>
                </div>
            </div></c:if>
            <div class="row">
                <div class="input-field col s12 m12 l12  login-text">
                    <input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}/>
                    <label for="rememberMe" title="下次不需要再登录">记住我（公共场所慎用）</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <button type="submit" class="btn waves-effect waves-light col s12">登录</button>
                </div>
            </div>
            <%--<div class="row">--%>
                <%--<div class="input-field col s6 m6 l6">--%>
                    <%--<p class="margin medium-small"><a href="#">马上注册!</a></p>--%>
                <%--</div>--%>
                <%--<div class="input-field col s6 m6 l6">--%>
                    <%--<p class="margin right-align medium-small"><a href="#">忘记密码 ?</a></p>--%>
                <%--</div>--%>
            <%--</div>--%>
        </form>
    </div>
</div>
<!-- ================================================
    Scripts
    ================================================ -->
<!-- jQuery Library -->
<script type="text/javascript" src="${ctxStatic}/materialize/js/jquery-1.11.2.min.js"></script>
<!--materialize js-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/materialize.js"></script>
<!--prism-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/prism.js"></script>
<!--scrollbar-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<!--plugins.js - Some Specific JS codes for Plugin Settings-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/plugins.js"></script>

<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function() {
        var errorMessage = '${message}';
        if(errorMessage)
            Materialize.toast(errorMessage, 4000);
        $("#loginForm").validate({
            rules: {
                validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
            },
            messages: {
                username: {required: "请填写帐号"},password: {required: "请填写密码"},
                validateCode: {remote: "验证码不正确", required: "请填写验证码"}
            },
            highlight: function (element) {
                $(element).closest('.input-field').addClass('has-error');
            },
            unhighlight: function (element) {
                $(element).closest('.input-field').removeClass('has-error');
            },
            errorElement: 'span',
            errorClass: 'help-block',
            errorPlacement: function (error, element) {
//				Materialize.toast(error.html(), 4000);
//				error.appendTo($(element).closest('.input-field').find('label'));
            }
        });
    });
    // 如果在框架或在对话框中，则弹出提示并跳转到首页
    if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
        alert('未登录或登录超时。请重新登录，谢谢！');
        top.location = "${ctx}";
    }
</script>

</body>
</html>