<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="showType" value="${not empty param.showType?param.showType:'html'}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_default/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctxStatic}/hsun/images/index.css" />
    <link href="${ctxStatic}/hsun/images/css.css" rel="stylesheet" />
    <title>地理云课程</title>
    <script src="${ctxStatic}/materialize/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript">
        //兼容基于jQuery1.9以下版本的jQuery插件能正常使用
        jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
    </script>
</head>

<body>
<div class="navmain">
    <ul class="mainbox">
        <div class="userlogin">
                <span id="PopLoginTips">
                    <div class="username" style="margin-left:0px"><a href="#" target="_blank" class="loginbtn">登录</a></div>
                    <div class="username"><a target="_blank" href="#">注册</a></div>
				</span>
        </div>
        <li class="logo">
            <a href="#"><img src="${ctxStatic}/hsun/images/logo.png" /></a>
        </li>
        <li class="class"><a href="#">首页</a></li>
        <li class="class active"><a href="${ctx}/doc/docInfo/listf">文库</a></li>
        <li class="class"><a href="${ctx}/standard/yWStandard/listf">标准</a></li>
        <li class="class"><a href="#">题库</a></li>
        <li class="class"><a href="#">课程</a></li>
        <li class="class"><a href="#">设备</a></li>
        <li class="class"><a href="#">客服</a></li>
    </ul>
</div>
<div class="clear"></div>
<div class="navheight"></div>
<div class="clear blank20"></div>
<div class="daohang mainbox">当前位置：<a href="#">地理云课堂</a> - <a href="#">文库</a> - <a href="#">技术指南</a> - 浏览文库</div>
<div class="clear"></div>
<div class="downmain01">
    <div class="leftcontent" style="width:100%;float:none">
        <div class="downbox01">
            <div class="downbox01left">
                <div class="typeimg"><img src="${ctxStatic}/hsun/images/word.png" /></div><img src="${ctxStatic}/hsun/images/I131224458356467.jpg" class="rj_pic" /></div>
            <div class="downbox01right" style="width:960px;">
                <h4>${m.title}</h4>
                <div class="xingji"></div>
                <ul>
                    <li><span>上传者：</span>${m.createBy.name}</li>
                    <li><span>分类：</span>${fns:getDictLabel(m.domain, 'dic_domain', '')}</li>
                    <li><span>更新时间：</span><fmt:formatDate value="${m.updateDate}" pattern="yyyy/MM/dd HH:mm:ss"/></li>
                    <li><span>大小：</span>${fileSize}</li>
                    <li><span>语言：</span>中文</li>
                    <li><span>资料类别：</span>pdf</li>
                    <li class="liintro">
                        <span>简要介绍：</span>${m.summary}
                    </li>
                    <li class="liintro">
                    <div class="favoritebtn" onclick=""><img src="${ctxStatic}/hsun/images/bg01.png" align="texttop" style="margin-right:10px" />收藏此文档</div></li>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div class="clear blank30"></div>
        <div class="downbox02">
            <div id="htmlContent" style="display:none">
                <input type="hidden" id="fileUrls" value="${m.files}">
            </div>
            <div id="documentViewer" style="margin:0;padding:0 20px">
                <c:if test="${showType eq 'html'}">
                    <center>
                    <iframe frameborder="0" width="800" height="720" src="${htmlURL}" scrolling="no"></iframe>
                    </center>
                    <a class="btn btn-success btn-large" href="${htmlURL}" target="_blank">下载此文档</a>
                </c:if>
                <c:if test="${showType eq 'file'}">
                    正在加载文档信息...
                </c:if>
            </div>
        </div>
        <div class="clear blank15"></div>
        <div class="clear blank20"></div>

        <c:if test="${showType eq 'html'}">
        <div align="center">
            <div class="fenye" id="fenye">
                <table border="0">
                    <tbody>
                    <tr>
                        <td id="pagelist">
                            ${page}
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        </c:if>
    </div>
</div>
<div class="clear"></div>
<div class="footer">
    <a href="#" target="_blank">关于我们</a> | <a href="#" target="_blank">联系我们</a> | <a href="#" target="_blank">法律条款</a> | <a href="#" target="_blank">招募英才</a> | <a href="#" target="_blank">免责声明</a>
</div>
<div class="copyright">Powered By Y-work 正式版 www.ywork.com inc .
    <br />北京华迅科技有限公司版权所有 © 2010-2016
    <br /> 统一社会信用代码:XXXXXXXX 京ICP备XXXXXXXX号
    <br />统一客服热线：400-008-0263
    <div class="clear"></div></div>
<form id="searchForm" action="${ctx}/doc/docInfo/pdf/preview?showType=html" method="post">
<input name="id" type="hidden" value="${m.id}"/>
<input name="showType" type="hidden" value="${showType}"/>
<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
</form>
<script src="${ctxStatic}/flash/flexpaper.js"></script>
<script src="${ctxStatic}/pdfobject/pdfobject.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var ctx = '${ctx}';
        var showType = '${showType}';
        if(showType == 'file'){
            $("#documentViewer").css("height","500px");
            PDFObject.embed("${targetFileURL}", "#documentViewer");
        }
    });

    function page(n,s){
        $("#pageNo").val(n);
        $("#searchForm").submit();
        return false;
    }
</script>
</body>

</html>