<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<shiro:hasPermission name="exam:question:view">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>地理云课堂</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/test_center/text_center.css${v}"/>
    <script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
    <script src="${ctxStatic}/hsun/front/js/xml2json/jquery.xml2json.js${v}" type="text/javascript"></script>
    <script src="${ctxStatic}/hsun/front/js/json2.js${v}"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}"/>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}"/>

</head>

<body>
<div id="divheader"></div>
<div id="container">
    <div id="swit" class="basket-tit">
        <p><em>知识点</em></p>
    </div>
    <div id="bo_fl" class="bo_fl state">
        <div class="sel">
            <div class="sel_title">
                选择知识点 <span class="gohide">收起</span>
            </div>
            <div class="slide_up_topic">
                <ul class="one_section dash_line">
                    <!--<li><a href="javascript:void(0);">煤炭采样</a></li>-->
                </ul>
            </div>
        </div>
        <div style="clear: both;"></div>

    </div>
    <div id="divcontent">
        <div id="divcontainer">
            <%--<div class="divsubject">--%>
                <%--<div class="subject">--%>
                    <%--<div>--%>
                        <%--<p class="fs14">科目：</p>--%>
                    <%--</div>--%>
                    <%--<ul id="ulSubject">--%>
                    <%--</ul>--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="divquestion">
                <div class="subject">
                    <div>
                        <p class="fs14">题型：</p>
                    </div>
                    <ul id="ulQuestion">
                    </ul>
                </div>
            </div>
            <div class="divlevel">
                <div class="subject">
                    <div>
                        <p class="fs14">难度：</p>
                    </div>
                    <ul id="ulLevel">
                    </ul>
                </div>
            </div>
            <div class="divpost">
                <div class="subject">
                    <div>
                        <p class="fs14">岗位：</p>
                    </div>
                    <ul id="ulPost">
                    </ul>
                </div>
            </div>
        </div>
        <div class="divlistmodel">
            <div class="divtotal">
                <span class="spanmodel"><i class="fa fa-book" style="color: #FE8922; font-size: 20px;"></i> &nbsp;&nbsp;&nbsp;模式：</span>
                <span class="spanlist" id="show_list" onclick="textCenter.todivlist()"><i class="fa  fa-reorder"
                                                                                          style="font-size: 14px;"></i> 列表</span>
                <span class="spanview" id="show_view" onclick="textCenter.todivview()"><i class="fa  fa-file-text-o"
                                                                                          style="font-size: 14px;"></i> 逐题</span>
                <!--<span class="two5">已收藏  <span style="color: #2F96E9;">88</span> 题</span>-->
                <div class="bo_search" style="float: right;position: relative;top:-9px;left:25px;">
                    <input type="text" name="style" class="style" id="keyword" placeholder="请输入关键字搜索"/>
                    <a href="javascript:;" onclick="textCenter.searchLibrary();"><i class="fa fa-search"
                                                                                    id="style1"></i></a>
                </div>
            </div>
            <div id="divlist">
                <div id="questionListDiv" style="min-height: 400px;">

                </div>
                <div class="divPage" id="pagehtml">

                </div>
            </div>
            <div id="divview">
                <div id="questionSingle" style="min-height: 357px;">

                </div>
                <div class="divPage" id="pagehtmlSingle">

                </div>
            </div>

        </div>
        <!--科目-->
        <input type="hidden" id="subjectType"/>
        <!--题型-->
        <input type="hidden" id="questionType"/>
        <!--难度-->
        <input type="hidden" id="levelType"/>
        <!--岗位-->
        <input type="hidden" id="postType"/>
        <%--知识点--%>
        <input type="hidden" id="topictValue">
        <!--页面类型-->
        <!--0代表列表模式1代表逐题模式-->
        <input type="hidden" id="hidType" value="0"/>

        <!--当前页列表-->
        <input type="hidden" id="pageNo" value="1"/>
        <!--当前页逐题-->
        <input type="hidden" id="pageNoSingle" value="1"/>
        <!--当前页逐题总页数-->
        <input type="hidden" id="totalPageCount" value="1"/>
        <!--当前题id-->
        <!--<input type="hidden" id="hidquestionid" value="1" />-->
        <%--左侧边栏的初始坐标--%>
        <input type="hidden" id="get_left">
    </div>
</div>
    <script src="${ctxStatic}/hsun/front/js/pagejs/talkView/jquery.slimscroll.min.js${v}" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/test_center/textCenter.js${v}"></script>
</body>

</html>
</shiro:hasPermission>
<shiro:lacksPermission name="exam:question:view">
    <script type="text/javascript">
        window.location.href = '${ctxRoot}/error/403.html';
    </script>
</shiro:lacksPermission>