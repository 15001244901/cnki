<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>文档维护管理</title>
    <script src="${ctxStatic}/materialize/js/jquery-1.11.2.min.js"></script>
    <style type="text/css">
        * {
            margin: 0;
            padding:0;
        }
    </style>
</head>
<body>
    <div id="documentViewer">正在加载文档信息...</div>
    <script type="text/javascript">
        //兼容基于jQuery1.9以下版本的jQuery插件能正常使用
        jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
    </script>
    <script src="${ctxStatic}/flash/flexpaper.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#documentViewer").css("height",$(document).height()+"px");
            $('#documentViewer').FlexPaperViewer({
                config: {
                    SWFFile: '${swfPath}',
                    jsDirectory:'${ctxStatic}/flash/',
                    Scale: 1.5,//默认缩放比例1=100%
                    ZoomTransition: 'easeOut',
                    ZoomTime: 0.5,
                    ZoomInterval: 0.2,
//                    FitPageOnLoad: true,//自动
                    FitWidthOnLoad: false,
                    FullScreenAsMaxWindow: true,
                    ProgressiveLoading: true,
                    MinZoomSize: 0.5,
                    MaxZoomSize: 2,
                    SearchMatchAll: false,
                    InitViewMode: 'Portrait',
                    RenderingOrder: 'flash',
                    StartAtPage: '',
                    PrintEnabled: false,
                    PrintToolsVisible: false,
                    ViewModeToolsVisible: false,
                    ZoomToolsVisible: false,
                    NavToolsVisible: true,
                    CursorToolsVisible: true,
                    SearchToolsVisible: true,
                    localeChain: 'zh_CN'
                }
            });
        });
    </script>
</body>
</html>