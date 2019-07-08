<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>地理云课堂</title>
        <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
        <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
        <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
        <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">
        <script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>

        <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
        <script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

        <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
        <link rel="stylesheet" href="${ctxStatic}/hsun/front/css/search.css${v}">

        <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
        <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

        <script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
        <script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
        <style>

            .fl{
                float: left;
            }
            .fr{
                float: right;
            }
            .ml20{
                margin-left: 20px;
            }
            .baike_cont div,.baike_cont figure,.baike_cont img,.baike_cont input,.baike_cont button {
                box-sizing: content-box;
            }
            .baike_cont{
                margin:20px auto 0 ;
                width:1200px;
                overflow: hidden;
            }
            .baike_cont_fl{
                width:840px;
                padding:30px;
            }
            .art-widget-box{
                background: #fff;
                box-shadow: 0 1px 2px #c1c1c1;
            }
            .fl_title{
                font-size:22px;
                font-weight: normal;
                line-height: 28px;
                color: #333;
            }
            .fl_title_mark{
                padding-top:5px;
                padding-bottom:20px;
                border-bottom:1px solid #e6e6e6;
            }
            .ding_num,.see_num{
                padding-top:4px;
            }
            .baike_cont_fl span{
                color: #999;
                font-size:14px;
                line-height: 14px;
            }

            .baike_container{
                padding:20px 10px;
                min-height: 300px;
                color: #333;
                font-size: 15px;
                line-height: 24px;
            }
            .baike_container span,.baike_container div{
                color: #333;
            }

            /*右侧*/
            .baike_cont_fr{
                width:250px;
                min-height: 122px;
                padding:30px 15px;
                margin-left:20px;
            }
            .other-top{
                margin-bottom:15px;
                font-size: 15px;
            }
            .other-list{
                color: #aaa;
                font-size: 13px;
            }
            .other-list li{
                margin:5px 0;
            }
            .other-list li a:hover{
                text-decoration: underline;
            }
            .other-list em{
                /*font-size: 12px;*/
            }

            /*内容底部*/
            .baike_cont_fl .baike_zan{
                width:100px;
                height:36px;
                line-height:36px;
                text-align: center;
                font-size: 16px;
                border-radius: 3px;
                border: solid 1px #e2e2e2;
                display: block;
                margin:0 auto;
            }
            .baike_cont_fl .baike_zan:hover{
                border-color: #3db06e;
                color: #3db06e;
            }
            .baike_zan em{
                padding-right:5px;
            }
            .baike_link{
                margin:30px auto;
                overflow: hidden;
                padding-top:15px;
                border-top:1px solid #e6e6e6;
            }
            .channel_logo{
                background-color: #e04845;
                border-radius: 50%;
                font-size: 12px;
                width: 40px;
                height: 35px;
                text-align: center;
                font-size: 10px;
                line-height: 14px;
                color: #fff;
                padding-top: 5px;
            }
            .channel_link p{
                margin-left:15px;
                line-height:40px;
            }
            .channel_link p:hover{
                text-decoration: underline;
            }
            .baike_container table{
                border-collapse: collapse;
            }
        </style>
    </head>
    <body>
        <div id="divheader"></div>
        <div class="baike_cont">
            <div class="fl baike_cont_fl art-widget-box">
                <h1 class="fl_title"></h1>
                <div class="fl_title_mark">
                    <span class="mark">
                        <a href="javascript:void(0)">发布于</a>
                    </span>
                    <span style="color: #e6e6e6;">
                        :
                    </span>
                    <span class="time">
                        <a href="javascript:void(0)"></a>
                    </span>
                    <%--<span class="ding_num fr">--%>
                        <%--<a class="fa fa-thumbs-up" href="javascript:void(0);"></a>111--%>
                    <%--</span>--%>
                    <%--<span class="see_num fr" style="padding-right:20px;">--%>
                        <%--<a class="fa fa-eye" href="javascript:void(0);"></a>--%>
                        <%--111--%>
                    <%--</span>--%>
                </div>

                <div class="baike_container">

                </div>
                <div class="baike_bottom">
                    <%--<a class="baike_zan" href="javascript:;"><em class="fa fa-thumbs-up"></em>赞</a>--%>
                    <div class="baike_link">
                        <a href="${ctxRoot}/page/baike/baike.html" target="_blank" class="channel_link">
                            <div class="channel_logo fl">地理<br>云课堂</div>
                            <p class="fl">更多精彩&nbsp;尽在地理云课堂百科</p>
                        </a>
                    </div>
                </div>
            </div>
            <div class="fl baike_cont_fr art-widget-box">
                <div class="other-article">
                    <div class="other-top">相关文章</div>
                    <ul class="other-list" id="other-list">
                        <%--<li class="list">--%>
                            <%--<em class="fa fa-arrow-circle-right"></em>--%>
                            <%--<a href="javascript:void(0);" target="_blank" title="什么是双光束原子吸收分光光度计？其优点何在？">什么是双光束原子吸收分光光度计？其优点何在？</a>--%>
                        <%--</li>--%>
                        <%--<li class="list">--%>
                            <%--<em class="fa fa-arrow-circle-right"></em>--%>
                            <%--<a href="javascript:void(0);" target="_blank" title="试样存放时间对b值有何影响？">试样存放时间对b值有何影响？</a>--%>
                        <%--</li>--%>
                        <%--<li class="list">--%>
                            <%--<em class="fa fa-arrow-circle-right"></em>--%>
                            <%--<a href="javascript:void(0);" target="_blank" title="本法的适用范围如何？">本法的适用范围如何？</a>--%>
                        <%--</li>--%>                       <%--<li class="lis
                           <%--<em class=
                           <%--<a href="j
                       <%--</li>--%>
                            <%--<li class="lis
                                <%--<em class=
                                <%--<a href="j
                            <%--</li>--%>

                    </ul>
                </div>
            </div>
        </div>
        <script id="relarticle" type="text/template">
            <li class="list">
                <em class="fa fa-arrow-circle-right"></em>
                <a href="${ctxRoot}/page/baike/baike_cont.html?id={{id}}" target="_blank" title="{{title}}">{{title}}</a>
            </li>
        </script>
        <script>
            $(function(){
                var baikeCont = function(){
                    var that = this;
                    var this_title_cont = $("#divheader");     //获取头部容器
                    var fl_title        = $('.fl_title');      //获取标题
                    var baike_container = $('.baike_container');  //获取内容
                    this.creattime      = $('.time');
                    var relarticle     = $('#relarticle').html();  //相关文章模型
                    this.otherlist       = $('#other-list');  //相关文章容器

                    //获取url参数 传值url中的key
                    this.getQueryString = function(key) {
                        var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
                        var result = window.location.search.substr(1).match(reg);
                        return result ? decodeURIComponent(result[2]) : null;
                    };

                    //加载数据
                    this.loadData = function(){
                        var baike_id = this.getQueryString('id');   //获取地址栏id

                        $.ajax({
                            url: urlpath_a + '/bk/encyclopedia/list.jhtml',
                            type: "POST",
                            data: {
                                id: baike_id
                            },
                            success: function(t) {
                                // console.log(t);
                                var data = t.data;
                                if(data.list){
                                    fl_title.html(data.list[0].title);
                                    baike_container.html(data.list[0].content);
                                    that.creattime.find('a').html(data.list[0].createDate);
                                }
                            }
                        })
                    };
                    //数据正则匹配方法
                    this.comPile = function(templateString , dictionary){
                        return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                            return dictionary[$1];
                        });
                    };
                    //加载相关文章列表
                    this.loadArticle = function(){
                        $.ajax({
                            url: urlpath_a + '/bk/encyclopedia/list.jhtml',
                            type: "POST",
                            data: {
                                pageSize:5
                            },
                            success: function(t) {
//                                console.log(t);
                                var data = t.data;
                                if(data.list){
                                    var domString = '';
                                    for(var i in data.list){
                                        var dictionary = data.list[i];
                                        domString += that.comPile(relarticle,dictionary);

                                    }
                                    that.otherlist.html(domString);
                                }
                            }
                        })
                    };

                    this.init = function(){
                        this_title_cont.load(projectname + "/page/include/header.html"+timestamps);
                        this.loadData();
                        this.loadArticle();
                    }
                };

                var baikecont = new baikeCont();
                baikecont.init();
            });
        </script>
    </body>
</html>