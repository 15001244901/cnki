$(function(){
    //优化click事件
    FastClick.attach(document.body);

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

        this.daily_pra_body = $('.daily_pra_body'); //试题容器

        this.dansel_btn = $('.question_option_item label');  //单选按钮


        this.question_table_show = $('.show_table');    //显示答题卡
        this.question_table  = $('.question_table');    //答题卡容器


        var eid = publicFun.getQueryString("id");
        var pid = publicFun.getQueryString("pid");

        //加载试题数据
        this.loadQuesDataFun = function(){
            publicFun.loading($('body'));
            $.ajax({
                url: urlpath + '/user/paper/history_detail.jhtml',
                type: "GET",
                // async: false,
                data: {
                    id: eid,
                    pid: pid
                },
                success:function(t){
                    console.log(t);
                    if(t.success){

                        if(!t.paper.sections){
                            publicFun.noData(that.daily_pra_body);
                            $('.loading').remove();
                            return;
                        }
                        var datas = t.paper.sections;

                        if(datas && datas.length>0){

                            var inum = 0;
                            var ques_arr = [];
                            for (var i = 0; i < datas.length; i++) {

                                var number = publicFun.changeBigNumber(i);
                                ques_arr.push('<div class="ques_type_title"><span>'+number+'、</span>'+(datas[i].name || t.detail.name)+'</div>');


                                var items =  datas[i].questions;
                                for (var j =0; j < items.length ; j++) {
                                    var dictionary = items[j];
                                    inum++;
                                    dictionary.num = inum+'、';

                                    dictionary.qcontent = publicFun.delDiv(dictionary.qcontent);
                                    dictionary.qcontent = publicFun.delStyle(dictionary.qcontent);

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

                                    // 判断难度
                                    if(dictionary.qlevel == '1'){
                                        dictionary.qlevel = '★☆☆☆☆';
                                    }else if(dictionary.qlevel == '2'){
                                        dictionary.qlevel = '★★★☆☆';
                                    }else if(dictionary.qlevel == '3'){
                                        dictionary.qlevel = '★★★★★';
                                    }

                                    // 判断答案
                                    var iskey = 'Q-'+ dictionary.id;
                                    var answered = (t.data[iskey] || '未作答');

                                    if(dictionary.qtype == '1' || dictionary.qtype == '2' || dictionary.qtype == '3'){
                                        if(dictionary.qtype == '2'){
                                            answered = answered.replace(/\`/g,"");
                                        }

                                        if(answered == dictionary.qkey){
                                            dictionary.bj = '回答正确';
                                            dictionary.bjclass = 'bg_success';
                                        }else if(answered == '未作答'){
                                            dictionary.bj = '未作答';
                                            dictionary.bjclass = 'bg_default';
                                        }else{
                                            dictionary.bj = '回答错误';
                                            dictionary.bjclass = 'bg_danger';
                                        }



                                    }else if(dictionary.qtype == '4'){
                                        answered = answered.split("`");
                                        var hade = false;
                                        for(var y=0;y<answered.length;y++){
                                            if(answered[y] && answered[y] != '未作答') {hade = true;}
                                            answered[y] = '【'+answered[y]+'】'
                                        }
                                        answered = answered.join('');

                                        if(!hade){
                                            dictionary.bj = '未作答';
                                            dictionary.bjclass = 'bg_default';
                                        }else{
                                            dictionary.bj = '主观题';
                                            dictionary.bjclass = 'bg_selected';
                                        }
                                    }else{
                                        if(answered == '未作答'){
                                            dictionary.bj = '未作答';
                                            dictionary.bjclass = 'bg_default';
                                        }else{
                                            dictionary.bj = '主观题';
                                            dictionary.bjclass = 'bg_selected';
                                        }
                                    }

                                    // 判断得分
                                    var hasscore =  (t.check[iskey] || 0);


                                    dictionary.thisscore = hasscore;
                                    dictionary.mykey = answered;
                                    dictionary.infor = publicFun.comPile(that.infor,dictionary);

                                    if(dictionary.qtype == '1' || dictionary.qtype == '2'){

                                        var option = ' ';
                                        for(var k=0; k<dictionary.options.length; k++){
                                            var op_items = dictionary.options[k];
                                            op_items.qid = dictionary.id;
                                            if(dictionary.qtype == '1' ){
                                                op_items.inptype = 'radio';
                                            }else if(dictionary.qtype == '2'){
                                                op_items.inptype = 'checkbox';
                                            }
                                            option += publicFun.comPile(that.option,op_items);
                                        }

                                        dictionary.options = option;
                                        ques_arr.push(publicFun.comPile(that.qtype1,dictionary));

                                    }else if(dictionary.qtype == '3'){

                                        ques_arr.push(publicFun.comPile(that.qtype3,dictionary));

                                    }else if(dictionary.qtype == '4'){

                                        var ishtml = publicFun.replaceInputLength(dictionary.qcontent);
                                        var islength = ishtml.count;

                                        dictionary.qcontent = ishtml.html;
                                        ques_arr.push(publicFun.comPile(that.qtype4,dictionary));

                                    }else if(dictionary.qtype == '5' || dictionary.qtype == '6'){
                                        ques_arr.push(publicFun.comPile(that.qtype5,dictionary));
                                    }

                                }


                            }
                            // console.log(datas);
                            that.daily_pra_body.html(ques_arr.join(""));
                            $('.loading').remove();
                            $('.exam_name').html(t.paper.name);
                            $('.exam_costtime').html(t.detail.timecost+'分钟');
                            $('.exam_totaltime').html(t.paper.duration+'分钟');
                            $('.exam_totalscore').html(t.paper.totalscore+'分');
                            $('.exam_score').html(t.detail.score+'分');
                            $('.exam_begintime').html(t.paper.starttime);
                            $('.exam_endtime').html(t.paper.endtime);

                        }



                    }else{
                        publicFun.alertBox(t.msg,1)
                    }


                    //加载答题卡
                    questionTable.loadTableCard(datas);


                }
            });
        };



        //更多信息
        moreInfor = function(is){
            var moreinfor = $(is).closest('.question_answer').find('.show_infor');
            publicFun.backgroundClick($(is));
            if(moreinfor.css('display') == 'none'){
                moreinfor.slideDown();
            }else{
                moreinfor.slideUp();
            }
        };

        //显示答题卡
        this.tableShowFun = function(){
            that.question_table.css({'top':0});
            publicFun.backgroundClick($(this));
        };


        this.init = function(){

            this.loadQuesDataFun();

            //显示答题卡
            this.question_table_show.off('click').on('click',this.tableShowFun);
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

        this.loadTableCard = function(obj){
            var datas = obj;
            var cards = [];
            var inum = 0;
            for (var i = 0; i < datas.length; i++) {
                var items = datas[i].questions;
                for (var j = 0; j<items.length; j++) {
                    inum++;
                    cards.push('<span data-id="'+items[j].id+'" id="" class="card '+items[j].bjclass+'">'+inum+'</span>');
                }
            }

            that.card_container.html(cards.join(''));

            that.card = $('.card');           //获取卡片属性
            that.card.off('click').on('click',this.cardFun);

            $('.show_table').show();
        };

        //点击答题卡
        this.cardFun = function(){
            var isid = $(this).data('id');

            location.hash = "#pos_"+isid;

            publicFun.backgroundClick($(this));
            that.tableHideFun();
        };

        //隐藏答题卡
        this.tableHideFun = function(){
            var isbottom = '100vh';
            that.question_table.css({'top':isbottom});
        };


        this.init = function(){
            this.ques_table_hide.off('click').on('click',this.tableHideFun);
        }
    };

    var questionTable = new questionTableFun;
    questionTable.init();

    publicFunPreventMove('mycontainer');

});