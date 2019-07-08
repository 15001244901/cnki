<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="${ctxStatic}/hsun/images/index.css" />
    <link href="${ctxStatic}/hsun/images/css.css" rel="stylesheet" />
    <title>地理云课堂</title>
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
        <li class="class active"><a href="#">文库</a></li>
        <li class="class"><a href="#">标准</a></li>
        <li class="class"><a href="#">题库</a></li>
        <li class="class"><a href="#">课程</a></li>
        <li class="class"><a href="#">设备</a></li>
        <li class="class"><a href="#">客服</a></li>
        <li class="scbox">
            <!--搜索条-->
            <div class="sc">
                <script>
                    function drop_mouseover(pos) {
                        try {
                            window.clearTimeout(timer);
                        } catch (e) {}
                    }

                    function drop_mouseout(pos) {
                        var posSel = document.getElementById(pos + "Sel").style.display;
                        if (posSel == "block") {
                            timer = setTimeout("drop_hide('" + pos + "')", 1000);
                        }
                    }

                    function drop_hide(pos) {
                        document.getElementById(pos + "Sel").style.display = "none";
                    }

                    function search_show(pos, searchType, href) {
                        document.getElementById(pos + "SearchType").value = searchType;
                        document.getElementById(pos + "Sel").style.display = "none";
                        document.getElementById(pos + "Slected").innerHTML = href.innerHTML;
                        var sE = document.getElementById("searchExtend");
                        if (sE != undefined && searchType == "bar") {
                            sE.style.display = "block";
                        } else if (sE != undefined) {
                            sE.style.display = "none";
                        }
                        try {
                            window.clearTimeout(timer);
                        } catch (e) {}
                        return false;
                    }

                    function dosearch() {
                        // var key = jQuery("#key-text").val();
                        // if (key == '' || key == '请输入搜索关键字') {
                        //     KesionJS.Alert("请输入搜索关键字！", "jQuery('#key-text').focus()");
                        // } else {
                        //     var m = jQuery("#headSearchType").val();
                        //     if (m == 1000) { //问吧
                        //         location.href = "/asklist/?key=" + key;
                        //     } else if (m == 1001) { //考试
                        //         location.href = "/examlist/?key-" + key;
                        //     } else if (m <= 4 && m >= 1) {
                        //         location.href = "/search.aspx?key=" + key + "&m=" + m;
                        //     } else {
                        //         location.href = "/examlist/?key-" + key;
                        //     }
                        // }

                    }
                    jQuery(document).ready(function() {
                        if (jQuery("#key-text").val() == '') {
                            jQuery("#key-text").val('')
                        }
                    });

                    function getonKey() {
                        if (event.keyCode == 13) {
                            dosearch();
                        }
                    }
                </script>
                <div class="scbox">
                    <div class="selSearch">
                        <div class="nowSearch" id="headSlected" onclick="if(document.getElementById('headSel').style.display=='none'){document.getElementById('headSel').style.display='block';}else {document.getElementById('headSel').style.display='none';};return false;" onmouseout="drop_mouseout('head');">资料</div>
                        <div class="btnSel">
                            <a href="#" onclick="if(document.getElementById('headSel').style.display=='none'){document.getElementById('headSel').style.display='block';}else {document.getElementById('headSel').style.display='none';};return false;" onmouseout="drop_mouseout('head');"></a>
                        </div>
                        <div class="clear"></div>
                        <dl class="selOption" id="headSel" style="display:none;">
                            <div class="ubg"></div>
                            <div class="clear"></div>
                            <dt[KS:ShowAsk]><a style="border-top:0px;" href="#" onclick="search_show('head','1000',this)" onmouseover="drop_mouseover('head');" onmouseout="drop_mouseout('head');">文库</a></dt>
                            <dt[KS:ShowExam]><a href="#" onclick="search_show('head','1001',this)" onmouseover="drop_mouseover('head');" onmouseout="drop_mouseout('head');">题库</a></dt>
                            <dt><a href="#" onclick="search_show('head','1',this)" onmouseover="drop_mouseover('head');" onmouseout="drop_mouseout('head');">标准</a></dt>
                        </dl>
                    </div>
                    <input type="input" id="key-text" style="font-size:12px;" name="wd" class="sctext" value="" onfocus="this.value=(this.value=='')?'':this.value" onblur="this.value=(this.value=='')?'':this.value" onkeypress="getonKey();" />
                    <input id="headSearchType" name="searchType" type="hidden" value="[KS:DefaultModelID]">
                    <input name="" onclick="dosearch();" type="button" value="" class="scbtn" align="left" />
                </div>
            </div>
            <!--搜索条结束-->
        </li>
    </ul>
</div>
<div class="clear"></div>
<div class="navheight"></div>
<div class="clear blank20"></div>
<div class="daohang mainbox">当前位置：<a href="#">地理云课堂</a> - <a href="#">文库</a> - <a href="#">行业文库</a> - <a href="#">技术指南</a> - 浏览文库</div>
<div class="clear"></div>
<div class="downmain01">
    <div class="leftcontent">
        <div class="downbox01">
            <div class="downbox01left">
                <div class="typeimg"><img src="${ctxStatic}/hsun/images/word.png" /></div><img src="${ctxStatic}/hsun/images/I131224458356467.jpg" class="rj_pic" /></div>
            <div class="downbox01right">
                <h4>${m.title}</h4>
                <div class="xingji"></div>
                <ul>
                    <li><span>上传者：</span>${m.createBy.name}</li>
                    <li><span>分类：</span>${fns:getDictLabel(m.domain, 'dic_domain', '')}</li>
                    <li><span>更新时间：</span><fmt:formatDate value="${m.updateDate}" pattern="yyyy/MM/dd HH:mm:ss"/></li>
                    <li><span>大小：</span>${fileSize}</li>
                    <li><span>语言：</span>中文</li>
                    <li><span>资料类别：</span>${showType}</li>
                    <li class="liintro">
                        <span>简要介绍：</span>${m.summary}
                    </li>
                    <li class="lidownnum">
                        <font type="showhits" action="count" f="0" id="3831" t="3" modelid="3">0</font>
                    </li>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div class="clear blank30"></div>
        <div class="downbox02">
            <div id="documentViewer" style="margin:0;padding:0">正在加载文档信息...</div>
        </div>
        <div class="downbox03">
            <div class="title">
                <h4>下载地址</h4>
                <div id="bdshare" class="f_l bdshare_b" style="line-height: 12px; float:right"><img src="http://bdimg.share.baidu.com/static/images/type-button-5.jpg?cdnversion=20120831" /></div>
                <script type="text/javascript" id="bdshare_js" data="type=button&amp;uid=0"></script>
                <script type="text/javascript" id="bdshell_js"></script>
                <script type="text/javascript">
                    document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date() / 3600000);
                </script>
            </div>
            <div class="clear blank10"></div>
            <div class="xz_list"><img src="${ctxStatic}/hsun/images/down.gif" border="0" align="absmiddle"><a href="#" target="_blank">下载地址1</a>
                <br/>
            </div>
        </div>
        <div class="clear blank15"></div>
        <div class="clear blank20"></div>
    </div>
    <div class="right">
        <div class="rightbtn" onclick=""><img src="${ctxStatic}/hsun/images/bg01.png" align="texttop" style="margin-right:10px" />收藏此文档</div>
        <div class="right01">
            <div class="title"><b>热门下载</b></div>
            <div class="clear"></div>
            <ul>
                <li><span class="span01">1</span><a href="#" title="悦工作平台设计">悦工作平台设计</a></li>
                <li><span class="span01">2</span><a href="#" title="悦工作平台设计">悦工作平台设计</a></li>
                <li><span class="span01">3</span><a href="#" title="悦工作平台设计">悦工作平台设计</a></li>
                <li><span>4</span><a href="#" title="悦工作平台设计">悦工作平台设计</a></li>
                <li><span>5</span><a href="#" title="煤炭价格术语">煤炭价格术语</a></li>
            </ul>
        </div>
        <div class="clear blank20"></div>
        <a href="#"><img src="${ctxStatic}/hsun/images/1512031433.jpg" width="100%" /></a>
        <div class="right01">
            <div class="title"><b>近期更新</b></div>
            <div class="clear"></div>
            <ul>
                <li><em><strong>0</strong>下载</em><a href="#" title="煤炭价格术语">煤炭价格术语</a></li>
                <li><em><strong>4</strong>下载</em><a href="#" title="悦工作平台设计">悦工作平台设计</a></li>
                <li><em><strong>1</strong>下载</em><a href="#" title="2014年导游资格证考试模拟试题">2014年导游资格证考试模拟试题</a></li>
                <li><em><strong>1</strong>下载</em><a href="#" title="中小企业如何完善人力资源管理">中小企业如何完善人力资源管理</a></li>
                <li><em><strong>0</strong>下载</em><a href="#" title="资产评估报告范例(最新)">资产评估报告范例(最新)</a></li>
                <li><em><strong>0</strong>下载</em><a href="#" title="2014年注册会计师考试(CPA)攻略">2014年注册会计师考试(CPA)攻略</a></li>
                <li><em><strong>0</strong>下载</em><a href="#" title="2015国家公务员考试复习计划">2015国家公务员考试复习计划</a></li>
                <li><em><strong>0</strong>下载</em><a href="#" title="2015年公务员常识大全">2015年公务员常识大全</a></li>
                <li><em><strong>0</strong>下载</em><a href="#" title="做一个合格的公务员的思考">做一个合格的公务员的思考</a></li>
            </ul>
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
<script type="text/javascript">
    $(document).ready(function() {
        $("#documentViewer").css("height","500px");
        $('#documentViewer').FlexPaperViewer({
            config: {
                SWFFile: '${targetFileURL}',
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
</script
</body>

</html>