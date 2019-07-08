$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var knowledgePractice = function(){
        var that = this;

        this.konw_container  = $('.konw_container');           //列表容器
        this.knowledge_model = $('#knowledge_model').html();  //列表模板

        this.confirm_model = $('#confirm_model').html();       //弹出框模板

        //加载试题数据
        this.loadKnowledgeDataFun = function(){
            $.ajax({
                url: urlpath + '/user/practice/practice.jhtml',
                type: "GET",
                data: {
                    ptype: 1
                },
                success:function(t){
                    //console.log(t)
                    if(!t.success){
                        that.konw_container.html('连接失败');
                        return;
                    }
                    if(!t.data || t.data <= 0) {
                        that.konw_container.html('暂无数据');
                        return;
                    }

                    var datas = t.data;

                    var domString = ' ';
                    var children = [];
                    for (var i = 0; i < datas.length; i++) {
                        if(datas[i].pid == '0d63fd54b0de4e41895b1088ed7a9732'){
                            var dictionary = datas[i];

                            dictionary.children = '';
                            dictionary.font = 'yuanquan';
                            if(dictionary.isleaf){
                                dictionary.font = 'zhankai';
                                var arr = that.getChildrenFun(datas,dictionary.id,dictionary.unum,dictionary.qnum);
                                dictionary.children = arr.domString;
                                dictionary.unum = arr.unum;
                                dictionary.qnum = arr.qnum;
                            }

                            domString += publicFun.comPile(that.knowledge_model,dictionary);

                        }

                    }

                    that.konw_container.html(domString);
                }
            });
        };

        //循环子集
        this.getChildrenFun = function(json,pid,unum,qnum){
            if(!json) return;

            var datas = json;
            var domString = ' ';
            for (var i = 0; i < datas.length; i++) {
                if(datas[i].pid == pid){
                    var dictionary = datas[i];


                    dictionary.children = '';
                    dictionary.font = 'yuanquan'
                    if(dictionary.isleaf){
                        dictionary.font = 'zhedie';
                        var arr = that.getChildrenFun(datas,dictionary.id,dictionary.unum,dictionary.qnum);
                        dictionary.children = arr.domString;
                        dictionary.unum = arr.unum;
                        dictionary.qnum = arr.qnum;
                    }

                    unum = unum + dictionary.unum;
                    qnum = qnum + dictionary.qnum;

                    domString += publicFun.comPile(that.knowledge_model,dictionary);

                }

            }

            var isjson = {'unum':unum,'qnum':qnum,'domString':domString};
            return isjson;
        };

        //折叠知识点
        toggerFun = function(is){

            publicFun.backgroundClick($(is),'transparent','#ddd');

            var isobj = $(is).next('ol');
            if($(is).find('.know_name i').hasClass('icon-yuanquan')) return;
            if(isobj.css('display') == 'none'){
                isobj.slideDown();
                $(is).find('.know_name i').addClass('icon-zhedie').removeClass('icon-zhankai');
            }else{
                isobj.slideUp();
                $(is).find('.know_name i').addClass('icon-zhankai').removeClass('icon-zhedie');

            }
        };

        //开始测试
        goTestFun = function(event,is,id,unum,qnum,topicname){
            event.stopPropagation();
            event.preventDefault();

            if(!publicFun.validateUser()){
                publicFun.jumpLoginPage2();
                return;
            }

            if(qnum <= 0){
                publicFun.alertBox('该知识点下暂无试题','1');
                return;
            }

            var isobj = $(is).closest('li');
            var arrtopic = [];
            isobj.find('.know_btn').each(function(index, el) {
                arrtopic.push($(this).data('topic'));
            });
            arrtopic = arrtopic.join(",");


            var classbj = 'active';
            var reseturl = 'javascript:void(0);';
            if(unum>0){
                classbj = '';
                reseturl = 'knowledgePractice.html?topic='+arrtopic+'&topicname='+topicname+'&restart=true';
            }
            var url = 'knowledgePractice.html?topic='+arrtopic+'&topicname='+topicname;


            if($('.confirm_prictice').length>0){
                return;
            }
            var domString = ' ';
            var dictionary = {'classbj':classbj,'url':url,'reseturl':reseturl};
            domString = publicFun.comPile(that.confirm_model,dictionary);

            $('body').append(domString);
            $('.confirm_prictice').addClass('bounceInLeft');


        };

        //关闭提示框
        confirmQx = function(is){
            $('.confirm_prictice').removeClass('bounceInLeft').addClass('bounceOutLeft');
            setTimeout(function(){
                $(is).closest('.confirm_prictice').remove();
            },300)
        };

        this.init = function(){
            // publicFun.bgClick();
            this.loadKnowledgeDataFun();
        };
    };

    var knowledgepractice = new knowledgePractice;
    knowledgepractice.init();

});