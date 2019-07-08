$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var indexPageFun = function(){
        var that = this;

        this.model_name = $('.model_name_list');

        this.powerTestFun = function(){
            if(!publicFun.validateUser()){
                publicFun.jumpLoginPage2();
                return;
            }

            var data_power = $(this).data('power');
            if(data_power == "1"){
                var href = $(this).data('href');
                window.location.href = href;
            }else if(data_power == "2"){
                var href = $(this).data('href');
                window.location.href = href;
            }else{
                publicFun.alertBox('暂无权限','1');
            }
        };

        this.updataNewsFun = function(){
            if(publicFun.validateUser()){
                var notice = $('<div id="updata-news"></div>');
                $('body').append(notice);
                notice.load(urlpath+'/page/updataNews/mobileNews.html');
            }
        }
        this.init = function(){
            this.updataNewsFun();
            this.model_name.off('click').on('click',this.powerTestFun);
        }
    };

    var indexPage = new indexPageFun;
    indexPage.init();

    var practiceRecordFun = function(){
        var that = this;

        this.record_list = $('.last_exam');   //列表容器
        this.list_model  = $('#last_exam').html(); //模板
        this.no_list_model  = $('#no_last_exam').html(); //模板暂无


        this.delobj_id;

        this.loadData = function(){
            publicFun.loading($('body'));

            $.ajax({
                url: urlpath + '/user/paper/list.jhtml',
                type: "GET",
                data: {
                    pageNo: 1,
                    pageSize: 10,
                    orderBy:'starttime asc',
                    isExpired:0
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
                        var paper_length = items.length > 5 ? 5 : items.length ;
                        for (var i = 0; i < paper_length; i++) {
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
                        that.record_list.html(that.no_list_model);
                    }

                    $('.loading').remove();

                    that.exam_infor = $('.last_exam li');
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


        this.goNext = function(e){

            if($(this).hasClass('no_exam')) return;

            var isbj = $(this).data('bj');
            var isid = $(this).data('id');

            if(!publicFun.validateUser()){
                publicFun.jumpLoginPage2();
                return;
            }

            if(isbj){
                window.location.href = "exam/examPage.html?pid="+isid;
            }else{
                publicFun.alertBox('未到考试',1)
            }
        };

        this.init = function(){
            this.loadData();
        }
    };

    var practiceRecord = new practiceRecordFun;
    practiceRecord.init();

    publicFunPreventMove('mycontainer');
});