
// 判断用户是否登录
function validateUser(){
	var islogin = false;
	$.ajax({
		url:urlpath+'/validateUser.jhtml',
		type:'post',
		async:false,
		success:function(ret) {
			if(ret.data) {
				islogin = true;
			}
		}
	});
	return islogin;
}
// 插入登录窗口
function validateLogin(){
    var islogin  = '<div class="login_container"></div>';
    if($('.login_container').length<=0){
        $('body').append(islogin);
        $('.login_container').load(urlpath + '/page/mobile/login/loginPc.html');
    }
}

// 加载移动端头部和底部
function loadMobile(){
	var isheader = '<header class="top_header"><i class="icon iconfont icon-jt-left"></i><span>课程</span></header><div class="header_size"></div>';
	$('body').prepend(isheader);
	var isfooter = [];
	isfooter.push('<div class="footer_size"></div>');
	isfooter.push('<footer class="top_footer">');
	isfooter.push(' <a class="text_login_btn course" data-href="'+urlpath+'/course/showcoulist" data-bg="course"><i class="icon iconfont icon-spzx"></i><span>课程</span></a>');
	isfooter.push(' <a class="text_login_btn usercenter" data-href="'+urlpath+'/page/mobile/userCenter/userCenter.html" data-bg="userCenter"><i class="icon iconfont icon-grzx"></i><span>我的</span></a>');
	isfooter.push('</footer>');
	$('body').append(isfooter.join(""));

     // 判断底部地址
     function testFooterBg(obj){
        var window_url = window.location.pathname;
        // var num1 = window_url.lastIndexOf('/');
        // var num2 = window_url.lastIndexOf('mobile/')+8;
        // var gethref = window_url.substring(num2,num1);

        var isobj = $('footer .text_login_btn');

        // var ishref = '';
        // if(gethref == 'course'){
        //     $('.top_header span').html('课程');
        //     courseBg();
        //     if(window_url.match('course/myFavourites')){
        //         $('.top_header span').html('课程收藏');
        //         userCenterBg();
        //     }else if(window_url.match('course/myCourses')){
        //         $('.top_header span').html('在学课程');
        //         userCenterBg();
        //     }
        // }else if(gethref == 'course/couinfo'){
        //     $('.top_header span').html('课程');
        //     courseBg();
        // }else if(gethref == 'course/play'){
        //     $('.top_header span').html('课程');
        //     courseBg();
        // }else if(gethref == 'qa/questions'){
        //     $('.top_header span').html('问答');
        //
        //
        // }else if(gethref == 'qa/questions/info'){
        //     $('.top_header span').html('问答');
        // }

        if(window_url.match('course/showcoulist')){
            $('.top_header span').html('课程');
            courseBg();
        }else if(window_url.match('course/couinfo')){
            $('.top_header span').html('课程');
            courseBg();
        }else if(window_url.match('course/play')){
            $('.top_header span').html('课程');
            courseBg();
        }else if(window_url.match('course/myCourses')){
            $('.top_header span').html('在学课程');
            userCenterBg();
        }else if(window_url.match('course/myFavourites')){
            $('.top_header span').html('课程收藏');
            userCenterBg();
        }else if(window_url.match('qa/questions')){
            $('.top_header span').html('问答');
        }


         else if(window_url.match('qa/myqa')){
            $('.top_header span').html('我的提问');
            userCenterBg();
        }else if(window_url.match('qa/myrepqa')){
            $('.top_header span').html('我的回答');
            userCenterBg();
        }

        // 个人信息和修改密码
         else if(window_url.match('a/sys/user/info')){
             $('.top_header span').html('个人信息');
             // ishref = urlpath +  '/page/mobile/userCenter/userCenter.html';
             userCenterBg()
         }else if(window_url.match('a/sys/user/modifyPwd')){
             $('.top_header span').html('安全管理');
             // ishref = urlpath +  '/page/mobile/userCenter/userCenter.html';
             userCenterBg()
         }else if(window_url.match('usTeam')){
             $('.top_header span').html('我的团队');
             userCenterBg()
         }


         function userCenterBg(){
             isobj.removeClass('active');
             $(".usercenter").addClass('active');
         }
         function courseBg(){
             isobj.removeClass('active');
             $(".course").addClass('active');
         }

         // console.log(ishref);
         $('.top_header .icon').off('click').on('click',function(){
            // window.location.href=  ishref;
             window.history.go(-1)
         });

     };
     //点击底部跳转
     function testFooterLogin(obj){
        obj.off('click').on('click',function(){
            if(!validateUser()){
                validateLogin();
                return;
            }
            var href = $(this).data('href');
            window.location.href = href;
        });
     };

     testFooterLogin($('footer .text_login_btn'));
     testFooterBg();
}
$(function(){
	loadMobile();

    window.onload = function(){
        $('a[target=_blank]').removeAttr('target');

        $('body').on('focus','input,textarea',function(){
            $('.top_header,.top_footer').css('position','static');
            $('.header_size,.footer_size').hide();
        });
        $('body').on('blur','input,textarea',function(){
            $('.top_header,.top_footer').css('position','fixed');
            $('.header_size,.footer_size').show();
        });
    }
});

