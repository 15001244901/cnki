$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var userCenterFun = function(){
        var that = this;
        this.title = $('.manage_item_title');
        this.has_next = $('.has_next');   //获取跳转标题
        this.sign_out = $('.sign_out');

        this.toggleTitleFun = function(){
            var children = $(this).next('ul');
            var url = $(this).data('url');
            publicFun.backgroundClick($(this));

            if(!publicFun.validateUser()){
                publicFun.jumpLoginPage2();
                return;
            }

            if(url){
                window.location.href = url;
                return;
            }

            if(children.length <= 0) return;

            if(children.css('display') == 'none'){
                children.slideDown();
            }else {
                children.slideUp();
            }
        };

        this.signOut = function(){
            window.location.href = urlpath_a+'/logout';
        };

        this.init = function(){
            this.title.off('click').on('click',this.toggleTitleFun);
            this.sign_out.off('click').on('click',this.signOut);
        }
    };

    var userCenter = new userCenterFun;
    userCenter.init();

});