$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var quesCenter = function(){
        var that = this;
        this.shade = $('.shade');                //阴影遮罩

        this.nav_sel = $('.que_select_item');   //筛选条件
        this.nav_sel_cont = $('.que_select_cont'); //筛选条件的选项容器

        this.ques_type1 = $('#ques_type_1').html();  //试题模板1
        this.ques_type3 = $('#ques_type_3').html();  //试题模板3
        this.ques_type4 = $('#ques_type_4').html();  //试题模板4
        this.ques_type5 = $('#ques_type_5').html();  //试题模板5
        this.ques_container = $('.que_cont ul');  //试题容器
        this.knowledge_container;                 //承载知识点数据容器
        this.page = $('.page');                   //分页样式容器


        this.error_container = $('.error_container');  //纠错容器
        this.ques_error = $('#ques_error').html();     //纠错模板

        // 分页属性
        this.page_btnl = $('.page_btnl');       //上一页
        this.page_btnnum = $('.page_btnnum');   //显示跳转页
        this.page_btnlr = $('.page_btnr');      //下一页
        this.page_num_btn = $('.page_num_btn'); //确定跳转
        this.page_num   = $('.page_num');       //跳转页容器

        this.gopage = $('.gopage');

        this.now_page_num = $('.now_page_num');     //当前页码
        this.total_page_num = $('.total_page_num'); //总页码

        //筛选方法
        this.navSelFun = function(event){
            event.stopPropagation();
            event.preventDefault();
            // that.nav_sel_cont.html('');
            if(!that.nav_sel_cont.hasClass('show')){
                that.nav_sel_cont.addClass('show');
            }
            that.shade.fadeIn();

            that.nav_sel.removeClass('active');
            $(this).addClass('active');

            if(!$(this).data('type')){
                if(that.knowledge_container){
                    that.nav_sel_cont.html(that.knowledge_container);
                }else{
                    that.loadKnowledgeFun();
                }
                return;
            }

            var istype = $(this).data('type');
            $.ajax({
                url: urlpath_a + '/sys/dict/listData.jhtml',
                type: "GET",
                async: false,
                data: {
                    'type': istype //题型
                },
                success: function(t) {
                    if(t.success){
                        var datas = t.data;
                        if(!t.data || t.data.length<=0){
                            return;
                        }

                        var qhtml = [];

                        var istype = $('.que_select_item.active').data('name');
                        var isval = $('#'+istype).val();
                        var bj2 = !isval ? 'active' : '';
                        qhtml.push('<span class="'+bj2+'" onclick="selOtherFun(this)">全部</span>');
                        for (var i = 0; i < datas.length ; i++) {
                            var bj = isval == datas[i].value ? 'active' : '';
                            qhtml.push('<span class="'+ bj+'" onclick="selOtherFun(this,'+datas[i].value+')">'+datas[i].label+'</span>');
                        }
                        that.nav_sel_cont.html(qhtml.join(""));
                    }
                }
            });
        };
        //选中筛选条件
        selOtherFun = function(is,val){
            var istype = $('.que_select_item.active');
            istype.find('span').html($(is).html());
            $(is).siblings().removeClass('active');
            $(is).addClass('active');

            $('#'+istype.data('name')).val(val);
            that.loadDataFun();
            that.hideShade();
        };

        //加载知识点
        this.loadKnowledgeFun = function(){
            that.knowledge_container = $('<ol class="knowledge_option"></ol>');
            $.ajax({
                url: urlpath_a+'/sys/dict/treeData.jhtml?type=dic_exam_questiontopic',
                type: "GET",
                async: false,
                success: function(t) {
                    console.log(t);
                    var datas = t;

                    for(var i = 0; i < datas.length; i++){
                        if(datas[i].pId == '0d63fd54b0de4e41895b1088ed7a9732'){
                            var onehtml = [];
                            var leaf = that.testChildrenFun(datas,datas[i].id);
                            onehtml.push('<li id="list_'+datas[i].id+'">');
                            onehtml.push(' <div class="knowledge_name" data-id="'+datas[i].code+'">');

                            if(leaf){
                                onehtml.push('  <i class="icon iconfont icon-clouseup" onclick="toggleChild(this,\''+datas[i].id+'\')"></i>');
                            }else{
                                onehtml.push('  <i class="icon iconfont icon-xuxian"></i>');
                            }

                            onehtml.push('  <em onclick="selKnowledgeFun(this,\''+datas[i].id+'\')">'+datas[i].name+'</em>');
                            onehtml.push(' </div>');

                            if(leaf){
                                onehtml.push('<ol class="pl42" id="c_'+datas[i].id+'">');
                                onehtml.push('</ol>');
                            }

                            onehtml.push('</li>');
                            that.knowledge_container.append(onehtml.join(""));
                            if(leaf){
                                that.addChildFun(datas,datas[i].id);
                            }
                        }

                    }

                    that.nav_sel_cont.html(that.knowledge_container);

                }
            });
        };
        //判断子集
        this.testChildrenFun = function(json,id){
            var data = json;
            var leaf = false;
            for (var i = 0; i < data.length; i++) {
                if(data[i].pId == id){
                    leaf = true;
                    break;
                }
            }
            return leaf;
        };
        //添加子集
        this.addChildFun = function(json,id){
            var data = json;
            for (var i = 0; i < data.length; i++) {
                if(data[i].pId == id){
                    var onehtml = [];
                    var leaf = that.testChildrenFun(data,data[i].id);
                    onehtml.push('<li>');
                    onehtml.push(' <div class="knowledge_name" data-id="'+data[i].code+'">');
                    if(leaf){
                        onehtml.push('  <i class="icon iconfont icon-clouseup" onclick="toggleChild(this,\''+data[i].id+'\')"></i>');
                    }else{
                        onehtml.push('  <i class="icon iconfont icon-xuxian"></i>');
                    }
                    onehtml.push('  <em onclick="selKnowledgeFun(this,\''+data[i].id+'\')">'+data[i].name+'</em>');
                    onehtml.push(' </div>');
                    if(leaf){
                        onehtml.push('<ol class="pl42" id="c_'+data[i].id+'">');
                        onehtml.push('</ol>');
                    }
                    onehtml.push('</li');
                    that.knowledge_container.find('#c_'+id).append(onehtml.join(""));
                    if(leaf){
                        that.addChildFun(data,data[i].id);
                    }
                }
            }
        };
        //展开折叠下一级
        toggleChild = function(is,id){
            var isobj = $(is).parent('.knowledge_name').next('ol')
            isobj.toggle(500,function(){
                if(isobj.css('display') == 'none'){
                    $(is).addClass('icon-opendown').removeClass('icon-clouseup');
                }else{
                    $(is).addClass('icon-clouseup').removeClass('icon-opendown');
                }
            });
        };
        //选中知识点
        selKnowledgeFun = function(is,id){
            var isname = $(is).html();
            if(isname.length>3){
                isname = isname.substring(0,3)+'...';
            }
            $('.knowledge_point').find('span').html(isname);
            var idarr = [];
            $(is).closest('li').find('.knowledge_name').each(function(el,index){
                idarr.push($(this).data('id'));
            });

            //将知识点id存入隐藏域
            $('#topictValue').val(idarr.join(","));
            that.loadDataFun();
            that.hideShade();
        };

        //加载试题
        this.loadDataFun = function(){
            var pageNo = $("#pageNo").val();
            var questionValue = $("#questionType").val();
            var levelValue = $("#levelType").val();
            var postValue = $("#postType").val();
            var topictValue = $("#topictValue").val();
            publicFun.loading($('body'));
            $.ajax({
                url: urlpath + '/user/question/wrong.jhtml',
                type: "GET",
                data: {
                    'pageNo': pageNo,
                    'pageSize': 10, //每页记录数
                    'qStatus': 1, //0未审核；1已审核；2待定
                    //qContent: keyword, //关键字
                    'QType': questionValue, //题型
                    'qLevel': levelValue, //难度
                    'post': postValue, //岗位
                    'topic':topictValue //知识点
                },
                success: function(t) {
                    //console.log(t);
                    var data = t.data.list;

                    that.now_page_num.html(t.data.pageNo);
                    that.total_page_num.html(t.data.totalPageCount);
                    // that.page.html(t.data.frontPageHtml);
                    if(t.data.length<=0 || !t.data){
                        $('.loading').remove();
                        publicFun.noData(that.ques_container);
                        return;
                    }
                    var domString = ' ';
                    for(var i in data){
                        var dictionary = data[i];

                        // 判断是否有解析
                        if(!dictionary.qresolve) dictionary.qresolve = '暂无';
                        // 判断是否有答案
                        if(!dictionary.qkey) dictionary.qkey = '暂无';

                        dictionary.delid = dictionary.userQuestion.id;

                        // 迭代题型模板
                        if(dictionary.qtype == 1 || dictionary.qtype == 2){
                            var options = [];
                            for (var j = 0; j<dictionary.options.length;j++) {
                                options.push('<p>'+dictionary.options[j].alisa+' 、 '+publicFun.delP(dictionary.options[j].text)+'</p>');
                            }
                            dictionary.sels = options.join("");
                            domString += publicFun.comPile(that.ques_type1,dictionary);
                        }else if(dictionary.qtype == 3 ){
                            domString += publicFun.comPile(that.ques_type3,dictionary);
                        }else if(dictionary.qtype == 4){
                            dictionary.qcontent = publicFun.replaceInput(dictionary.qcontent);
                            domString += publicFun.comPile(that.ques_type4,dictionary);
                        }else if(dictionary.qtype == 5 || dictionary.qtype == 6){
                            domString += publicFun.comPile(that.ques_type5,dictionary);
                        }
                    }
                    that.ques_container.html(domString);
                    $('.loading').remove();
                }
            });

        };
        this.loadDataFun();

        //点击遮罩
        this.shadeFun = function(event){
            event.stopPropagation();
            event.preventDefault();

            that.page_num.css('height',0);

            that.nav_sel_cont.html('').removeClass('show');
            $(this).fadeOut().css('z-index',0);
            that.nav_sel.removeClass('active');

        };
        this.hideShade = function(){
            that.nav_sel_cont.html('').removeClass('show');
            $('.shade').fadeOut().css('z-index',0);
            that.nav_sel.removeClass('active');
        };
        //查看答案
        seeAnswer = function(is){
            $(is).parent('.question_btn').prev('.question_answer').toggle(300);
        };
        //删除试题
        collectQue = function(is,id){
            $.ajax({
                url: urlpath + '/user/question/delete.jhtml?id='+id,
                type: "GET",
                success:function(ret){
                    console.log(ret);
                    if(ret.success){
                        publicFun.alertBox(ret.msg);
                        $(is).closest('li').remove();
                    }else{
                        publicFun.alertBox(ret.msg);
                    }
                }
            })
        };
        //试题纠错
        findError = function(is,id){

            var domString = '';
            var dictionary = {'id':id,'urlpath':urlpath};
            domString = publicFun.comPile(that.ques_error,dictionary);
            that.error_container.html(domString);
            that.error_container.css('left',0);

            console.log(that.error_container.html());

            // $('.body_container').css('visibility','hidden');
            setTimeout(function(){
                $('.body_container').css('visibility','hidden');
            },300)
        };
        //隐藏纠错
        hideError = function(){
            $('.body_container').css('visibility','visible');

            that.error_container.css('left','100%');
            setTimeout(function(){
                that.error_container.html('');
            },300);
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
                    if(t.success) {
                        publicFun.alertBox(t.msg);
                        hideError();
                    } else {
                        publicFun.alertBox(t.msg,'1');
                    }
                }
            });
        };
        //做笔记
        takeNode = function(is,id){
            window.location.href = "../takeNote.html?id="+id;
        };

        //上一页
        this.prevPageFun = function(){
            var pagenum = Number($("#pageNo").val());
            if(pagenum <= 1){
                publicFun.alertBox('已经到第一页了');
                return;
            }
            $("#pageNo").val(pagenum-1);
            that.loadDataFun();
        };
        //显示跳转页
        this.showPageFun = function(){
            that.page_num.css('height','4rem');
            that.shade.show().css('z-index',1);

            that.nav_sel_cont.html('').removeClass('show');
            that.nav_sel.removeClass('active');
        };
        //下一页
        this.nextPageFun = function(){
            var pagenum = Number($("#pageNo").val());
            var totalnum = Number(that.total_page_num.html());
            if(pagenum >= totalnum){
                publicFun.alertBox('已经到最后一页了');
                return;
            }
            $("#pageNo").val(pagenum+1);
            that.loadDataFun();
        };
        //跳转页
        this.selPageFun = function(){
            var pagenum = $('input[name=pagenum]').val();

            if(!/^[0-9]*$/.test(pagenum)){
                publicFun.alertBox('请输入数字',1);
                return;
            }

            $("#pageNo").val(pagenum);
            that.loadDataFun();

            that.page_num.css('height',0);
            that.shade.fadeOut().css('z-index',0);

        };


        this.init = function(){
            document.body.addEventListener('touchstart', function() {}, false);
            // this.navSelFun();
            this.nav_sel.off('click').on('click',this.navSelFun);
            this.shade.off('click').on('click',this.shadeFun);

            // 分页
            this.page_btnl.off('click').on('click',this.prevPageFun);
            this.page_btnnum.off('click').on('click',this.showPageFun);
            this.page_btnlr.off('click').on('click',this.nextPageFun);
            this.page_num_btn.off('click').on('click',that.selPageFun);


        }
    };
    var quescenter = new quesCenter;
    quescenter.init();


    // 输入框获取焦点时
    function init() {
        $('input[name=pagenum]').on('focus', function () {
            $('.que_cont').hide();
            $('.que_select').hide();

            $('.page').css('position','static');
            $('.page_num').css('position','static');
            $('.page_html').hide();

            $('html,body').scrollTop(0);
            $('.shade').css({'position':'absolute','z-index':-1});
            $('.shade').css('backgroundColor','#eee');

            $('header').css('position','static');
            $('footer').css('position','static');

        });

        $('input[name=pagenum]').on('blur', function inputBlur() {
            $('.que_cont').show();
            $('.que_select').show();

            $('.page').css('position','fixed');
            $('.page_num').css('position','absolute');
            $('.page_html').show();

            $('.shade').css({'position':'fixed','z-index':0});
            $('.shade').css('backgroundColor','rgba(0,0,0,0.3)');

            $('header').css('position','fixed');
            $('footer').css('position','fixed');



        });

        $(document).on('focus','textarea,.code', function () {
            $('.body_container').hide();
            $('.error_container').css('position','static');
        });
        $(document).on('blur','textarea,.code', function () {
            $('.error_container').css('position','fixed');
            $('.body_container').show();
        });
    }
    init();



});