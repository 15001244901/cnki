
//建立一个时间戳的全局变量
var timestamps = '?t='+new Date().getTime();
var timestampv = '&v='+new Date().getTime();

$.ajaxSetup({
	// dataType: "jsonp",
	// jsonp: "callback",
	// jsonpCallback: "successCallback",
	timeout:30000,
	cache:false,
	error: function(jqXHR, textStatus, errorThrown) {
		switch(jqXHR.status) {
			case(500):
				if(jqXHR.responseText.indexOf('UnauthenticatedException')>=0) {
					// alert('请先登录！');
					var loginPage = $('<div></div>');
					$('body').append(loginPage);
					loginPage.load(projectname +'/frontlogin?t='+Math.random());
				} else {
					// alert("服务器系统内部错误");
					layer.open({
						title: '系统提示',
						closeBtn: 1,
						skin: 'layui-layer-molv',
						content: '<div style="text-align:center;">服务器系统内部错误</div>',
						yes: function(index, layero){
							layer.close(index);
						}
					});
				}
				break;
			case(401):
				layer.open({
					title: '系统提示',
					closeBtn: 1,
					skin: 'layui-layer-molv',
					content: '<div style="text-align:center;">未登录</div>',
					yes: function(index, layero){
						layer.close(index);
					}
				});
				break;
			case(403):
				layer.open({
					title: '系统提示',
					closeBtn: 1,
					skin: 'layui-layer-molv',
					content: '<div style="text-align:center;">无权限执行此操作</div>',
					yes: function(index, layero){
						layer.close(index);
					}
				});
				break;
			case(408):
				layer.open({
					title: '系统提示',
					closeBtn: 1,
					skin: 'layui-layer-molv',
					content: '<div style="text-align:center;">请求超时</div>',
					yes: function(index, layero){
						layer.close(index);
					}
				});
				break;
			default:
				{
					// if(jqXHR.status == 200) {
					// 	try {
					// 		var ret = JSON.parse(jqXHR.responseText);
					// 		if(ret.code == '401') {
					// 			var loginPage = $('<div></div>');
					// 			$('body').append(loginPage);
					// 			loginPage.load('/ywork/frontlogin');
					// 			return;
					// 		}
                    //
					// 		if(json.code == '403') {
					// 			alert('您无权访问该功能！');
					// 			return;
					// 		}
                    //
					// 		if(ret.message) {
					// 			alert(ret.message);
					// 			return;
					// 		}
					// 	} catch(e) {
					// 		// var loginPage = $('<div></div>');
					// 		// $('body').append(loginPage);
					// 		// loginPage.load('/ywork/frontlogin');
					// 		// return;
					// 	}
                    //
					// }
					// alert("未知错误");

				}
		}
	}
});

$(document).ready(function(){
	$('body').on('click','.no_login span',function(){
		var loginPage = $('<div></div>');
		$('body').append(loginPage);
		loginPage.load(projectname + '/frontlogin'+timestamps);
	});

    $(document).ajaxStart(function(){
        $('.load_img').html('<div id="load_div" style="width: 100%;min-height:250px;position: relative;"></div>');
        var loading_img = '<img id="load_img" style="margin-top:-33px;margin-left:-33px;display: block;position: absolute;top:50%; left:50%;" src="'+imgUrl+'/usercenter/images/loading.gif" alt="">';
        $('#load_div').height($('#load_div').parent().height());
        $('#load_div').html(loading_img);

    });
    $(document).ajaxStop(function(){
        $('#load_div').remove();
    });

});

//加载数据失败
function loadFail(id){
	var this_fail_img = '<div id="load_fail" style="text-align: center;display: block;margin:120px auto 0;"><img src="'+imgUrl+'/usercenter/images/getfail.png" alt=""><P style="font-size: 16px;color: #D1D3D8;">&nbsp;&nbsp;&nbsp;获取数据失败～～</P></div>';
	setTimeout(function(){
		$(id).html(this_fail_img);
	},500);
}
//正在加载数据
function nowLoadData(id){
	var this_load_img = '<div style="text-align: center;display: block;margin:150px auto 0;position: static;"><img src="'+imgUrl+'/usercenter/images/loading.gif" alt=""></div>';
	$(id).html(this_load_img);
}

//获取url
var jqUrl;
$(function () {
	var windowUrl=window.location.href;
	var t = windowUrl.substr(windowUrl.indexOf('/page/')+1);
	// console.log(t);
	jqUrl = t;
	// document.oncontextmenu=function(){return false;};
	// document.onselectstart=function(){return false;};
});


// if(/AppleWebKit.*mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))){
// 	if(window.location.href.indexOf("?mobile")<0){
// 		try{
// 			if(/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)){
// 				window.location.href=urlpath + "/page/mobel/home.html";
// 			}else if(/iPad/i.test(navigator.userAgent)){
// 				window.location.href= urlpath + "/page/mobel/home.html";
// 			}else{
// 				window.location.href= urlpath + "/page/mobel/home.html"
// 			}
// 		}catch(e){}
// 	}
// }
if(/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
	window.location.href=urlpath + "/page/mobile/home.html";
}

