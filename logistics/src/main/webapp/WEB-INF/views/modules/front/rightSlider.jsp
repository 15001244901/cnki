<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <style>
        .yb_conct{position:fixed;z-index:9;top:180px;right:-127px;cursor:pointer;transition:all .3s ease}
        .yb_bar ul li{width:180px;height:53px;font:16px/53px 'Microsoft YaHei';color:#fff;text-indent:54px;margin-bottom:3px;border-radius:3px;transition:all .5s ease;overflow:hidden}
        .yb_bar .yb_top{background:#399d60 url(${ctxStatic}/hsun/front/img/rightSlider/fixCont.png) no-repeat 0 0}
        .yb_bar .yb_phone{background:#399d60 url(${ctxStatic}/hsun/front/img/rightSlider/fixCont.png) no-repeat 0 -57px}
        .yb_bar .yb_QQ{text-indent:0;background:#399d60 url(${ctxStatic}/hsun/front/img/rightSlider/tx1.png) no-repeat 8px center;background-size:36px 36px;}
        .yb_bar .yb_ercode{background:#399d60 url(${ctxStatic}/hsun/front/img/rightSlider/fixCont.png) no-repeat 0 -169px}
        .yb_bar .yb_ercode .hd_qr{margin:0 29px 25px 29px;width: 125px;}
        .yb_QQ a{display:block;text-indent:54px;width:100%;height:100%;color:#fff}
        /*#dyrsb{ height:154px; width:174px; margin-bottom:0px; background: left bottom url(/ywork/static/hsun/front/img/rightSlider/xtb.png)  no-repeat ; }*/
    </style>
</head>
<body>
<div class="yb_conct">
    <div class="yb_bar">
        <ul>
            <!--<li id="dyrsb"></li>-->
            <li class="yb_top">返回顶部</li>
            <li class="yb_phone">010-88888888</li>
            <!--<li class="yb_QQ">
              <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1771031323&site=qq&menu=yes" title="在线咨询">在线咨询</a>
            </li>-->
            <c:if test="${not empty fns:getUser().id}">
            <li class="yb_QQ">
                <%--<a target="_blank" href="${ctxRoot}/front/talkView.html" title="在线交流">在线交流</a>--%>
                <a class="tal" href="javascript:void(0)" title="在线交流">在线交流</a>
            </li>
            </c:if>
            <c:if test="${empty fns:getUser().id}">
                <li class="yb_QQ">
                    <a class="nologin" href="javascript:void(0);" title="在线交流">在线交流</a>
                </li>
            </c:if>
            <li class="yb_ercode" style="height:53px;">微信二维码 <br>
                <img class="hd_qr" src="${ctxStatic}/hsun/front/img/rightSlider/1520421614.png${v}" alt="地理云课堂">
            </li>
        </ul>
    </div>
</div>
<script>
    $(function() {
        // 悬浮窗口
        $(".yb_conct").hover(function() {
            $(".yb_conct").css("right", "5px");
            $(".yb_bar .yb_ercode").css('height', '200px');
//	    		$("#dyrsb").css('background-image', 'url(list_images/jykf.png)');
            $("#dyrsb").css('height', '154px');
            $("#dyrsb").css('width', '174px');
        }, function() {
            $(".yb_conct").css("right", "-127px");
            $(".yb_bar .yb_ercode").css('height', '53px');
//	    		$("#dyrsb").css('background-image', 'url(list_images/xtb.png)');
        });
        // 返回顶部
        $(".yb_top").click(function() {
            $("html,body").animate({
                'scrollTop': '0px'
            }, 300)
        });

        //未登录时点击在线交流弹出登录框
        $('.yb_conct').off('click').on('click','.nologin',function(){
            var loginPage = $('<div></div>');
            $('body').append(loginPage);
            loginPage.load('${ctxRoot}/frontlogin');
        });

        $('.yb_QQ').off('click').on('click','.tal',function(){
            if(validateUser()){
                layer.open({
                    type: 2,
                    title:'',
                    area: ['950px', '570px'],
                    fixed: true, //不固定
                    maxmin: false,
                    content: '${ctxRoot}/front/talkView.html?t='+ new Date().getTime()
                });
            }else{
                var loginPage = $('<div></div>');
                $('body').append(loginPage);
                loginPage.load('${ctxRoot}/frontlogin');
            }

            <%--window.open('${ctxRoot}/front/talkView.html','_blank','width=950,height=501,top=0,left=0');--%>
        });

    });
</script>
</body>
</html>
