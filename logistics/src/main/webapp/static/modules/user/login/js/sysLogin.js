$(function(){
	var Login = function(){
		//申明属性
		var that = this;
		
		var height    = $(window).height();          //获取窗口高度
		var hei       = $('#container').height();    //获取根容器高度
		
		this.windows     = $('#window');            //获取半透明背景框
		this.container   = $('#container'); 		//获取根容器
		this.uesernamedel= $('.uesername_del'); 	//清除用户名内容按钮
		this.userstyle  = $('.userstyle'); 		    //获取选择登录方式 0 ；1

		// 登录框属性--------------------------------------------------------
		this.login       = $('#login');          	//获取登录框容器
		this.getpassword = $('.get_password');		//忘记密码按钮
		this.goregist    = $('#go_regist');   		//进入注册框
		this.inputstyle  = $('.input_style'); 		//获取选择登录方式 0 ；1
		this.loginuesername = $('#login-uesername');//获取登录用户名
		this.uesernamedel   =$('.uesername_del');   //用户名清除键
		
		//窗口发生变化
		this.resize   = function(){
			$(window).resize(function() {
			    height= $(window).height();
			    hei = that.container.height();
				var ltop = (height-hei)/2;
				that.container.css('top',ltop)
			});
		}

		//获取登录方式
		this.inputStyle = function(){
			var login_style =  $(this).attr('data-style');
			that.inputstyle.removeClass('border_bottom3');
			$(this).addClass('border_bottom3');
			$(this).parent('li').find('input').trigger('click');
		}
		
		//清除用户名内容
		this.uesernameDel = function(){
			that.loginuesername.val('');
			that.uesernamedel.hide();
		}

		//用户名键盘监听事件
		this.keyDown = function(){
			if(that.loginuesername.val()){
				that.uesernamedel.show();
			}else{
				that.uesernamedel.hide();
			}
		}

		
		//重新获取根容器高度
		this.getHeight = function(){
		 	hei = that.container.height();
			that.vertical();
		}

		this.init = function(){
			this.resize();                    //窗口发生变化，改变窗口垂直位置
			this.getpassword.off('click').on('click',this.getPassword);  //进入重设密码框
			this.goregist.off('click').on('click',this.goRegist);        //进入注册框绑定点击事件
			this.inputstyle.off('click').on('click',this.inputStyle);    //切换登录方式绑定点击事件
			this.loginuesername.off('keydown').on('keydown',this.keyDown);  //用户名按键监听事件
			this.uesernamedel.off('click').on('click',this.uesernameDel);  // 用户名清空事件
		}

	}

	var login = new Login();
	login.init();
});