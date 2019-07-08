<%@ page contentType="text/html;charset=UTF-8" %>
<!-- BEGIN JAVASCRIPT -->
<script src="${ctxStatic}/gecoder/jinxuan/js/libs/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
    //兼容基于jQuery1.9以下版本的jQuery插件能正常使用
    jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
</script>
<script src="${ctxStatic}/gecoder/jinxuan/js/libs/jquery/jquery-migrate-1.2.1.min.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/libs/bootstrap/bootstrap.min.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/libs/spin.js/spin.min.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/libs/autosize/jquery.autosize.min.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/libs/nanoscroller/jquery.nanoscroller.min.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/source/App.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/source/AppNavigation.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/source/AppOffcanvas.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/source/AppCard.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/source/AppForm.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/source/AppNavSearch.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/source/AppVendor.js"></script>
<script src="${ctxStatic}/gecoder/jinxuan/js/core/demo/Demo.js"></script>
<!-- END JAVASCRIPT -->

<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
<!-- 调整jbox样式，使其兼容Bootstrap3  -->
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Purple/jbox.css" rel="stylesheet" />
<style type="text/css">
    div.jbox .jbox-title-panel , div.jbox .jbox-button-panel{
        box-sizing:content-box;
    }
</style>
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>