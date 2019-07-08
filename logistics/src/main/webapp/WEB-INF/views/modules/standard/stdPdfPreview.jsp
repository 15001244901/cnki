<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_flat/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/hsun/images/index.css" />
    <link href="${ctxStatic}/hsun/images/css.css" rel="stylesheet" />
    <title>悦工作平台-标准内容页</title>
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
        <li class="class"><a href="${ctx}/doc/docInfo/listf">文库</a></li>
        <li class="class active"><a href="${ctx}/standard/yWStandard/listf">标准</a></li>
        <li class="class"><a href="#">题库</a></li>
        <li class="class"><a href="#">课程</a></li>
        <li class="class"><a href="#">设备</a></li>
        <li class="class"><a href="#">客服</a></li>
    </ul>
</div>
<div class="clear"></div>
<div class="navheight"></div>
<div class="clear blank20"></div>
<div class="daohang mainbox">当前位置：<a href="#">悦工作平台</a> - <a href="#">标准</a> - 详细内容</div>
<div class="clear"></div>
<div class="downmain01">
    <div class="leftcontent">
        <div class="downbox01">
            <div class="downbox01left">
                <c:set var="std_slt" value="${m.thumbnail}"></c:set>
                <c:if test="${empty std_slt}">
                    <c:set var="std_slt" value="${ctxStatic}/hsun/images/std_slt.png"></c:set>
                </c:if>
                <div class="typeimg"><img src="${ctxStatic}/hsun/images/pdf.gif" /></div><img src="${std_slt}" class="rj_pic" /></div>
            <div class="downbox01right">
                <h4><a href="javascript:;">${m.sno}</a></h4>
                <div class="xingji"></div>
                <ul>
                    <li class="liintro"><span>中文名称：</span>${m.name}</li>
                    <li class="liintro"><span>英文名称：</span>${m.enname}</li>
                    <li class="liintro"><span>中标分类：</span>${m.typezh}</li>
                    <li class="liintro"><span>ICS&nbsp;分类：</span>${m.ics}</li>
                    <li><span>实施日期：</span><fmt:formatDate value="${m.executedate}" pattern="yyyy/MM/dd"/></li>
                    <li><span>年代号：</span>${m.yearno}</li>
                    <li><span>标准状态：</span>${m.status}</li>
                    <!--
                    <li class="lidownnum">
                        <font type="showhits" action="count" f="0" id="3831" t="3" modelid="3">0</font>
                    </li>
                    -->
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div class="clear blank30"></div>
        <div class="downbox02">
            <div id="documentViewer" style="margin:0;padding:0">正在加载标准文档...</div>
        </div>
        <div class="downbox03">
            <div class="title">
                <h4>起草单位</h4>
                <div id="bdshare" class="f_l bdshare_b" style="line-height: 12px; float:right"><img src="http://bdimg.share.baidu.com/static/images/type-button-5.jpg?cdnversion=20120831" /></div>
                <script type="text/javascript" id="bdshare_js" data="type=button&amp;uid=0"></script>
                <script type="text/javascript" id="bdshell_js"></script>
                <script type="text/javascript">
                    document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date() / 3600000);
                </script>
            </div>
            <div class="clear blank10"></div>
            <c:if test="${not empty m.draftcompany}">
                <c:set var="dcList" value="${fn:split(m.draftcompany, ';')}" />
                <c:forEach var="dc" items="${dcList}">
                <div class="xz_list">${dc}</div>
                </c:forEach>
            </c:if>
        </div>
        <div class="clear blank15"></div>
        <div class="clear blank20"></div>

        <div class="downbox03">
            <div class="title">
                <h4>归口单位</h4>
            </div>
            <div class="clear blank10"></div>
            <c:if test="${not empty m.gkcompany}">
                <div class="xz_list">${m.gkcompany}</div>
            </c:if>
        </div>
        <div class="clear blank15"></div>
        <div class="clear blank20"></div>
    </div>
    <div class="right">
        <div class="rightbtn" onclick=""><img src="${ctxStatic}/hsun/images/bg01.png" align="texttop" style="margin-right:10px" />收藏此标准</div>
        <div class="right01">
            <div class="title"><b>替代标准</b></div>
            <div class="clear"></div>
            <c:if test="${not empty m.replacestd}">
                <ul>
                    <c:set var="items" value="${fn:split(m.replacestd, ',')}" />
                    <c:forEach var="item" items="${items}" varStatus="c">
                        <li><img src="${ctxStatic}/hsun/images/pdf.gif" border="0" align="absmiddle"><a href="#" title="${item}"> ${item}</a></li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
        <div class="clear blank20"></div>
        <div class="right01">
            <div class="title"><b>被替代标准</b></div>
            <div class="clear"></div>
            <c:if test="${not empty m.replacedby}">
                <ul>
                    <c:set var="items" value="${fn:split(m.replacedby, ',')}" />
                    <c:forEach var="item" items="${items}" varStatus="c">
                        <li><img src="${ctxStatic}/hsun/images/pdf.gif" border="0" align="absmiddle"><a href="#" title="${item}"> ${item}</a></li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
        <div class="clear blank20"></div>
        <div class="right01">
            <div class="title"><b>引用标准</b></div>
            <div class="clear"></div>
            <c:if test="${not empty m.citestd}">
            <ul>
                <c:set var="items" value="${fn:split(m.citestd, ';')}" />
                <c:forEach var="item" items="${items}" varStatus="c">
                <li><span ${c.index lt 4?'class="span01"':''}>${c.index+1}</span><a href="#" title="${item}">${item}</a></li>
                </c:forEach>
            </ul>
            </c:if>
        </div>
        <div class="clear blank20"></div>
        <div class="right01">
            <div class="title"><b>采用标准</b></div>
            <div class="clear"></div>
            <c:if test="${not empty m.usestd}">
                <ul>
                    <c:set var="items" value="${fn:split(m.usestd, ';')}" />
                    <c:forEach var="item" items="${items}" varStatus="c">
                        <li><span ${c.index lt 4?'class="span01"':''}>${c.index+1}</span><a href="#" title="${item}">${item}</a></li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
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
<script src="${ctxStatic}/flash/flexpaper.js"></script>
<script src="${ctxStatic}/pdfobject/pdfobject.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var ctx = '${ctx}';
        var errorMsg = '${error}';
        if(errorMsg) {
            var alertEL = '<div class="alert alert-warning">' + errorMsg + '</div>';
            $("#documentViewer").html(alertEL);
        } else {
            $("#documentViewer").css("height","500px");
            PDFObject.embed("${targetFileURL}", "#documentViewer");
        }
    });
</script>
</body>

</html>