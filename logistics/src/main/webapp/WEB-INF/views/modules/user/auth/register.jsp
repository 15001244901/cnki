<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>注册</title>
    <link rel="stylesheet" href="${ctxStatic}/modules/user/register/css/register.css${v}"></head>
</head>
<body>
<div class="g-cw1 reg-wrap">
    <h2>地理云课堂注册新账号</h2>
    <div class="reg-bd">
        <ul class="flow-tag">
            <li class="step_num active">第一步：填写公司信息<i></i></li>
            <li class="step_num ">第二步：填写个人信息<i></i></li>
            <li class="step_num ">第三步：完成注册<i></i></li>
        </ul>
        <div class="main-view">


        </div>
    </div>
    <div class="address">

    </div>

</div>

<script type="text/template" id="step1">
    <div class="form-wrap cfx bo_infor">
        <div class="form-line">
            <label><span>*</span>公司名称：</label>
            <div class="set-input">
                <input type="text" id="gsname" onblur="gsnameBlur();" name="gsname" placeholder="请输入公司名称">
                <span></span>
            </div>
        </div>
        <div class="form-line">
            <label><span>*</span>公司简介：</label>
            <div class="set-input">
                <textarea type="text" id="gsinfor" name="gsinfor" placeholder="请输公司简介，如地址、联系方式和所属行业等。"></textarea>
            </div>
        </div>
        <div class="form-btn cfx">
            <button class="reg-btn" onclick="onloadTwoEmail()" type="submit" id="reg_next">下一步</button>
        </div>
    </div>
    <div class="login">
        <span>已拥有地理云课堂账号，</span><a href="${cxt}/ywork/a/login">登录&gt&gt</a>
    </div>
</script>
<script type="text/template" id="step2-email">
    <div class="form-wrap cfx">
        <div class="reg-form">
            <input type="hidden" name="style" value="1">
            <div class="form-line hint-line">
                <p class="ttips">提示：您当前注册的是<span>企业管理用户</span>身份，注册成功后无法更改，<a href="javascript:void(0);" onclick="onloadOne()" class="return-step1">上一步&gt&gt</a></p>

            </div>
            <div class="form-line">
                <label><span>*</span>手机号码：</label>
                <div class="set-input">
                    <label class="ie-placeholder" for="email">请输入手机号码</label>
                    <input type="text" name="text" id="email" onblur="registerName()" onkeyup="registerName()" placeholder="请输入手机号码">
                    <span></span>
                    <%--<a class="p-reg" href="javascript:;" data-type="mobile">手机注册>></a>--%>
                </div>
            </div>
            <div class="form-line">
                <label><span>*</span>用户姓名：</label>
                <div class="set-input">
                    <label class="ie-placeholder" for="password">请输入真时有效的姓名</label>
                    <input type="text" name="name" onblur="realName()" id="real_name" placeholder="请输入真时有效的姓名"><span></span>
                </div>
            </div>
            <div class="form-line">
                <label><span>*</span>登录密码：</label>
                <div class="set-input">
                    <label class="ie-placeholder" for="password">请输入密码</label>
                    <input type="password" name="password" onblur="registerPass()" onkeyup="registerPass()" id="password" placeholder="请输入密码"><span></span>
                </div>
            </div>
            <div class="form-line">
                <label><span>*</span>确认密码：</label>
                <div class="set-input">
                    <label class="ie-placeholder" for="password2">请输入密码</label>
                    <input type="password" name="password2" onblur="registerPass2()" id="password2" placeholder="请输入密码"><span></span>
                </div>
            </div>
            <!-- <div class="form-line">
                <label><span>*</span>邮箱验证码：</label>
                <div class="set-input">
                    <label class="ie-placeholder" for="scode">请输入验证码</label>
                    <div class="input-b"><input type="text" class="code-txt" name="scode" onblur="registerCode()" id="scode" placeholder="请输入验证码"><span></span></div>
                    <a href="javascript:void(0);" onclick="getUserCode()" class="get-code" data-type="email" id="get_code">获取验证码</a>
                </div>
            </div> -->
            <div class="agree-line"><span class="custom-checkbox checked"><i class="cu-checkbox4"></i><input type="checkbox" name="agree" value="1"  checked></span>我同意<a href="" target="_blank">《地理云课堂》</a></div>
            <p id="fail">注册失败</p>
            <div class="form-btn cfx">
                <button class="reg-btn" onclick="submitTest()" type="submit" id="reg_btn">注册</button>
            </div>
        </div>
        <div class="login">
            <span>已拥有地理云课堂账号，</span><a href="${cxt}/ywork/a/login">登录&gt&gt</a>
        </div>
    </div>
</script>
<script type="text/template" id="step3">
    <div>
        <div class="success-wrap cfx">
            <img src="${ctxStatic}/modules/user/register/images/success.png" width="100">
            <div class="success-msg">
                <h3>账号注册成功！</h3>
                <p style="font-align:center;" align="center"><a href="javascript:void(0);" id="j-return-url"><span class="seconds">2</span>秒后 如果您的浏览器没有自动跳转，请点击此链接</a></p>
            </div>
        </div>
    </div>
</script>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script>
<%--<script src="${ctxStatic}/modules/user/register/js/register.js"></script>--%>
<script>
    $(function(){
        var Register  = function(){
            var that = this;
            var url = '${ctxRoot}';

            var step = 0;                   //承载步骤,默认在第一步
            var step1 = $('#step1').html(); //获取注册第一步模板
            var step2email = $('#step2-email').html(); //获取注册第二步邮箱模板
            var step3 = $('#step3').html();            //获取注册第三步模板

            var tab  = /\s/;                            //正则空格
            var cn   = /^.*[\u4e00-\u9fa5].*$/;         //正则至少含有一个汉字
            var reg_zimu    = /^[a-zA-Z]{4,20}$/;       //正则字母
            var reg_num     = /^[0-9]{4,20}$/;          //正则数字
            var reg_zn      = /^[a-zA-Z0-9]{4,20}$/;	//正则数字字母
            var reg         = /^[a-zA-Z0-9!,%,&,@,#,$,^,*,?,_,.,~]{4,20}$/;  //正则数字字母特殊字符
            var reg_email   = /^[a-zA-Z0-9\u4e00-\u9fa5_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/ ;   //正则邮箱
            var reg_phone   = /^1[34578]\d{9}$/;       //手机号码

            this.mainview = $('.main-view');//承载注册内容容器
            this.stepnum  = $('.step_num'); //获取注册步骤

            //加载第一步
            onloadOne = function(){
                that.mainview.html(step1);
                that.regstyle = $('.reg-style');  //选择注册方式键
                step = 0;
                that.stepnum.removeClass('active');
                that.stepnum.eq(0).addClass('active');

                that.gsname = $('#gsname');      //公司名称
                that.gsinfor = $('#gsinfor');    //公司简介
            }

            //公司名称失去焦点
            gsnameBlur = function(){
                if (that.gsname.val()) {
                    that.gsname.parent('div').find('span').html('');
                }else{
                    that.gsname.parent('div').find('span').html(' 公司名称必填');
                }
            }
            //加载第二步邮箱
            onloadTwoEmail = function(){
                if (!that.gsname.val()) {
                    that.gsname.parent('div').find('span').html(' 公司名称必填');
                }else{
                    step = 1;
                    that.mainview.html(step2email);                      //插入第二部

                    that.stepnum.removeClass('active');
                    that.stepnum.eq(0).addClass('active');
                    that.stepnum.eq(1).addClass('active');

                    that.regform = $('#reg_form');                      //获取表单
                    that.regbtn  = $('#reg_btn');                       //获取表单提交键
                    that.getcode = $('#get_code');                      //获取邮箱验证码
                    that.email      =$('#email');                       //获取邮箱
                    that.password   =$('#password');                    //获取密码
                    that.password2  =$('#password2');                   //确认密码
                    that.scode      =$('#scode');                       //输入邮箱验证码
                    that.agree      =$('#agree');                       //获取同意
                    that.returnUrl  =$('#j-return-url');              //获取成功跳转

                    that.realName   = $('#real_name');                //用户名
                };

            };

            //加载第二步手机
            this.onloadTwoTell = function(){
                // that.mainview.html(step2email);
            };

            //加载第三步
            this.onloadThree = function(ret){
                step = 2;
                that.stepnum.addClass('active');
                that.mainview.html(step3);
                setTimeout(function(){
                    window.location.href='${ctxRoot}';
                },2000);
                that.returnUrl.prop('href','${ctxRoot}');
            };

            //提交表单
            submitTest = function(){
                // console.log(formData);
                if (that.email.val().match(reg_phone)) {
                    if(that.password.val().match(reg) || that.password.val().match(reg_zn)){
                        if(that.password2.val() === that.password.val()){
                            if(!that.scode.val()){
                                if(!that.realName.val()){
                                    that.realName.parent('div').find('span').html('用户名不能为空');
                                    return;
                                }
                                $.ajax({
                                    url :url+'/register',
                                    type : 'POST',
                                    data: {
                                        loginName :that.email.val(),
                                        password  :that.password.val(),
                                        'company.area.id':'1',
                                        'company.name':that.gsname.val(),
                                        'name':that.realName.val()
                                    },
                                    dataType:'json',           // 传递的数据类型
                                    success : function (ret) {
                                        if(ret.success){
                                            that.onloadThree(ret);

                                        }else{
                                            $('#fail').html(ret.msg).show();
                                            setTimeout(function(){
                                                $('#fail').hide();
                                            },10000);
                                        }

                                    },
                                    error: function(xhr, errorText, errorStatus){
                                        alert(errorText);
                                        // alert(errorStatus);
                                    }
                                });

                            }else{
                                that.scode.parent('div').find('span').html('验证码不正确');
                            }
                        }else{
                            that.password2.parent('div').find('span').html('两次密码不一致');
                        }

                    }else{
                        that.password.parent('div').find('span').html('5-20个数字、字母和符号');
                    }
                }else{
                    that.email.parent('div').find('span').html('格式不正确');
                };
                return false;
            };

            //获取邮箱验证码
            this.onloadAjax = function(e){
                $.ajax({
                    url :url+'/register',
                    type : 'POST',
                    data: {
                        loginName:e
                    },
                    // timeout : 1,
                    dataType:'jsonp',           // 传递的数据类型
                    jsonp: 'callback',
                    jsonpCallback: "successCallback",
                    success : function (ret) {
                        console.log(ret);
                        if(ret.success == 1){


                        }

                    },
                    error: function(xhr, errorText, errorStatus){
                        alert(errorText);
                        // alert(errorStatus);
                    }
                });
            };

            //邮箱按键监听
            registerName = function(){
                if (that.email.val().match(reg_phone)){
                    that.email.parent('div').find('span').html('');
                }else{
                    that.email.parent('div').find('span').html('格式不正确');
                }
            };
            //密码按键监听
            registerPass = function(){
                if (that.password.val().match(reg) || that.password.val().match(reg_zn)){
                    that.password.parent('div').find('span').html('');
                }else{
                    that.password.parent('div').find('span').html('5-20个数字、字母和符号');
                }
            }
            //密码失去焦点
            registerPass2 = function(){
                if (that.password2.val() === that.password.val()){
                    that.password2.parent('div').find('span').html('');
                }else{
                    that.password2.parent('div').find('span').html('两次密码不一致');
                }
            };
            //验证码失去焦点
            registerCode = function(){
                if (that.scode.val()){
                    that.scode.parent('div').find('span').html('');
                }else{
                    that.scode.parent('div').find('span').html('验证码不正确');
                }
            };
            //用户名失去焦点
            realName = function(){
                if (that.realName.val()){
                    that.realName.parent('div').find('span').html('');
                }else{
                    that.realName.parent('div').find('span').html('用户名不能为空');
                }
            };
            //获取验证码
            getUserCode = function(){
                if (that.email.val().match(reg_email)){
                    that.onloadAjax(that.email.val());
                }else{
                    that.email.parent('div').find('span').html('格式不正确');
                }
            };

            //数据正则匹配方法
            this.comPile = function(templateString , dictionary){
                return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                    return dictionary[$1];
                });
            };

            this.init = function(){
                onloadOne();                                               //加载第一步
            };

        };

        var register = new Register();
        register.init();

    });

</script>
</body>
</html>