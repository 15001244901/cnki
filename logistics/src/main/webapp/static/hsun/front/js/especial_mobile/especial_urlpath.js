
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

				} else {
					// alert("服务器系统内部错误");

				}
				break;
			case(401):

				break;
			case(403):

				break;
			case(408):

				break;
			default:
				{


				}
		}
	}
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


