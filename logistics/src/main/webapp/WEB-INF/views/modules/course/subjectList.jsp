<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css">
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/teacher/css/subjectList.css${v}"/>

</head>
    <body>
        <ul class="nav nav-tabs" style="margin-top:20px;">
            <li class="active"><a href="${ctx}/course/subj/toList.jhtml">科目管理</a></li>
        </ul>
        <div id="cont">

            <div class="cont_fl">
                <ul class="dash_line dash_pos ml19" id="onecontainer">
                    <%--<li>--%>
                        <%--<div class="one_title">--%>
                            <%--<em class="bg title_radio1"></em><span>数学</span><i class="glyphicon glyphicon-pencil"></i><i class=" 	glyphicon glyphicon-trash"></i>--%>
                        <%--</div>--%>
                        <%--<ul class="dash_line dash_pos ml19">--%>
                            <%--<li>--%>
                                <%--<div class="one_title">--%>
                                    <%--<em class="bg title_radio1"></em><span>数学</span>--%>
                                <%--</div>--%>
                            <%--</li>--%>
                        <%--</ul>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<div class="one_title">--%>
                            <%--<em class="bg title_radio1"></em><span>数学</span>--%>
                        <%--</div>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<div class="one_title">--%>
                            <%--<em class="bg title_radio1"></em><span>数学</span>--%>
                        <%--</div>--%>
                    <%--</li>--%>
                </ul>
                <div class="addbtn">
                    <a class="btn btn-primary" href="javascript:void(0);">添加</a>
                </div>
            </div>
            <div class="cont_fr hide">
                <form class="form-horizontal">
                    <div class="form-group has_hide">
                        <label for="" class="col-sm-2 control-label">父级 :</label>
                        <div class="col-sm-4 has-feedback">
                            <select name="parentId" class="form-control">

                                <%--<option value="2">首席讲师</option>--%>
                            </select>
                            <span class="errhas">*</span>
                        </div>
                    </div>
                    <hr class="has_hide">
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">名称 :</label>
                        <div class="col-sm-4 has-feedback hasinput">
                            <input type="text" class="form-control" id="inputEmail3" name="subjectName">
                            <span class="errhas">*</span>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">排序 :</label>
                        <div class="col-sm-2 has-feedback hasinput">
                            <input type="text" class="form-control" id="" name="sort">
                            <span class="errhas">*</span>
                        </div>
                    </div>
                    <hr>

                </form>
                <div class="mt20">
                    <div class="col-sm-offset-2 col-sm-10" style="padding-left:7px;">
                        <button id="save" class="btn btn-primary" data-id="">保存</button>
                        <button id="qx" class="btn btn-warning">取消</button>
                    </div>
                </div>
            </div>
            <input type="hidden" name="isid" value="0">
        </div>
        <script id="model" type="text/template">
            <li>
                <div class="one_title one sel_bg" id="sub-{{subjectId}}" data-id="{{subjectId}}" data-sort="{{sort}}">
                    <em class="bg title_radio1" onclick="toggerClick(this);"></em><span>{{subjectName}}</span><i class="glyphicon glyphicon-pencil" onclick="resetData(this,{{parentId}});"></i><i class="glyphicon glyphicon-trash" onclick="del(this)"></i><i class="issort">&nbsp;[排序:{{sort}}]</i>
                </div>
                <ul class="dash_line dash_pos ml19">
                </ul>
            </li>
        </script>
        <script id="model_2" type="text/template">
            <li>
                <div class="one_title" id="sub-{{subjectId}}" data-id="{{subjectId}}" data-sort="{{sort}}">
                    <em class="bg title_dash" onclick="toggerClick(this);"></em><span>{{subjectName}}</span><i class="glyphicon glyphicon-pencil" onclick="resetData(this,{{parentId}});"></i><i class="glyphicon glyphicon-trash" onclick="del(this)"></i><i class="issort">&nbsp;[排序:{{sort}}]</i>
                </div>
            </li>
        </script>
        <script id="model_3" type="text/template">
            <option value="{{subjectId}}">{{subjectName}}</option>
        </script>
        <script>
            $(function(){
                var subTree = function(){
                    var that = this;
                    this.onecontainer = $('#onecontainer');  //第一层容器
                    this.model        = $('#model').html();   //第一层末班
                    this.model2        = $('#model_2').html();   //第二层末班
                    this.model3        = $('#model_3').html();   //选项末班

                    this.cont_fr       = $('.cont_fr');   //右侧内容容器

                    this.savebtn  = $('#save');  //保存按钮
                    this.qxbtn    = $('#qx');     //取消按钮
                    this.addbtn   = $('.addbtn a');  // 添加按钮
                    this.input    = $('.hasinput');

                    //初始化树
                    this.loadTree = function(){
                        $.ajax({
                            'url':'${ctx}/course/subj/list.jhtml',
                            'type':'get',
                            'dataType': "json",
                            success:function(ret){
//                                console.log(ret.data);
                                var datas = ret.data;
                                var domString;
                                var selhtml='<option value="0"></option>';
                                for(var i in datas){
                                    var dictionary = datas[i];
                                    if(dictionary.parentId == '0'){
                                        domString = that.comPile(that.model,dictionary);
                                        that.onecontainer.append(domString);

                                        that.chirldData(ret.data,dictionary.subjectId);

                                        selhtml += that.comPile(that.model3,dictionary);

                                    }
                                }
                                $('select[name = parentId]').html(selhtml);
                            }
                        })
                    };

                    this.chirldData = function(obj,pid){
                        var datas = obj;
                        for(var i in datas){
                            var dictionary = datas[i];
                            if(dictionary.parentId == pid){
                                $('#sub-'+pid).data('bj','1');
                                domString = that.comPile(that.model2,dictionary);
                                $('#sub-'+pid).next('ul').append(domString);
                            }
                        }

                        that.title_one = $('.sel_bg');
                        that.title_one.find('span').off('click').on('click',that.selId);
                    };

                    toggerClick = function(is){
                        var is_next = $(is).parent('.one_title').next('ul');
                        if(!is_next){
                            return;
                        }
                        if(is_next.css('display') == 'none'){
                            is_next.slideDown();
                            $(is).removeClass('title_radio2').addClass('title_radio1');
                        }else{
                            is_next.slideUp();
                            $(is).removeClass('title_radio1').addClass('title_radio2');
                        }
                    };

                    //选中当前层数id
                    this.selId = function(){
                        var isid = $(this).parent('.one_title').data('id');
                        $('input[name = isid]').val(isid);
                        that.title_one.find('span').removeClass('bg_color1');
                        $(this).addClass('bg_color1');


                    }
                    //添加数据
                    this.addData = function(){
                        if(!$('input[name = subjectName]').val()){
                            $('input[name = subjectName]').parent('div').addClass('has-error');
                            return;
                        }
                        if(!$('input[name = sort]').val()){
                            $('input[name = sort]').parent('div').addClass('has-error');
                            return;
                        }
                        var isid = $(this).data('id');
                        if(isid){
                            if($('#sub-'+isid).data('bj') == '1' && $('select[name=parentId]').val() !="0"){
                                layer.msg(
                                        '科目结构最多有两层',
                                        {
                                            anim:4,
                                            time:3000
                                        }
                                );
                                return;
                            }
                            that.resetAjax(isid);
                        }else{
                            that.addAjax();
                        }

                    };
                    this.addAjax = function(){
                        $.ajax({
                            'url':'${ctx}/course/subj/create.jhtml',
                            'type':'post',
                            'dataType': "json",
                            'data':{
                                'sort':$('input[name = sort]').val(),
                                'subjectName':$('input[name = subjectName]').val(),
                                'parentId':$('select[name=parentId]').val()
                            },
                            success:function(ret){
                                console.log(ret);
                                if(ret.success){
                                    that.onecontainer.html('');
                                    that.cont_fr.addClass('hide');
                                    that.loadTree();
                                    $('input[name=isid]').val('0');
                                    layer.msg(
                                            '添加成功',
                                            {
                                                anim:4,
                                                time:3000
                                            }
                                    );
                                }
                            }
                        })
                    }
                    this.resetAjax = function(id){
                        var myid = id;
                        $.ajax({
                            'url':'${ctx}/course/subj/updatename.jhtml',
                            'type':'post',
                            'dataType': "json",
                            'data':{
                                'subjectName':$('input[name = subjectName]').val(),
                                'subjectId':myid
                            },
                            success:function(ret){
                                if(ret.success){
                                    that.resetAjaxSort(myid)
                                }
                            }
                        })
                    }
                    this.resetAjaxSort = function(id){
                        var myid = id;
                        $.ajax({
                            'url':'${ctx}/course/subj/updatesort.jhtml',
                            'type':'post',
                            'dataType': "json",
                            'data':{
                                'sort':$('input[name = sort]').val(),
                                'subjectId':myid
                            },
                            success:function(ret){
                                if(ret.success){
                                    that.resetAjaxParent(myid);
                                }
                            }
                        })
                    }
                    this.resetAjaxParent = function(id){
                        $.ajax({
                            'url':'${ctx}/course/subj/'+$('select[name=parentId]').val()+'/'+id+'/updatepid.jhtml',
                            'type':'post',
                            'dataType': "json",
                            success:function(ret){
                                console.log(ret);
                                if(ret.success){
                                    that.onecontainer.html('');
                                    that.loadTree();
                                    that.cont_fr.addClass('hide');
                                    layer.msg(
                                            '修改成功',
                                            {
                                                anim:4,
                                                time:3000
                                            }
                                    );
                                }
                            }
                        })
                    }

                    //删除数据
                    del = function(is){
                        var isid = $(is).parent('div').data('id');
                        layer.msg('您确定要删除此条信息么？', {
                            time: 0, //不自动关闭
                            btn: ['必须啊', '取消吧'],
                            yes: function(index){
//                                layer.close(index);
                                $.ajax({
                                    'url':'${ctx}/course/subj/'+isid+'/delete.jhtml',
                                    'type':'post',
                                    'dataType': "json",
                                    success:function(ret){
                                        if(ret.success){
                                            that.onecontainer.html('');
                                            that.loadTree();
                                            that.cont_fr.addClass('hide');
                                            layer.msg(
                                                    '删除成功',
                                                    {
                                                        anim:4,
                                                        time:3000
                                                    }
                                            );
                                        }

                                    }
                                })
                            }
                        });

                    }
                    //修改数据
                    resetData = function(is,pid){
                        var isname = $(is).parent('.one_title').find('span').html();
                        var isid   = $(is).parent('.one_title').data('id');
                        var sort   = $(is).parent('.one_title').data('sort');
                        $('input[name = subjectName]').val(isname);
                        $('input[name = sort]').val(sort);
                        that.savebtn.data('id',isid);
                        $('select[name=parentId]').val(pid);
                        that.cont_fr.removeClass('hide');

                    }

                    this.addClick = function(){
                        $('input[name = subjectName]').val('');
                        $('input[name = sort]').val('');
                        that.savebtn.data('id','');
                        $('select[name=parentId]').val($('input[name=isid]').val());
                        that.cont_fr.removeClass('hide');
                    }

                    this.inputFocus = function(){
                        $(this).parent('div').removeClass('has-error');
                    }

                    //取消添加
                    this.qxClick = function(){
                        that.cont_fr.addClass('hide');
                    }

                    //数据正则匹配方法
                    this.comPile = function(templateString , dictionary){
                        return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                            return dictionary[$1];
                        });
                    }

                    this.init = function(){
                        this.loadTree();
                        this.savebtn.off('click').on('click',this.addData);
                        this.input.find('input').off('focus').on('focus',this.inputFocus);
                        this.addbtn.off('click').on('click',this.addClick);
                        this.qxbtn.off('click').on('click',this.qxClick);
                    }
                }

                var subtree = new subTree;
                subtree.init();
            })
        </script>
    </body>
</html>