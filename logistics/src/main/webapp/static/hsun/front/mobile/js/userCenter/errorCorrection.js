$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var pageNo = 1;
    var errorCorrectionFun = function(){
        var that = this;

        this.error_correction = $('.error_correction');  //列表容器
        this.error_model   = $('#error_model').html();    //模板内容


        this.loadData = function(){
            publicFun.loading($('body'));
            $('.now_page_num').html(pageNo);

            $.ajax({
                url: urlpath_a + '/exam/question/comment.jhtml?ctype=3',
                type: "GET",
                data:{
                    pageNo:pageNo,
                    pageSize:10
                },
                success:function(t){
                    //console.log(t);
                    var data = t.data;
                    if(t.success && data.list && data.list.length>0){

                        var domString = '';
                        for(var j in t.data.list){
                            var dictionary = t.data.list[j]; // 获取数据
                            // 字典修正，构造一个字段
                            if(dictionary.delFlag === "2"){
                                dictionary.errstate = "审核中";
                            }else if(dictionary.delFlag === "0"){
                                dictionary.errstate = "已审核";
                            }else if(dictionary.delFlag === "1"){
                                continue;
                            }

                            if(!dictionary.content){
                                dictionary.content = "无";
                            }
                            dictionary.href = '../takeNote.html?id=' + dictionary.qid;
                            domString += publicFun.comPile(that.error_model,dictionary);
                        }

                        that.error_correction.html(domString);

                    }else{
                        publicFun.noData(that.error_correction);
                    }

                    $('.loading').remove();



                    pageBtn.loadPage(data.totalPageCount);
                }
            });
        };



        this.init = function(){
            this.loadData();
        }
    };

    var errorCorrection = new errorCorrectionFun;
    errorCorrection.init();

    var pageBtnFun = function(){
        var that = this;
        this.page_btnl = $('.page_btnl');       //上一页
        this.page_btnlr = $('.page_btnr');      //下一页
        this.now_page_num = $('.now_page_num');     //当前页码
        this.page_btnnum  = $('.page_btnnum');   //跳转页码
        this.total_page_num = $('.total_page_num'); //总页码
        this.page_num_list = $('.page_num_list');
        this.page_num      = $('.page_num');

        this.pageTotalNum;
        this.shade = $('.shade');

        //加载分页
        this.loadPage = function(totalnum){
            if(that.pageTotalNum == totalnum){
                return;
            }

            that.total_page_num.html(totalnum);

            pageTotalNum = totalnum;
            var pages = totalnum;
            var pagearr = [];
            for (var i = 0; i < pages; i++) {
                pagearr.push('<li data-num="'+(i+1)+'">第'+(i+1)+'页</li>');
            }
            that.page_num_list.html(pagearr.join(""));

            that.page_num_item = that.page_num_list.find('li');
            that.page_num_item.off('click').on('click',that.goPage);

            if(totalnum > 1){
                $('.page').show();
            }else{
                $('.page').hide();
            }

        };

        this.showPagePanel = function(){

            that.page_num_item.removeClass('bg_success');
            that.page_num_item.eq(pageNo-1).addClass('bg_success');
            that.page_num.css('height','5rem');
            $('.shade').fadeIn();
        };
        this.hidePagePanel = function(){
            that.page_num.css('height',0);
            $('.shade').fadeOut();
        };
        // 跳转
        this.goPage = function(){
            var num = $(this).data('num');
            pageNo = num;
            publicFun.backgroundClick($(this));
            errorCorrection.loadData();
            that.hidePagePanel();
        };
        //上一页
        this.prevPageFun = function(){
            if(pageNo <= 1){
                publicFun.alertBox('已经到第一页了');
                return;
            }
            pageNo = pageNo -1;
            errorCorrection.loadData();
        };
        //下一页
        this.nextPageFun = function(){
            var totalnum = Number(that.total_page_num.html());
            if(pageNo >= totalnum){
                publicFun.alertBox('已经到最后一页了');
                return;
            }
            pageNo = pageNo + 1;
            errorCorrection.loadData();
        };

        this.init = function(){
            // 分页
            this.page_btnl.off('click').on('click',this.prevPageFun);
            this.page_btnlr.off('click').on('click',this.nextPageFun);
            this.page_btnnum.off('click').on('click',this.showPagePanel);
            this.shade.off('click').on('click',this.hidePagePanel);
        }
    };
    var pageBtn = new pageBtnFun;
    pageBtn.init();
});