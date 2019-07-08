$(function(){
    //优化click事件
    FastClick.attach(document.body);
    // 做笔记
    var takeNotes = function(){
        var that = this;

        this.ques_type1 = $('#ques_type_1').html();  //试题模板1
        this.ques_type3 = $('#ques_type_3').html();  //试题模板3
        this.ques_type4 = $('#ques_type_4').html();  //试题模板4
        this.ques_type5 = $('#ques_type_5').html();  //试题模板5
        this.ques_container = $('.que_cont ul');     //试题容器

        this.error_container = $('.error_container');  //纠错容器
        this.ques_error = $('#ques_error').html();     //纠错模板

        this.take_notes_save = $('.take_notes_save');  //保存笔记按钮

        var queId = publicFun.getQueryString("id");   //在地址栏获取试题id
        var pageNo = 1;
        var totalPageCount;
        this.note_list_bj = false;          //滚动条开关
        this.node_list_data = [];           //承载离线数据

        this.nav_slide = $('.nav_slide a');           //做笔记和笔记列表导航
        this.notes_list_container = $('.notes_list_container');  //笔记列表容器
        this.note_list = $('#note_list').html();                        //笔记列表模板
        this.more = $('.more');                                  //加载更多按钮
        this.last = $('.last');                                  //加载到底提示

        //加载试题
        this.loadDataFun = function(){

            $.ajax({
                url: urlpath_a + '/exam/question/' + queId + '/view.jhtml',
                type: "GET",
                data: {
                    id: queId
                },
                success: function(t) {
                    //console.log(t);
                    var data = t.datax;
                    var datalist = t.data;

                    var domString = ' ';
                    var dictionary = data;

                    // 判断是否有解析
                    if(!dictionary.qresolve) dictionary.qresolve = '暂无';
                    // 判断是否有答案
                    if(!dictionary.qkey) dictionary.qkey = '暂无';

                    // 迭代题型模板
                    if(dictionary.qtype == 1 || dictionary.qtype == 2){
                        var options = [];
                        for (var j = 0; j<dictionary.options.length;j++) {
                            options.push('<p>'+dictionary.options[j].alisa+' 、 '+publicFun.delP(dictionary.options[j].text)+'</p>');
                        }
                        dictionary.sels = options.join("");
                        domString = publicFun.comPile(that.ques_type1,dictionary);
                    }else if(dictionary.qtype == 3 ){
                        domString = publicFun.comPile(that.ques_type3,dictionary);
                    }else if(dictionary.qtype == 4){
                        dictionary.qcontent = publicFun.replaceInput(dictionary.qcontent);
                        domString = publicFun.comPile(that.ques_type4,dictionary);
                    }else if(dictionary.qtype == 5 || dictionary.qtype == 6){
                        domString = publicFun.comPile(that.ques_type5,dictionary);
                    }
                    that.ques_container.html(domString);
                }

            });

        };

        //查看答案
        seeAnswer = function(is){
            $(is).parent('.question_btn').prev('.question_answer').toggle(300);
        };

        //保存笔记
        this.takeNotesSaveFun = function(){
            var pobj = $(this).closest('section');
            var iscont = pobj.find('textarea').val();
            var iscode = pobj.find('input').val();

            if(!$.trim(iscont)){
                publicFun.alertBox('内容不能为空','1');
                return;
            }

            $.ajax({
                url: urlpath_a + '/exam/question/commentsave.jhtml',
                type: "GET",
                data: {
                    ctype: 2,
                    qid: queId,
                    content: iscont,
                    validateCode: iscode,
                    ispublic: 1
                },
                success: function(t) {
                    var success = t.success;
                    if(t.success) {
                        publicFun.alertBox(t.msg);
                    } else {
                        publicFun.alertBox(t.msg,'1');
                    }
                }
            });
        };

        //试题纠错
        findError = function(is,id){
            if(!publicFun.validateUser()){
                publicFun.jumpLoginPage2();
                return;
            }

            var domString = '';
            var dictionary = {'id':id,'urlpath':urlpath};
            domString = publicFun.comPile(that.ques_error,dictionary);
            that.error_container.html(domString);
            that.error_container.css('left',0);
        };
        //隐藏纠错
        hideError = function(){
            that.error_container.css('left','100%');
            setTimeout(function(){
                that.error_container.html('');
            },100);
        };
        //提交纠错
        saveError = function(is,id){
            var pobj = $(is).closest('section');
            var iscont = pobj.find('textarea').val();
            var iscode = pobj.find('input').val();

            if(!$.trim(iscont)){
                publicFun.alertBox('内容不能为空','1');
                return;
            }

            $.ajax({
                url: urlpath_a + '/exam/question/commentsave.jhtml',
                type: "POST",
                data: {
                    qid: id,
                    ctype: 3,
                    content: iscont,
                    validateCode: iscode
                },
                success: function(t) {
                    //console.log(t);
                    if(t.success) {
                        publicFun.alertBox(t.msg);
                        hideError();
                    } else {
                        publicFun.alertBox(t.msg,'1');
                    }
                }
            });
        };

        //切换做笔记和笔记列表
        this.navSlideFun = function(){
            var isindex = $(this).index();
            if(isindex == 1){
                swiper.slideNext();
            }else{
                swiper.slidePrev();
            }

            $(window).scrollTop('0');

        };
        //获取笔记列表接口
        this.getNotesListDataFun = function() {
            $.ajax({
                url: urlpath_a + '/exam/question/comment.jhtml',
                type: "GET",
                data: {
                    'pageNo': 1,
                    'pageSize': 10,
                    'qid': queId,
                    'ctype': 2
                },
                success: function(t) {
                    //console.log(t);
                    var success = t.success;

                    if(success) {
                        totalPageCount = t.data.totalPageCount;

                        if(t.data.totalPageCount > 0) {
                            var datas = t.data.list;
                            that.loadStorageDataFun(datas,'1');

                        } else {
                            publicFun.noData(that.notes_list_container);
                        }

                    }
                    that.more.hide();
                }
            });

        };
        //迭代笔记列表
        this.loadStorageDataFun = function(arr,bj){
            var domString = ' ';
            var datas = arr;
            for(var i=0;i<datas.length;i++){
                if(bj){
                    that.node_list_data.push(datas[i]);
                }

                var dictionary = datas[i];
                if(!dictionary.userphoto){
                    dictionary.userphoto = urlpath + '/static/images/userphoto.jpg';
                }
                domString += publicFun.comPile(that.note_list,dictionary);
            }

            that.notes_list_container.append(domString);
        };

        //获取更多数据
        this.getMoreDataFun = function(){
            if(totalPageCount <= 0 || !totalPageCount) {
                return;
            }
            that.last.hide();
            that.more.show();

            if(pageNo >= totalPageCount){
                that.more.hide();
                that.last.show();
                return;
            }
            pageNo ++;

            that.getNotesListDataFun();
        };

        $(window).scroll(function(){
            if(!that.note_list_bj){
                return;
            }
            var viewH =$(window).height();//可见高度
            var contentH =$(document).height();//内容高度
            var scrollTop =$(window).scrollTop();//滚动高度
            var plusHeight = contentH - viewH - scrollTop;

            if(plusHeight <= 100){
                that.getMoreDataFun();
            }
        });

        this.init = function(){

            this.loadDataFun();           //加载试题
            this.getNotesListDataFun();   //加载笔记记录

            this.take_notes_save.off('click').on('click',this.takeNotesSaveFun);
            this.nav_slide.off('click').on('click',this.navSlideFun);
        }
    };

    var takenotes = new takeNotes;
    takenotes.init();


    //swiper切换
    var swiper = new Swiper('.swiper-container',{
        roundLengths : true,
        //autoHeight: true, //高度随内容变化
        onSlideChangeStart: function(swiper){
            $(window).scrollTop('0');
            $('.nav_slide a').removeClass('active');
            $('.nav_slide a').eq(swiper.activeIndex).addClass('active');
            switch (swiper.activeIndex) {
                case  0:
                    takenotes.note_list_bj = false;
                    $('.note_form section').show();
                    setTimeout(function(){
                        $('.notes_list section').hide();
                    },500);
                    break;
                case  1:
                    $('.notes_list section').show();
                    setTimeout(function(){
                        $('.note_form section').hide();
                    },500);
                    takenotes.note_list_bj = true;
                    takenotes.notes_list_container.html('');
                    // takenotes.loadStorageDataFun(takenotes.node_list_data);
                    takenotes.node_list_data = [];
                    takenotes.getNotesListDataFun();
                    break;
            }
        }
    });

    //输入框处理
    function init() {
        $(document).on('focus','.body_container textarea,.body_container .code', function () {
            $('.body_head').css('position','absolute');
            $('.nav_size ').hide();
            $('.nav_slide').css('position','static');

        });
        $(document).on('blur','.body_container textarea,.body_container .code', function () {
            $('.body_head').css('position','fixed');
            $('.nav_size ').show();
            $('.nav_slide ').css('position','fixed');
        });

        $(document).on('focus','.error_container textarea,.error_container .code', function () {
            $('.body_container').hide();
            $('.error_container').css('position','static');
        });
        $(document).on('blur','.error_container textarea,.error_container .code', function () {
            $('.error_container').css('position','fixed');
            $('.body_container').show();
        });
    }
    init();
})