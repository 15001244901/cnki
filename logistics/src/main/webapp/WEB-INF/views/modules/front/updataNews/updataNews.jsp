<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        .updata-news{
            background: rgba(0,0,0,0.5);
            position: fixed;
            top:0;
            left:0;
            right:0;
            bottom:0;
            z-index: 99;
        }

        .system-upgrade  .system-upgrade-wall, .system-upgrade  .pop-wrap { display: block; }
        .system-upgrade-wall { position: fixed; top:0; right:0; left:0; bottom:0; background:#000; opacity: 0.3; filter:alpha(opacity=30); z-index: 10000; display: none; }
        .pop-wrap { width: 600px; background-color: #fff;  position: absolute; top: 60px;  left: 50%; margin-left: -300px; z-index: 12000; font-size: 14px; display: none; }
        .update span:first-child { margin-right: 30px; }
        .pop-banner img { display: block; }
        .pop-banner { position: relative;min-height: 168px;}
        .produce { position: absolute; top: -54px; left: 87px; }
        .pop-banner .icon-close { cursor: pointer; display: block; width: 36px; height: 36px; position: absolute; background: url(${ctxStatic}/hsun/front/img/updataNews/close.png); right: -15px; top: -16px;}
        .main-wrap { padding: 20px 24px; max-height: 350px; overflow: auto; }
        .pop-icon { width: 4px; height: 22px; background-color: #52c684; float: left; margin-right: 10px; }
        .pop-title>h1 { font-size: 16px; float: left;line-height: 22px;}
        .pop-detail { clear: both; }
        #J_NoticeModal .pop-content { margin-top: 20px; text-align: left; margin:0; }
        .pop-detail li { line-height: 22px; margin-bottom: 5px; }
        .pop-detail li a {  color: #52c684; }
        .pop-detail li a:hover { text-decoration:underline; }
        .pop-detail { padding-top: 10px;}
        .pop-title { overflow: hidden; margin-top: 15px; }
        #J_NoticeModal .pop-content h1 { margin-bottom: 0; font-size: 16px; font-weight: bold; }
        .news-remember{line-height: 30px;border-top:1px solid #ddd;margin-top:10px;font-size: 12px;padding:1px 25px;}
        .news-remember input{position:relative;top:2px;}
        #version-number{display:none}
    </style>
</head>

<body>
    <%--<div class="updata-news">--%>

    <%--</div>--%>
    <div class="system-upgrade-wall"></div>
    <div class="pop-wrap" id="J_NoticeModal" style="top: 111.5px; position: absolute;">
        <div class="pop-banner">
            <img src="${ctxStatic}/hsun/front/img/updataNews/updata1.png" alt="">
            <img src="${ctxStatic}/hsun/front/img/updataNews/updata2.png" alt="" class="produce">
            <span class="icon-close"></span>
        </div>
        <div class="main-wrap">
            <div class="update">
                <span id="uptata-number">更新版本：V</span>
                <span>更新时间：2018年2月5日</span>
            </div>
            <div class="pop-content">
                <div class="pop-title">
                    <div class="pop-icon"></div>
                    <h1>更新内容</h1>
                </div>
                <ul class="pop-detail">
                    <li>1.公司、检测单位、人员组织架构重构升级；</li>
                    <li>2.管理员、子管理员、主管角色权限重构升级；</li>
                    <li>3.加入【我的团队】学习情况监管机制；</li>
                    <li>4.加入公司及检测单位人员答题榜、活跃榜、勤奋榜统计分析；</li>
                    <li>5.单位内部在线交流模块按照组织机构体系进行重构升级；</li>
                    <li>6.文库、标准、试题等模块内容更新；</li>
                    <li>7.系统性能优化，移动端全面适配；</li>
                </ul>
            </div>
        </div>
        <div class="news-remember">
            <label>下次不再提示<input type="checkbox"></label>
        </div>

    </div>
    <script>
        $(function() {
            // 获取存储
            function fetch(id){
                return JSON.parse(window.localStorage.getItem('fykt-news-'+id));
            }
            //存储到本地
            function save(str,id){
                var keyName = 'fykt-news-'+id;
                window.localStorage.setItem(keyName,JSON.stringify(str));
            }

            var version_number = '${v}';
            version_number = version_number.substring (3);
            $('#uptata-number').html('更新版本：V'+version_number);
            var SystemUpgrade = {
                show_notice: function() {
                    var h = $(window).height(); // 显示器屏幕高度
                    var h1 = this.$el.height();

                    if (h >= h1) {
                        this.$el.css({'top': ((h-h1+60)/2) + 'px', 'position': 'fixed'});
                    }
                    else {
                        this.$el.css({'position': 'absolute'});
                    }
                },
                isClosed: function() {
                    return  fetch(ismyid);
                },
                clear_notice: function() {
                    this.$el.remove();
                    $('.system-upgrade-wall').remove();

                    var isremb = this.$inp.is(':checked');
                    if(isremb){
                        save({'remeber':1,'version':version_number},ismyid)
                    }

                },
                init: function() {
                    var self = this;
                    this.$el = $('#J_NoticeModal');
                    this.$version = $('#version-number');
                    this.$inp = $('.news-remember input');
                    this.$doc = $(document.documentElement);
                    this.$doc.addClass('system-upgrade');
                    this.$el.on('click', '.icon-close', function() {
                        self.clear_notice();
                    });
                    this.show_notice();
                    $(window).resize(function() {
                        self.show_notice();
                    });
                }
            };
            if (!SystemUpgrade.isClosed() || SystemUpgrade.isClosed().version != version_number) SystemUpgrade.init();

        });
    </script>
</body>

</html>
