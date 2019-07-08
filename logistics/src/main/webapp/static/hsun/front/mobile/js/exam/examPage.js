$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var mySwiper = new Swiper ('.swiper-container', {
        roundLengths : true,
        prevButton:'.page_btnl',
        nextButton:'.page_btnr',
        autoHeight: true,
        onSlideChangeStart: function(swiper){

            $('#pagesize').html(swiper.activeIndex+1);
            $('#ques_type_name').html(swiper.qtypename[swiper.activeIndex]);

        },
        onSlideChangeEnd: function(swiper){

            if(swiper.isEnd){
                // swiper.nextButton.addClass('color_default');
                $('.page_btnr').html('<div onclick="saveQuesFun();" class="page_save bg_danger"><i>提交</i></div>');
            }else{
                // swiper.nextButton.removeClass('color_default');
                $('.page_btnr').html('<i class="icon iconfont icon-practive-right"></i>');
            }

            if(mySwiper.isBeginning){
                swiper.prevButton.addClass('color_default');
            }else{
                swiper.prevButton.removeClass('color_default');
            }

        }
    });

    //加载试题
    var dailyPracticeFun = function(){
        var that = this;
        this.totalsize = $('#totalsize');  //总页数

        this.qtype1 = $('#qtype1').html();
        this.qtype3 = $('#qtype3').html();
        this.qtype4 = $('#qtype4').html();
        this.qtype5 = $('#qtype5').html();
        this.option = $('#options_model').html();
        this.input  = $('#input_model').html();
        this.infor  = $('#ques_infor').html();

        this.dansel_btn = $('.question_option_item label');  //单选按钮


        this.question_table_show = $('.page_table');    //显示答题卡
        this.question_table  = $('.question_table');    //答题卡容器

        this.prevBtn = $('.page_btnl');         //上一题
        this.nextBtn = $('.page_btnr');         //下一题


        this.paperId  = publicFun.getQueryString("pid");


        //加载试题数据
        this.loadQuesDataFun = function(){
            publicFun.loading($('body'));

            $.ajax({
                url: urlpath + '/user/paper/startExam.jhtml',
                type: "GET",
                // async: false,
                data: {
                    pid:that.paperId
                },
                success:function(t){
                    console.log(t);

                    if(!t.success){
                        publicFun.alertBox(t.msg,'1');
                        $('.loading').remove();
                        publicFun.noData($('.swiper-wrapper'));
                        return;
                    }
                    if(!t.data.sections || t.data.sections<=0 || !t.data.sections[0].questions || t.data.sections[0].questions.length<=0){
                        $('.loading').remove();
                        publicFun.noData($('.swiper-wrapper'));
                        return;
                    }


                    var html = [];
                    var domString = [];
                    var qtypename = [];

                    var quesId = [];


                    for (var h=0; h<t.data.sections.length; h++) {
                        var datas = t.data.sections[h].questions;


                        for(var i=0; i<datas.length; i++){

                            quesId.push( datas[i].id);
                            var dictionary = datas[i];
                            qtypename.push(dictionary.typeName || '综合');

                            if(dictionary.qtype == '1' || dictionary.qtype == '2'){

                                var option = ' ';
                                for(var j=0; j<dictionary.options.length; j++){
                                    var op_items = dictionary.options[j];
                                    op_items.qid = dictionary.id;
                                    if(dictionary.qtype == '1' ){
                                        op_items.inptype = 'radio';
                                    }else if(dictionary.qtype == '2'){
                                        op_items.inptype = 'checkbox';
                                    }
                                    option += publicFun.comPile(that.option,op_items);
                                }

                                dictionary.options = option;
                                domString.push(publicFun.comPile(that.qtype1,dictionary));

                            }else if(dictionary.qtype == '3'){

                                domString.push(publicFun.comPile(that.qtype3,dictionary));

                            }else if(dictionary.qtype == '4'){

                                var ishtml = publicFun.replaceInputLength(dictionary.qcontent);
                                var islength = ishtml.count;

                                var inputhtml = [];
                                for (var k=0;k<islength;k++) {
                                    inputhtml.push('<div class="question_option_item flex">');
                                    inputhtml.push('<input class="textinput" type="text" name="Q-'+dictionary.id+'" placeholder="请填入第'+(k+1)+'个空的答案" onchange=fillUp(this,\''+dictionary.id+'\')>');
                                    inputhtml.push('</div>');
                                }
                                dictionary.input = inputhtml.join("");
                                dictionary.qcontent = ishtml.html;
                                domString.push(publicFun.comPile(that.qtype4,dictionary));

                            }else if(dictionary.qtype == '5' || dictionary.qtype == '6'){
                                domString.push(publicFun.comPile(that.qtype5,dictionary));
                            }

                        }
                    }

                    mySwiper.appendSlide(domString);
                    mySwiper.qtypename = qtypename;
                    that.totalsize.html($('.swiper-slide').length);
                    $('#ques_type_name').html(qtypename[0]);

                    countTime.times = t.data.duration* 60;
                    countTime.duringtime = t.data.duration;

                    //加载答题卡
                    questionTable.loadTableCard(quesId);
                    countTime.init();

                    $('.loading').remove();
                    $('.exam_name').html(t.data.name);
                    $('.exam_totaltime').html(t.data.duration+'分钟');
                    $('.exam_totalscore').html(t.data.totalscore+'分');
                    $('.exam_begintime').html(t.data.starttime);
                    $('.exam_endtime').html(t.data.endtime);

                }
            });
        };



        //显示答题卡
        this.tableShowFun = function(){
            questionTable.nowQuesStateFun();
            that.question_table.css({'top':0});
            publicFun.backgroundClick($(this));

        };

        // 上一题
        this.prevQuesFun = function(){
            publicFun.backgroundClick($(this));
        };
        // 下一题
        this.nextQuesFun = function(){
            publicFun.backgroundClick($(this));
        };

        //选择题
        selectQuesFun = function(is,id){
            event.preventDefault();
            event.stopPropagation();
            var isparent = $(is).closest('.question_option');



            var istype = isparent.data('qtype');


            if(istype == 1 || istype == 3){

                isparent.find('label').removeClass('bg_selected');
                $(is).addClass('bg_selected');
                $('#card_'+id).addClass('bg_selected');

                isparent.find('input').removeAttr('checked');
                $(is).find('input').attr('checked','checked');

            }else if(istype == 2){

                if($(is).hasClass('bg_selected')){
                    $(is).removeClass('bg_selected').addClass('bg_default');
                    $(is).find('input').removeAttr('checked');
                }else{
                    $(is).addClass('bg_selected').removeClass('bg_default');
                    $(is).find('input').attr('checked','checked');
                }

                var checkedbox= false;
                isparent.find('input').each(function(el,index){
                    if($(this).attr('checked')){
                        checkedbox=true;
                    }
                });

                console.log(checkedbox);
                if(checkedbox){
                    $('#card_'+id).addClass('bg_selected')
                }else{
                    $('#card_'+id).removeClass('bg_selected');
                }
            }

        };

        //填空题
        fillUp = function(is,id){
            var parentobj = $(is).closest('.question_option');

            var isanswer = false;
            parentobj.find('input').each(function(el,index){
                var istext = $(this).val();
                if($.trim(istext)){
                    isanswer = true;
                }
            });
            if(isanswer){
                $('#card_'+id).addClass('bg_selected');
            }else{
                $('#card_'+id).removeClass('bg_selected');
            }
        };

        //简答题
        shortAnswer = function(is,id){
            var parentobj = $(is).closest('.question_option');
            var isanswer = parentobj.find('textarea').val();
            if($.trim(isanswer)){
                $('#card_'+id).addClass('bg_default');
            }else{
                $('#card_'+id).removeClass('bg_default');
            }
        };

        this.init = function(){
            // publicFun.bgClick();
            this.loadQuesDataFun();

            //显示答题卡
            this.question_table_show.off('click').on('click',this.tableShowFun);

            // 上一题
            this.prevBtn.off('click.a').on('click.a',this.prevQuesFun);
            // 上一题
            this.nextBtn.off('click.a').on('click.a',this.nextQuesFun);


        }
    };

    var dailyPractice = new dailyPracticeFun;
    dailyPractice.init();

    //答题卡
    var questionTableFun = function(){
        var that = this;

        this.question_table  = $('.question_table');    //答题卡容器
        this.ques_table_hide = $('.ques_table_hide');   //隐藏答题卡

        this.card_container  = $('.card_container');     //卡容器

        this.save_ques = $('.save_btn');                 //提交按钮
        this.confirm_model = $('#confirm_model').html(); //提交确定框

        this.loadTableCard = function(obj){
            var datas = obj;
            var cards = [];
            for (var i = 0; i < datas.length; i++) {
                cards.push('<span id="card_'+datas[i]+'" class="card">'+(i+1)+'</span>');
            }

            that.card_container.html(cards.join(''));

            that.card = $('.card');           //获取卡片属性
            that.card.off('click').on('click',this.cardFun);
        };

        //点击答题卡
        this.cardFun = function(){
            var index = $(this).index();
            mySwiper.slideTo(index,0);
            publicFun.backgroundClick($(this));
            that.tableHideFun();
        };

        //隐藏答题卡
        this.tableHideFun = function(){
            var isbottom = '100vh';
            that.question_table.css({'top':isbottom});
        };

        //答题卡当前题的状态
        this.nowQuesStateFun = function(){
            var index = mySwiper.activeIndex;
            that.card.removeClass('now_pos');
            that.card.eq(index).addClass('now_pos');
        };

        // 提交试题
        saveQuesFun = function(){
            if($('.confirm_prictice').length>0) return;
            $('body').append(that.confirm_model);

        };

        //确定提交练习
        confirmSaveQuesFun = function(){
            var duration;
            if(countTime.times<=60){
                duration = 1
            }else{
                duration = Math.floor(countTime.times/60)
            }

            duration = countTime.duringtime - duration;

            var datas = '';
            $('form .selinput').each(function(){
                if($(this).attr('checked') == "checked"){
                    var names = $(this).attr("name");
                    var val = $(this).val();
                    datas += names+'='+val+'&';
                }
            });

            $('form .textinput').each(function(){
                var val = $(this).val();
                if($.trim(val)){
                    var names = $(this).attr("name");
                    var val = $(this).val();
                    datas += names+'='+val+'&';
                }
            });

            $('form textarea').each(function(){
                var val = $(this).val();
                if($.trim(val)){
                    var names = $(this).attr("name");
                    var val = $(this).val();
                    datas += names+'='+val+'&';
                }
            });

            datas += 't_timecost='+duration+'&pid='+dailyPractice.paperId;
            console.log(datas);
            $.ajax({
                url: urlpath + '/user/paper/submitPaper.jhtml',
                type: "post",
                data: datas,
                success: function (t) {
                    // console.log(t);
                    var success = t.success;
                    if (success) {
                        window.location.href = "../userCenter/examRecord.html";
                    } else {
                        publicFun.alertBox(t.msg,'1');
                    }
                }
            });
        };


        this.init = function(){
            this.ques_table_hide.off('click').on('click',this.tableHideFun);
            this.save_ques.off('click').on('click',saveQuesFun);
        }
    }

    var questionTable = new questionTableFun;
    questionTable.init();

    //记录时间
    var countTimeFun = function(){
        var that = this;
        this.times = 0;
        this.duringtime;
        this.page_answer = $('.page_answer');    //暂停按钮
        this.pause_model = $('#pause_model').html();

        this.loadTime = function(){
            var day1 = Math.floor(that.times / (60 * 60 * 24));
            var hour = Math.floor((that.times - day1 * 24 * 60 * 60) / 3600);
            var minute = Math.floor((that.times - day1 * 24 * 60 * 60 - hour * 3600) / 60);
            var second = Math.floor(that.times - day1 * 24 * 60 * 60 - hour * 3600 - minute * 60);

            if (hour.toString().length == 1) {
                hour = "0" + "" + hour;
            }
            if (minute.toString().length == 1) {
                minute = "0" + "" + minute;
            }
            if (second.toString().length == 1) {
                second = "0" + "" + second;
            }

            $('.hour').html(hour);
            $('.minute').html(minute);
            $('.second').html(second);

            that.times--;
        }

        this.pauseTimer = function(){
            clearInterval(that.timer);
            $('body').append(that.pause_model);
        }

        goOn = function(){
            $('.confirm_shade').remove();
            that.timer = setInterval(that.loadTime,1000);
        }

        this.init = function(){
            this.timer = setInterval(that.loadTime,1000);
            //暂停
            this.page_answer.off('click').on('click',this.pauseTimer);
        }
    }
    var countTime = new countTimeFun;

    publicFunPreventMove('mycontainer');
});