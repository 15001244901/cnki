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

            dailyPractice.moreCheckQuesFun(2);
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


        this.page_answer = $('.page_answer');    //显示答案按钮
        this.question_table_show = $('.page_table');    //显示答题卡
        this.question_table  = $('.question_table');    //答题卡容器

        this.prevBtn = $('.page_btnl');         //上一题
        this.nextBtn = $('.page_btnr');         //下一题

        //加载试题数据
        this.loadQuesDataFun = function(){
            var topic   = publicFun.getQueryString("topic");
            var topicname = publicFun.getQueryString("topicname");
            var restart = publicFun.getQueryString("restart");
            $.ajax({
                url: urlpath + '/user/practice/startPractice.jhtml',
                type: "GET",
                // async: false,
                data: {
                    ptype: 1,
                    topic: topic,
                    topicname: topicname,
                    pageSize:20 ,
                    restart:(restart || '')
                },
                success:function(t){
                    // console.log(t);
                    if(!t.success){
                        publicFun.alertBox(t.msg,'1');
                        return;
                    }
                    if(!t.data.sections || t.data.sections<=0 || !t.data.sections[0].questions || t.data.sections[0].questions.length<=0){
                        return;
                    }

                    var datas = t.data.sections[0].questions;

                    that.totalsize.html(datas.length);

                    var html = [];
                    var domString = [];
                    var qtypename = [];
                    for(var i=0; i<datas.length; i++){

                        var dictionary = datas[i];
                        qtypename.push(dictionary.typeName || '综合');

                        if(!dictionary.qresolve){
                            dictionary.qresolve = '暂无';
                        }
                        if(!dictionary.stdNo){
                            dictionary.stdNo = '暂无';
                        }
                        if(!dictionary.topicName){
                            dictionary.topicName = '暂无';
                        }
                        if(!dictionary.postName){
                            dictionary.postName = '暂无';
                        }

                        if(dictionary.qlevel == '1'){
                            dictionary.qlevel = '★☆☆☆☆';
                        }else if(dictionary.qlevel == '2'){
                            dictionary.qlevel = '★★★☆☆';
                        }else if(dictionary.qlevel == '3'){
                            dictionary.qlevel = '★★★★★';
                        }

                        dictionary.infor = publicFun.comPile(that.infor,dictionary);

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

                    mySwiper.appendSlide(domString);
                    mySwiper.qtypename = qtypename;
                    $('#ques_type_name').html(qtypename[0]);

                    //加载答题卡
                    questionTable.loadTableCard(datas);
                }
            });
        };

        //显示当前试题答案
        this.showActiovAnswerFun = function(){
            var parentobj = $('.swiper-slide').eq(mySwiper.activeIndex);
            var active_ques_answer = parentobj.find('.question_answer');
            if(!active_ques_answer.hasClass('hide')){
                return;
            }

            active_ques_answer.slideDown(function(){
                var swiper_height = $('.swiper-slide').eq(mySwiper.activeIndex).height();
                $('.swiper-wrapper').css('height',swiper_height);

            }).removeClass('hide');

            var ques_type = parentobj.data('qtype');
            if(ques_type == 4 || ques_type == 5 || ques_type == 6){
                active_ques_answer.find('.show_descript').html('主观题');
            }

            var answer_bj = active_ques_answer.find('.show_descript').data('bj')
            if(ques_type == 2 && answer_bj){
                parentobj.find('.question_option').data('had',true);
                if(answer_bj == 1){
                    parentobj.find('.bg_selected').addClass('bg_danger');
                }else if(answer_bj == 2){
                    parentobj.find('.bg_selected').addClass('bg_success');
                }
            }

            publicFun.backgroundClick($(this));
        };

        //显示答题卡
        this.tableShowFun = function(){
            questionTable.nowQuesStateFun();
            that.question_table.css({'top':0});
            publicFun.backgroundClick($(this));

            that.moreCheckQuesFun(1);

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
            var answer   = isparent.next('.question_answer').find('.my_answer_content');
            var answer_bj = isparent.next('.question_answer').find('.show_descript');

            if(isparent.data('had')){
                return;
            }

            var istype = isparent.data('qtype');
            var isanswer = isparent.next('.question_answer').find('.answer_content').html();

            if(istype == 1 || istype == 3){

                isparent.find('input').removeAttr('checked');
                $(is).find('input').attr('checked','checked');

                var ismyanswer = $(is).find('input').val();
                answer.html(ismyanswer);

                if(ismyanswer == isanswer){
                    $(is).addClass('bg_success');
                    answer_bj.html('回答正确');
                    that.showActiovAnswerFun();

                    $('#card_'+id).addClass('bg_success');
                }else{
                    $(is).addClass('bg_danger');
                    answer_bj.html('回答错误');
                    that.showActiovAnswerFun();
                    $('#card_'+id).addClass('bg_danger');
                }

                var checkedbox= [];
                isparent.find('input').each(function(el,index){
                    if($(this).attr('checked')){
                        checkedbox.push($(this).val());
                    }
                });

                isparent.data('had',true);

            }else if(istype == 2){


                if($(is).hasClass('bg_selected')){
                    $(is).removeClass('bg_selected').addClass('bg_default');
                    $(is).find('input').removeAttr('checked');

                }else{
                    $(is).addClass('bg_selected').removeClass('bg_default');
                    $(is).find('input').attr('checked','checked');

                }

                var checkedbox= [];
                isparent.find('input').each(function(el,index){
                    if($(this).attr('checked')){
                        checkedbox.push($(this).val());
                    }
                });
                checkedbox = checkedbox.join("");

                if(checkedbox){
                    answer.html(checkedbox);
                    if(checkedbox == isanswer){
                        answer_bj.html('回答正确').data('bj',2);
                        $('#card_'+id).addClass('bg_success').removeClass('bg_danger');
                    }else{
                        answer_bj.html('回答错误').data('bj',1);
                        $('#card_'+id).addClass('bg_danger').removeClass('bg_success');
                    }
                }else{
                    answer.html('无');
                    answer_bj.html('暂无回答').data('bj',0);
                    $('#card_'+id).removeClass('bg_danger bg_success');
                }
            }


            // console.log(istype)
        };
        //判断多选题是否正确
        this.moreCheckQuesFun = function(index){

            if(index == 1){
                index = mySwiper.activeIndex;
            }else if(index == 2){
                index = mySwiper.previousIndex;
            }
            var parentobj = $('.swiper-slide').eq(mySwiper.activeIndex);
            var ques_type = parentobj.data('qtype');
            var answer_bj = parentobj.find('.show_descript').data('bj')
            if(ques_type == 2 && answer_bj){
                parentobj.find('.question_option').data('had',true);
                that.showActiovAnswerFun();

                if(answer_bj == 1){
                    parentobj.find('.bg_selected').addClass('bg_danger');
                }else if(answer_bj == 2){
                    parentobj.find('.bg_selected').addClass('bg_success');
                }
            }
        };

        //填空题
        fillUp = function(is,id){
            var parentobj = $(is).closest('.question_option');
            var answer_box   = parentobj.next('.question_answer').find('.my_answer_content');

            var isanswer = [];
            parentobj.find('input').each(function(el,index){
                var istext = $(this).val();
                if($.trim(istext)){
                    isanswer.push('【'+$.trim(istext)+'】');
                }
            });
            isanswer = isanswer.join(",");
            if(isanswer){
                $('#card_'+id).addClass('bg_default');
                answer_box.html(isanswer);
            }else{
                $('#card_'+id).removeClass('bg_default');
                answer_box.html('无');
            }
        };

        //简答题
        shortAnswer = function(is,id){
            var parentobj = $(is).closest('.question_option');
            var answer_box   = parentobj.next('.question_answer').find('.my_answer_content');

            var isanswer = parentobj.find('textarea').val();
            if($.trim(isanswer)){
                $('#card_'+id).addClass('bg_default');
                answer_box.html('见答题框');
            }else{
                $('#card_'+id).removeClass('bg_default');
                answer_box.html('无');
            }
        };

        this.init = function(){
            // publicFun.bgClick();
            this.loadQuesDataFun();

            //显示当前试题答案
            this.page_answer.off('click').on('click',this.showActiovAnswerFun);
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

                cards.push('<span id="card_'+datas[i].id+'" class="card">'+(i+1)+'</span>');
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

            datas += 't_timecost='+duration;

            $.ajax({
                url: urlpath + '/user/practice/submit.jhtml',
                type: "post",
                data: datas,
                success: function (t) {
                    // console.log(t);
                    var success = t.success;
                    if (success) {
                        window.location.href = "knowledgeList.html";
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
    };

    var questionTable = new questionTableFun;
    questionTable.init();

    //记录时间
    var countTimeFun = function(){
        var that = this;
        this.times = 0;
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

            that.times++;
        };

        this.timer = setInterval(that.loadTime,1000);

        this.init = function(){

        }
    };
    var countTime = new countTimeFun;
    // countTime.init();

    publicFunPreventMove('mycontainer');

});