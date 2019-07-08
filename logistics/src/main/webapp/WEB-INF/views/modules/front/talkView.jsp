<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<head>
    <meta charset="utf-8" />
    <title>地理云课堂</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />

    <link href="${ctxStatic}/hsun/front/css/talkView/fonts.css${v}" rel="stylesheet" />
    <link href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/hsun/front/css/talkView/simple-line-icons/simple-line-icons.min.css${v}" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.min.css${v}" rel="stylesheet" type="text/css" />

    <link href="${ctxStatic}/hsun/front/css/talkView/components-md.css${v}" id="style_components" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/hsun/front/css/talkView/layout.css${v}" rel="stylesheet" type="text/css" />
    <link href="${ctxStatic}/hsun/front/css/talkView/talkView.css${v}" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

    <%--<script src="${ctxStatic}/jquery/jquery-3.2.0.min.js${v}" type="text/javascript"></script>--%>
    <script type="text/javascript" src="${ctxStatic}/umeditor1.2.3-src/third-party/jquery.min.js"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>

    <%--百度编辑器--%>
    <link href="${ctxStatic}/umeditor1.2.3-src/themes/default/_css/umeditor.css" type="text/css" rel="stylesheet">
    <%--<script type="text/javascript" src="${ctxStatic}/umeditor1.2.3-src/third-party/jquery.min.js"></script>--%>

    <script>
        var lhost = "${pageContext.request.contextPath}";
        var uName = "${fns:getUser().name}";
        var uphoto = "${fns:getUser().photo}";
        if(!uphoto){
            uphoto = "${ctxStatic}/images/userphoto.jpg";
        }
        var uemptyPhoto ="${ctxStatic}/images/userphoto.jpg";

        var userid = '${fns:getUser().id}';
        var offficeid = '${fns:getUser().office.id}';
        var companyid = '${fns:getUser().company.id}';

        var showOnlineList = top.showOnlineList;


    </script>
    <style>
        #sender{
            width:200px;
            /*height:;*/
            position: absolute;
            left:0;
            top:0;
        }
        .row{
            margin:0;
        }
        .col-md-12 , .col-sm-12{
            padding:0;
        }
        .page-content-wrapper .page-content {
            padding-top: 3px;
        }
        @media (min-width: 1000px){
            .page-container {
                margin-top:20px;
            }
        }
        /*检测开关*/
        .actions button{
            outline: none;
            border:1px solid #ddd;
            padding:3px 10px;
            background: #F0F0F0;
            transition: all 0.2s;
        }
        .actions button:hover{
            color:#3598dc;
            border:1px solid #3598dc;
        }
        .actions button:active{
            color: #fff;
            background: #3598dc;
        }
        /*更改消息样式*/
        .chats li.in>img{
            border:2px solid #1bbc9b;
        }
        .chats li.in .name{
            color: #1bbc9b;
        }
        .chats li.out>img{
            border:2px solid #3598dc;
        }
        .chats li.out .name{
            color: #3598dc;
        }
        .chats li.in .message,.chats li.out .message{
            background: #fff;
            padding:0;
            /*margin-left:56px;*/
            margin-top:-5px;
            border:none;
        }
        .chats li.in .message .body,.chats li.out .message .body{
            background: #EDEDED;
            border-radius:5px;
            padding:10px;
            display: inline-block;
            word-wrap: break-word;
            word-break: break-all;
        }
        .chats .message .body>p{
            margin:0;
        }
        .chats .message .body>p img{
            vertical-align: middle;
        }
        .chats li.in .message .arrow{
            top:25px;
            border-right: 8px solid #EDEDED;
        }
        .chats li.out .message .arrow{
            top:25px;
            border-left: 8px solid #EDEDED;
        }
        .chats{
            margin-top:0;
        }
        /*等待窗口消息*/
        .people_list li{
            position: relative;
        }
        .news_nums{
            display: none;
            font-size: 12px;
            text-align: center;
            transform:scale(0.75);
            width:30px;
            height:26px;
            line-height: 26px;
            background: #F74C31;
            color: #fff;
            border-top-left-radius:50%;
            border-top-right-radius:50%;
            border-bottom-right-radius:50%;
            position: absolute;
        }

        /*工具栏改动*/
        .input-icon.right > .form-control{
            font-size: 14px;
            width:0;
            padding-left:0;
            border:1px solid #fff;
            transition: all 0.2s;
            opacity: 0;
        }
        .input-icon.right:hover .form-control{
            padding-left:24px;
            width:190px;
            opacity: 1;
            border:1px solid #e5e5e5;
        }
        .icon-magnifier{
            cursor: pointer;
        }
        .chat_set button{
            display: none;
        }
        .chat_set:hover button{
            display: inline;
        }
        .set_link{
            font-size: 21px;
            color: #ccc;
            top:5px;
            top:3px\9;
            cursor: pointer;
            position: relative;
        }
        /*@-moz-document url-prefix(){*/
            /*.set_link{*/
                /*top:5px;*/
            /*}*/
        /*}*/
        .set_link:hover{
            color: #555;
        }
        .edui-container{
            box-sizing:content-box;
        }
        .edui-body-container{
            box-sizing:content-box;
        }
        .edui-body-container>p{

        }

        <%--.child-line{--%>
            <%--background: url("${ctxStatic}/hsun/front/img/child2.png") no-repeat 8px center;--%>
        <%--}--%>
        .child-line1{
            <%--background: url("${ctxStatic}/hsun/front/img/child.png") no-repeat 30px center;--%>
            background-color:#999;
            padding-left:20px;
        }
        .part_name .fa{
            display: inline-block;
            float: none;
            transition: all 0.2s;
        }
        .part_name .fa.scal90{
            transform:rotate(-90deg);
            -ms-transform:rotate(-90deg); 	/* IE 9 */
            -moz-transform:rotate(-90deg); 	/* Firefox */
            -webkit-transform:rotate(-90deg); /* Safari 和 Chrome */
            -o-transform:rotate(-90deg);
        }

        <%--.class2 .part_name:nth-last-of-type(1){--%>
            <%--background: url("${ctxStatic}/hsun/front/img/child1.png") no-repeat 30px center;--%>
            <%--background-color:#999;--%>
            <%--padding-left:20px;--%>
        <%--}--%>

        .talk-user {
            padding-left:40px;
        }

    </style>
</head>

<body style="overflow-y:hidden">
<div class="page-container">
    <div class="page-content-wrapper">
        <div class="page-content">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light ">
                        <div id="pflet">
                            <ul class="people_list" id="people_list">
                                <li id="news-total" class="news-total opd5">
                                    <a class="active" href="javascript:void(0);">
                                        <img src="${ctxStatic}/hsun/front/img/feiyang.png" alt="">
                                        <span class="to_user_name">全体人员</span>-<span class="numpeople" style="font-size: 12px;">0人在线</span><span class="news_nums">0</span>
                                        <input type="hidden" name="addnums" class="addnums" value="0">
                                    </a>
                                </li>
                                <div class="ones_list ">
                                    <%--<li><a href="javascript:void(0);"><img src="${ctxStatic}/hsun/front/img/feiyang.jpg" alt=""> <span>买买提1</span><span class="news_nums">0</span></a></li>--%>
                                </div>
                            </ul>
                        </div>
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bubble font-red-sunglo"></i>
                                <span class="caption-subject font-red-sunglo bold uppercase is_aite_name" style="font-size:14px;">全体人员</span>
                            </div>

                            <div class="actions">
                                <%--<span>--%>
                                    <%--<button>建立群聊</button>--%>
                                    <%--<button>清空聊天记录</button>--%>
                                <%--</span>--%>
                                <div class="portlet-input input-inline">
                                    <div class="input-icon right">
                                        <i onclick="Index.searchData()" class="icon-magnifier"></i>
                                        <input id="keywords" type="text" class="form-control input-circle" placeholder="输入搜索内容">
                                    </div>
                                </div>
                                <span class="chat_set">
                                    <button id="getConnection">连接</button>
                                    <button id="closeConnection">断开</button>
                                    <button id="clearConsole">清空记录</button>
                                    <button id="checkConnection">检测连接</button>
                                    <span class="fa fa-cog set_link"></span>
                                </span>

                            </div>
                        </div>
                        <div class="portlet-body" id="chats">
                            <div class="scroller" style="height: 341px;" data-always-visible="1" data-rail-visible1="1">
                                <ul class="chats">
                                    <%--<li class="out">--%>
                                        <%--<img class="avatar" alt="" src="${ctxStatic}/hsun/front/img/feiyang.jpg" />--%>
                                        <%--<div class="message">--%>
													<%--<span class="arrow">--%>
											<%--</span>--%>
                                            <%--<a href="javascript:;" class="name">--%>
                                                <%--Bob Nilson </a>--%>
                                            <%--<span class="datetime">--%>
											<%--at 20:09 </span>--%>
                                            <%--<br/>--%>
                                            <%--<span class="body">--%>
                                                <%--迷路也好空气里有种相依为命的味道爱你很好连风都知道第一次心甘情愿不想逃当爱相随...--%>
											 <%--</span>--%>
                                        <%--</div>--%>
                                    <%--</li>--%>
                                </ul>
                            </div>
                            <%--<div class="chat-form">--%>
                                <%--<div class="input-cont">--%>
                                    <%--<input class="form-control" type="text" placeholder="输入发送消息" />--%>
                                <%--</div>--%>
                                <%--<div class="btn-cont">--%>
											<%--<span class="arrow">--%>
									<%--</span>--%>
                                    <%--<a href="" class="btn blue icn-only">--%>
                                        <%--<i class="fa fa-check icon-white"></i>--%>
                                    <%--</a>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                            <!-- 加载编辑器的容器 -->
                            <div style="clear: both;padding-top: 40px;position:relative;">
                                <script id="container" name="content" type="text/plain" style="width:606px;height:60px;">输入发送消息</script>

                                <a class="blue fa fa-check icon-white fa-2x" href="javascript:void(0);" id="send_to" title="发送"></a>
                                <%--<a href="" class="btn blue icn-only">发送</a>--%>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
            </div>
        </div>
    </div>
    <!-- END CONTENT -->
</div>
<input id="now_talk_people" type="hidden" name="now_talk_people" value="total">
<input id="chats_height" type="hidden" name="chats_height" value="0">
<%--<input id="now_talk_window" type="hidden" name="now_talk_window" value="news-total">--%>
<%--<input type="text" id="sender" value="">--%>
<!--[if lt IE 9]>
<!--<script src="../../assets/global/plugins/respond.min.js"></script>-->
<!--<script src="../../assets/global/plugins/excanvas.min.js"></script>-->
<%--<![endif]-->--%>


<script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js${v}" type="text/javascript"></script>
<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/jquery.slimscroll.min.js${v}" type="text/javascript"></script>

<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/metronic.js${v}" type="text/javascript"></script>
<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/index.js${v}" type="text/javascript"></script>

<script type="text/javascript" src="${ctxStatic}/umeditor1.2.3-src/third-party/template.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/umeditor1.2.3-src/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctxStatic}/umeditor1.2.3-src/editor_api.js"></script>
<script type="text/javascript" src="${ctxStatic}/umeditor1.2.3-src/lang/zh-cn/zh-cn.js"></script>
<script>
    var um = UM.getEditor('container');
    //获取编辑器内容
    function getContent() {
        return UM.getEditor('container').getContent();
    }
    //设置编辑器内容
    function setContent(text) {
        um.setContent(text);
    }
    //获取编辑器纯文本
    function getContentTxt() {
        return um.getContentTxt();
    }

    jQuery(document).ready(function() {
        //编辑器获取焦点
        um.addListener('focus',function(){
            if(getContentTxt() == "输入发送消息"){
                setContent('');
            }
        });
        //编辑器失去焦点
        um.addListener('blur',function(){
            if(um.hasContents() == false){
                setContent('输入发送消息');
            }
        });


        $('#now_talk_people').val('total');
        //打开页面时上线通知
        if("${message}"){
            layer.msg('${message}', {
                offset: 0
            });
        }
        if("${error}"){
            layer.msg('${error}', {
                offset: 0,
                shift: 6
            });
        }

        $("#people_list").slimScroll({
            color:'#E4E4E4'
        });
        $("#container").slimScroll({
            color:'#E4E4E4'
        });


        Metronic.init(); // init metronic core componets
        Index.initChat();

        $('.input-icon.right').mouseout(function(){
            $('.form-control').blur();
        })
    });

</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->

</html>