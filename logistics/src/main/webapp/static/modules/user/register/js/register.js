$(function(){
	var Register  = function(){
		var that = this;
		var url = '${ctx}';

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
				that.returnUrl  =$('#j-return-url');                          //获取成功跳转
			};
			
		}

		//加载第二步手机
		this.onloadTwoTell = function(){
			// that.mainview.html(step2email);
		}

		//加载第三步
		this.onloadThree = function(ret){
			step = 2;
			that.stepnum.addClass('active');
			that.mainview.html(step3);
			that.returnUrl.prop('href',ret.returnUR);
			setTimeout(function(){
				window.location.href=ret.returnUR; 
			},4000);
		}

		//提交表单
		submitTest = function(){
			// console.log(formData);
			if (that.email.val().match(reg_email)) {
				if(that.password.val().match(reg) || that.password.val().match(reg_zn)){
					if(that.password2.val() === that.password.val()){
						if(that.scode.val()){
							// that.onloadThree();
							$.ajax({
								url :url+'/register',
								type : 'POST',
								data: {
									loginName :that.email.val(),
									password  :that.password.val(),
									'company.area.id':'1',
									'company.name':that.gsname.val()
								},
								// timeout : 1,
								dataType:'jsonp',           // 传递的数据类型
								jsonp: 'callback',
								jsonpCallback: "successCallback",
								success : function (ret) {
									console.log(ret);
									if(ret.success){
										that.onloadThree(ret);

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
		}

		//获取邮箱验证码
		this.onloadAjax = function(){
			$.ajax({
				url :url+'/register',
	            type : 'POST',               
	            data: {
	            	loginName:that.email.val()
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
		}

		//邮箱按键监听
		registerName = function(){
			if (that.email.val().match(reg_email)){
				that.email.parent('div').find('span').html('');
			}else{
				that.email.parent('div').find('span').html('格式不正确');
			}
		}
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
		}
		//验证码失去焦点
		registerCode = function(){
			if (that.scode.val()){
				that.scode.parent('div').find('span').html('');
			}else{
				that.scode.parent('div').find('span').html('验证码不正确');
			}
		}
		//获取验证码
		getUserCode = function(){
			if (that.email.val().match(reg_email)){
				that.onloadAjax();
			}else{
				that.email.parent('div').find('span').html('格式不正确');
			}
		}

		//数据正则匹配方法
		this.comPile = function(templateString , dictionary){
			return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
				return dictionary[$1];
			});
		}

		this.init = function(){
			onloadOne();                                               //加载第一步
		}

	}

	var register = new Register();
	register.init();

});
