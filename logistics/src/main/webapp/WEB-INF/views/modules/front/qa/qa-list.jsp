<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<!--[if lt IE 7]>      <html class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no,minimal-ui">
    <title>地理云课堂-问答列表</title>
    <meta name="author" content="FYJCKT" />
    <meta name="keywords" content="地理,在线教育,网络教育,远程教育,云网校,在线学习,在线考试" />
    <meta name="description" content="" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta content="telephone=no" name="format-detection" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/reset.css${v}">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/theme.css${v}">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/global.css${v}">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/web.css${v}">
    <link href="${ctxStatic}/hsun/front/qa/css/mw_320_768.css" rel="stylesheet" type="text/css" media="screen and (min-width: 320px) and (max-width: 768px)">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/qa/css/mobile_reset.css${v}">
    <!--[if lt IE 9]><script src="${ctxStatic}/hsun/front/qa/js/html5.js"></script><![endif]-->
    <script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/jquery-1.7.2.min.js${v}"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/webutils.js${v}"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
    <%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>--%>
    <%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>--%>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/common.js${v}"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/especial_mobile/especial_public.js${v}"></script>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />


</head>
<body>
<div id="divheader"></div>

<div class="bg-fa of">
    <div id="qa_container">
    <section class="container">
        <section class="i-question">
            <div class="fl col-7">
                <section class="mr30 pt10">
                    <section class="c-infor-tabTitle c-tab-title">
                        <a href="javascript: void(0)" title="全部问答" onclick="submitForm(0,'type')" <c:if test="${questions.type==0 }">class="current"</c:if>>全部问答</a>
                        <a href="javascript: void(0)" title="学习问答" onclick="submitForm(1,'type')" <c:if test="${questions.type==1 }">class="current"</c:if>>学习问答</a>
                        <a href="javascript: void(0)" title="学习分享" onclick="submitForm(2,'type')" <c:if test="${questions.type==2 }">class="current"</c:if>>学习分享</a>

                        <div class="search_qa fr">
                            <input id="is_search_title" type="text" placeholder="请输入关键词">
                            <i class="fa fa-search" id="is_search"></i>
                        </div>
                    </section>
                    <div class="js-wrap">
                        <section class="fr">
								<span class="c-ccc"> <tt class="c-master f-fM">${page.currentPage}</tt>/<tt class="c-666 f-fM">${page.totalPageSize}</tt>
								</span>
                        </section>
                        <section class="fl pl10">
                            <ol class="js-tap clearfix">
                                <li <c:if test="${questions.orderFalg=='addTime' }">class="current bg-orange"</c:if>><a onclick="submitForm('addTime','order')" href="javascript:void(0)" title="最新">最新</a></li>
                                <li <c:if test="${questions.orderFalg=='replycount' }">class="current bg-orange"</c:if>><a onclick="submitForm('replycount','order')" href="javascript:void(0)" title="热门">热门</a></li>
                                <li <c:if test="${questions.orderFalg=='status0' }">class="current bg-orange"</c:if>><a onclick="submitForm('status0','order')" href="javascript:void(0)" title="等待回答">等待回答</a></li>
                            </ol>
                        </section>
                    </div>
                    <!-- /问题列表 开始 -->
                    <div class="q-list">
                        <c:if test="${empty questionsList }">
                            <!-- /无数据提示 开始-->
                            <section class="no-data-wrap">
                                <em class="icon30 no-data-ico">&nbsp;</em> <span class="c-666 fsize14 ml10 vam">没有相关数据，小编正在努力整理中...</span>
                            </section>
                            <!-- /无数据提示 结束-->
                        </c:if>

                        <c:if test="${not empty questionsList }">
                            <section class="q-all-list">
                                <ul>
                                    <c:forEach items="${questionsList }" var="question">
                                        <li>
                                            <aside class="q-head-pic">
                                                <c:choose>
                                                    <c:when test="${not empty question.picImg }">
                                                        <img src="${question.picImg }" alt="">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${ctxStatic}/hsun/front/qa/img/avatar-boy.gif" alt="">
                                                    </c:otherwise>
                                                </c:choose>
                                                <p class="hLh30 txtOf">
														<span class="c-999"> <c:if test="${empty question.showName }">${question.email }</c:if> <c:if test="${not empty question.showName }">${question.showName }</c:if>
														</span>
                                                </p>
                                            </aside>
                                            <section class="q-txt-box">
                                                <a class="replyBrowseNum" href="${ctxRoot}/qa/questions/info/${question.id }" title="">
                                                    <div class="replyNum">
                                                        <span class="r-b-num">${question.replyCount }</span>
                                                        <p class="hLh30">
                                                            <span class="c-999 f-fA">回答数</span>
                                                        </p>
                                                    </div>
                                                    <div class="browseNum">
                                                        <span class="r-b-num">${question.browseCount }</span>
                                                        <p class="hLh30">
                                                            <span class="c-999 f-fA">浏览数</span>
                                                        </p>
                                                    </div>
                                                </a>
                                                <h3 class="hLh30 txtOf">
                                                    <em class="icon16 q-tw">&nbsp;</em>
                                                    <a href="${ctxRoot}/qa/questions/info/${question.id }" title="" class="fsize16 c-333 vam">${question.title }</a>
                                                </h3>
                                                <h3 class="hLh30 txtOf mt5">
                                                    <em class="icon16 q-hd">&nbsp;</em>
                                                    <c:if test="${empty question.questionsCommentList }">
                                                        <span class="fsize12 c-999 vam">哈~~~ 此问题大家还有苦思冥想中...</span>
                                                        <!-- 没有回答时的内容 -->
                                                    </c:if>
                                                    <c:if test="${not empty question.questionsCommentList }">
                                                        <c:if test="${question.status==0 }">
																<span class="fsize12 c-999 vam"> <tt class="c-ccc f-fM mr5">[最新回答]</tt> <c:forEach items="${question.questionsCommentList }" var="questionsComment">
                                                                    <c:out value="${questionsComment.content }"></c:out>
                                                                </c:forEach>
																</span>
                                                            <!-- 有回答时显示最新一条的回答内容 -->
                                                        </c:if>

                                                        <c:if test="${question.status==1 }">
																<span class="fsize12 c-999 vam"> <tt class="c-green f-fM mr5">[最佳回答]</tt>
																<c:forEach items="${question.questionsCommentList }" var="questionsComment">
                                                                    <c:out value="${questionsComment.content }"></c:out>
                                                                </c:forEach>
																</span>
                                                            <!-- 采纳最佳显示最佳答案内容 -->
                                                        </c:if>
                                                    </c:if>
                                                </h3>
                                                <div class="mt15">
                                                    <span class="c-ccc fl vam">${question.modelTime }</span>
                                                    <section class="fl ml20 pt10">
                                                        <div class="taglist clearfix">
                                                            <c:forEach items="${question.questionsTagRelationList }" var="questionsTag">
                                                                <a title="${questionsTag.tagName }" data-id="${questionsTag.questionsTagId }" onclick="submitForm('${questionsTag.questionsTagId }','questionsTagId')" class="list-tag" href="javascript:;">${questionsTag.tagName }</a>
                                                            </c:forEach>
                                                        </div>
                                                    </section>
                                                    <div class="clear"></div>
                                                </div>
                                            </section>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </section>
                        </c:if>
                        <!-- 公共分页 开始 -->
                        <jsp:include page="/WEB-INF/views/modules/front/qa/front_page.jsp" />
                        <!-- 公共分页 结束 -->
                        <form action="${ctxRoot}/qa/questions/list" id="searchForm" method="post">
                            <input type="hidden" id="pageCurrentPage" name="page.currentPage" value="1" />
                            <input type="hidden" name="questions.orderFalg" value="${questions.orderFalg}" />
                            <input type="hidden" name="questions.type" value="${questions.type}" />
                            <input type="hidden" name="questions.status" value="${questions.status}" />
                            <input type="hidden" name="questions.questionsTagId" value="${questions.questionsTagId}" />
                            <input type="hidden" name="questions.title" value="">
                        </form>
                    </div>
                    <!-- /问题列表 结束 -->
                </section>
            </div>
            <aside class="fl col-3">
                <div class="mt30">
                    <section class="pt10">
                        <a href="javascript:void(0)" onclick="toAddQuestions()" title="我要提问" class="comm-btn c-btn-5">我要提问</a>
                    </section>
                    <section class="pt20">
                        <div class="taglist clearfix">
                            <a onclick="submitForm('0','questionsTagId')" href="javascript:;" class="list-tag <c:if test='${questions.questionsTagId==0 }' >onactive</c:if>" data-id="0" title="JAVA">全部</a>
                            <c:forEach items="${questionsTagList }" var="questionsTag">
                                <a title="${questionsTag.questionsTagName }" data-id="${questionsTag.questionsTagId }" class="list-tag <c:if test='${questionsTag.questionsTagId==questions.questionsTagId }' >onactive</c:if>" href="javascript:;" onclick="submitForm('${questionsTag.questionsTagId }','questionsTagId')">${questionsTag.questionsTagName }</a>
                            </c:forEach>
                        </div>
                    </section>
                    <!-- /标签云 -->
                    <section class="mt30">
                        <section class="c-infor-tabTitle c-tab-title">
                            <a href="javascript: void(0)" title="热门问答推荐">热门问答推荐</a>
                        </section>
                        <div class="q-r-rank-list">
                            <ul id="hotQuestions">
                                <section class="no-data-wrap">
                                    <em class="icon30 no-data-ico">&nbsp;</em> <span class="c-666 fsize14 ml10 vam">没有相关数据，小编正在努力整理中...</span>
                                </section>
                            </ul>
                        </div>
                    </section>
                    <!-- /热门问答排行 -->
                </div>
            </aside>
            <div class="clear"></div>
        </section>
    </section>
    <!-- /提问题 结束 -->
</div>
</div>
<script type="text/javascript" src="${ctxStatic}/hsun/front/qa/js/questions.js${v}"></script>

</body>
</html>
