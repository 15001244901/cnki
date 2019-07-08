
$(function () {
    inTheTest.init();
    inTheTest.setHover();
    inTheTest.setClick();

    function BottomJumpPage() {
        var scrollTop = $(this).scrollTop();
        var scrollHeight = $(document).height()-375;
        var windowHeight = $(this).height();
        if (scrollTop + windowHeight >= scrollHeight) { //滚动到底部执行事件
            if($('#single_model').hasClass('fixed_p')){
                $('#single_model').removeClass('fixed_p');
            }
        }else{
            if(!$('#single_model').hasClass('fixed_p')){
                $('#single_model').addClass('fixed_p');
            }
        }
    }
    // $(window).scroll(BottomJumpPage);
    $(window).scroll(function () {
        BottomJumpPage();
        // if ($(window).scrollTop() > 135) {
        //     $('.left').addClass('pos');
        // } else {
        //     $('#div .left').removeClass('pos');
        // }
    });
    // 全部变量，公式图片与xml映射
    $(function () {
        var xml_data = "";
        var FormulaImgHash = {
            index: xml_data ? xml_data.index : 0, // 索引自增
            data: xml_data ? xml_data.answer_xml : {}, // 图片与xml映射内容
            answers: null, // 主观填空类图片答案
            getHash: function () {
                // 获取需要的图片与答案xml映射
                var ids = [];
                var _filter = function (str) {
                    var reg = /data-kfformula-index="(\d+)"/g;
                    var m;
                    while (m = reg.exec(str)) {
                        ids.push(m[1]);
                    }
                };
                _.each(this.answers, function (item, i) {
                    if (typeof item === 'string') {
                        _filter(item);
                    } else if (item != null && _.size(item) > 0) {
                        _.each(item, function (v, k) {
                            if (typeof v === 'string') _filter(v);
                        })
                    }
                });
                var res = {};
                _.each(this.data, function (v, k) {
                    k = k.toString();
                    if (_.indexOf(ids, k) > -1) {
                        res[k] = v;
                    }
                });
                return {
                    answer_xml: res,
                    index: this.index
                };
            }
        };
        // 公式编辑器

        // CKEDITOR.config.customConfig = 'config-custom.js';
        var current_editor = null;
        $('.fill-edit').each(function () {
            var _editor = CKEDITOR.inline(this);

            var self = this;
            _editor.on('change', function (evt) {
                var txt = _editor.getData();
                // txt = inTheTest.delP(txt);
                $(self).trigger('fillblank', txt);
                changeText(self,txt);
            });
            $(this).on('dblclick', function (evt) {
                if(!$(this).attr('contenteditable')){
                    return;
                }
                if (typeof formulaShow === 'function') formulaShow();
                current_editor = _editor;
            });
            _editor.on('focus', function (evt) {
                current_editor = _editor;
            });

            // $(this).parent('.edit-wrap2').find('.edit-show').on('click',function(){
            // 	$(self).trigger('dblclick');
            // });
        });

        if (document.body.addEventListener) {
            var $FeditorContainer = $('#formula-wrap');
            var formulaEditor_visible = false;
            var url = '../test_sets/Start_the_test/editor.html';
            $FeditorContainer.find('iframe').attr({
                'src': url
            });

            var formulaShow = function (state) {
                if (state === false) {
                    formulaEditor_visible = false;
                    $FeditorContainer.animate({
                        'right': '-800px'
                    }, 'slow');
                    return false;
                }
                if (formulaEditor_visible) return false;
                formulaEditor_visible = true;
                $FeditorContainer.animate({
                    'right': 0
                }, 'slow');
            };

            // formulaShow();
            $('#J_FormulaClose').click(function () {
                formulaShow(false);
            });

            $FeditorContainer.draggable({
                handle: '.formula-tit',
                axis: "y",
                containment: 'window'
            });

            window.formulaReady = function (feditor) {
                $('#J_FormulaOk').click(function () {

                    feditor.execCommand('get.image.data', function (data) {
                        var latex = feditor.execCommand('get.source');
                        var mathml = TeXZilla.toMathMLString(latex, false, false, true);
                        // var html = '<img class="kfformula" src="'+ data.img +'" data-mathexpression="' + encodeURI(mathml) + '" />';
                        var html = '<img class="kfformula" data-kfformula-index="' + FormulaImgHash.index + '" src="' + data.img + '" />';
                        FormulaImgHash.data[FormulaImgHash.index] = mathml; // 全部变量，公式图片与xml映射
                        FormulaImgHash.index += 1;
                        if (current_editor) current_editor.insertHtml(html);
                    });
                });

            }
        }
    });
    //把编辑器的文本复制到相应的textarea
    function changeText(is,tx){
        var this_html = inTheTest.delP(tx);
        $(is).parents('.four1').find('textarea').val(this_html);
        $(is).parents('.four1').find('textarea').trigger('change');
        $(is).parents('.four1').find('textarea').trigger('blur');
    }
});
var questionTypes = [];
var ints;
var interval = 1000;
var leftsecond = 0;
var topic = getQueryString("topic");
var topicname = getQueryString("topicname");
function getQueryString(key) {
    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
    var result = window.location.search.substr(1).match(reg);
    return result ? decodeURIComponent(result[2]) : null;
};

//记录当前题号
var page_num = 0;
// 答题模式 1:自动显示答案；2:自动下一题；3:答对自动下一题；4:手动操作；默认为3。
var answer_mode = $('.down_menu input[name=set_paper]:checked').data('id');

var inTheTest = {
    //初始化
    init: function () {
        $("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);

        var pid = inTheTest.getQueryString("id");
        var restart = inTheTest.getQueryString("restart");
        $("#hidID").val(pid);
        tm_pid = pid;
        $.ajax({
            url: urlpath + '/user/practice/startPractice.jhtml',
            type: "GET",
            async: false,
            data: {
                ptype: 1,
                topic: topic,
                topicname: topicname,
                pageSize:20 ,
                restart:(restart || '')
            },
            success: function (t) {
                // console.log(t);
                var success = t.success;
                if (success) {
                    if(!t.data.sections){
                        $('#model_exam').addClass('no_data');
                        return;
                    }
                    var datas = t.data.sections;
                    // $("#divName").html(t.data.name);
                    $('.pos_name span').html(t.data.name);
                    // $("#txtTotalScore").val(t.data.totalscore);
                    $("#txtDuration").val(t.data.duration);
                    //计算总题数
                    if(!datas[0].questions){
                        $('#model_exam').addClass('no_data');
                        return;
                    }
                    $('.progress_num i').html(datas[0].questions.length);
                    // leftsecond = t.data.duration * 60;

                    //试题编号
                    var question_num = 0;
                    var html = [];
                    var questionCounts = [];
                    var questionCount = 1;
                    for (var i = 0; i < datas.length; i++) {
                        //题型序列号
                        var title;
                        switch (i) {
                            case 0:
                                title = '一、';
                                break;
                            case 1:
                                title = '二、';
                                break;
                            case 2:
                                title = '三、';
                                break;
                            case 3:
                                title = '四、';
                                break;
                            case 4:
                                title = '五、';
                                break;
                            case 5:
                                title = '六、';
                                break;
                        }
                        questionTypes.push({'name': datas[i].name, 'num': title, 'type': datas[i].id});
                        html.push('<div class="div2">');

                        // html.push(' <div class="one1">' + title + datas[i].name + '&nbsp;&nbsp;&nbsp;<span class="switch_model">逐题模式</span></div>');
                        var questions = datas[i].questions;

                        for (var j = 0; j < questions.length; j++) {
                            var qcount = questionCount++;
                            question_num++;
                            if (qcount.toString().length < 2) {
                                qcount = "0" + qcount;
                            }
                            questionCounts.push({
                                "qcount": qcount,
                                "qid": questions[j].id,
                                'stype': questions[j].qtype
                            });

                            //去除题干的html
                            if(questions[j].qcontent){
                                questions[j].qcontent = inTheTest.delP(questions[j].qcontent);
                            }

                            html.push('<div id="QC-' + questions[j].id + '" class="ask_list">');
                            if (questions[j].qtype == 1) {
                                html.push(' <div class="two1"> <span class="que_num">' + question_num + '、[ '+questions[j].typeName+' ] </span>' + questions[j].qcontent + '</div>');
                                html.push(' <div class="three1">');
                                var options = questions[j].options;
                                for (var k = 0; k < options.length; k++) {
                                    if(options[k].text)
                                        options[k].text = inTheTest.delP(options[k].text);
                                    html.push('<div>');
                                    html.push(options[k].alisa + "&nbsp;、&nbsp;"+ options[k].text);
                                    html.push('</div>');
                                }
                                html.push(' </div>');
                                html.push(' <div class="four1">');

                                html.push('<div style="margin-left: 20px;">');
                                for (var k = 0; k < options.length; k++) {
                                    html.push('<label class="labelRadio" id="Q-' + questions[j].id + "-" + options[k].alisa + '" name="' + questions[j].id + '" onclick="inTheTest.choose(this,\'' + questions[j].id + '\')" for="radio-' + questions[j].id + '-' + k + '">' + options[k].alisa + '</label>');
                                    html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="radio-' + questions[j].id + '-' + k + '" value="' + options[k].alisa + '"/>');
                                }
                                html.push('</div>');
                                html.push(' </div>');

                                // 解析部分开始
                                html.push('<div class="your_key">');
                                html.push(' <span>您的答案 :</span>');
                                html.push('  <p class="your_key_cont">该教师没有树立正确的教师观，需要我们引以为戒</p>');
                                html.push('</div>');
                                html.push('<div class="paper_key">');
                                html.push(' <div class="paper_key_title">');
                                html.push('  <span class="paper_key_confirm" data-id="'+questions[j].id+'" data-type="'+questions[j].qtype+'" ><i></i>确定</span>');
                                html.push('  <span class="paper_key_down"><i></i><span>展开解析</span></span>');
                                html.push(' </div>');
                                html.push(' <div class="paper_key_cont"><ul>');
                                html.push('  <li class="key_cont_key"><span><i></i>参考答案 :</span><p>'+questions[j].qkey+'</p></li>');
                                html.push('  <li class="key_cont_lever"><span><i></i>试题难度 :</span><p>'+questions[j].levelName+'</p></li>');
                                html.push('  <li class="key_cont_analysis"><span><i></i>参考解析 :</span><p>'+(questions[j].qresolve || '暂无') +'</p></li>');
                                html.push(' </ul></div>');
                                html.push('</div>');
                                // 解析部分结束

                            } else if (questions[j].qtype == 2) {
                                html.push(' <div class="two1"> <span class="que_num">' + question_num + '、[ '+questions[j].typeName+' ] </span>' + questions[j].qcontent + '</div>');
                                html.push(' <div class="three1">');
                                var options = questions[j].options;
                                for (var k = 0; k < options.length; k++) {
                                    if(options[k].text)
                                        options[k].text = inTheTest.delP(options[k].text);
                                    html.push('<div>');
                                    html.push(options[k].alisa + "&nbsp;、&nbsp;"+ options[k].text);
                                    html.push('</div>');
                                }
                                html.push(' </div>');
                                html.push(' <div class="four1">');

                                html.push('<div style="margin-left: 20px;">');
                                for (var k = 0; k < options.length; k++) {
                                    html.push('<label class="labelCheckbox" id="Q-' + questions[j].id + "-" + options[k].alisa + '" onclick="inTheTest.chooseMulti(this,\'checkbox-' + questions[j].id + '-' + k + '\')" for="checkbox-' + questions[j].id + '-' + k + '">' + options[k].alisa + '</label>');
                                    html.push('<input class="checkbox qk-mchoice" type="checkbox" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="checkbox-' + questions[j].id + '-' + k + '" value="' + options[k].alisa + '">');

                                }
                                html.push('</div>');

                                html.push(' </div>');

                                // 解析部分开始
                                html.push('<div class="your_key">');
                                html.push(' <span>您的答案 :</span>');
                                html.push('  <p class="your_key_cont">该教师没有树立正确的教师观，需要我们引以为戒</p>');
                                html.push('</div>');
                                html.push('<div class="paper_key">');
                                html.push(' <div class="paper_key_title">');
                                html.push('  <span class="paper_key_confirm" data-id="'+questions[j].id+'" data-type="'+questions[j].qtype+'" ><i></i>确定</span>');
                                html.push('  <span class="paper_key_down"><i></i><span>展开解析</span></span>');
                                html.push(' </div>');
                                html.push(' <div class="paper_key_cont"><ul>');
                                html.push('  <li class="key_cont_key"><span><i></i>参考答案 :</span><p>'+questions[j].qkey+'</p></li>');
                                html.push('  <li class="key_cont_lever"><span><i></i>试题难度 :</span><p>'+questions[j].levelName+'</p></li>');
                                html.push('  <li class="key_cont_analysis"><span><i></i>参考解析 :</span><p>'+(questions[j].qresolve || '暂无') +'</p></li>');
                                html.push(' </ul></div>');
                                html.push('</div>');
                                // 解析部分结束
                            } else if (questions[j].qtype == 3) {
                                html.push(' <div class="two1 ">  <span class="que_num">' + question_num + '、[ '+questions[j].typeName+' ] </span>' + questions[j].qcontent + '</div>');

                                html.push(' <div class="four1">');

                                html.push('<div style="margin-left: 20px;">');

                                html.push('<label class="labelRadio" id="Q-' + questions[j].id + '-Y" name="' + questions[j].id + '" onclick="inTheTest.choose(this,\'' + questions[j].id + '\')" for="radio-' + questions[j].id + '-Y">Y</label>');
                                html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="radio-' + questions[j].id + '-Y" value="Y"/>');
                                html.push('<label class="labelRadio" id="Q-' + questions[j].id + '-N" name="' + questions[j].id + '" onclick="inTheTest.choose(this,\'' + questions[j].id + '\')" for="radio-' + questions[j].id + '-N">N</label>');
                                html.push('<input class="radio qk-choice" type="radio" data-qid="' + questions[j].id + '" name="Q-' + questions[j].id + '" id="radio-' + questions[j].id + '-N" value="N"/>');
                                html.push('</div>');

                                html.push(' </div>');

                                // 解析部分开始
                                html.push('<div class="your_key">');
                                html.push(' <span>您的答案 :</span>');
                                html.push('  <p class="your_key_cont">该教师没有树立正确的教师观，需要我们引以为戒</p>');
                                html.push('</div>');
                                html.push('<div class="paper_key">');
                                html.push(' <div class="paper_key_title">');
                                html.push('  <span class="paper_key_confirm" data-id="'+questions[j].id+'" data-type="'+questions[j].qtype+'" ><i></i>确定</span>');
                                html.push('  <span class="paper_key_down"><i></i><span>展开解析</span></span>');
                                html.push(' </div>');
                                html.push(' <div class="paper_key_cont"><ul>');
                                questions[j].qkey = inTheTest.delP(questions[j].qkey);
                                html.push('  <li class="key_cont_key"><span><i></i>参考答案 :</span><p>'+questions[j].qkey+'</p></li>');
                                html.push('  <li class="key_cont_lever"><span><i></i>试题难度 :</span><p>'+questions[j].levelName+'</p></li>');
                                html.push('  <li class="key_cont_analysis"><span><i></i>参考解析 :</span><p>'+(questions[j].qresolve || '暂无') +'</p></li>');
                                html.push(' </ul></div>');
                                html.push('</div>');
                                // 解析部分结束
                            } else if (questions[j].qtype == 4) {
                                var qcontents = inTheTest.replaceInput(questions[j].qcontent, questions[j].id);
                                html.push(' <div class="two1 width95 min_height200"> ' + question_num + '、['+questions[j].typeName+']' + qcontents + '</div>');

                                // 解析部分开始
                                html.push('<div class="your_key">');
                                html.push(' <span>您的答案 :</span>');
                                html.push('  <p class="your_key_cont">该教师没有树立正确的教师观，需要我们引以为戒</p>');
                                html.push('</div>');
                                html.push('<div class="paper_key">');
                                html.push(' <div class="paper_key_title">');
                                html.push('  <span class="paper_key_confirm" data-id="'+questions[j].id+'" data-type="'+questions[j].qtype+'"><i></i>确定</span>');
                                html.push('  <span class="paper_key_down"><i></i><span>展开解析</span></span>');
                                html.push(' </div>');
                                html.push(' <div class="paper_key_cont"><ul>');
                                questions[j].qkey = inTheTest.delP(questions[j].qkey);
                                html.push('  <li class="key_cont_key"><span><i></i>参考答案 :</span><p>'+questions[j].qkey+'</p></li>');
                                html.push('  <li class="key_cont_lever"><span><i></i>试题难度 :</span><p>'+questions[j].levelName+'</p></li>');
                                html.push('  <li class="key_cont_analysis"><span><i></i>参考解析 :</span><p>'+(questions[j].qresolve || '暂无') +'</p></li>');
                                html.push(' </ul></div>');
                                html.push('</div>');
                                // 解析部分结束

                            } else if (questions[j].qtype == 5) {
                                html.push(' <div class="two1"> <span class="que_num">' + question_num + '、[ '+questions[j].typeName+' ] </span>' + questions[j].qcontent + '</div>');
                                html.push('	<div class="four1">');
                                html.push('  <div style="margin-left: 40px;">');
                                html.push('   <textarea readonly="readonly"  onchange="inTheTest.changeTextArea(this,\'Q-' + questions[j].id + '\')" data-qid="' + questions[j].id + '" class="questionTextArea qk-txt textarea_cont" name="Q-' + questions[j].id + '"></textarea>');

                                html.push('   <div class="q-res">');
                                html.push('    <div class="edit-wrap2">');
                                html.push('      <div contenteditable="true" class="fill-edit txt-field edit-line done-textarea"></div>');

                                html.push('    </div>');
                                html.push('   </div>');

                                html.push('  </div>');
                                html.push(' </div>');

                                // 解析部分开始
                                html.push('<div class="your_key">');
                                html.push(' <span>您的答案 :</span>');
                                html.push('  <p class="your_key_cont">该教师没有树立正确的教师观，需要我们引以为戒</p>');
                                html.push('</div>');
                                html.push('<div class="paper_key">');
                                html.push(' <div class="paper_key_title">');
                                html.push('  <span class="paper_key_confirm" data-id="'+questions[j].id+'" data-type="'+questions[j].qtype+'"><i></i>确定</span>');
                                html.push('  <span class="paper_key_down"><i></i><span>展开解析</span></span>');
                                html.push(' </div>');
                                html.push(' <div class="paper_key_cont"><ul>');
                                questions[j].qkey = inTheTest.delP(questions[j].qkey);
                                html.push('  <li class="key_cont_key"><span><i></i>参考答案 :</span><p>'+questions[j].qkey+'</p></li>');
                                html.push('  <li class="key_cont_lever"><span><i></i>试题难度 :</span><p>'+questions[j].levelName+'</p></li>');
                                html.push('  <li class="key_cont_analysis"><span><i></i>参考解析 :</span><p>'+(questions[j].qresolve || '暂无') +'</p></li>');
                                html.push(' </ul></div>');
                                html.push('</div>');
                                // 解析部分结束
                            } else if (questions[j].qtype == 6) {
                                html.push(' <div class="two1"> <span class="que_num">' + question_num + '、[ '+questions[j].typeName+' ] </span>' + questions[j].qcontent + '</div>');
                                html.push('	<div class="four1">');
                                html.push('  <div style="margin-left: 40px;">');
                                html.push('   <textarea onchange="inTheTest.changeTextArea(this,\'Q-' + questions[j].id + '\')" data-qid="' + questions[j].id + '" class="questionTextArea qk-txt textarea_cont" name="Q-' + questions[j].id + '"></textarea>');

                                html.push('   <div class="q-res">');
                                html.push('    <div class="edit-wrap2">');
                                html.push('      <div contenteditable="true" class="fill-edit txt-field edit-line done-textarea"></div>');

                                html.push('    </div>');
                                html.push('   </div>');

                                html.push('  </div>');
                                html.push(' </div>');

                                // 解析部分开始
                                html.push('<div class="your_key">');
                                html.push(' <span>您的答案 :</span>');
                                html.push('  <p class="your_key_cont">该教师没有树立正确的教师观，需要我们引以为戒</p>');
                                html.push('</div>');
                                html.push('<div class="paper_key">');
                                html.push(' <div class="paper_key_title">');
                                html.push('  <span class="paper_key_confirm" data-id="'+questions[j].id+'" data-type="'+questions[j].qtype+'"><i></i>确定</span>');
                                html.push('  <span class="paper_key_down"><i></i><span>展开解析</span></span>');
                                html.push(' </div>');
                                html.push(' <div class="paper_key_cont"><ul>');
                                questions[j].qkey = inTheTest.delP(questions[j].qkey);
                                html.push('  <li class="key_cont_key"><span><i></i>参考答案 :</span><p>'+questions[j].qkey+'</p></li>');
                                html.push('  <li class="key_cont_lever"><span><i></i>试题难度 :</span><p>'+questions[j].levelName+'</p></li>');
                                html.push('  <li class="key_cont_analysis"><span><i></i>参考解析 :</span><p>'+(questions[j].qresolve || '暂无') +'</p></li>');
                                html.push(' </ul></div>');
                                html.push('</div>');
                                // 解析部分结束
                            }
                            html.push('</div>');
                        }
                        html.push('</div>');
                    }


                    var cardHtml = [];
                    // console.log(questionCounts);
                    // console.log(questionTypes);
                    for (var i = 0; i < questionCounts.length; i++) {

                        cardHtml.push('<span class="notAnswer" data-num="'+i+'" id="QQC-' + questionCounts[i].qid + '" onclick="inTheTest.anchorPosition(\'C-' + questionCounts[i].qid + '\',this)">' + questionCounts[i].qcount + '</span>  ');
                    }
                    $("#txtCount").val(questionCounts.length);
                    $("#questionCard").html(cardHtml.join(""));
                    $("#model_exam").html(html.join(""));

                    //启动翻题函数
                    inTheTest.selectQuestion();
                    // 展开试题解析
                    inTheTest.keyConfirm();
                    //自动加载本地缓存
                    inTheTest.tmLoadUserPaperCache(tm_uid, tm_pid);
                    //统计进度条
                    inTheTest.countProgress();

                    ints = window.setInterval(function () {
                        inTheTest.ShowCountDown();
                    }, interval);
                } else {
                    $(window).unbind('beforeunload');
                    layer.open({
                        title: '系统提示',
                        closeBtn: 1,
                        skin: 'layui-layer-molv',
                        content: '<div style="text-align:center;">' + t.msg + '</div>',
                        yes: function (index, layero) {
                            layer.close(index);
                            window.location.href = "online_test.html";
                        }
                    });

                }

            }
        });
    },
    // 删除p标签
    delP:function(str){
        if(!str)
            return str;
        str = str.replace(/<([\/]?)(p)((:?\s*)(:?[^>]*)(:?\s*))>/g,"");//去掉
        str = str.replace(/&nbsp;/g,"");
        str = str.replace(/\<br\>/g,"");
        return str;
    },
    //加载本地缓存
    tmLoadUserPaperCache: function (uid, pid) {
        var cacheData = tmUserDataCache.getCache(uid, pid);

        if (cacheData == null) {
            return;
        }
        try {
            var cacheJson = JSON.parse(cacheData);
            $.each(cacheJson, function (idx, item) {

                if (item["type"] == "blank") {
                    var is_null = false;
                    $("input[name='" + item["name"] + "']").each(function (ii, iblank) {
                        if(item["value"][ii]){
                            is_null = true;
                        }
                        if(!is_null){
                            return;
                        }
                        $(this).val(item["value"][ii]);
                        var theqid = item["name"].replace("Q-", "");
                        $("#QQC-" + theqid).attr("class", "yesAnswer");
                    });

                } else if (item["type"] == "choice") {
                    var theqid = item["name"].replace("Q-", "");
                    if(item["rect"] == '1'){
                        $("#QQC-" + theqid).attr("class", "nocorrect");
                    }else if(item["rect"] == '2'){
                        $("#QQC-" + theqid).attr("class", "correct");
                    }
                    // $("#QQC-" + theqid).attr("class", "yesAnswer");
                    $("#" + item["name"] + "-" + item["value"].split("")).attr("class", "labelRadio chooseRadio");
                    $("input[name='" + item["name"] + "']").val(item["value"].split(""));

                } else if (item["type"] == "mchoice") {
                    var cho = item["value"].split("");
                    if(cho == ''){
                        return;
                    }
                    var theqid = item["name"].replace("Q-", "");
                    if(item["rect"] == '1'){
                        $("#QQC-" + theqid).attr("class", "nocorrect");
                    }else if(item["rect"] == '2'){
                        $("#QQC-" + theqid).attr("class", "correct");
                    }
                    // $("#QQC-" + theqid).attr("class", "yesAnswer");
                    for (var i = 0; i < cho.length; i++) {
                        $("#" + item["name"] + "-" + cho[i]).attr("class", "labelCheckbox chooseCheckbox");
                    }
                    $("input[name='" + item["name"] + "']").val(item["value"].split(""));

                } else if (item["type"] == "essay") {
                    if(item["value"] == ''){
                        return;
                    }
                    $("textarea[name='" + item["name"] + "']").val(item["value"]);
                    $("textarea[name='" + item["name"] + "']").parents('.four1').find('.fill-edit').html(item["value"]);
                    var theqid = item["name"].replace("Q-", "");
                    $("#QQC-" + theqid).attr("class", "yesAnswer");
                }

            });

        } catch (e) {
            //BROWSER DOESN'T SUPPORTED
        }

    },
    anchorPosition: function (pos,is) {
        page_num = Number($(is).data('num'));
        $('.div2').css({
            'left':-page_num*905
        });
        if(page_num+1 == $('.ask_list').length){
            $('#next_que').addClass('over_paper').html('结束作答');
        }else{
            $('#next_que').removeClass('over_paper').html('下一题<i class="in_bl next_que" ></i>');
        }
        inTheTest.adjustHeight();
        // $('.ask_list').hide();
        // $('#Q'+pos).show();
        // var pos = $("#Q" + pos).offset().top;
        // $("html,body").animate({scrollTop: pos}, 400);
    },
    //我要交卷
    savaQuestions: function () {
        // 耗费时间
        var duration;
        if(leftsecond<=60){
            duration = 1
        }else{
            duration = Math.floor(leftsecond/60)
        }
        $('#hidTimecost').val(duration);
        $(window).unbind('beforeunload');
        layer.open({
            title: '系统提示',
            closeBtn: 1,
            skin: 'layui-layer-molv',
            btn: ['确定', '取消'],
            content: '<div style="text-align:center;">您确定要提交练习？</div>',
            yes: function (index, layero) {
                $.ajax({
                    url: urlpath + '/user/practice/submit.jhtml',
                    type: "post",
                    data: $("form").serialize(),
                    success: function (t) {
                        var success = t.success;
                        if (success) {
                            tmUserDataCache.clearCache();
                            window.location.href = "majorpage.html";
                        } else {
                        }
                    }
                });
            },
            btn2:function(index, layero){
                layer.close(index);
            }
        });
    },
    //替换输入框
    replaceInput: function (qcontent, qid) {
        return qcontent.replace(/\[BlankArea[A-Za-z0-9]+\]/g, '&nbsp;&nbsp;<input type="text" onchange="inTheTest.changeInput(this,\'Q-' + qid + '\')" class="questionInput qk-blank" data-qid="' + qid + '" name="Q-' + qid + '" />&nbsp;&nbsp;');

    },
    //输入框改变值后触发改变答题卡样式
    changeInput: function (lthis, qid) {
        //var cardID = $(lthis).parent().parent().attr("id");
        var inputs = document.getElementsByName(qid);
        var result = "false";
        for (var i = 0; i < inputs.length; i++) {
            var inputValue = inputs[i].value;
            if (inputValue != "") {
                result = "true";
                break;
            }
        }
        var cardID = qid.replace("Q-", "QC-");
        if (result == "true") {
            $("#Q" + cardID).attr("class", "yesAnswer");
        } else {
            $("#Q" + cardID).attr("class", "notAnswer");
        }
        inTheTest.countProgress();
        tmUserPaper.bindQuickTip();
    },
    //输入域改变后改变答题卡样式
    changeTextArea: function (lthis, qid) {
        //var cardID = $(lthis).parent().parent().parent().attr("id");
        var inputs = document.getElementsByName(qid);
        var result = "false";
        for (var i = 0; i < inputs.length; i++) {
            var inputValue = inputs[i].value;
            if (inputValue != "") {
                result = "true";
                break;
            }
        }
        var cardID = qid.replace("Q-", "QC-");
        if (result == "true") {
            $("#Q" + cardID).attr("class", "yesAnswer");
        } else {
            $("#Q" + cardID).attr("class", "notAnswer");
        }
        inTheTest.countProgress();
        tmUserPaper.bindQuickTip();
    },
    //选择单选答案
    choose: function (lthis, id) {
        var radios = document.getElementsByName(id);
        for (var i = 0; i < radios.length; i++) {
            $(radios[i]).removeClass("chooseRadio");
        }
        $(lthis).addClass("chooseRadio");

        // var cardID = $(lthis).parent().parent().parent().attr("id");
        // $("#Q" + cardID).attr("class", "yesAnswer");

        tmUserPaper.bindQuickTip();
    },
    //选择多选答案
    chooseMulti: function (lthis, id) {
        if (document.getElementById(id).checked) {
            $(lthis).removeClass("chooseCheckbox");
        } else {
            $(lthis).addClass("chooseCheckbox");
        }

        // var cardID = $(lthis).parent().parent().parent().attr("id");
        // inTheTest.chooseMultiDel(lthis);

        tmUserPaper.bindQuickTip();
    },
    // 选择多选答案去除选项卡样式
    chooseMultiDel:function(lthis){
        var cardID = $(lthis).parent().parent().parent().attr("id");
        var is_checked = false;
        for(var i=0;i < $(lthis).parent().find('.labelCheckbox').length;i++){
            if($(lthis).parent().find('.labelCheckbox').eq(i).hasClass('chooseCheckbox')){
                is_checked = true;
            }
        }
        if(is_checked){
            $("#Q" + cardID).attr("class","yesAnswer");
        }else{
            $("#Q" + cardID).attr("class","notAnswer")
        }
        inTheTest.countProgress();
    },
    //判断题
    chooseTrueFalse: function (lthis, YN, id) {
        var truefalse = document.getElementsByName(id);
        for (var i = 0; i < truefalse.length; i++) {
            $(truefalse[i]).removeClass("chooseTrueFalse");
        }
        $(lthis).addClass("chooseTrueFalse");
        if (YN == "Y") {
            $("#" + id).val("Y");
        } else {
            $("#" + id).val("N");
        }
        // var cardID = $(lthis).parent().parent().parent().attr("id");
        // $("#Q" + cardID).attr("class", "yesAnswer");
    },
    //获取url参数 传值url中的key
    getQueryString: function (key) {
        var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
        var result = window.location.search.substr(1).match(reg);
        return result ? decodeURIComponent(result[2]) : null;
    },
    //暂停做题
    spanPause: function () {
        window.clearInterval(ints);
        layer.confirm('暂停做题，休息一下！', {
            btn: ['确定'],
            closeBtn: 0,
            title: false
        }, function () {
            ints = window.setInterval(function () {
                inTheTest.ShowCountDown();
            }, interval);
            layer.closeAll('dialog');
        });
    },
    //倒计时
    ShowCountDown: function () {
        var day1 = Math.floor(leftsecond / (60 * 60 * 24));
        var hour = Math.floor((leftsecond - day1 * 24 * 60 * 60) / 3600);
        var minute = Math.floor((leftsecond - day1 * 24 * 60 * 60 - hour * 3600) / 60);
        var second = Math.floor(leftsecond - day1 * 24 * 60 * 60 - hour * 3600 - minute * 60);
        var cc = document.getElementById("spanTime");
        var h = document.getElementById("spanHour");
        var m = document.getElementById("spanMinute");
        var c = document.getElementById("spanSecond");
        if (hour.toString().length == 1) {
            hour = "0" + "" + hour;
        }
        if (minute.toString().length == 1) {
            minute = "0" + "" + minute;
        }
        if (second.toString().length == 1) {
            second = "0" + "" + second;
        }
        h.innerHTML = hour;
        m.innerHTML = minute;
        c.innerHTML = second;

        leftsecond++;
    },
    // 上一题和下一题
    selectQuestion:function(){
        var total_num = $('.ask_list').length;
        if(total_num < 2){
            $('#next_que').addClass('over_paper').html('结束作答');
            return;
        }
        // 上一题
        $('#pre_que').off('click').on('click',function(){
            if(page_num >= 1){
                page_num--;
                $('#next_que').removeClass('over_paper').html('下一题<i class="in_bl next_que" ></i>');
            }else{
                return;
            }
            //滑动模式
            $('.div2').animate({
                'left':-page_num*905
            });
            inTheTest.adjustHeight();
        });
        // 下一题
         $('#next_que').off('click').on('click',function(){
             inTheTest.selectNextQuestion('1');
         });
    },
    // 下一题
    selectNextQuestion:function(next){
        var total_num = $('.ask_list').length;
        if(page_num < total_num-1){
            page_num++;
            if(page_num == total_num-1){
                $('#next_que').addClass('over_paper').html('结束作答');
            }
        }else{
            if(next == '1'){
                $('#over_paper').trigger('click');
            }
            return;
        }
        //滑动模式
        $('.div2').animate({
            'left':-page_num*905
        });
        inTheTest.adjustHeight();
    },
    // 鼠标移动到设置显示下拉菜单
    setHover:function(){
        $(".set_set").hover(function() {
            $('.down_menu').slideDown();
        }, function() {
            $('.down_menu').stop(true,false).slideUp();
        });
    },
    // 鼠标单机设置显示下拉菜单
    setClick:function(){
        $('.set_set .down_menu div').off('click').on('click',function(){
            $(this).find('input').prop("checked","true");
            answer_mode = $('input[name=set_paper]:checked').data('id');
        });
    },
    // 确定答案
    keyConfirm:function(){
        var new_que_id;
        // 显示展开答案按钮
        $('.paper_key_confirm').off('click').on('click',function(){
            var this_qus_id = $(this).data('id');
            var this_qus_type = $(this).data('type');
            if(this_qus_type == '1'){
                // 获取单选的答案
                var your_key_cont = $('#QC-'+this_qus_id).find('.four1').find('input[type=radio]:checked').val();
                if(!your_key_cont)
                    your_key_cont = '您没有选择任意选项';

                // 判断答题模式
                decideAnswerMode(your_key_cont,this_qus_id);

            }else if(this_qus_type == '2'){
                // 获取多选的答案
                var checkbox_key = $('#QC-'+this_qus_id).find('.four1').find('input[type=checkbox]');
                var your_key_cont = '';
                for(var i = 0 ; i< checkbox_key.length;i++){
                    if(checkbox_key.eq(i).attr('checked')){
                        your_key_cont += checkbox_key.eq(i).val();
                    }
                }
                if(!your_key_cont)
                    your_key_cont = '您没有选择任意选项';

                // 判断答题模式
                decideAnswerMode(your_key_cont,this_qus_id);

            }else if(this_qus_type == '3'){
                // 获取单选的答案
                var your_key_cont = $('#QC-'+this_qus_id).find('.four1').find('input[type=radio]:checked').val();
                if(!your_key_cont)
                    your_key_cont = '您没有选择任意选项';

                your_key_cont = inTheTest.delP(your_key_cont);
                // 判断答题模式
                decideAnswerMode(your_key_cont,this_qus_id);
            }else if(this_qus_type == '4'){
                var this_input_text = $(this).parents('.ask_list').find('.two1').find('input');
                var this_input_arr = false;
                $.each( this_input_text, function (idx, item) {
                    if($(this).val()){
                        this_input_arr = true;
                    }
                });
                if(this_input_arr){
                    this_input_text.prop('readonly','readonly');
                }
                decideAnswerMode2(this_qus_id);
            }else{
                if($(this).parents('.ask_list').find('.questionTextArea').val()){
                    $(this).parents('.ask_list').find('.fill-edit').removeAttr('contenteditable').css('borderColor','#dcdcdc');
                }
                decideAnswerMode2(this_qus_id);
            }
            // $(this).hide();
            $(this).next('.paper_key_down').show();

            // 统计进度条
            inTheTest.countProgress();
        });
        //隐藏选题显示自己的答案（只用于单选、多选和判断）
        function showYourKey(key,id){
            if(key != '您没有选择任意选项'){
                $('#QC-'+id).find('.four1').hide();
            }
            $('#QC-'+id).find('.your_key_cont').html(key);
            $('#QC-'+id).find('.your_key').show();
        }
        // 判断自己的答案与正确答案是否相同
        function decideKey(key,id,aotutype){
            if(key == '正确'){
                key = 'Y';
            }else if(key == '错误'){
                key = 'N';
            }
            var correct_key = $('#QC-'+id).find('.key_cont_key>p').html();
            if(correct_key == '正确'){
                correct_key = 'Y';
            }else if(correct_key == '错误'){
                correct_key = 'N';
            }
            if(key == correct_key){
                if(aotutype != "1"){
                    inTheTest.selectNextQuestion('0');
                }
                $('#QQC-'+id).attr('class','correct');
                $('#QC-'+id).find('.your_key').css('color','#62c68b');
            }else{
                $('#QQC-'+id).attr('class','nocorrect');
                if($('#QC-'+id).find('.paper_key_cont').css('display') == 'none'){
                    $('#QC-'+id).find('.paper_key_down').trigger('click');
                }
                if(aotutype == "2"){
                    inTheTest.selectNextQuestion('0');
                }
            }
            if(aotutype == "1"){
                if($('#QC-'+id).find('.paper_key_cont').css('display') == 'none'){
                    $('#QC-'+id).find('.paper_key_down').trigger('click');
                }
            }
        };

        //判断答题模式（客观题）
        function decideAnswerMode(your_key_cont,this_qus_id){
            if(answer_mode == "1"){
                showYourKey(your_key_cont,this_qus_id);
                decideKey(your_key_cont,this_qus_id,'1');
            }else if(answer_mode == "2"){
                showYourKey(your_key_cont,this_qus_id);
                decideKey(your_key_cont,this_qus_id,'2');
            }else if(answer_mode == "3"){
                showYourKey(your_key_cont,this_qus_id);
                // 判断自己的答案与正确答案是否相同
                decideKey(your_key_cont,this_qus_id);
            }else if(answer_mode == "4"){
                showYourKey(your_key_cont,this_qus_id);
            }
        }
        //判断答题模式（主观题）
        function decideAnswerMode2(this_qus_id){
            if(answer_mode == "1"){
                if($('#QC-'+this_qus_id).find('.paper_key_cont').css('display') == 'none') {
                    $('#QC-' + this_qus_id).find('.paper_key_down').trigger('click');
                }
            }else if(answer_mode == "2"){
                $('#next_que').trigger('click');
            }
        }
        // 展开和折叠答案
        $('.paper_key_down').off('click').on('click',function(){
            if($(this).parents('.paper_key').find('.paper_key_cont').css('display') == 'none'){
                $(this).parents('.paper_key').find('.paper_key_cont').slideDown();
                $(this).find('span').html('收起解析');
                $(this).parents('.paper_key').find('.paper_key_cont').css('display','block');
            }else{
                $(this).parents('.paper_key').find('.paper_key_cont').slideUp();
                $(this).find('span').html('展开解析');
                $(this).parents('.paper_key').find('.paper_key_cont').css('display','none');
            }
            inTheTest.adjustHeightAuto();
        });

        inTheTest.seeKey();
    },
    // 查看答案
    seeKey:function(){
        $('#show_key').off('click').on('click',function(){
            // $('.ask_list').eq(page_num).find('.paper_key_confirm').hide();
            $('.ask_list').eq(page_num).find('.paper_key_down').show().trigger('click');
        });
    },
    // 统计进度条
    countProgress:function(){
        var had_que   = $('.yesAnswer').length;
        var rect_que   = $('.correct').length;
        var norect_que   = $('.nocorrect').length;
        var total_que = $('.ask_list').length;
        had_que = had_que + rect_que + norect_que;
        var per_num   = (had_que/total_que)*100;
        per_num = parseFloat(per_num.toFixed(2));
        $('.progress_num em').html('已完成'+had_que+'题');
        $('.progress_bar p').css('width',per_num+'%')
    },
    //调整容器高度
    adjustHeight:function(){
        var now_height = $('.ask_list').eq(page_num).height()+10;
        $('#model_exam').css('height',now_height);
    },
    //恢复容器高度
    adjustHeightAuto:function(){
        $('#model_exam').css('height','auto');
    }

};

$(window).bind('beforeunload', function () {
    return '您输入的内容尚未保存，确定离开此页面吗？';
});
// $(window).bind('unload', function () {
//     alert('buqu')
// });
var tm_pid = "1";
var tm_uid = "2";
var tmUserPaper = {
    bindQuickTip: function () {
        //单选题题绑定
        $(".qk-choice").off('click').on('click',function () {
            var thename = $(this).attr("name");
            var theqid = $(this).data("qid");
            var chval = "";
            $.each($('input[name=' + thename + ']:checked'), function (idx, item) {
                chval += $(this).val();
            });
            var is_key =chval;
            if(is_key == 'Y'){
                is_key = '正确';
            }else if(is_key == 'N'){
                is_key = '错误';
            }
            var rect_key = $(this).parents('.ask_list').find('.key_cont_key p').html();
            if(rect_key == 'Y'){
                rect_key = '正确';
            }else if(rect_key == 'N'){
                rect_key = '错误';
            }
            var _rect = '0';
            if(rect_key == is_key){
                _rect = "2";
            }else{
                _rect = "1";
            }
            //增加到本地缓存
            tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "choice", chval , _rect);
        });
        //多选题题绑定
        $(".qk-mchoice").click(function () {
            var thename = $(this).attr("name");
            var theqid = $(this).data("qid");
            var chval = "";
            $.each($('input[name=' + thename + ']:checked'), function (idx, item) {
                chval += $(this).val();
            });
            var rect_key = $(this).parents('.ask_list').find('.key_cont_key p').html();
            var _rect = '0';
            if(rect_key == chval){
                _rect = "2";
            }else{
                _rect = "1";
            }
            //增加到本地缓存
            tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "mchoice", chval ,_rect);
        });
        //填空题绑定
        $(".qk-blank").blur(function () {
            var thename = $(this).attr("name");
            var theqid = $(this).data("qid");
            var charrval = [];
            $.each($('input[name=' + thename + ']'), function (idx, item) {
                charrval.push($(this).val());
            });
            //增加到本地缓存
            tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "blank", charrval);
        });
        //问答题绑定
        $(".qk-txt").blur(function () {
            var thename = $(this).attr("name");
            var theqid = $(this).data("qid");
            var chval = $(this).val();

            //增加到本地缓存
            tmUserDataCache.addCache(tm_uid, tm_pid, theqid, "essay", chval);

        });
    }
};
//本地缓存操作
var tmUserDataCache = {
    support: function () {
        try {
            if (window.localStorage) {
                return true;
            } else {
                return false;
            }
        } catch (e) {
            return false;
        }

    },
    addCache: function (uid, pid, qid, qtype, val, rect) {

        if (!tmUserDataCache.support()) {
            return;
        }

        var cacheData = tmUserDataCache.getCache(uid, pid);
        var cacheKey = "C" + topic + topicname;
        var cacheJson = [];
        try {
            if (cacheData != null) {
                cacheJson = JSON.parse(cacheData);
            }
            $(cacheJson).each(function (idx, item) {
                var _name = "Q-" + qid;
                if (_name == item["name"]) {
                    cacheJson.splice(idx, 1);
                }
            });
            cacheJson.push({"name": "Q-" + qid, "type": qtype, "value": val, 'rect': rect});

            var strCacheData = JSON.stringify(cacheJson);
            localStorage.setItem(cacheKey, strCacheData);

        } catch (e) {
            //BROWSER DOESN'T SUPPORTED
        }

    },
    getCache: function (uid, pid) {
        if (!tmUserDataCache.support()) {
            return;
        }
        var cacheKey = "C" + topic + topicname;
        return localStorage.getItem(cacheKey);
    },
    clearCache:function(){
        var keyName = "C" + topic + topicname;
        window.localStorage.removeItem(keyName);
    }
};
