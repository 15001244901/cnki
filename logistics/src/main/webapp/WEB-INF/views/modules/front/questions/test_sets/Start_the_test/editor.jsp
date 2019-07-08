<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>KityFormula</title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/ckeditor/iframe/css/page.css${v}">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/ckeditor/iframe/css/base.css${v}">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/ckeditor/iframe/css/fui.min.css${v}">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/ckeditor/iframe/css/fui.ext.css${v}">
    <style>
        html, body { background: #fff; }
        .kf-editor { background: #fff}
        .kf-editor-ui-latex-area { display: none; }
        .kf-editor-ui-canvas { width: 100%; }
        .kf-editor > .fui-container:first-child { background: #efefef; }
    </style>
    <script>
        SVGElement.prototype.getTransformToElement = SVGElement.prototype.getTransformToElement || function(toElement) {
            return toElement.getScreenCTM().inverse().multiply(this.getScreenCTM());
        };
    </script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/ui.conf.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/jquery-1.11.1.min.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/jhtmls.min.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/fui.all.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/kitygraph.all.min.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/kity-formula-render.all.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/kity-formula-parser.all.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/kityformula-editor.all.js${v}"></script>
    <script src="${ctxStatic}/hsun/front/ckeditor/iframe/js/texzilla.js${v}"></script>
    <script>
          jQuery( function ($) {

            if ( document.body.addEventListener ) {

                $( "#tips").html('<div id="loading"><img src="${ctxStatic}/hsun/front/ckeditor/iframe/images/loading.gif" alt="loading" /><p>正在加载，请耐心等待...</p></div>' );

                var factory = kf.EditorFactory.create( $( "#kfEditorContainer" )[ 0 ], {
                    render: {
                        fontsize: 14
                    },
                    resource: {
//                        path: "resource/"
                        path: "../../../../../../../..${ctxStatic}/hsun/front/ckeditor/resource/"
                    }
                } );

                factory.ready( function ( KFEditor ) {

                    $( "#tips").remove();

                    // this指向KFEditor

                    this.execCommand( "render", "\\placeholder" );
                    this.execCommand( "focus" );

                    parent.formulaReady( KFEditor );

                } );

            } else {
                $( "#tips").css( "color", "black" );
                $( "#tips").css( "padding", "10px" );
            }

        } );
    </script>
</head>

<body>
    <div id="kfEditorContainer" class="kf-editor" style="width: 100%;">
        <div id="tips" class="tips">
            公式编辑仅支持IE9及以上版本的浏览器，正式版本将会支持低版本浏览器，谢谢您的关注！
        </div>
    </div>
    <!--
        <div style="z-index: 100;position: absolute;bottom: 0;right: 0px;background: rgba(48, 48, 48, 0.5);width: 100%;height: 54px;overflow: hidden">
        <button id="data_submit" style="border: 1px none;bottom: 5px;height: 42px;position: absolute;right: 5px;width: 88px;">确定</button >
        <button  id="iframe_close" style="border: 1px none;bottom: 5px;height: 42px;position: absolute;right: 120px;width: 88px;">关闭</button >  
    </div>
    -->
    
</body>
</html>