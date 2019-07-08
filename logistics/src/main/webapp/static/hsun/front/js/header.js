//个人中心显示隐藏
function displaySubMenu(div) {
	var subMenu = div.getElementsByTagName("ul")[0];
	if(subMenu.style.display == "block") {
		subMenu.style.display = "none";
	} else {
		subMenu.style.display = "block";
	}
}
// 没有登录时个人中心弹出登录框
function headerCenter(num){
	if(!validateUser()){
		validateLogin();
		return;
	}
	switch (num){
		case 1:
			window.open(urlpath+'/page/usercenter/usercenter.html','_self');
			break;
		case 2:
			window.open(urlpath +'/page/organization/organizationManage.html','_self');
			break;
		case 3:
			window.open(urlpath_a +'?console','_self');
			break;
		case 4:
			window.open(urlpath +'/page/usTeam/usTeam.html','_self');
			break;
	}
}
//头部切换
function titleClick(thisli, type) {
	if(type == 1) {
		window.location.href = projectname + "/course/showcoulist"+timestamps;
	} else if(type == 2) {
		window.location.href = projectname + "/page/library/knowledge_library.html"+timestamps;
	} else if(type == 3) {
		window.location.href = projectname + "/qa/questions/list";
	}
}


function frontLogout(){
	if(ws != null){
		ws.close();
		ws = null;
	}
	window.location.href = urlpath_a+'/logout'+timestamps;
}
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
	var loginPage = $('<div></div>');
	$('body').append(loginPage);
	loginPage.load(projectname + '/frontlogin');
}

//添加底部
window.onload = function(){
	$('body').append('<div id="footer"></div>');
	$('#footer').load(projectname + "/page/foot/foot.html"+timestamps);

	$('body').append('<div id="talk_view"></div>');
	$('#talk_view').load(projectname + '/page/rightSlider.html'+timestamps);

	//点击头部消息，模拟在线交流点击事件
	$('#divheader').on('click','.is_chat_news',function(){
		$('.tal').trigger('click');
	});
	if(validateUser()){
		$('body').append('<script type="text/javascript" src= "'+projectname +'/static/hsun/front/js/pagejs/talkView/WebSocket.js">')

	}

	// updataNews();
};

function isNoLogin(){
	$('.no_login span').trigger('click');
}

function headerNav(){
	// var nav_list    =document.getElementById('header_nav').getElementsByTagName('li');
	// var nav_bot     =document.getElementById('hender_bot');
	// for(var i=0;i<nav_list.length;i++){
	// 	var nav_index;
	// 	nav_bot.style.left= nav_index*118 + 39 +'px';
	// 	nav_list[i].index=i;
	// 	if(nav_list[i].className=='active'){
	// 		console.log(nav_list[i].index);
	// 		nav_index = nav_list[i].index;
	// 	}
	// 	nav_list[i].onmouseover=function(){
    //
	// 		var thisoff = this.offsetLeft + 39;
	// 		nav_bot.style.left = thisoff+'px';
	// 	};
    //
	// 	nav_list[i].onmouseout=function(){
	// 		nav_bot.style.left= nav_index*118 + 39 +'px';
    //
	// 	}
    //
	// }

	var nav_list    =$('#header_nav li');
	var nav_bot     =$('#hender_bot');
	navBg();

	for(var i=0;i<nav_list.length;i++){
		for(var i=0;i<nav_list.length;i++){
			var nav_index;
			nav_bot.css('left',nav_index*99 );
			if(nav_list.eq(i).hasClass('active')){
				nav_index = i;
			}
			nav_list.eq(i).mouseover(function(){
				nav_bot.css('left',$(this).position().left );
			});
			nav_list.eq(i).mouseout(function(){
				nav_bot.css('left',nav_index*99 );
			});
		}
	}

	//没有内容的两个导航绑定点击事件
	var set_nav_time = 0;
	$('.no_nav').click(function(){
		if(set_nav_time == 0){
			set_nav_time = 1;
			var alert_no = '<div id="alert_no_" style="' +
				'position: absolute;' +
				'left: 50%;top:-100px;' +
				'z-index:3;'+
				'background: #000;font-size:16px;' +
				'color:#fff;width:200px;' +
				'text-align:center;' +
				'line-height:70px;' +
				'height: 70px;' +
				'opacity: 0;' +
				'margin-left: -100px;' +
				'margin-top:-100px;'+
				'border-radius: 5px;' +
				'">暂未开通</div>';
			$('body').append(alert_no);
			$('#alert_no_').stop().animate({
				'top':'300px',
				'opacity':0.8
			},400,'swing');

			setTimeout(function(){
				$('#alert_no_').animate({
					'top':'-100px',
					'opacity':0
				},300,'swing',function(){
					$('#alert_no_').remove();
					set_nav_time = 0;
				});
			},2000);
			// set_nav_time = 0;
		}
	});

	//判断导航位置
	function navBg(){
		var windowUrl=window.location.href;
        // windowUrl_user = windowUrl;
        // windowUrl = windowUrl.substr(windowUrl.lastIndexOf(projectname+'/')+7);
        // windowUrl =  windowUrl.substr(0,2);
        // windowUrl_user = windowUrl_user.substr(windowUrl_user.lastIndexOf('/')+1);
        // windowUrl_user =  windowUrl_user.substr(0,10);
        // console.log(windowUrl);
        // if(windowUrl == 'qa'){
			// $('#header_nav li').removeClass('active');
			// $('#header_nav li').eq(5).addClass('active');
			// posBj(5);
        // } else if(windowUrl == 'co') {
			// $('#header_nav li').removeClass('active');
			// $('#header_nav li').eq(3).addClass('active');
			// posBj(3);
        // } else if(windowUrl_user == 'usercenter'|| windowUrl_user == 'organizati'|| windowUrl_user == 'roleManage' || windowUrl_user.match('usTeam')){
        //     $('#header_nav li').removeClass('active');
        //     $('#hender_bot').hide();
        // }
		if(windowUrl.match('qa')){
			$('#header_nav li').removeClass('active');
			$('#header_nav li').eq(2).addClass('active');
			posBj(2);
		} else if(windowUrl.match('course')) {
			$('#header_nav li').removeClass('active');
			$('#header_nav li').eq(0).addClass('active');
			posBj(0);
		} else if(windowUrl.match('usercenter')|| windowUrl.match('organizati')|| windowUrl.match('roleManage') || windowUrl.match('usTeam')){
			$('#header_nav li').removeClass('active');
			$('#hender_bot').hide();
		}
	}

	//导航标记位置
	function posBj(posNum){
		nav_bot.css('left',posNum*99 );
	}

}

//通知
function updataNews(){
	var notice = $('<div id="updata-news"></div>');
	$('body').append(notice);
	notice.load(projectname + '/page/updataNews/updataNews.html');
}

