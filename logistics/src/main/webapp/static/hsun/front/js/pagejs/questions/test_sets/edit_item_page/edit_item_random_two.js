$(function () {
    var autoModel = function () {


        var that = this;
        var types = $('#types').html();		//科目模板
        var easy = $('#easy').html();		//添加试卷难度模板
        var items = $('#items').html();		//添加科目模板
        var topic = $('#topic').html();      //添加知识点模板
        var item_topics= $('#item_topic').html(); //添加树级知识点模板
        var duty = $('#duty').html();      //添加岗位模板
        var qtcontainer = $('#qtcontainer').html();//试题种类模板
        var putQuestion = $('#putQuestion').html(); //获取题量和题型模板
        this.seltypes = $('#sel_types');          //获取左侧盒子
        this.coner = $('#coner');

        this.smartemptytip = $('.smart-empty-tip'); //未设置科目题型
        this.selstyle = $('.sel_style');  //选择的科目盒子

        this.easys = $('#easys');      //试卷难度
        this.topics = $('#topics');    //知识点容器
        this.dutys = $('#dutys');      //岗位容器
        this.qtypecont = $('#qtype_cont'); //试题种类容器


        this.quetype = $('#queType');    //题型所插入的容器
        this.remove = $('#remove');     //清空科目
        this.frtitlenum = $('#fr_title_num'); //添加的科目总数

        //清空科目
        this.empty = function () {
            that.selstyle.find('.section-items').remove();
            if($('.toggel_name').html() == '科目'){
                $('.sel_types').find('b.title_checkbox2').removeClass('title_checkbox2').addClass('title_checkbox1');
                that.countTypes();
            }else if($('.toggel_name').html() == '知识点'){
                $('.one_section').find('b.title_checkbox2').removeClass('title_checkbox2').addClass('title_checkbox1');
                that.topicName();
            }
            that.titleNum();
        };

        //科目数目
        this.titleNum = function () {
            that.frtitlenum.html(that.selstyle.find('.section-items').length);
            if(that.selstyle.find('.section-items').length == 0){
                $('.smart-empty-tip').show();
            }else{
                $('.smart-empty-tip').hide();
            }
        };

        //引入科目
        this.onloadKnowlge = function () {
            $.ajax({
                url: urlpath_a + '/sys/dict/listData.jhtml',
                type: "GET",
                async: false,
                dataType: "json",
                data: {
                    type: 'dic_exam_questionsubject' //知识点
                },
                success: function (ret) {
                    var domString = ''; //承载接受的数据
                    for (var j in ret.data) {
                        var dictionary = ret.data[j]; // 获取数据
                        // 字典修正，构造一个字段
                        // dictionary.imgurl = imgurl;
                        domString += that.comPile(types, dictionary); //数据绑定
                    }
                    // console.log(domString);
                    that.seltypes.html(domString);

                    that.gettypes =  $('.one_title b');  //知识点
                    that.gettypes.off('click').on('click', that.getTypes); //添加知识点

                    // that.Topics();
                    that.Easy();
                }

            });
        };

        //知识点选择
        this.Topics = function () {
            $.ajax({
                url: urlpath_a + '/sys/dict/listData.jhtml',
                type: "GET",
                async: false,
                dataType: "json",
                data: {
                    type: 'dic_exam_questiontopic'					//知识点
                },
                success: function (ret) {
                    // console.log(ret);
                    var doms = '';                                   //承载接受的数据
                    for (var j in ret.data) {
                        var dictionary = ret.data[j];              // 获取数据
                        // 字典修正，构造一个字段
                        if(j>5){
                            dictionary.disno = 'disno';
                        }else{
                            dictionary.disno = '';
                        }
                        doms += that.comPile(topic, dictionary); //数据绑定
                    }

                    that.topics.html(doms);

                    if(ret.data.length>5){
                        var uo_down_btn = '<span class="up_down"><b class="fa fa-angle-double-down"></b>展开</span>';
                        that.topics.append(uo_down_btn);
                        that.updown  = $('.up_down');                             //获取知识点内容展开按钮
                        that.updown.off('click').on('click', that.typeUpdown);    //展开隐藏的知识点
                    }

                    that.checkboxtopic = $('.checkboxtopic');                //知识点条件
                    that.checkboxtopic.off('click').on('click', that.checkBoxTopic); //选择知识点

                    that.Easy();

                }
            });
        };

        //展开隐藏知识点
        this.typeUpdown = function(){
            if($('.disno').eq(0).css('display') == 'none'){
                $(this).parent('div').find('.disno').show();
                $(this).html('<span class="up_down"><b class="fa fa-angle-double-up"></b>收起</span>');
            }else{
                $(this).parent('div').find('.disno').hide();
                $(this).html('<span class="up_down"><b class="fa fa-angle-double-down"></b>展开</span>');

            }
            console.log($('.disno').eq(0).css('display'));
        };

        //试卷难度
        this.Easy = function () {
            $.ajax({
                url: urlpath_a + '/sys/dict/listData.jhtml',
                type: "GET",
                async: false,
                dataType: "json",
                // jsonp: "callback",
                // jsonpCallback: "successCallback",
                data: {
                    type: 'dic_exam_questionlevel'//难度
                },
                success: function (ret) {
                    // console.log(ret);
                    var dom = ''; //承载接受的数据
                    for (var j in ret.data) {
                        var dictionary = ret.data[j]; // 获取数据
                        dom += that.comPile(easy, dictionary); //数据绑定
                    }
                    that.easys.append(dom);
                    that.radiobox = $('.radiobox');   // 难度条件
                    that.radiobox.off('click').on('click', that.radioBox); //选择难度

                    that.Duty();
                }
            });
        };

        //岗位选择
        this.Duty = function () {
            $.ajax({
                url: urlpath_a + '/sys/dict/listData.jhtml',
                type: "GET",
                async: false,
                dataType: "json",
                // jsonp: "callback",
                // jsonpCallback: "successCallback",
                data: {
                    type: 'dic_exam_questionpost'					//岗位
                },
                success: function (ret) {
                    // console.log(ret);
                    var doms = '';                                   //承载接受的数据
                    for (var j in ret.data) {
                        var dictionary = ret.data[j];              // 获取数据
                        doms += that.comPile(duty, dictionary); //数据绑定
                    }
                    that.dutys.html(doms);
                    that.checkbox = $('.checkboxduty');                //岗位条件
                    that.checkbox.off('click').on('click', that.checkBox); //选择岗位

                    that.questionStyle();

                }
            });
        };

        //试题种类
        this.questionStyle = function () {
            $.ajax({
                url: urlpath_a + '/sys/dict/listData.jhtml',
                type: "GET",
                async: false,
                dataType: "json",
                // jsonp: "callback",
                // jsonpCallback: "successCallback",
                data: {
                    type: 'dic_exam_questiontype'					       //题型
                },
                success: function (ret) {
                    // console.log(ret);
                    var dommon = '';                                            //承载接受的数据
                    for (var j in ret.data) {
                        var dictionary = ret.data[j];                        // 获取数据
                        dommon += that.comPile(qtcontainer, dictionary);   //数据绑定
                    }
                    that.qtypecont.html(dommon);
                    that.putqus = $('.put_qus');                          //获取题型
                    that.putqus.off('click').on('click', that.putQus);     //选择题量和题型
                    that.examplePutQus();                                    //模拟点击

                }
            });
        };


        //选择科目
        this.getTypes = function () {
            if ($(this).hasClass('title_checkbox2')) {
                var this_type = $(this).attr('data-type');
                // var this_code = $(this).attr('data-code');
                $(this).removeClass('title_checkbox2').addClass('title_checkbox1');
                $('.q' + this_type).remove();

            } else {
                $(this).removeClass('title_checkbox1').addClass('title_checkbox2');
                var this_html = $(this).parent('.one_title').find('em').html();           //知识名称
                var this_type = $(this).attr('data-type'); //类型id
                var this_code = $(this).attr('data-code'); //类型编号
                var domString;
                var lists = [{name: this_html, num: this_code,qid:this_type}];

                for (var i in lists) {
                    var dictionary = lists[i];
                    domString = that.comPile(items, dictionary);
                }

                that.selstyle.append(domString);
            }
            that.titleNum();
            that.countTypes();
        };

        //删除科目
        iconaCha2 = function (e, k) {
            $(e).parents('.section-items').remove();
            $('#'+k).children('.one_title').find('b').removeClass('title_checkbox2').addClass('title_checkbox1');

            if($('.toggel_name').html() == '科目'){
                that.countTypes();
            }else if($('.toggel_name').html() == '知识点'){
                that.topicName();
            }
            that.titleNum();
        };
        // --------------------------------------------------------------------------------------------------------------------

        //统计科目
        var knowledge_num = "";
        this.countTypes = function () {
            knowledge_num = "";
            var knowledge_style = that.selstyle.find('[name = p_subjects]');
            for (var i = 0; i < knowledge_style.length; i++) {
                knowledge_num = knowledge_num + knowledge_style.eq(i).prop('value') + ",";
            }
            if (knowledge_num.length > 0) {
                knowledge_num = knowledge_num.substring(0, knowledge_num.length - 1);
            }
            // console.log(knowledge_num);
            that.questions();
        };

        //统计试卷难度
        var p_levels = '';
        this.contLevels = function () {
            var question_levels = that.easys.find('[name = p_levels]');
            for (var i = 0; i < question_levels.length; i++) {
                if (question_levels.eq(i).prop('checked')) {
                    p_levels = question_levels.eq(i).attr('value');
                }
            }
            // if(p_levels == '')
            //     p_levels = '';
            // console.log(p_levels);
            that.questions();
        };

        //统计知识点
        var topic_name = "";
        this.topicName = function () {
            topic_name = "";
            // var topic_names = that.topics.find('[name = p_topics]');
            var topic_names = $('.sel_style').find('[name = p_topics]');
            for (var i = 0; i < topic_names.length; i++) {
                // if (topic_names.eq(i).prop('checked')) {
                    topic_name = topic_name + topic_names.eq(i).attr('value')+",";
                // }
            }
            if (topic_name.length > 0) {
                topic_name = topic_name.substring(0, topic_name.length - 1);
            }
            // console.log(topic_name);
            that.questions();
        };

        //统计岗位
        var post_name = "";
        this.postName = function () {
            post_name = "";
            var post_names = that.dutys.find('[name = p_posts]');
            for (var i = 0; i < post_names.length; i++) {
                if (post_names.eq(i).prop('checked')) {
                    post_name = post_name + post_names.eq(i).attr('value')+",";
                }
            }
            if (post_name.length > 0) {
                post_name = post_name.substring(0, post_name.length - 1);
            }
            // console.log(post_name);
            that.questions();
        };

        //统计题型
        this.questions = function () {
            var types;
           if($('.t-item').length > 0) {
               for(var n = 0; n < $('.t-item').length ; n++){
                    type =$('.t-item').eq(n).attr('data-type');
                    that.countNumber(type);
               }
           }

        };
        //统计试题数量
        this.countNumber = function (stype) {
            $.ajax({
                url: urlpath_a + '/exam/question/countQuestionNums.jhtml',
                type: "GET",
                data: {
                    'qType': stype ,      //题型
                    'subject': knowledge_num || '',    //科目
                    'topic':topic_name || '',       //知识点
                    'post': post_name || '',        //岗位
                    'qLevel': p_levels || ''    //难易
                },
                success: function (t) {
                    // console.log(t);
                    if (t.success) {
                        var num = t.data[0];
                        if (num) {
                            // console.log(t.data[0]);
                            $('#i' + stype).html(num.qnum);
                        }else{
                            // console.log('#i' + stype);
                            $('#i' + stype).html('0');
                        }

                    }
                }
            });
        };
        // -----------------------------------------------------------------------------------------------------------------------

        //选择难度
        this.radioBox = function () {

            that.radiobox.removeClass('checked');
            $(this).addClass('checked');
            $(this).find('input').prop('checked', 'true');

            that.contLevels();
        };

        //选择知识点
        this.checkBoxTopic = function () {
            // that.checkbox.removeClass('checked');
            if ($(this).hasClass('checked')) {
                $(this).removeClass('checked');
                $(this).find('input').prop('checked', '');
            } else {
                $(this).addClass('checked');
                $(this).find('input').prop('checked', 'checked');
            }
            that.topicName();
        };

        //选择岗位
        this.checkBox = function () {
            // that.checkbox.removeClass('checked');
            if ($(this).hasClass('checked')) {
                $(this).removeClass('checked');
                $(this).find('input').prop('checked', '');
            } else {
                $(this).addClass('checked');
                $(this).find('input').prop('checked', 'checked');
            }
            that.postName();
        };

        //选择题量和题型
        this.putQus = function () {

            if ($(this).hasClass('active')) {
                var this_html = $(this).html();
                var this_number = $(this).attr('data-type');
                var this_name = $(this).attr('data-name');
                var iarr = [{qtyname: this_html, number: this_number, label: this_name}];
                var domString;
                $(this).removeClass('active');

                for (var i in iarr) {
                    var dictionary = iarr[i];
                    domString = that.comPile(putQuestion, dictionary);
                }
                that.quetype.append(domString);
                $('.scores').inputmask('9{1,6}',{placeholder:"", clearMaskOnLostFocus: false });
                $('.qnums').inputmask('9{1,6}',{placeholder:"", clearMaskOnLostFocus: false });
                that.remarkclass = $('.remark_class');
                that.scores = $('.scores');
                that.qnums = $('.qnums');

                // console.log(this_number);
                that.countNumber(this_number);

            }
        };


        //模拟三种题量和题型的选择
        this.examplePutQus = function () {
            that.putqus.eq(0).trigger('click');
            that.putqus.eq(1).trigger('click');
            that.putqus.eq(2).trigger('click');
        };


        //删除题量和题型
        queDelet = function (e, i) {
            $(e).parents('.t-item').remove();
            $('.p' + i).addClass('active');
        };

        //数据正则匹配方法
        this.comPile = function (templateString, dictionary) {
            return templateString.replace(/\{{([A-Za-z]+)\}}/g, function (match, $1, index, string) {
                return dictionary[$1];
            });
        };


        //试题标记
        var quesNums = true;
        var quesScore = true;
        scoresBlur = function (y,nums) {
            var score_val = $('#s_' + y).attr('value');
            var pnum_val = $('#p_' + y).attr('value');
            $('#remark_' + y).attr('value', '每题' + score_val + '分，共' + pnum_val + '题。');
            var rets = /^(\d)*$/;
            if(nums && nums == 'p_qnums'){
                if(pnum_val - 50 > 0 || pnum_val<=0){
                    quesNums = false;
                    // $('#p_' + y).attr('value','1');
                    layer.tips('输入1-50的数字','#p_' + y, {
                        tips: [1, '#3595CC'],
                        time: 2000
                    });
                }else{
                    quesNums = true;
                }
            }

        };
        qnumBlur = function (y,nums) {
            var score_val = $('#s_' + y).attr('value');
            var pnum_val = $('#p_' + y).attr('value');
            $('#remark_' + y).attr('value', '每题' + score_val + '分，共' + pnum_val + '题。');
            var rets = /^(\d)*$/;
            if(nums && nums == 'p_qnums'){
                if(score_val - 50 > 0 || score_val<=0){
                    quesScore = false;
                    // $('#s_' + y).attr('value','2');
                    layer.tips('输入1-50的数字','#s_' + y, {
                        tips: [1, '#3595CC'],
                        time: 2000
                    });
                }else{
                    quesScore = true;
                }
            }

        };

        //获取url参数 传值url中的key
        var id;
        this.boId = function () {
            id = this.getQueryString('id');

        };

        this.getQueryString = function (key) {
            var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
            var result = window.location.search.substr(1).match(reg);
            return result ? decodeURIComponent(result[2]) : null;
        };

        //引入试题信息
        this.infors = function () {
            $.ajax({
                url: urlpath_a + '/exam/paper/view.jhtml',
                type: "GET",
                async: false,
                dataType: "json",
                // jsonp: "callback",
                // jsonpCallback: "successCallback",
                data: {
                    id: id //试卷ID
                },
                success: function (t) {

                    var success = t.success;

                    if (success) {
                        var datas = t.data;
                        $("#hidID").val(datas.id);
                        $("#hidName").val(datas.name);
                        $("#divName").html(datas.name);
                        $("#txtDuration").val(datas.duration);
                        $("#txtTotalScore").val(datas.totalscore);
                        $("#txtPassScore").val(datas.passscore);
                        $("#hidOrderType").val(datas.ordertype);
                        $("#hidPaperType").val(datas.papertype);

                        that.onloadKnowlge();
                    }
                }
            });
        };


        this.selForm = $("#select-form");
        this.formBtn = $('.set-btn');
        this.formBtns = function (e) {
            e.preventDefault();

            if(!quesNums||!quesScore){
                layer.open({
                    title: '系统提示',
                    closeBtn: 1,
                    skin: 'layui-layer-molv',
                    content: '<div style="text-align:center;font-sizze:13px;">题型或分数的设置不正确</div>',
                    yes: function (index, layero) {
                        layer.close(index);
                    }
                });
                return;
            }

            that.replayPaperInfor();
            var formSerialize = that.selForm.serialize();
            formSerialize = formSerialize + "&iscomplete=0";
            // console.log(formSerialize);
            // return;
            $.ajax({
                url: urlpath_a + '/exam/paper/detail.jhtml',
                type: "POST",
                data: formSerialize,
                dataType: "json",
                // jsonp: "callback",
                // jsonpCallback: "successCallback",
                success: function (t) {
                    console.log(t);

                    var success = t.success;
                    var msg = t.msg;
                    if (success) {
                        var datas = t.data;

                        layer.open({
                            title: '系统提示',
                            closeBtn: 0,
                            skin: 'layui-layer-molv',
                            content: '<div style="text-align:center;">' + t.msg + '</div>',
                            yes: function (index, layero) {
                                layer.close(index);
                                window.location.href = "edit_item_page_next.html?pid=" + datas.id+timestampv;
                            }
                        });
                        // window.location.href = "Edit_item_two.html?id="+datas.id ;

                    } else {
                        layer.open({
                            title: '系统提示',
                            closeBtn: 0,
                            skin: 'layui-layer-molv',
                            content: '<div style="text-align:center;">' + t.msg + '</div>',
                            yes: function (index, layero) {
                                layer.close(index);
                            }
                        });
                    }
                }
            });
        };
        //从新提交题的数量和总分
        this.replayPaperInfor = function () {
            var totalscore = 0;
            for (var i = 0; i < that.scores.length; i++) {
                totalscore += parseInt(that.scores.eq(i).val() * that.qnums.eq(i).val());
            }
            $("#txtTotalScore").val(totalscore);
            $("#txtPassScore").val(parseInt(totalscore * 6 / 10));
        };

        // 新添树层知识点
        this.titleUp = function(){
            var next_ulcont = $(this).parent('.one_title ').next('ul');
            var this_tispan = $(this).parent('.one_title ').find('span');
            if(this_tispan.hasClass('title_radio1')){
                this_tispan.removeClass('title_radio1').addClass('title_radio2');
                next_ulcont.slideDown();
            }else{
                this_tispan.removeClass('title_radio2').addClass('title_radio1');
                next_ulcont.slideUp();
            }
        }

        this.oneSelectChapter = function(){
            var next_ulcont = $(this).parent('.one_title ').next('ul');
            var next_titlecont = next_ulcont.find('.one_title');

            var this_html = $(this).parent('.one_title').find('em').html();   //知识名称
            var this_type = $(this).attr('data-type'); //类型
            var this_code = $(this).attr('data-code'); //编号

            if($(this).hasClass('title_checkbox1')){
                $(this).removeClass('title_checkbox1').addClass('title_checkbox2');

                var lists = [];
                var domString = '';
                lists = [{name:this_html,num:this_code,qid:this_type}];
                // 选中下级所有菜单并添加
                $.each(next_titlecont,function(){
                    if($('.q'+$(this).find('b').data('code')).length<=0){
                        lists.push({'name':$(this).find('em').html(),'num':$(this).find('b').data('code'),'qid':$(this).find('b').data('type')});
                    }
                });

                for(var i in lists){
                    var dictionary = lists[i];
                    domString += that.comPile(item_topics,dictionary);
                }
                that.selstyle.append(domString);
                next_ulcont.find('.one_title b').removeClass('title_checkbox1').addClass('title_checkbox2');
            }else{
                // 取消本身，并取消添加
                $(this).removeClass('title_checkbox2').addClass('title_checkbox1');
                $('.q'+this_type).remove();
                // 取消选中下级所有菜单，并取消添加
                next_ulcont.find('.one_title b').removeClass('title_checkbox2').addClass('title_checkbox1');
                $.each(next_titlecont,function(){
                    var qx_this_type = $(this).find('b').data('type');
                    $('.q'+qx_this_type).remove();
                });
            }
            //更行统计的知识点个数
            that.titleNum();
            //更行统计的知识点题数
            that.topicName();
        }

        //检查所有兄弟是否都被选中
        this.allSibling = function(is){
            var this_li = $(is).parents('.two_section ').children('li');
            var this_li_bj = false;
            $.each(this_li,function(index){
                if($(this).children('div').find('b').hasClass('title_checkbox1')){
                    this_li_bj = true;
                    console.log($(this).index());
                }
            });
            return this_li_bj;
        }


        this.sendAjax = function(){
            var tree_one_data = [];
            var tree_two_data = [];
            var tree_red_data = [];
            var tree_three_data = [];

            var list_html = [];
            $.ajax({
                url:urlpath_a+'/sys/dict/treeData?type=dic_exam_questiontopic',
                type: "GET",
                success: function(ret){
                    // console.log(ret);
                    // 循环第一阶梯
                    for(var i=0;i<ret.length;i++){
                        if(ret[i].pId == '0d63fd54b0de4e41895b1088ed7a9732'){
                            tree_one_data.push(ret[i]);
                            list_html.push('<li id="'+ret[i].id+'">');
                            list_html.push(' <div class="one_title" data-type="'+ret[i].id+'">');
                            list_html.push('  <span class=" cuesor title_radio1"></span>');
                            list_html.push('  <b class="title_checkbox1 cuesor" data-code="'+ret[i].code+'" data-type="'+ret[i].id+'"></b>');
                            list_html.push('  <em class=" cuesor" title="'+ret[i].name+'">'+ret[i].name+'</em>');
                            list_html.push(' </div>');
                            list_html.push(' <ul class="two_section dash_line">');
                            list_html.push(' </ul>');
                            list_html.push('</li>');
                        }else{
                            tree_two_data.push(ret[i]);
                        }
                    }
                    // 将第一阶梯插入页面
                    $('.one_section').html(list_html.join(''));

                    // 循环第二阶梯
                    for(var i=0;i<tree_one_data.length; i++){
                        var is_id = tree_one_data[i].id;
                        for(var j=0; j<tree_two_data.length; j++){
                            if(tree_two_data[j].pId == is_id){
                                var list_twohtml = [];
                                list_twohtml.push('<li id="'+tree_two_data[j].id+'">');
                                list_twohtml.push(' <div class="one_title" data-type="'+tree_two_data[j].id+'">');
                                list_twohtml.push('  <span class=" cuesor title_radio1"></span>');
                                list_twohtml.push('  <b class="title_checkbox1 cuesor" data-code="'+tree_two_data[j].code+'" data-type="'+tree_two_data[j].id+'"></b>');
                                list_twohtml.push('  <em class=" cuesor" title="'+tree_two_data[j].name+'">'+tree_two_data[j].name+'</em>');
                                list_twohtml.push(' </div>');
                                list_twohtml.push(' <ul class="three_section dash_line">');
                                list_twohtml.push(' </ul>');
                                list_twohtml.push('</li>');

                                tree_red_data.push(tree_two_data[j]);
                                // 将第二阶梯插入页面
                                $('#'+is_id).children('.one_title').find('span').addClass('title_up');
                                $('#'+is_id).children('.one_title').find('em').addClass('title_up');
                                $('#'+is_id).find('.two_section').append(list_twohtml.join(''));
                            }
                        }
                    }

                    // 循环出第三级数据
                    for(var i=0; i<tree_two_data.length; i++){
                        var is_reduce = true;
                        for(var j=0; j < tree_red_data.length; j++){
                            if(tree_two_data[i] == tree_red_data[j])
                                is_reduce = false;
                        }
                        if(is_reduce)
                            tree_three_data.push(tree_two_data[i]);
                    }

                    // 循环第三阶梯
                    for(var j=0; j<tree_three_data.length; j++){
                        var is_pid = tree_three_data[j].pId;
                        if($('#'+is_pid).length>0){
                            var list_twohtml = [];
                            list_twohtml.push('<li id="'+tree_three_data[j].id+'">');
                            list_twohtml.push(' <div class="one_title" data-type="'+tree_three_data[j].id+'">');
                            list_twohtml.push('  <span class=""></span>');
                            list_twohtml.push('  <b class="title_checkbox1 cuesor" data-code="'+tree_three_data[j].code+'" data-type="'+tree_three_data[j].id+'"></b>');
                            list_twohtml.push('  <em class=" cuesor" title="'+tree_three_data[j].name+'">'+tree_three_data[j].name+'</em>');
                            list_twohtml.push(' </div>');
                            list_twohtml.push('</li>');
                            // 将第三阶梯插入页面
                            $('#'+is_pid).children('.one_title').find('span').addClass('title_up');
                            $('#'+is_pid).children('.one_title').find('em').addClass('title_up');
                            $('#'+is_pid).find('.three_section').append(list_twohtml.join(''));
                        }

                    }

                    // 按章节筛选
                    that.title_up  = $('.title_up'); //折叠展开下级菜单按钮
                    that.one_title_add = $('.one_section>li>div b'); //选取第一章节点按钮
                    that.two_title_add = $('.two_section>li>div b'); //选取第一章节点按钮
                    that.three_title_add = $('.three_section>li>div b'); //选取第一章节点按钮


                    // 添加章节
                    that.title_up.off('click').on('click',that.titleUp);   //展开下级菜单
                    that.one_title_add.off('click').on('click',that.oneSelectChapter);   //选中第一节章节
                    that.two_title_add.off('click').on('click',that.oneSelectChapter);   //选中第二节章节
                    that.three_title_add.off('click').on('click',that.oneSelectChapter);   //选中第三节章节
                }

            });
        };

        //切换知识点和科目
        this.select_style_cont = $('.select_style_cont p');
        this.localtopic = $('#localtopic');
        this.localkno = $('#localkno');
        this.toggleType = function(){
            if($(this).html() == '选择'+$('.toggel_name').html()){
                return;
            }
            var local_html = that.selstyle.html();
            that.selstyle.html('');
            if($(this).html() == '选择科目'){
                that.localkno.html(local_html);
                $('.one_section').hide();
                $('.sel_types').show();
                that.selstyle.html(that.localtopic.html());
                $('.toggel_name').html('科目');
            }else if($(this).html() == '选择知识点'){
                that.localtopic.html(local_html);
                $('.sel_types').hide();
                $('.one_section').show();
                that.selstyle.html(that.localkno.html());
                $('.toggel_name').html('知识点');
            }
            $('.sel_title').children('i').html($(this).html());
            that.titleNum();
            that.countTypes();
            that.topicName();
        }

        this.init = function () {
            // this.Easy();
            this.boId();
            this.infors();
            this.formBtn.off('click').on('click', this.formBtns);
            this.remove.off('click').on('click', this.empty);
            $("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);

            this.select_style_cont.off('click').on('click',this.toggleType);
            this.sendAjax();
            $(".one_section").slimScroll({
                color:'#E4E4E4'
            });
        }
    }

    var automodel = new autoModel();
    automodel.init();
});