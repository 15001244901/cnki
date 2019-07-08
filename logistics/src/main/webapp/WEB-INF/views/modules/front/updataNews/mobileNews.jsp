<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <style>
        .system-upgrade-wall  .pop-wrap { display: block;}
        .system-upgrade-wall { position: fixed; top:0; right:0; left:0; bottom:0; background:rgba(0,0,0,0.5);  z-index: 10000;display: flex;justify-content:center;align-items:center; }
        .pop-wrap { width: 80%; background-color: #fff;font-size:0.32rem;}

        .update span:first-child { margin-right: 0.4rem; }
        .pop-banner img { display: block;width: 5.613333rem; }
        .pop-banner { position: relative;min-height: 0.666667rem;background: #52C684;}

        .produce { position: absolute; top: -0.72rem; left: 1.16rem; }
        /*.pop-banner .icon-close { display: block; width: 0.533333rem; height: 0.533333rem; position: absolute;right: -0.266667rem; top: -0.266667rem;background-size:cover;font-size:0.506667rem;background: #fff;color: #999;border-radius: 50%;border:1px solid #ddd;text-align: center;line-height: 0.426667rem;}*/
        .pop-banner .icon-close{
            cursor: pointer; display: block; width: 0.8rem; height: 0.8rem; position: absolute; background: url(${ctxStatic}/hsun/front/img/updataNews/close.png); right: -0.4rem; top: -0.4rem;
            background-size:cover;
        }
        [data-dpr="1"] .pop-banner .icon-close{
            cursor: pointer; display: block; width: 30px; height: 30px; position: absolute; background: url(${ctxStatic}/hsun/front/img/updataNews/close.png); right: -14px; top: -14px;
            background-size:cover;
        }

        .main-wrap { padding: 0.266667rem 0.32rem; height: 4.666667rem; overflow: scroll;-webkit-overflow-scrolling: touch; }
        .pop-icon { width: 4px; height:0.413333rem; background-color: #52c684; float: left; margin-right: 0.133333rem; }
        .pop-title>h1 {float: left;}
        .pop-detail { clear: both; }
        #J_NoticeModal .pop-content { margin-top: 0.266667rem; text-align: left; margin:0; }
        .pop-detail li { line-height: 0.48rem; margin-bottom: 0.133333rem; }
        .pop-detail li a {  color: #52c684; }
        .pop-detail li a:hover { text-decoration:underline; }
        .pop-detail { padding-top: 10px;}
        .pop-title { overflow: hidden; margin-top: 0.2rem; }
        #J_NoticeModal .pop-content h1 { margin-bottom: 0; font-size: 0.32rem; font-weight: bold; }
        .news-remember{line-height: 0.4rem;border-top:1px solid #ddd;font-size: 0.293333rem;padding:0.2rem 0.333333rem;}
        .news-remember input{position:relative;top:0.026667rem;display: inline-block;width: 0.293333rem;height: 0.293333rem;}
        #version-number{display:none}
    </style>
</head>

<body>
<%--<div class="updata-news">--%>

<%--</div>--%>
<div class="system-upgrade-wall">
    <div class="pop-wrap" id="J_NoticeModal" >
        <div class="pop-banner">
            <%--<img src="${ctxStatic}/hsun/front/img/updataNews/updata1.png" alt="">--%>
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

        var ismyid = '${fns:getUser().id}';
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
                $('#updata-news').remove();

                var isremb = this.$inp.is(':checked');
                if(isremb){
                    save({'remeber':1,'version':version_number},ismyid)
                }

            },
            preMove:function(){
                 $('.system-upgrade-wall').on('touchmove',function(e){
                    e.preventDefault();
                });
                $('.main-wrap').on('touchmove',function(e){
                    e.stopPropagation();
                });
            },
            init: function() {
                var self = this;
                self.preMove();
                this.$el = $('#J_NoticeModal');
                this.$version = $('#version-number');
                this.$inp = $('.news-remember input');
              
                this.$el.on('click', '.icon-close', function() {
                    self.clear_notice();
                });
            }
        };
      
        if (!SystemUpgrade.isClosed() || SystemUpgrade.isClosed().version != version_number){
            SystemUpgrade.init();
            $('#updata-news').fadeIn();
        } 


    });
</script>
</body>

</html>
