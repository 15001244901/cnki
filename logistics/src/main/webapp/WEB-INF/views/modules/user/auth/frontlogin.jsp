<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${fns:getConfig('productName')}登录</title>
    <link rel="stylesheet" href="${ctxStatic}/modules/user/login/css/loginBase.css${v}">
    <link rel="stylesheet" href="${ctxStatic}/modules/user/login/css/frontLogin.css${v}">

</head>
<body>
<div id="window" class="window">

    <div id="containers" class="containers auto">
        <div id="close" class="is_clouse_login"></div>
        <!-- 登录 -->
        <div id="login" class="login ">
            <h1 class="text2">
                欢迎登录
                <a id="go_regist" class="" href="${ctxRoot}/register;" target="_blank">注册</a>
            </h1>

            <div class="login_input">
                <form id="loginForm" action="${ctx}/login" method="post">
                    <ul class="login_style mb30 over">
                        <li><span class="input_style border_bottom3" data-style="0">普通登录</span>
                            <input class="userstyle" type="radio" name="loginConsole" checked value="0"/>
                        </li>
                        <li><span class="input_style" data-style="1">管理登录</span>
                            <input class="userstyle" type="radio" name="loginConsole" value="1"/>
                            <%--<input  class="userstyle"  type="checkbox" id="loginConsole" name="loginConsole"/>--%>
                        </li>
                    </ul>
                    <div>
                        <input id="login-uesername" type="text" required name="username" placeholder="用户名/手机号">
                        <span class="uesername_del uesername_del_x hide" data-del="0"></span>
                        <i class="uesername-icon icon"></i>
                        <span id="login-uesername-err" class="uesername-err input-text-err"></span>
                        <span class="hp-flag"></span>
                    </div>
                    <div>
                        <input id="login-password" type="password" name="password" required minlength="3" maxlength="20" placeholder="密码">
                        <i class="password-icon icon"></i>
                        <a class="get_password" href="javascript:void(0);">忘记密码？</a>
                        <span id="login-password-err" class="password-err input-text-err"></span>
                    </div>
                    <c:if test="${isValidateCodeLogin}">
                        <div>
                            <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                            <span id="validateCode-err" class="captcha-err input-text-err"></span>
                            <i class="captcha-icon icon"></i>
                        </div></c:if>
                    <div>
                        <input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}/>
                        <label id="rememberMeInfor" for="rememberMe" title="下次不需要再登录">记住我（公共场所慎用）</label>
                    </div>
                    <%--截取浏览器地址--%>
                    <input id="back_url" type="hidden" name="backURL">
                    <div>
                        <button id="login_btn" class="login_btn" type="submit">登录</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--<script src="${ctxStatic}/jquery/jquery-1.8.3.js"></script>--%>
    <script src="${ctxStatic}/modules/user/login/js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/modules/user/login/js/messages_zh.js" type="text/javascript"></script>
    <script src="${ctxStatic}/modules/user/login/js/frontLogin.js${v}"></script>

    <script type="text/javascript">

        var errorMessage = '${message}';
        if(errorMessage){
            $('#login_btn').html(errorMessage);
            $('#login_btn').css('color','#ff615b');
        }
        setTimeout(function(){
            $('#login_btn').css('color','#fff');
            $('#login_btn').html('登录');
        },4000);
        $().ready(function() {
            // 在键盘按下并释放及提交后验证提交表单
            $("#loginForm").validate({
                rules: {
                    validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
                },
                errorClass:"err",
                messages: {
                    username: {
                        required: "请输入邮箱用户名"
                    },
                    password: {
                        required: "请输入密码",
                        minlength: "密码长度不能小于4 个字母",
                        maxlength: "字母不能少于 4 个且不能大于 20 个"
                    },
                    validateCode:{
                        required: "请输入验证码"
                    }
                },
                errorPlacement: function(error, element) {
                    // Append error within linked label
                    $( element ).closest( "#loginForm" ).find( "#" + element.attr( "id" )+"-err").append( error );
                },

            });
        });
        // 如果在框架或在对话框中，则弹出提示并跳转到首页
        if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
            alert('未登录或登录超时。请重新登录，谢谢！');
            top.location = "${ctx}";
        }
    </script>
</div>

</body>
</html>