<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${fns:getConfig('productName')} 控制台</title>
    <meta name="decorator" content="materialize"/>
    <style>
        /*.sidebar-collapse{*/
            /*top:51px;*/
        /*}*/
        .header-search-wrapper{
            margin-top:11px;
        }
        #slide-out{
            padding-bottom: 0px;
            top:64px;
        }
    </style>
</head>

<body>
<!-- Start Page Loading -->
<div id="loader-wrapper">
    <div id="loader"></div>
    <div class="loader-section section-left"></div>
    <div class="loader-section section-right"></div>
</div>
<!-- End Page Loading -->
<!-- //////////////////////////////////////////////////////////////////////////// -->
<!-- START HEADER -->
<header id="header" class="page-topbar">
    <!-- start header nav-->
    <div class="navbar-fixed">
        <nav class="cyan">
            <div class="nav-wrapper">
                <ul class="left">
                    <li>
                        <h1 class="logo-wrapper"><a href="#" class="brand-logo darken-1"><img src="${ctxStatic}/materialize/images/materialize-logo.png" alt="materialize logo"></a> <span class="logo-text">e-Science+会议平台</span></h1></li>
                </ul>
                <div class="header-search-wrapper hide-on-med-and-down">
                    <i class="mdi-action-search"></i>
                    <input type="text" name="Search" class="header-search-input z-depth-2" placeholder="全文搜索" />
                </div>
                <ul class="right hide-on-med-and-down">
                    <li title="最大化窗口"><a href="javascript:void(0);" class="waves-effect waves-block waves-light toggle-fullscreen"><i class="mdi-action-settings-overscan"></i></a>
                    </li>
                    <li title="系统提醒"><a href="javascript:void(0);" class="waves-effect waves-block waves-light"><i class="mdi-social-notifications"></i></a>
                    </li>
                    <li title="个人消息"><a href="#" data-activates="chat-out" class="waves-effect waves-block waves-light chat-collapse"><i class="mdi-communication-chat"></i></a>
                    </li>
                    <li title="退出系统"><a href="${ctx}/logout" class="waves-effect waves-block waves-light"><i class="mdi-action-settings-power"></i></a>
                </ul>
            </div>
        </nav>
    </div>
    <!-- end header nav-->
</header>
<!-- END HEADER -->
<!-- //////////////////////////////////////////////////////////////////////////// -->
<!-- START MAIN -->
<div id="main">
    <!-- START WRAPPER -->
    <div class="wrapper">
        <!-- START LEFT SIDEBAR NAV-->
        <aside id="left-sidebar-nav">
            <ul id="slide-out" class="side-nav leftside-navigation fixed">
                <li class="user-details cyan darken-2">
                    <div class="row">
                        <div class="col col s4 m4 l4">
                            <c:set var="userphoto" value="${ctxStatic}/images/userphoto.jpg"/>
                            <c:if test="${not empty fns:getUser().photo}">
                                <c:set var="userphoto" value="${fns:getUser().photo}"/>
                            </c:if>
                            <img width="180" height="180" src="${userphoto}" alt="" class="circle responsive-img valign profile-image">
                        </div>
                        <div class="col col s8 m8 l8">
                            <ul id="profile-dropdown" class="dropdown-content">
                                <li><a href="#"><i class="mdi-action-face-unlock"></i> 帐号</a>
                                </li>
                                <li><a href="#"><i class="mdi-action-settings"></i> 个性化</a>
                                </li>
                                <li><a href="#"><i class="mdi-communication-live-help"></i> 帮助</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="mdi-action-lock-outline"></i> 注销</a>
                                </li>
                                <li><a href="${ctx}/logout"><i class="mdi-hardware-keyboard-tab"></i> 退出</a>
                                </li>
                            </ul>
                            <a class="btn-flat dropdown-button waves-effect waves-light white-text profile-btn" href="#" data-activates="profile-dropdown">${fns:getUser().name}<i class="mdi-navigation-arrow-drop-down right"></i></a>
                            <p class="user-roal">${fns:getUser().office}</p>
                        </div>
                    </div>
                </li>
                <li class="no-padding">
                    <ul class="collapsible collapsible-accordion">
                        <c:set var="menuList" value="${fns:getMenuList()}" />
                        <c:set var="firstMenu" value="true" />
                        <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                        <c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:'1')&&menu.isShow eq '1'}">
                            <li class="bold">
                                <a class="collapsible-header  waves-effect waves-cyan"><i class="mdi-action-dashboard"></i> ${menu.name}</a>
                                <div class="collapsible-body">
                                    <ul class="collapsible collapsible-accordion">
                                        <c:forEach items="${menuList}" var="menu2">
                                        <c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
                                        <li class="bold">
                                            <c:choose>
                                            <c:when test="${not empty menu2.href}">
                                                <a href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}" target="${not empty menu2.target ? menu2.target : 'mainFrame'}">${menu2.name}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="collapsible-header  waves-effect waves-cyan">${menu2.name}</a>
                                                <div class="collapsible-body">
                                                    <ul class="collapsible collapsible-accordion">
                                                        <c:forEach items="${menuList}" var="menu3">
                                                            <c:if test="${menu3.parent.id eq menu2.id&&menu3.isShow eq '1'}">
                                                                <li><a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}" target="${not empty menu3.target ? menu3.target : 'mainFrame'}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${menu3.name}</a>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <c:set var="firstMenu" value="false" />
                                        </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </li>
                        </c:if>
                        </c:forEach>
                    </ul>
                </li>
            </ul>
            <a href="#" data-activates="slide-out" class="sidebar-collapse btn-floating btn-medium waves-effect waves-light hide-on-large-only cyan"><i class="mdi-navigation-menu"></i></a>
        </aside>
        <!-- END LEFT SIDEBAR NAV-->
        <!-- //////////////////////////////////////////////////////////////////////////// -->
        <!-- START CONTENT -->
        <section id="content">
            <iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="600"></iframe>
        </section>
        <!-- END CONTENT -->
        <!-- //////////////////////////////////////////////////////////////////////////// -->
        <!-- START RIGHT SIDEBAR NAV-->
        <aside id="right-sidebar-nav">
            <ul id="chat-out" class="side-nav rightside-navigation">
                <li class="li-hover">
                    <a href="#" data-activates="chat-out" class="chat-close-collapse right"><i class="mdi-navigation-close"></i></a>
                    <div id="right-search" class="row">
                        <form class="col s12">
                            <div class="input-field">
                                <i class="mdi-action-search prefix"></i>
                                <input id="icon_prefix" type="text" class="validate">
                                <label for="icon_prefix">搜索</label>
                            </div>
                        </form>
                    </div>
                </li>
                <li class="li-hover">
                    <ul class="chat-collapsible" data-collapsible="expandable">
                        <li>
                            <div class="collapsible-header teal white-text active"><i class="mdi-social-whatshot"></i>近期任务</div>
                            <div class="collapsible-body recent-activity">
                                <div class="recent-activity-list chat-out-list row">
                                    <div class="col s3 recent-activity-list-icon"><i class="mdi-action-add-shopping-cart"></i>
                                    </div>
                                    <div class="col s9 recent-activity-list-text">
                                        <a href="#">今天</a>
                                        <p>前后端统一权限验证与业务逻辑分离。</p>
                                    </div>
                                </div>
                                <div class="recent-activity-list chat-out-list row">
                                    <div class="col s3 recent-activity-list-icon"><i class="mdi-device-airplanemode-on"></i>
                                    </div>
                                    <div class="col s9 recent-activity-list-text">
                                        <a href="#">昨天</a>
                                        <p>功能优化。</p>
                                    </div>
                                </div>
                                <div class="recent-activity-list chat-out-list row">
                                    <div class="col s3 recent-activity-list-icon"><i class="mdi-action-settings-voice"></i>
                                    </div>
                                    <div class="col s9 recent-activity-list-text">
                                        <a href="#">2天前</a>
                                        <p>bug修复。</p>
                                    </div>
                                </div>
                                <div class="recent-activity-list chat-out-list row">
                                    <div class="col s3 recent-activity-list-icon"><i class="mdi-action-store"></i>
                                    </div>
                                    <div class="col s9 recent-activity-list-text">
                                        <a href="#">上周</a>
                                        <p>前端工作对接。</p>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header light-blue white-text active"><i class="mdi-editor-attach-money"></i>记事本</div>
                            <div class="collapsible-body sales-repoart">
                                <div class="sales-repoart-list  chat-out-list row">
                                    <div class="col s8">富文本处理</div>
                                    <div class="col s4"><span id="sales-line-1"></span>
                                    </div>
                                </div>
                                <div class="sales-repoart-list chat-out-list row">
                                    <div class="col s8">内容显示</div>
                                    <div class="col s4"><span id="sales-bar-1"></span>
                                    </div>
                                </div>
                                <div class="sales-repoart-list chat-out-list row">
                                    <div class="col s8">登录及注册设计</div>
                                    <div class="col s4"><span id="sales-line-2"></span>
                                    </div>
                                </div>
                                <div class="sales-repoart-list chat-out-list row">
                                    <div class="col s8">前端开发进度跟踪</div>
                                    <div class="col s4"><span id="sales-bar-2"></span>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header red white-text"><i class="mdi-action-stars"></i>联系人</div>
                            <div class="collapsible-body favorite-associates">
                                <div class="favorite-associate-list chat-out-list row">
                                    <div class="col s4"><img src="${ctxStatic}/images/userphoto2.jpg" alt="" class="circle responsive-img online-user valign profile-image">
                                    </div>
                                    <div class="col s8">
                                        <p>许航</p>
                                        <p class="place">途牛旅游</p>
                                    </div>
                                </div>
                                <div class="favorite-associate-list chat-out-list row">
                                    <div class="col s4"><img src="${ctxStatic}/images/userphoto2.jpg" alt="" class="circle responsive-img online-user valign profile-image">
                                    </div>
                                    <div class="col s8">
                                        <p>李学华</p>
                                        <p class="place">金融达人</p>
                                    </div>
                                </div>
                                <div class="favorite-associate-list chat-out-list row">
                                    <div class="col s4"><img src="${ctxStatic}/images/userphoto2.jpg" alt="" class="circle responsive-img offline-user valign profile-image">
                                    </div>
                                    <div class="col s8">
                                        <p>陈晓明</p>
                                        <p class="place">投篮高手</p>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </aside>
        <!-- LEFT RIGHT SIDEBAR NAV-->
        <!-- Floating Action Button -->
        <!--
        <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
            <a class="btn-floating btn-large red">
                <i class="large mdi-editor-mode-edit"></i>
            </a>
            <ul>
                <li><a href="#" class="btn-floating red"><i class="large mdi-communication-live-help"></i></a></li>
                <li><a href="#" class="btn-floating yellow darken-1"><i class="large mdi-device-now-widgets"></i></a></li>
                <li><a href="#" class="btn-floating green"><i class="large mdi-editor-insert-invitation"></i></a></li>
                <li><a href="#" class="btn-floating blue"><i class="large mdi-communication-email"></i></a></li>
            </ul>
        </div>
        -->
        <!-- Floating Action Button -->
    </div>
    <!-- END WRAPPER -->
</div>
<!-- END MAIN -->
<!-- //////////////////////////////////////////////////////////////////////////// -->
<!-- START FOOTER -->
<!-- END FOOTER -->
    <%--<script src="${ctxStatic}/hsun/ywork/exam/inc/js/jquery.js" type="text/javascript"></script>--%>

</body>

</html>
