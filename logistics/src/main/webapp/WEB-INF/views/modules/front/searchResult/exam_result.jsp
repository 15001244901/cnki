<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>地理云课堂</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/searchResult/exam_result.css${v}" />
    <script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
    <!--<link href="${ctxStatic}/hsun/front/css/title.css" type="text/css" rel="stylesheet" />-->
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
</head>

<body>
<div id="divheader"></div>
<div id="border">
    <div class="sets">
        <div id="section">
            <span><i class="fa fa-search"></i>&nbsp;&nbsp;组卷搜索结果</span>
            <div class="bo_search">
                <div>
                    <input type="text" id="keyword" class="txtsearch" placeholder="&nbsp;请输入关键字搜索">
                    <span class="spansearch"><a href="javascript:;" onclick="textSets.searchLibrary();"><i class="fa fa-search fa-lg"></i></a></span>
                </div>
            </div>
        </div>
        <div class="content" id="contents">
            <%--<img id="load_img" style="margin: 140px auto 0;display: block;" src="${ctxStatic}/hsun/front/usercenter/images/loading.gif" alt="">--%>
        </div>

        <div class="divPage" id="pagehtml"></div>
        <!--当前页码-->
        <input type="hidden" id="pageNo" value="1" />
        <input type="hidden" id="style" value="0">
    </div>
</div>
<input type="hidden" id="hidQuestionId">
<%--组卷窗口--%>
<script type="text/template" id="hand_test" >
    <form id="form_hand_test">
        <ul>
            <li>
                <%--<span>试卷名称：</span>--%>
                <input type="text" class="txtinput" id="questionName" name="name" value="请输入试卷名称"
                       onfocus="if(value=='请输入试卷名称'){value='';style.color='#333'}"
                       onblur="if(value==''){value='请输入试卷名称';style.color='#888'}"
                />
            </li>
        </ul>
        <div id="btn_hand_test">
            <a href="javascript:;" id="btn_a"  class="active" onclick="textSets.saveExam()">创建试卷</a>
        </div>
    </form>
</script>
</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/searchResult/exam_result.js${v}"></script>