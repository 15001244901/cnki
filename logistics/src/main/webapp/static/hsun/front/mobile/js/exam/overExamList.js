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
                url: urlpath + '/user/paper/list.jhtml',
                type: "GET",
                data: {
                    pageNo: pageNo,
                    pageSize: 10,
                    orderBy:'starttime asc',
                    isExpired:1
                    // keyword: keyword,
                },
                success:function(t){
                    // console.log(t);

                    var datas = t.data;
                    if(t.success && datas.list && datas.list.length>0){
                        var items = datas.list;
                        var newtimes = new Date().getTime();     //获取当前时间戳


                        var timestamp = t.nowDate;
                        timestamp = timestamp.replace(/-/g,"/");
                        timestamp = Date.parse(timestamp);



                        var domString = ' ';
                        for (var i = 0; i < items.length; i++) {
                            var dictionary = items[i];

                            // 考试开始时间
                            var ie_starttime =dictionary.starttime;
                            ie_starttime = ie_starttime.replace(/-/g,"/");
                            // 考试开始时间戳
                            var times = Date.parse(ie_starttime);
                            //判断考试是否开始
                            var timecha = times - timestamp ;

                            if(timecha <= 0){
                                dictionary.during = '已开始考试';
                                dictionary.classname = 'color4';
                                dictionary.bj = true;
                            }else{
                                dictionary.during = that.countTime(timecha,times);
                                dictionary.classname = '';
                                dictionary.bj = false;


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


        this.countTime = function(str,tis) {
            var is_plus = str;
            str = Math.abs(str);
            str = str/1000;
            var day1 = Math.floor(str / (60 * 60 * 24));
            var hour = Math.floor((str - day1 * 24 * 60 * 60) / 3600);
            var minute = Math.floor((str - day1 * 24 * 60 * 60 - hour * 3600) / 60);
            var second = Math.floor(str - day1 * 24 * 60 * 60 - hour * 3600 - minute * 60);

            if(hour.toString().length == 1) {
                hour = "0" + "" + hour;
            }
            if(minute.toString().length == 1) {
                minute = "0" + "" + minute;
            }
            if(second.toString().length == 1) {
                second = "0" + "" + second;
            }

            var time = (day1 || 0) + ' 天 ' + (hour || 0) + ' 时 ' + (minute || 0) + ' 分 ' + (second || 0) + ' 秒';
            if(!day1){
                var time = (hour || 0) + ' 时 ' + (minute || 0) + ' 分 ' + (second || 0) + ' 秒';
            }else if(!hour){
                var time = (minute || 0) + ' 分 ' + (second || 0) + ' 秒';
            }else if(!minute){
                var time = (second || 0) + ' 秒';
            }

            if(is_plus<0){
                time = '-&nbsp;'+time;
            }
            return time;
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
            // var isbj = $(this).data('bj');
            // var isid = $(this).data('id');

            // if(isbj){
            // 	window.location.href = "examPage.html?pid="+isid;
            // }else{
            // 	publicFun.alertBox('未到考试',1)
            // }
            publicFun.alertBox('考试已结束',1)
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