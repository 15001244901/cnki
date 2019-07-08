<%@ page contentType="text/html;charset=UTF-8" %>
<!-- ================================================
Scripts
================================================ -->
<!-- jQuery Library -->
<script type="text/javascript" src="${ctxStatic}/materialize/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
    //兼容基于jQuery1.9以下版本的jQuery插件能正常使用
    jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
</script>
<!--materialize js-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/materialize.js"></script>
<!--prism-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/prism.js"></script>
<!--scrollbar-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<!-- chartist -->
<script type="text/javascript" src="${ctxStatic}/materialize/js/plugins/chartist-js/chartist.min.js"></script>
<!--plugins.js - Some Specific JS codes for Plugin Settings-->
<script type="text/javascript" src="${ctxStatic}/materialize/js/plugins.js"></script>

<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script>

    $(function(){
        var height_window = $(window).height()-64;
        //设置右侧内容窗口高度；
        $('#mainFrame').height(height_window);
        //设置左侧侧导航窗口高度；
        $('#slide-out').height(height_window);
    });

</script>