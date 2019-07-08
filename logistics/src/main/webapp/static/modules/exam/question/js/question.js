function page(n,s){
    question.queryParam.pageNo = n;
    question.queryParam.pageSize = s;
    question.queryData();
    return false;
}

//递归逐级取父节点
function showParentName(node){
    var parentNode = node.getParentNode();
    var ret = node.name;
    if(parentNode){
        ret =  showParentName(parentNode) + ' 》 ' + ret;
    }
    return ret;
}
function initTopic(obj) {
    var qid = obj.id;
    $('#topic'+qid).val(obj.topic);
    $('#topicName'+qid).val(obj.topicName);
    $("#topicButton"+qid).click(function(){
        // 是否限制选择，如果限制，设置为disabled
        if ($("#topicButton"+qid).hasClass("disabled")){
            return true;
        }
        // 正常打开
        top.$.jBox.open("iframe:"+urlpath_a+"/tag/treeselect?url="+encodeURIComponent("/sys/dict/treeData?type=dic_exam_questiontopic")+"&module=&checked=&extId=&isAll=", "选择知识点", 300, 420, {
            ajaxData:{selectIds: $("#topic"+qid).val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                    var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                    var ids = [], names = [], nodes = [];
                    if ("" == "true"){
                        nodes = tree.getCheckedNodes(true);
                    }else{
                        nodes = tree.getSelectedNodes();
                    }
                    for(var i=0; i<nodes.length; i++) {//
                        ids.push(nodes[i].code);
                        var _name = nodes[i].name;
                        //
                        names.push(_name);//
                        break; // 如果为非复选框选择，则返回第一个选择
                    }
                    $("#topic"+qid).val(ids.join(",").replace(/u_/ig,""));
                    $("#topicName"+qid).val(names.join(","));
                }//
                else if (v=="clear"){
                    $("#topic"+qid).val("");
                    $("#topicName"+qid).val("");
                }//
                if(typeof parentTreeselectCallBack == 'function'){
                    parentTreeselectCallBack(v, h, f);
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        });
    });
}

var Question = function () {
    var that = this;
    var templateString = $("#template").html();
    var optionsTemplateString = $("#options_template").html();
    var optionsTemplateYNString = $("#options_templateYN").html();
    var quesopmenuTemplateString = $("#quesopmenu_template").html();
    var qxQuesopmenuTemplateString = $("#qx_quesopmenu_template").html();
    var qid;
    var qStatus;
    var status=0;
    var pageSize = 10;
    var optionhtml = ''; //选项的html
    var quesopmenuhtml = ''; //鼠标经过菜单栏的html
    this.questypebodyUl = $("#question_questypebodyul"); //承载数据的UL
    this.questionOptionsdiv = $("#question_optionsdiv"); //承载选项的div
    this.questionQuesopmenudiv = $("#question_quesopmenudiv");// 承载功能菜单的 div
    this.questionNumber = $("#question_number"); // 序号
    this.cantelCheckBtn = $("#cantel_check");// 未审核的标签
    this.pending = $("#pending");// 待定的标签
    this.checked = $("#checked");// 审核的标签
    this.all = $("#all");       // 全部的标签
    this.preview = $("#preview");// 预览的标签
    this.addNew = $("#addNew");// 添加的标签

    this.search_type = $('.dropdown-menu li');  //试题搜索类型
    this.search_btn  = $('#pos_search');        //试题搜索按钮
    this.search_cont  = $('#search_cont');      //试题搜索内容
    this.quenums      = $('#quenums');           //总题数隐藏域
    // var imgUrl         = urlpath;

    //每次审核时都存储改题的编号做为毛点id
    var storageKey = {id:''};
    //存储的对象名称
    var keyName = 'localstorage'+$('#storageid').val();

    this.queryParam = {qStatus:status};


    //查询数据  ctx+"/exam/question/list.jhtml?pageSize=" + pageSize + "&qStatus=" + status,
    this.queryData = function (e,quekey) {
        $("#question_questypebodyul").empty();
        $('#question_partnote1').html('');
        var load_img = '<img id="load_img" style="margin: 100px auto 0;display: block;" src="'+imgUrl+'/usercenter/images/loading.gif" alt="">';
        that.questypebodyUl.html(load_img);
        var qKeyword;
        // var statusString = "&qStatus=";
        if(e){
            status = e;
            if(status == "all"){
                status = "";
            }
            that.queryParam.qStatus = status;
        }
        if(!quekey){
            qKeyword = '';
        }else{
            qKeyword = quekey;
        }

        that.queryParam.fast = true;

        $.ajax({
            type: "GET",
            url: ctx + "/exam/question/list.jhtml?orderBy=qno&qKeyword="+qKeyword+"&pageSize=10",
            data: that.queryParam,
            dataType: "json",
            success: function (result) {
                // console.log(result);
                var data_status = result.data.list;
                if(result.code == '403'){
                    alert('您无权访问该功能！');
                    return;
                }
                if(result.datax.length == 0) {
                    setTimeout(function(){
                        $('#load_img').remove();
                        $('#question_partnote1').html('没有符合条件的试题');
                    },200);
                    $('#pagelist').html('');
                } else {
                    $('#question_partnote1').html('');
                    $('#pagelist').html(result.data.frontPageHtml);
                }
                //试题总数
                $("#question_stcount").text(result.datax.length);
                $("#question_dxcount").text(result.datax.length);

                var domString = "";
                //  result.datax.reverse();
                $.each(result.datax, function (index, obj) {
                    /*数据列模板*/
                    domString = compile(templateString, obj);
                    $('#load_img').remove();
                    that.questypebodyUl.append($(domString));
                    //动态div ID
                    $("#question_number").attr({id: 'question_number_' + index});
                    // $("#question_number_" + index).text(index+1);//序号

                    $("#question_bracket").attr({id: 'question_bracket_' + index});// 括号的div

                    $("#question_choiceB").attr({id: 'question_choiceB_' + index});//承载选择题的答案的ID 显示正确，错误
                    $("#question_editorBox").attr({id: 'question_editorBox_' + index});//试题解析动态添加id
                    $("#que_cont").attr({id: 'que_cont_' + index});//试题题干动态添加id

                    $("#question_optionsdiv").attr({id: 'question_optionsdiv_' + index});
                    that.questionOptionsdiv = $("#question_optionsdiv_" + index); //选项父标签div

                    $("#question_quesopmenudiv").attr({id: 'question_quesopmenudiv_' + index});
                    that.questionQuesopmenudiv = $("#question_quesopmenudiv_" + index); //菜单栏父标签div
                    /*选项模板开始 qtype 题型*/
                    if (obj.qtype < 3) {
                        // obj.options.reverse();   //翻转函数 倒序 否则选项为 d c b a
                        $.each(obj.options, function (i, val) {    //遍历选项abcd...
                            if(val.text){
                                optionhtml = compile(optionsTemplateString, val);
                                that.questionOptionsdiv.append($(optionhtml));
                            }
                        });
                    } else if (obj.qtype == 3) {
                        optionhtml = compile(optionsTemplateYNString, '');
                        that.questionOptionsdiv.prepend($(optionhtml));
                        //判断题Y 正确 N 错误
                        var keys = $("#question_choiceB_" + index).html();
                        if(keys == 'Y'){
                            $("#question_choiceB_" + index).html("正确");
                        }else if(keys == 'N'){
                            $("#question_choiceB_" + index).html("错误");
                        }
                    }
                    /*选项模板结束*/
                    //功能菜单 模板
                    // if(obj.qtype)
                    // console.log(data_status[index].qstatus);
                    if(data_status[index].qstatus == "1"){
                        optionhtml = compile(qxQuesopmenuTemplateString, obj);
                    }else{
                        optionhtml = compile(quesopmenuTemplateString, obj);
                    }
                    that.questionQuesopmenudiv.prepend($(optionhtml));
                    // $(".question_status").attr("data-qstatus",status);

                    // $(".question_collection").show();
                    $(".question_answer").show();
                    $(".question_del").show();
                    $(".question_update").show();
                    $(".question_examine").show();
                    $(".question_pending").show();
                    $(".question_moveup").show();
                    $(".question_movedn").show();
                    // if (status == 1) {
                    //     $(".question_answer").show();
                    //     $(".question_cancel_examine").show();
                    // } else if (status == 2) {
                    //     $(".question_answer").show();
                    //     $(".question_update").show();
                    //     $(".question_examine").show();
                    // }

                    // 临时增加绑定试题难度和岗位
                    that.issave = $('.is_save');
                    var arr = obj.post&&obj.post.indexOf(',')>0?obj.post.split(','):obj.post;
                    $('#ispost-'+obj.id).val(arr).trigger("change");
                    $('#islever-'+obj.id).val(eval(obj.qlevel)).trigger("change");
                    // $('#topic-'+obj.id).val(eval(obj.topic)).trigger("change");
                    $('#ispost-'+obj.id).prop('readonly',true);
                    $('#islever-'+obj.id).prop('readonly',true);
                    // $('#topic-'+obj.id).prop('readonly',true);
                    $("select").select2();

                    initTopic(obj);

                    that.issave.off('click').on('click',that.saveIs);
                });

                //试题解析 的P 标签添加指定class  为了满足当前页的样式
                $(".question_title_css p").addClass("question_p");
                //填空正则
                $('.questionContent').each(function (i, e) {
                    $(e).html($(e).html().replace(/\[BlankArea[A-Za-z0-9]+\]/g, '<u style="letter-spacing:60px;">&nbsp;</u>'));
                });
                //加载数据后初始化模板内标签
                question.init();
                is_top_down();

                loadEdit();

                // 涮新页面时加载本地存储，跳转到相应的试题
                var storageQno = $('#posid').val();
                if(storageQno && storageQno!== "1"){
                    if($('#pos-'+storageQno).length > 0){
                        that.toPosY(storageQno);
                    }
                }

            }
        });

        function compile(templateString, dictionary) {
            return templateString.replace(/\{{([A-Za-z]+)\}}/g, function (match, $1, index, string) {
                return dictionary[$1]||'';
            });
        }
    };

    //审核
    this.check = function(e){
        qid = $(this).data('qid');
        var isqno = $(this).data('qno');
        qstatus = $(this).data('qstatus');

        $.ajax({
            type: "GET",
            url:  ctx+"/exam/question/" + qid + "/check.jhtml?status=1",
            dataType: "jsonp",
            jsonp: 'callback',
            jsonpCallback: "successCallback",
            success: function (result) {
                if (result.success == false) {
                    alert(result.msg);
                    return false;
                } else {
                    alert("审核成功");
                    $('#posid').val(isqno);
                    that.queryData(qstatus);
                    storageKey.id = isqno;
                    that.save(storageKey);
                }
            }
        })
    };
    //取消审核
    this.cantelCheck = function(e){
        qid = $(this).data('qid');
        var isqno = $(this).data('qno');
        qstatus = $(this).data('qstatus');
        $.ajax({
            type: "GET",
            url: ctx+"/exam/question/" + qid + "/check.jhtml?status=0",
            dataType: "jsonp",
            jsonp: 'callback',
            jsonpCallback: "successCallback",
            success: function (result) {
                if (result.success == false) {
                    alert(result.msg);
                    return false;
                } else {
                    alert("取消审核成功");
                    $('#posid').val(isqno);
                    storageKey.id = isqno;
                    that.queryData(qstatus);
                    that.save(storageKey);
                }
            }
        })
    }
    //待定
    this.toPending = function(e){
        qid = $(this).data('qid');
        var isqno = $(this).data('qno');
        qstatus = $(this).data('qstatus');
        $.ajax({
            type: "GET",
            url: ctx+"/exam/question/" + qid + "/check.jhtml?status=2",
            dataType: "jsonp",
            jsonp: 'callback',
            jsonpCallback: "successCallback",
            success: function (result) {
                if (result.success == false) {
                    alert(result.msg);
                    return false;
                } else {
                    alert("成功");
                    $('#posid').val(isqno);
                    storageKey.id = isqno;
                    that.queryData(qstatus);
                    that.save(storageKey);
                }
            }
        })
    }
    //修改---待定
    this.updateData = function(e){
        qid = $(this).data('qid');
        window.location.href = ctx + '/exam/question/form?id='+qid+'&backURL=/exam/question/listpreview';
    }
    //删除---待定
    this.delData = function(e){
        qid = $(this).data('qid');
        var href = ctx + '/exam/question/delete?id='+qid+'&backURL=/exam/question/listpreview';
        return confirmx('确认要删除该试题吗？', href);
    }

    // 点击保存
    this.saveIs = function(){
        var isbj = $(this).parents('li').find('.question_reportError').attr('data-bj');
        if(isbj == 'false'){
            alert('改题未处于编辑状态,保存无效');
            return;
        }
        var data_id = $(this).find('button').attr('data-id');
        var q_cont = $(this).parents('li').find('.questionContent ').html();
        var q_answer = $(this).parents('li').find('.question_choiceB ').html();
        var q_jiqxi = $(this).parents('li').find('.question_editorBox ').html();

        var q_know = $(this).parents('.question_quesbox').find('input[name = topic]').val();
        var q_post = $(this).parents('.question_quesbox').find('select[name = post]').val();
        var q_level = $(this).parents('.question_quesbox').find('select[name = qLevel]').val();

        // var serialize ='topic='+q_know+'&post='+q_post+'&qLevel='+q_level+'&id='+data_id+'&qContent='+q_cont+'&qKey='+q_answer+'&qResolve='+q_jiqxi;
        var serialize = {
            id : data_id,
            qContent : q_cont,
            qKey : q_answer,
            qResolve : q_jiqxi,
            topic : q_know,
            post : q_post+'',
            qLevel : q_level
        }
        console.log(serialize);

        var isthis = $(this);
        var q_cont_id = $(this).parents('li').find('.questionContent ').attr('id');
        var q_answer_id = $(this).parents('li').find('.question_choiceB ').attr('id');
        var q_jiqxi_id = $(this).parents('li').find('.question_editorBox ').attr('id');
        var arr_cont  = 'CKEDITOR.instances.'+ q_cont_id;
        var arr_answer  = 'CKEDITOR.instances.'+ q_answer_id;
        var arr_jiexi  = 'CKEDITOR.instances.'+ q_jiqxi_id;
        console.log(serialize);
        $.ajax({
            type:'POST',
            url:ctx + '/exam/question/checkSave.jhtml',
            data:serialize,
            success:function () {
                alert('保存成功');

                if ( eval(arr_cont) ){
                    eval(arr_cont).destroy();
                }
                if ( eval(arr_answer) ){
                    eval(arr_answer).destroy();
                }
                if ( eval(arr_jiexi) ){
                    eval(arr_jiexi).destroy();
                }

                // isthis.parents('li').find('.question_reportError').attr('data-bj','false').css({'color':'#1887e3'});
                $('#'+q_cont_id).attr( 'contenteditable', false );
                // isthis.parents('li').find('.is_answer').attr('data-bj','false').css({'backgroundColor':'#e8e8e8','color':'#333'}).html('结束编辑');
                $('#'+q_answer_id).attr( 'contenteditable', false );
                // isthis.parents('li').find('.isjiexi').attr('data-bj','false').css({'backgroundColor':'#e8e8e8','color':'#333'}).html('结束编辑');
                $('#'+q_jiqxi_id).attr( 'contenteditable', false );
                isthis.parents('li').find('.question_reportError').attr('data-bj','false').css({'color':'#1887e3'});
                isthis.parents('li').find('.control_editor').html('编辑');

                $('#ispost-'+ data_id).prop('disabled',true);
                $('#islever-'+ data_id).prop('disabled',true);
                $('#topic-'+ data_id).prop('disabled',true);

                $('#ispost-'+ data_id).select2();
                $('#islever-'+ data_id).select2();
                $('#topic-'+ data_id).select2({
                    ajax: {
                        url: projectname + "/a/sys/dict/listData.jhtml",
                        dataType: 'json',
                        delay: 250,
                        data: {type: 'dic_exam_questiontopic'},
                        processResults: function (json) {
                            $.each(json.data,function(i,it){
                                it.id = it.value;
                                it.text = it.label;
                            });
                            return {
                                results: json.data
                            };
                        }
                    }
                });
            }
        });
    };
    // 获取总题数
    // this.quesTotals = function(){
    //     var load_img = '<img id="load_img" style="margin: 100px auto 0;display: block;" src="'+imgUrl+'/usercenter/images/loading.gif" alt="">';
    //     that.questypebodyUl.html(load_img);
    //     $.ajax({
    //         type: "GET",
    //         url: ctx + "/exam/question/list.jhtml",
    //         success: function (result) {
    //             that.quenums.val(result.data.count);
    //             that.pageLoad();
    //         }
    //     });
    // };

    // 试题搜索
    this.searchBtn = function(){
        if(that.search_cont.val() == '')
            return;
        $('#posid').val(that.search_cont.val());
        that.quesNumSearchToPage();
        that.delType();
    };
    // 试题搜索是清除条件限制
    this.delType = function(){
        $('.question_limenu').children('a').removeClass('curr');
        $('.del_type').addClass('curr');
    };
    // 试题编号搜索到页
    this.quesNumSearchToPage = function(){
        var ques_num = that.search_cont.val();
        // if(ques_num - that.quenums.val() > 0){
        //     alert('没有此试题编号');
        //     return;
        // }
        that.queryParam = {};
        that.queryParam.qno = $('#search_cont').val();
        // that.queryParam.pageNo = Math.ceil(ques_num/10);
        that.queryData('','');

    };
    //试题编号搜索到题
    // this.quesNumSearchToTitle = function(){
    //     // that.queryParam.pageNo = '';
    //     that.queryParam = {};
    //     that.queryParam.qno    = that.search_cont.val();
    //     that.queryData('','');
    // };
    //试题添加锚点
    this.toPosY = function (y) {
        var pos = $("#pos-" + y).offset().top-30;
        $("html,body").animate({scrollTop: pos}, 400);
    };

    // 获取存储
    this.fetch = function (){
        return JSON.parse(window.localStorage.getItem(keyName));
    };
    //存储到本地
    this.save = function (str){
        window.localStorage.setItem(keyName,JSON.stringify(str));
    };
    this.pageLoad = function(){
        var getStorageKey = that.fetch();
        if(!getStorageKey){
            getStorageKey = {'id':'1'}
        }
        var storageQno    = getStorageKey.id;
        $('#posid').val(storageQno);
        that.search_cont.val(storageQno);
        that.quesNumSearchToPage();
        that.search_cont.val('');

    };

    //弹出字典管理
    this.addDictionary = function(){
        $('.is_form').on('click','.add_dictionary',function(){
            layer.open({
                type: 2,
                title:'知识点字典设置',
                // skin: 'layui-layer-molv',
                area: ['800px', '400px'],
                fixed: true, //不固定
                maxmin: true,
                shade: 0.5,
                offset: '50px',
                content: projectname + '/a/sys/dict/formSimple?type=dic_exam_questiontopic&parentId=0d63fd54b0de4e41895b1088ed7a9732'
            });
        });
    }
    // 绑定方法
    this.init = function(){
        this.cantelCheckBtn.off('click').on('click', function(e){
            status = $(this).attr('data-status');
            that.queryData(status);
            $('#question_limenu').find('a').removeClass('curr');
            $(this).addClass('curr');
        });
        this.pending.off('click').on('click', function(e){
            status = $(this).attr('data-status');
            that.queryData(status);
            $('#question_limenu').find('a').removeClass('curr');
            $(this).addClass('curr');
        });
        this.checked.off('click').on('click', function(e){
            status = $(this).attr('data-status');
            that.queryData(status);
            $('#question_limenu').find('a').removeClass('curr');
            $(this).addClass('curr');
        });
        this.all.off('click').on('click', function(e){
            status = $(this).attr('data-status');
            that.queryData(status);
            $('#question_limenu').find('a').removeClass('curr');
            $(this).addClass('curr');
        });
        this.preview.off('click').on('click', function(e){
            status = $(this).attr('data-status');
            that.queryData(status);
            $('#question_limenu').find('a').removeClass('curr');
            $(this).addClass('curr');

        });
        this.addNew.off('click').on('click', function(e){
            status = $(this).attr('data-status');
            that.queryData(status);
            $('#question_limenu').find('a').removeClass('curr');
            $(this).addClass('curr');

        });

        $(".btn-question-check").off('click').on('click', this.check);
        $(".btn-question-cancelcheck").off('click').on('click', this.cantelCheck);
        $(".btn-question-update").off('click').on('click', this.updateData);
        $(".btn-question-pending").off('click').on('click', this.toPending);
        $(".btn-question-del").off('click').on('click', this.delData);

        // Author GeC on 2017/4/12
        this.questionTagClick = function(e){
            console.log(this);
            var value = $(this).data('value');
            var key   = $(this).data('tagtype');
            that.queryParam[key] = value;
            question.queryParam.pageNo = 1;
            console.log(JSON.stringify(that.queryParam));
            that.queryData();
            $(this).closest('div').find('a').removeClass('curr');
            $(this).addClass('curr');
        };
        $('.question-tag').off('click').on('click',this.questionTagClick);

        this.btnAdd.on('click',this.btnAddClick);
        // Author GeC on 2017/4/12

        //试题搜索事件
        this.search_btn.off('click').on('click',this.searchBtn);
        this.search_type.off('click').on('click',this.searchType);

        this.addDictionary();
    }

    this.btnAdd = $('#btn-add');

    this.btnAddClick = function(e){
        window.location.href = ctx+'/exam/question/form?backURL=/exam/question/listpreview';
    }

    var that = this;
}

var question = null;

$(function () {
    question = new Question();
    // question.init();
   // question.pageLoad();

    question.queryData('','');
});

// 点击编辑启动编辑画面
function loadEdit(){
    $('.question_reportError').click(function(){

        var bj = $(this).attr('data-bj');
        var q_id = $(this).attr('data-id');
        var q_type = $(this).attr('data-type');
        var q_cont_id = $(this).parents('li').find('.questionContent ').attr('id');
        var q_answer_id = $(this).parents('li').find('.question_choiceB ').attr('id');
        var q_jiqxi_id = $(this).parents('li').find('.question_editorBox ').attr('id');

        var that = $(this);

        if(bj == 'false'){
            that.css({'color':'#d9534f'});
            that.find('.control_editor').html('取消编辑');
            if(q_type != "4"){
                addCkeditor(q_cont_id,q_id);
            }
            // if(q_type == "5" || q_type == "6"){
            //     addCkeditor(q_answer_id,q_id);
            // }
            addCkeditor(q_jiqxi_id,q_id);
            that.attr('data-bj','true');
            $('#ispost-'+ q_id).prop('disabled',false);
            $('#islever-'+ q_id).prop('disabled',false);
            $('#topic-'+ q_id).prop('disabled',false);
            $('#ispost-'+ q_id).select2();
            $('#islever-'+ q_id).select2();
            $('#topic-'+ q_id).select2({
                ajax: {
                    url: projectname+ "/a/sys/dict/listData.jhtml",
                    dataType: 'json',
                    delay: 250,
                    data: {type: 'dic_exam_questiontopic'},
                    processResults: function (json) {
                        $.each(json.data,function(i,it){
                            it.id = it.value;
                            it.text = it.label;
                        });
                        return {
                            results: json.data
                        };
                    }
                }
            });

            // 显示添加知识点按钮
            that.parents('.question_quesdiv').find('.add_dictionary').show();
            // 显示查找知识点按钮
            that.parents('.question_quesdiv').find('.query_dictionary').show();
        }else{
            that.css({'color':'#1887e3'});
            that.find('.control_editor').html('编辑');
            if(q_type != "4"){
                removeCkeditor(q_cont_id);
            }
            // if(q_type == "5" || q_type == "6"){
            //     removeCkeditor(q_answer_id);
            // }
            removeCkeditor(q_jiqxi_id);
            that.attr('data-bj','false');
            $('#ispost-'+ q_id).prop('disabled',true);
            $('#islever-'+ q_id).prop('disabled',true);
            // $('#topic-'+ q_id).prop('disabled',true);
            $('#ispost-'+ q_id).select2();
            $('#islever-'+ q_id).select2();
            // $('#topic-'+ q_id).select2({
            //     ajax: {
            //         url: projectname+ "/a/sys/dict/listData.jhtml",
            //         dataType: 'json',
            //         delay: 250,
            //         data: {type: 'dic_exam_questiontopic'},
            //         processResults: function (json) {
            //             $.each(json.data,function(i,it){
            //                 it.id = it.value;
            //                 it.text = it.label;
            //             });
            //             return {
            //                 results: json.data
            //             };
            //         }
            //     }
            // });
            // 隐藏添加知识点按钮
            that.parents('.question_quesdiv').find('.add_dictionary').hide();
            // 隐藏查找知识点按钮
            that.parents('.question_quesdiv').find('.query_dictionary').hide();
        }
    });
}
// 增加编辑器
function addCkeditor(id,qid){
    var arr  = 'CKEDITOR.instances.'+ id;
    var arrs = '!CKEDITOR.instances.'+ id;
    if ( eval(arrs) ) {
        CKEDITOR.inline( id, {
            extraAllowedContent: 'a(documentation);abbr[title];code',
            extraPlugins: 'sharedspace,sourcedialog',
            removePlugins: 'floatingspace,maximize,resize',
            sharedSpaces: {
                top: 'top-'+ qid,
                // bottom: 'bottom'
            },
            // startupFocus: true
        } );
    }
    eval(id).setAttribute( 'contenteditable', true );
    CKEDITOR.config.title = false;
}
// 注销编辑器
function removeCkeditor(id){
    var arr  = 'CKEDITOR.instances.'+ id;
    if ( eval(arr) ){
        eval(arr).destroy();
    }
    eval(id).setAttribute( 'contenteditable', false );
}
// 关闭layer模态窗口
function clouseLayer(){
    layer.closeAll('iframe');
}

//引入知识点
$(function(){
    var subTree = function(){
        var that = this;
        this.onecontainer = $('#onecontainer');  //第一层容器
        this.model        = $('#model').html();   //第一层末班
        this.model2        = $('#model_2').html();   //第二层末班

        //初始化树
        this.loadTree = function(){
            $.ajax({
                'url':urlpath +'/a/sys/dict/treeData.jhtml?type=dic_exam_questiontopic',
                'type':'get',
                'dataType': "json",
                success:function(ret){
                    console.log(ret);
                    var datas = ret;
                    var domString;
                    for(var i in datas){
                        var dictionary = datas[i];
                        if(dictionary.pId == '0d63fd54b0de4e41895b1088ed7a9732' || !datas[i].pId){
                            dictionary.isleaf = that.haveChild(datas,dictionary.id);
                            if(dictionary.isleaf){
                                dictionary.bg = 'title_radio1';
                            }else{
                                dictionary.bg = 'title_dash';
                            }

                            domString = that.comPile(that.model,dictionary);
                            that.onecontainer.append(domString);

                            if(dictionary.isleaf){
                                // $('#sub-'+datas[i].id).find('.select').remove();
                                that.chirldData(ret,dictionary.id);
                            }
                        }
                    }
                }
            })
        };

        //判断是否有下级
        this.haveChild = function(obj,id){
            var datas = obj;
            var hasleaf = false;
            for(var i in datas){
                var dictionary = datas[i];
                if(dictionary.pId == id){
                    hasleaf = true;
                }
                if(hasleaf){
                    break;
                }
            }
            return hasleaf;
        };

        this.chirldData = function(obj,id){
            var datas = obj;
            for(var i in datas){
                var dictionary = datas[i];
                if(dictionary.pId == id){
                    dictionary.isleaf = that.haveChild(datas,dictionary.id);
                    if(dictionary.isleaf){
                        dictionary.bg = 'title_radio1';
                    }else{
                        dictionary.bg = 'title_dash';
                    }
                    domString = that.comPile(that.model2,dictionary);
                    $('#sub-'+id).next('ul').append(domString);

                    if(dictionary.isleaf){
                        $('#sub-'+datas[i].id).find('.select').remove();
                        that.chirldData(datas,dictionary.id);
                    }
                }
            }

        };

        toggerClick = function(is){
            if($(is).hasClass('title_dash')){
                return;
            }
            var is_next = $(is).parent('.one_title').next('ul');
            if(is_next.css('display') == 'none'){
                is_next.slideDown();
                $(is).removeClass('title_radio2').addClass('title_radio1');
            }else{
                is_next.slideUp();
                $(is).removeClass('title_radio1').addClass('title_radio2');
            }
        };

        selClick = function(is){
            var sel_child = $(is).parent('.one_title').parent('li').find('.sel');
            $('.selected').removeClass('selected');

            var codearr = [];
            if(sel_child.length>0){
                sel_child.each(function(el,index){
                    var is_code = $(this).parent().parent('.one_title').data('code');
                    codearr.push(is_code);
                });
            }
            sel_child.addClass('selected');
            codearr = codearr.join(',');

            question.queryParam.topic = codearr;
            question.queryData();
        };

        //数据正则匹配方法
        this.comPile = function(templateString , dictionary){
            return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                return dictionary[$1];
            });
        };

        this.init = function(){
            // $(".divlist_fl_list").slimScroll({
            //     color:'#E4E4E4'
            // });
            this.loadTree();

        }
    }

    var subtree = new subTree;
    subtree.init();
})





