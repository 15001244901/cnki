$(function(){
	var Login = function(){
		//申明属性
		var that = this;
		var tab  = /\s/;                            //正则空格
		var cn   = /^.*[\u4e00-\u9fa5].*$/;         //正则至少含有一个汉字
		var reg_zimu    = /^[a-zA-Z]{8,20}$/;       //正则字母
		var reg_num     = /^[0-9]{8,20}$/;          //正则数字
		var reg_zn      = /^[a-zA-Z0-9]{8,20}$/;	//正则数字字母
		var reg         = /^[a-zA-Z0-9!,%,&,@,#,$,^,*,?,_,.,~]{8,20}$/;            //正则数字字母特殊字符
		var reg_email   = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/ ;   //正则邮箱

		var url  = 'http://139.129.97.177/ywork/a'; //发送地址变量
		var login_img = 'http://139.129.97.177/ywork/servlet/validateCodeServlet'; //验证码图片地址
		
		var height    = $(window).height();          //获取窗口高度
		var hei       = $('#container').height();    //获取根容器高度

		var login_style = 0;                        //设置一个登录方式变量，默认为0：普通用户登录
													//---1:管理用户登录
		var register_infor = 0;                     //承载注册公司信息 0:补提交，1：提交
		var register_user  = 0;                     //承载注册用户名信息 0:补提交，1：提交
		var register_pass  = 0;                     //承载注册密码信息 0:补提交，1：提交
		
		this.windows     = $('#window');            //获取半透明背景框
		this.container   = $('#container'); 		//获取根容器
		this.close       = $('#close');       		//获取总关闭按钮
		this.uesernamedel= $('.uesername_del'); 	//清除用户名内容按钮

		// 登录框属性--------------------------------------------------------
		this.login       = $('#login');          	//获取登录框容器
		this.getpassword = $('.get_password');		//忘记密码按钮
		this.inputstyle  = $('.input_style'); 		//获取选择登录方式 0 ；1
		this.goregist    = $('#go_regist');   		//进入注册框
		this.loginbtn       = $('#login_btn');      //获取登录提交按钮
		this.loginuesername = $('#login_uesername');//获取登录用户名
		this.loginpassword  = $('#login_password'); //获取登录密码
		this.logincaptcha   = $('#login_captcha');  //获取登录验证码
		this.loginphoto     = $('#login_photo');    //获取登录验证图片
		this.loginuesernameerr = $('#login-uesername-err'); //获取登录用户名错误报告
		this.loginpassworderr  = $('#login-password-err');  //获取登录密码错误报告
		this.logincaptchaerr   = $('#login-captcha-err');   //获取登录验证码错误报告

		// 注册框属性--------------------------------------------------------
		this.regist          = $('#regist');          //获取注册框容器
		this.backlogin       = $('#back_login');  	  //返回登录框
		this.registbtn       = $('#regist_btn');      //获取注册提交按钮
		this.registuesername = $('#regist_username'); //获取注册用户名
		this.registpassword  = $('#regist_password'); //获取注册密码
		this.infor           = $('#infor');           //获取注册公司信息
		this.strength        = $('.strength');        //获取密码强度
		this.registinforerr  = $('#regist-infor-err'); 		  //获取注册工作信息错误报告
		this.registuesernameerr = $('#regist-uesername-err'); //获取注册用户名错误报告
		this.registpassworderr  = $('#regist-password-err');  //获取注册密码错误报告
		this.degree             = $('#degree');               //获取注册强度进度条

		// 注册成功框属性--------------------------------------------------------
		this.registsuccess = $('#regist_success');  //获取注册成功框容器
		this.successbtn    = $('#success_btn');   	//获取注册成功提交按钮
		this.file          = $('#file');            //获取隐藏的文件类型put
		this.registsuccessphoto = $('.regist_success_photo');   //获取头像
		this.fileimg       = $('#file_img');                    //获取上传的图片
		this.successusername     = $('#success_username');      //获取昵称
		this.successuesernameerr = $('#success-uesername-err'); //获取昵称提示
		this.uploadForm          = $('#uploadForm');            //获取提交表单

		// 重设密码框属性--------------------------------------------------------
		this.reset          = $('#reset');           //获取重置密码框容器
		this.gologin        = $('#go_login');        //获取重设密码页返回按钮
		this.goemailreset   = $('#go_email_reset');  //获取进入邮箱重置框按钮
		this.gophonereset   = $('#go_phone_reset');  //获取进入短信框按钮

		// 邮箱方式重设密码框属性------------------------------------------------
		this.email_reset    = $('#email_reset');     //获取邮箱重置密码框容器
		this.email_login    = $('#email_login');     //获取重设邮箱密码框返回按钮

		// 短信方式重设密码框属性------------------------------------------------
       

		//总关闭按钮绑定方法
		this.Close = function(){
			that.windows.hide();
		}
		//登录框垂直居中
		this.vertical = function(e){
			hei = that.container.height();
			that.container.css('top',(height-hei)/2);

		}
		//窗口发生变化
		this.resize   = function(){
			$(window).resize(function() {
			    height= $(window).height();
			    hei = that.container.height();
			    that.vertical();
			});
		}
		//清除用户名内容
		this.uesernameDel = function(){
			$(this).parent('div').find('input').val('');
			if ($(this).attr('data-del') == 0) {
				that.loginBlur();
			}else{
				that.registBlurUser();
			};
			
		}
		//获取登录方式
		this.inputStyle = function(){
			login_style =  $(this).attr('data-style');
			that.inputstyle.removeClass('border_bottom3');
			$(this).addClass('border_bottom3');
		}
		//注册框返回登录框
		this.backLogin = function(){
			that.regist.hide();
			that.login.show();
			that.getHeight();

			that.registuesername.val('');
			that.registpassword.val('');
			that.infor.val('');

		}
		//重设密码框返回登录框
		this.goLogin = function(){
			that.reset.hide();
			that.login.show();
			that.getHeight();
		}
		//登录框进入注册框
		this.goRegist = function(){
			that.login.hide();
			that.regist.show();
			that.getHeight();
		}
		//登录框进入重设密码框
		this.getPassword = function(){
			that.login.hide();
			that.reset.show();
			that.getHeight();
		}
		//重设密码框进入邮箱重设密码框
		this.goEmailReset = function(){
			that.email_reset.find('h1').find('p').html('邮箱重置密码');
			that.email_reset.find('.login_input').children('div').eq(2).hide();
			that.reset.hide();
			that.email_reset.show();
			that.getHeight();
		}
		//邮箱框返回登录框
		this.emailLogin = function(){
			that.email_reset.hide();
			that.reset.show();
			that.getHeight();
		}
		//重设密码框进入短信重设密码框
		this.goPhoneReset = function(){
			that.email_reset.find('h1').find('p').html('短信重置密码');
			that.email_reset.find('.login_input').children('div').eq(2).show();

			that.reset.hide();
			that.email_reset.show();
			that.getHeight();
		}
		//重新获取根容器高度
		this.getHeight = function(){
		 	hei = that.container.height();
			that.vertical();
		}
		//动态添加验证图片地址
		this.imgSrc = function(){
			that.loginphoto.attr('src',login_img);
		}

		//登录提交
		this.loginBtn =function(){
			var reg_email   = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/ ;      //正则邮箱
			if (that.loginuesername.val() && that.loginuesername.val().match(reg_email) && !that.loginuesername.val().match(tab)) { //判断登录用户名是否为空
				if(that.loginpassword.val() && that.loginpassword.val().match(tab)){       //判断登录密码是否为空
					if(that.logincaptcha.val() && that.logincaptcha.val().match(tab)){     //判断登录验证码是否为空
						$.ajax({
							url :url+' ',
				            type : 'POST',               
				            data:{
				            	logintype   : login_style,               //登录方式
				            	name        :that.loginuesername.val(),  //用户登录名
				            	password    :that.loginpassword.val(),   //登录密码
				            	validateCode:that.logincaptcha.val(),    //验证码
				            },
				            // timeout : 1,
				            dataType:'jsonp',           // 传递的数据类型
							jsonp: 'callback',
		     				jsonpCallback: "successCallback",
				            success : function (ret) {
								console.log(ret);
				            	if(ret.success == 1){
				            		alert('ok');
				            		that.windows.hide();
				            	}
				            	
				            },
				            error: function(xhr, errorText, errorStatus){
				            	alert(errorText);
				            	// alert(errorStatus);
				            	//<meta http-equiv="refresh" content="0; url=" /> 
				            }
				        });

					}else{
						that.logincaptcha.addClass('err');
						that.logincaptchaerr.html('验证码不能为空');
					}
				}else{
					that.loginpassword.addClass('err');
					that.loginpassworderr.html('密码不能为空');
				}

			}else{
				that.login.find('.uesername_del').addClass('uesername_del_err');
				that.loginuesername.addClass('err');
				that.loginuesernameerr.html('用户名不符合规范');
			};
			that.logincaptcha.val('');                                  //验证码内容清空
			that.loginphoto.attr('src',imgSrc+'?'+new Date().getTime()); //更新验证图片
		}

		//注册账号
		this.registBtn = function(){
			if(that.infor.val()){                     //公司信息是否为空
				if (that.registuesername.val()) {     //注册用户名是否为空
					if(that.registpassword.val()){    //注册密码是否为空
						if(register_infor && register_user && register_pass){
							alert('ok')
							that.regist.hide();
							that.registsuccess.show();
							// $.ajax({
							// 	url :url+'/exam/question/commentsave.jhtml',
					  //           type : 'POST',               
					  //           data:{
					  //           	content     :that.infor.val(),            //注册公司信息
					  //           	name        :that.registuesername.val(),  //注册用户名
					  //           	password    :that.registpassword.val(),    //登录密码
					  //           },
					  //           // timeout : 1,
					  //           dataType:'jsonp',           // 传递的数据类型
							// 	jsonp: 'callback',
			    //  				jsonpCallback: "successCallback",
					  //           success : function (ret) {
							// 		console.log(ret);
					  //           	if(ret.success == 1){
					  //           		alert('ok');
					  //           		that.regist.hide();
					  //           		that.registsuccess.show()//注册成功栏出现
					  //           	}
					            	
					  //           },
					  //           error: function(xhr, errorText, errorStatus){
					  //           	alert(errorText);
					  //           	// alert(errorStatus);
					  //           }
					  //       });
						}
						
					}else{
						that.degree.addClass('degree_err');
						that.registpassword.addClass('err');
						that.registpassworderr.html('密码不能为空');
					}
				}else{
					that.regist.find('.uesername_del').removeClass('uesername_del_x').addClass('uesername_del_err');
					that.registuesername.addClass('err');
					that.registuesernameerr.html('用户名不能为空');
				};
			}else{
				that.infor.addClass('err');
				that.registinforerr.html('公司信息不能为空');
			}

		}

		//登录用户名失去焦点
		this.loginBlur = function(){
			if(!that.loginuesername.val()){
				that.login.find('.uesername_del').removeClass('uesername_del_x');
				that.loginuesernameerr.html('用户名不能为空');
				that.LoginErrs();
			}else{
				if(that.loginuesername.val().match(tab)){
					that.loginuesernameerr.html('用户名不能有空格');
					that.LoginErrs();
				}else{
					if (!that.loginuesername.val().match(reg_email)) {
						that.loginuesernameerr.html('用户名为邮箱');
						that.LoginErrs();
					}
				}
			}
		}
		//登录用户名错误类
		this.LoginErrs = function(){
			that.loginuesername.addClass('err');
			that.login.find('.uesername_del').removeClass('uesername_del_x').addClass('uesername_del_err');
		}

		//登录密码失去焦点
		this.loginBlurPass = function(){
			if(that.loginpassword.val()){
				if(that.loginpassword.val().match(tab)){
					that.loginpassword.addClass('err');
					that.loginpassworderr.html('密码不能有空格');
				}else{
					if(!that.loginpassword.val().match(reg_zn) || !that.loginpassword.val().match(reg)){
						that.loginpassword.addClass('err');
						that.loginpassworderr.html('密码格式不正确');
					}
				}
			}else{
				that.loginpassword.addClass('err');
				that.loginpassworderr.html('密码不能为空');
			}
		}

		//注册公司信息失去焦点
		this.registBlurInfor = function(){
			if (!that.infor.val()) {
				that.infor.addClass('err');
				that.registinforerr.html('公司信息不能为空');
				register_infor = 0;
			}else{
				if (that.infor.val().match(cn)) {
					register_infor = 1;
				}else{
					that.infor.addClass('err');
					that.registinforerr.html('公司信息不符合规范');
					register_infor = 0;
				};
				
			};
		}

		//注册用户名失去焦点
		this.registBlurUser = function(){
			if(that.registuesername.val()){
				if (that.registuesername.val().match(tab)) {
					that.RegistErrs();
					that.registuesernameerr.html('用户名不能有空格');
					register_user = 0;
				}else{
					if (that.registuesername.val().match(reg_email)) {
						register_user = 1;
					}else{
						that.RegistErrs();
						that.registuesernameerr.html('用户名不符合规范');
						register_user = 0;
					};
				};
			}else{
				that.RegistErrs();
				that.registuesernameerr.html('用户名不能为空');
				register_user = 0;
			}
			
		} 

		//注册用户名错误类
		this.RegistErrs = function(){
			that.registuesername.addClass('err');
			that.regist.find('.uesername_del').removeClass('uesername_del_x').addClass('uesername_del_err');
		}

		//注册密码键失去焦点
		this.registBlurPass = function(){
			if (that.registpassword.val().match(tab)) {
				that.registPassClass();
				that.registpassworderr.html('密码不能有空格');
			}else{
				if (that.registpassword.val().length>=8 && that.registpassword.val().length<15) {
					if (that.registpassword.val().match(reg_zimu) || that.registpassword.val().match(reg_num)) {
						that.registPassClass();
						that.registpassworderr.html('密码不能由单一字母或数字组成');
					}else if(that.registpassword.val().match(reg_zn)){
						that.degree.html('弱');
						that.strength.find('span').removeClass('strength_bg1 strength_bg2 strength_bg3');
						that.strength.find('span').eq(0).addClass('strength_bg1');
						register_pass = 1;
					}else if(that.registpassword.val().match(reg)){
						that.registStrengthClass();
					}else{
						that.registPassClass();
						that.registpassworderr.html('密码不符合规范');
					};
				}else if(that.registpassword.val().length>=15){
					if (that.registpassword.val().match(reg_zimu) || that.registpassword.val().match(reg_num)) {
						that.registPassClass();
						that.registpassworderr.html('密码不能由单一字母或数字组成');
					}else if(that.registpassword.val().match(reg_zn)){
						that.registStrengthClass();
					}else if(that.registpassword.val().match(reg)){
						that.degree.html('强');
						that.strength.find('span').removeClass('strength_bg1 strength_bg2 strength_bg3');
						that.strength.find('span').eq(0).addClass('strength_bg3');
						that.strength.find('span').eq(1).addClass('strength_bg3');
						that.strength.find('span').eq(2).addClass('strength_bg3');
						register_pass = 1;
					}else{
						that.registPassClass();
						that.registpassworderr.html('密码不符合规范');
					};

				}else{
					that.registPassClass();
					that.registpassworderr.html('密码长度不小8位');
				};
			};
			
		} 

		//注册密码错误类
		this.registPassClass = function(){
			that.degree.addClass('degree_err');
			that.registpassword.addClass('err');
			that.strength.find('span').removeClass('strength_bg1 strength_bg2 strength_bg3');
			register_pass = 0;
		}
		//注册密码强度显示类
		this.registStrengthClass = function(){
			that.degree.html('中');
			that.strength.find('span').removeClass('strength_bg1 strength_bg2 strength_bg3');
			that.strength.find('span').eq(0).addClass('strength_bg2');
			that.strength.find('span').eq(1).addClass('strength_bg2');
			register_pass = 1;
		}

		//所有输入框获取焦点
		this.loginFocus = function(){
			$(this).removeClass('err');
			$(this).parent('div').find('.uesername_del').removeClass('uesername_del_err').addClass('uesername_del_x');
			// $(this).parent('div').find('.uesername_del').removeClass('uesername_del_err');
			$(this).parent('div').find('.input-text-err').html(' ');
			$(this).parent('div').find('#degree').removeClass('degree_err');
			if($(this).hasClass('regist_password')){
				that.degree.html('');
				that.strength.find('span').removeClass('strength_bg1 strength_bg2 strength_bg3');
			}
		}
		//注册成功框的确认
		// this.successBtn = function(){

		// 	alert()
		// 	var formData = new FormData($( "#uploadForm" )[0]);  
		//     $.ajax({  
		//         url: '1.php' ,  
		//         type: 'POST',  
		//         data: formData,  
		//         async: false,  
		//         cache: false,  
		//         contentType: false,  
		//         processData: false, 
  //               dataType:'jsonp', 
		// 		jsonp: 'callback',
 	// 			jsonpCallback: "successCallback", 
	 //            success: function (returndata) {  
	 //                alert(returndata);  
	 //            },  
		//         error: function (returndata) {  
		//             alert(returndata);  
		//         }  
		//     });  
		// }

		//注册成功本地上传图像路径
		getPhoto = function(node){
			var imgPath = $(node).val();
			//alert(imgPath);
			var strExtension = imgPath.substr(imgPath.lastIndexOf('.') + 1);
            if (strExtension != 'jpg' && strExtension != 'gif'
            && strExtension != 'png' && strExtension != 'bmp') {
                alert("请选择png、jpg、gif、bmp格式图片文件");
                return;
            }
            
			var imgURL = "";  
	        try{  
	            var file = null;  
	            if(node.files && node.files[0] ){  
	                file = node.files[0];  
	            }else if(node.files && node.files.item(0)) {  
	                file = node.files.item(0);  
	            }  
	            try{  
	                imgURL =  file.getAsDataURL();  
	            }catch(e){  
	                imgRUL = window.URL.createObjectURL(file);  
	            }  
	        }catch(e){  
	            if (node.files && node.files[0]) {  
	                var reader = new FileReader();  
	                reader.onload = function (e) {  
	                    imgURL = e.target.result;  
	                };  
	                reader.readAsDataURL(node.files[0]);  
	            }  
	        } 
	        creatImg(imgRUL); 
	        return imgURL;  
		}
		//注册成功本地上传图像
		creatImg = function(imgRUL){
			//alert(imgRUL);
			that.fileimg.prop('src',imgRUL);
			that.fileimg.show();
		}
		
		//注册成功昵称失去焦点
		this.successUserName = function(){
			if(!that.successusername.val().match(reg_zn)){
				that.successusername.addClass('err');
				that.successuesernameerr.html('昵称只能由数字和字母组成');
			}
			
		}

		//昵称为空或不符要求时，阻止表单提交 reg_num reg_zn
		this.uploadForms = function(e){
			var formData = that.uploadForm.serialize()+"&fileimg="+$("input[name='fileimg']").val();
			e.preventDefault();
			if(!that.successusername.val() || !that.successusername.val().match(reg_zn)){
				that.successusername.addClass('err');
				that.successuesernameerr.html('昵称由8-20位字母和数字或字母组成');
			}else{
				$.ajax({  
		          url: url+'' ,  
		          type: 'POST',  
		          data: formData,  
		          async: false,  
		          cache: false,  
		          contentType: false,  
		          processData: false,  
		          success: function (returndata) {  
		              alert(returndata);  
		          },  
		          error: function (returndata) {  
		              alert(returndata);  
		          }  
		     });  
			}

		}

		this.init = function(){
			// this.imgSrc();                 //初始化加载验证码图片
			this.vertical();                  //初始化窗口垂直位置
			this.resize();                    //窗口发生变化，改变窗口垂直位置

			//注册页返回登录框绑定点击事件
			this.backlogin.off('click').on('click',this.backLogin);   
			//重设密码页返回登录框绑定点击事件
			this.gologin.off('click').on('click',this.goLogin); 
			//邮箱重置密码框 返回登录框点击事件
			this.email_login.off('click').on('click',this.emailLogin);  
			//进入邮箱重置密码框点击事件
			this.goemailreset.off('click').on('click',this.goEmailReset);
			//进入短信重置密码框点击事件
			this.gophonereset.off('click').on('click',this.goPhoneReset);
			
			this.close.off('click').on('click',this.Close);              //总关闭按钮绑定点击事件
			this.getpassword.off('click').on('click',this.getPassword);  //进入重设密码框
			this.uesernamedel.off('click').on('click',this.uesernameDel);//清除当前用户名内容
			this.goregist.off('click').on('click',this.goRegist);        //进入注册框绑定点击事件

			this.inputstyle.off('click').on('click',this.inputStyle);    //切换登录方式绑定点击事件

			this.loginuesername.off('focus').on('focus',this.loginFocus); //登录用户名获取焦点
			this.loginpassword.off('focus').on('focus',this.loginFocus);  //登录密码获取焦点
			this.logincaptcha.off('focus').on('focus',this.loginFocus);   //登录验证码获取焦点
			this.loginuesername.off('blur').on('blur',this.loginBlur);    //登录用户名失去焦点
			this.loginpassword.off('blur').on('blur',this.loginBlurPass); //登录密码失去焦点

			this.infor.off('focus').on('focus',this.loginFocus);           //注册公司信息获取焦点
			this.registuesername.off('focus').on('focus',this.loginFocus); //注册用户名获取焦点
			this.registpassword.off('focus').on('focus',this.loginFocus);  //注册密码获取焦点
			this.infor.off('blur').on('blur',this.registBlurInfor);        //注册公司信息名失去焦点
			this.registuesername.off('blur').on('blur',this.registBlurUser);//注册用户名失去焦点
			this.registpassword.off('blur').on('blur',this.registBlurPass); //注册密码失去焦点

			this.loginbtn.off('click').on('click',this.loginBtn);     //登录提交按钮绑定点击事件
			this.registbtn.off('click').on('click',this.registBtn);   //注册提交按钮绑定点击事件

			//注册成功后绑定事件--------------------------------------------------------------
			// this.registsuccessphoto.off('click').on('click',this.registSuccessPhoto);
			// this.successbtn.off('click').on('click',this.successBtn);
			this.successusername.off('blur').on('blur',this.successUserName); //昵称失去焦点
			this.successusername.off('focus').on('focus',this.loginFocus);    //昵称获取焦点
			this.uploadForm.off('submit').on('submit',this.uploadForms);       //表单提交绑定sublim事件
		}

	}

	var login = new Login();
	login.init();
});