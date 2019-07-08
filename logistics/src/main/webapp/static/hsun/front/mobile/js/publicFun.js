
//公用函数
var publicFun = {
	//获取url参数 传值url中的key
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	},

	//数据正则匹配方法(迭代数据时)
	comPile : function(templateString , dictionary){
	    return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
	        return dictionary[$1];
	    });
	},

	//去除所有p标签
    delP : function(str){
		if(str) {
			str = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
			str = str.replace(/&nbsp;/g,"");
		}
		return str;
	},
	//去除所有style标签
    delStyle : function(str){
		if(str) {
			str = str.replace(/style\s*?=\s*?([‘"])[\s\S]*?\1/g,"");//去掉
			str = str.replace(/&nbsp;/g,"");
		}
		return str;
	},
	//去除所有div标签
    delDiv : function(str){
		if(str) {
			str = str.replace(/<\/*div.*?>/g,"");
			str = str.replace(/<br>/g,"");
		}
		return str;
	},

	//匹配填空题的空格个数
    replaceInputLength : function(qcontent) {
    	var count = 0;
		var html = qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g,function(m,i){
			count ++;
			m = '____';
			return m;
		});
		var isinput = {'count':count,'html':html};
		return isinput;
	},

	//转化填空题的空格
    replaceInput : function(qcontent) {
		return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '____')
	},

	//消息提示框
	alertBox : function(text,bj){
		var clasname = 'icon-success1';
		if(bj){
			clasname = 'icon-error2';
		}

		var alert_box = $('<div class="alert_box animated"></div>');
		$('body').append(alert_box);
		
		alert_box.html('<div><i class="icon iconfont '+clasname+'"></i>'+text+'</div>');
		alert_box.show().addClass('bounceInDown');
		
		setTimeout(function (argument) {
			alert_box.addClass('fadeOutDown').removeClass('bounceInDown');
			setTimeout(function (argument) {
				alert_box.remove();
			},1000);
		},2000);
	},
	//暂无数据
	noData : function(container){
		var isnodata = '<div class="nodata"></div>';
		container.html(isnodata);
	},
	//正在加载
	loading : function(container){
		var loadingHtml = '<div class="loading"></div>';
		container.append(loadingHtml);
	},
	//点击背景
	bgClick : function(){
		document.body.addEventListener('touchstart', function() {}, false);
	},
	//点击时改变背景颜色
	backgroundClick :function(obj){
		obj.addClass('bgbtn');
		setTimeout(function(){
			obj.removeClass('bgbtn');
		},200);
	},
	// 转换大写数字
	changeBigNumber : function(num){
		// if(!num) return num;

		switch (num){
			case(0):
				num = '一';
				break;
			case(1):
				num = '二';
				break;
			case(2):
				num = '三';
				break;
			case(3):
				num = '四';
				break;
			case(4):
				num = '五';
				break;
			case(5):
				num = '六';
				break;	
		}

		return num;
	},
	// 判断底部地址
	testFooterBg : function(obj){
		var window_url = window.location.pathname;
		var num1 = window_url.lastIndexOf('/');
		var num2 = window_url.lastIndexOf('mobile/')+7;
		var gethref = window_url.substring(num2,num1);

		var isobj = $('footer .text_login_btn');
		isobj.each(function(){
			var ishref = $(this).data('bg');
			if(ishref == gethref){
				$(this).addClass('active');
			}
		})

	},
	//点击底部跳转
	testFooterLogin : function(obj){
		obj.off('click').on('click',function(){
			if(!publicFun.validateUser()){
				publicFun.jumpLoginPage2();
				return;
			}
			var href = $(this).data('href');
			window.location.href = href;
		});
	},
	// 登录验证
	validateUser : function(){
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
	},
	validateLogin : function(){
		if(!publicFun.validateUser()){
			publicFun.jumpLoginPage2();
			return;
		}
	},
	// 跳转到登录页面
	jumpLoginPage : function(){
		var islogin  = '<div class="login_container"><iframe class="login_iframe" src="'+urlpath+'/mobile/mobel/login/login.html" frameborder="0"></iframe></div>';

		if($('.login_container').length<=0){
			$('body').append(islogin);
		}
	},
	jumpLoginPage2 : function(){
		var islogin  = '<div class="login_container"></div>';
		if($('.login_container').length<=0){
			$('body').append(islogin);
			$('.login_container').load(urlpath + '/page/mobile/login/ajaxlogin.html');
		}
	}

};
publicFun.testFooterLogin($('footer .text_login_btn'));
publicFun.testFooterBg();

if(!publicFun.validateUser()){
	publicFun.jumpLoginPage2();
}

// ajax全局设置
$.ajaxSetup({
	dataType: "json",
	// jsonp: "callback",
	//jsonpCallback: "successCallback",
	timeout:30000,
	cache:false,
	beforeSend:function(){

	},
	error: function(jqXHR, textStatus, errorThrown) {
		$('.loading').remove();
		switch(jqXHR.status) {
			case(500):
				if(jqXHR.responseText.indexOf('UnauthenticatedException')>=0) {
					publicFun.jumpLoginPage2();
				} else {
					publicFun.alertBox('服务器系统内部错误','1');
				}
				break;
			case(401):
				publicFun.alertBox('未登录','1');
				break;
			case(403):
				publicFun.alertBox('无权限','1');
				break;
			case(408):
				publicFun.alertBox('请求超时','1');
				break;
			default:
				publicFun.alertBox('未知错误','1');

		}
	}
});


// 禁止页面拖动
function publicFunPreventMove(idname){
	document.body.ontouchmove = function (e) {
        e.preventDefault();
	};

	var startX = 0, startY = 0;
    //touchstart事件  
    function touchSatrtFunc(evt) {
        try
        {
            //evt.preventDefault(); //阻止触摸时浏览器的缩放、滚动条滚动等  

            var touch = evt.touches[0]; //获取第一个触点  
            var x = Number(touch.pageX); //页面触点X坐标  
            var y = Number(touch.pageY); //页面触点Y坐标  
            //记录触点初始位置  
            startX = x;
            startY = y;

        } catch (e) {
            alert('touchSatrtFunc：' + e.message);
        }
    }
    document.addEventListener('touchstart', touchSatrtFunc, false);

    var _ss = document.getElementById(idname);
    _ss.ontouchmove = function (ev) {
        var _point = ev.touches[0],
            _top = _ss.scrollTop;
        // 什么时候到底部
        var _bottomFaVal = _ss.scrollHeight - _ss.offsetHeight;
        // 到达顶端
        if (_top === 0) {
            // 阻止向下滑动
            if (_point.clientY > startY) {
                ev.preventDefault();
            } else {
                // 阻止冒泡
                // 正常执行
                ev.stopPropagation();
            }
        } else if (_top === _bottomFaVal) {
            // 到达底部
            // 阻止向上滑动
            if (_point.clientY < startY) {
                ev.preventDefault();
            } else {
                // 阻止冒泡
                // 正常执行
                ev.stopPropagation();
            }
        } else if (_top > 0 && _top < _bottomFaVal) {
            ev.stopPropagation();
        } else {
            // ev.preventDefault();
            ev.stopPropagation();
        }
    };
}

