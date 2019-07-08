$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var practiceRecordFun = function(){
        var that = this;
        var pageNo = 1;
        var pageTotalNum;

        this.shade = $('.shade');

        this.record_list = $('.record_list ul');   //列表容器
        this.list_model  = $('#list_model').html(); //模板

        this.page_btnl = $('.page_btnl');       //上一页
        this.page_btnlr = $('.page_btnr');      //下一页
        this.now_page_num = $('.now_page_num');     //当前页码
        this.page_btnnum  = $('.page_btnnum');   //跳转页码
        this.total_page_num = $('.total_page_num'); //总页码
        this.page_num_list = $('.page_num_list');
        this.page_num      = $('.page_num');

        this.delobj_id;

        this.loadData = function(){
            publicFun.loading($('body'));

            $.ajax({
                url: urlpath + '/user/paper/history.jhtml',
                type: "GET",
                data: {
                    pageNo: pageNo,
                    pageSize: 10
                    // keyword: keyword,
                },
                success:function(t){
                    // console.log(t);
                    var datas = t.data;
                    if(t.success && datas.list && datas.list.length>0){
                        var items = datas.list;
                        var newtimes = new Date().getTime();     //获取当前时间戳

                        var domString = ' ';
                        for (var i = 0; i < items.length; i++) {
                            var dictionary = items[i];

                            var times = (dictionary.paper.showtime || 0);
                            var showtimes = Date.parse(new Date(times));  //将发放试卷时间转化为时间戳
                            var differ = showtimes - newtimes ;

                            //判断及格分数
                            var ispassscore = dictionary.score - dictionary.paper.passscore;


                            if(differ <= 0){
                                if(ispassscore >= 0){
                                    dictionary.classname = 'color3';
                                }else{
                                    dictionary.classname = 'color4';
                                }
                            }


                            if(differ>0){
                                dictionary.bj = 0;
                                dictionary.score = "未到成绩公布日期";
                                dictionary.classname = 'color4';
                            }else{
                                dictionary.bj = 1;
                                dictionary.score = dictionary.score + '分';
                            }



                            if(dictionary.paper.showtime){
                                dictionary.papertype = '';
                                dictionary.opentime = '成绩公布日期：'+dictionary.paper.showtime;
                            }else{
                                dictionary.papertype = '试卷类型：线下卷';
                                dictionary.opentime = '';
                            }

                            domString += publicFun.comPile(that.list_model,dictionary);
                        }
                        that.record_list.html(domString);

                    }else{
                        publicFun.noData(that.record_list);
                    }

                    if(datas.totalPageCount > 1){
                        $('.page').show();
                    }else{
                        $('.page').hide();
                    }
                    that.total_page_num.html(datas.totalPageCount);
                    that.now_page_num.html(datas.pageNo);

                    $('.loading').remove();
                    that.loadPage(datas.totalPageCount);



                    that.exam_infor = $('.exam_infor');
                    that.exam_infor.off('click').on('click',that.goNext);
                }
            });
        };





        //加载分页
        this.loadPage = function(totalnum){
            if(pageTotalNum == totalnum){
                return;
            }
            pageTotalNum = totalnum;
            var pages = totalnum;
            var pagearr = [];
            for (var i = 0; i < pages; i++) {
                pagearr.push('<li data-num="'+(i+1)+'">第'+(i+1)+'页</li>');
            }
            that.page_num_list.html(pagearr.join(""));

            that.page_num_item = that.page_num_list.find('li');
            that.page_num_item.off('click').on('click',that.goPage);

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
            that.loadData();
            that.hidePagePanel();
        };
        //上一页
        this.prevPageFun = function(){
            if(pageNo <= 1){
                publicFun.alertBox('已经到第一页了');
                return;
            }
            pageNo = pageNo -1;
            that.loadData();
        };
        //下一页
        this.nextPageFun = function(){
            var totalnum = Number(that.total_page_num.html());
            if(pageNo >= totalnum){
                publicFun.alertBox('已经到最后一页了');
                return;
            }
            pageNo = pageNo + 1;
            that.loadData();
        };

        this.goNext = function(e){
            if(!publicFun.validateUser()){
                publicFun.jumpLoginPage2();
                return;
            }

            var isid = $(this).data('id');
            var ispid = $(this).data('pid');
            var isbj = $(this).data('bj');

            if(isbj == '1'){
                window.location.href = "examContent.html?id="+isid+'&pid='+ispid;
            }else{
                publicFun.alertBox('未到成绩公布日期');
            }



        };

        this.init = function(){
            this.loadData();
            // 分页
            this.page_btnl.off('click').on('click',this.prevPageFun);
            this.page_btnlr.off('click').on('click',this.nextPageFun);
            this.page_btnnum.off('click').on('click',this.showPagePanel);
            this.shade.off('click').on('click',this.hidePagePanel);

        }
    };

    var practiceRecord = new practiceRecordFun;
    practiceRecord.init();

});