<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
    <script src="${ctxStatic}/common/ywork.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css">
    <script src="${ctxStatic}/ckeditor/ckeditor.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/teacher/css/teacherAdd.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/teacher/css/istree.css${v}"/>
</head>
<body>
<div id="cont">
    <ul class="nav nav-tabs">
        <li><a href="${ctx}/teacher/toList.jhtml">教师列表</a></li>
        <li class="active"><a href="${ctx}/teacher/toAdd.jhtml">教师添加</a></li>
    </ul>
    <form class="form-horizontal">
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">姓名 :</label>
            <div class="col-sm-3 has-feedback">
                <input type="text" class="form-control hastext" id="inputEmail3" name="name">
                <span class="errhas">*</span>
            </div>
        </div>
        <hr>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">专业 :</label>
            <div class="col-sm-2 has-feedback">
                <input type="hidden" class="form-control"  name="subjectId">
                <input type="text" class="form-control hastext"  name="subjectName" readonly="readonly" onclick="selsub(event.this);" style="background: #fff;">
                <span class="errhas">*</span>
            </div>
        </div>
        <hr>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">头衔 :</label>
            <div class="col-sm-4 has-feedback">
                <%--<input type="text" class="form-control" id="inputPassword3" name="isStar">--%>
                    <select name="isStar" class="form-control">
                        <option value="1">高级讲师</option>
                        <option value="2">首席讲师</option>
                    </select>
                <span class="errhas">*</span>
            </div>
        </div>
        <hr>

        <div class="form-group">
            <label for="" class="col-sm-2 control-label">资历 :</label>
            <div class="col-sm-9 has-feedback">
                <textarea id="education" class="form-control hastext" name="education"></textarea>
                <span class="errhas">*</span>
            </div>
        </div>
        <hr>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">头像 :</label>
            <div class="col-sm-8 has-feedback pics">
                <%--<input type="file" class="form-control" style="border:none;"  name="file">--%>
                <input type="hidden" id="logo" path="logo" htmlEscape="false" maxlength="200" class="input-xlarge"/>
                <sys:ckfinder input="logo" type="images" uploadPath="/course" selectMultiple="false"/>
                <font color="red">(请上传 100*100(长X宽)像素 的图片)</font>
            </div>
        </div>
        <hr>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">简介 :</label>
            <div class="col-sm-9 has-feedback">
                <script type="text/plain" id="context_script">${course.context}</script>
                <textarea rows="4"  id="context" name="career" class="input-xxlarge  required">${course.context}</textarea>
                <sys:ckeditor replace="context" uploadPath="/course" height="100"/>
            </div>
        </div>
        <hr>

        <!-- <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <div class="checkbox">
                    <label>
                        <input type="checkbox"> Remember me
                    </label>
                </div>
            </div>
        </div> -->
        <div class="form-group">
            <label for="" class="col-sm-2 control-label">排序 :</label>
            <div class="col-sm-2 has-feedback">
                <input type="number" class="form-control hastext" id="" name="sort">
                <span class="errhas">*</span>
            </div>
        </div>
        <hr>

        <%--<button id="sub_btn" type="submit" class="hide">提交</button>--%>
    </form>

    <div class="mt20">
        <div class="col-sm-offset-2 col-sm-10">
            <button id="save" class="btn btn-primary">保存</button>
            <button class="btn btn-warning" onclick="history.go(-1)">返回</button>

        </div>
    </div>
</div>

<div id="istree">
    <div class="istree">
        <ul class="dash_line dash_pos ml19" id="onecontainer">

        </ul>
    </div>
</div>
<script id="model" type="text/template">
    <li>
        <div class="one_title one sel_bg" id="sub-{{subjectId}}" data-id="{{subjectId}}" data-name="{{subjectName}}">
            <em class="bg title_radio1" onclick="toggerClick(this);"></em><span>{{subjectName}}</span>
        </div>
        <ul class="dash_line dash_pos ml19">
        </ul>
    </li>
</script>
<script id="model_2" type="text/template">
    <li>
        <div class="one_title" id="sub-{{subjectId}}" data-id="{{subjectId}}" data-name="{{subjectName}}">
            <em class="bg title_dash" onclick="toggerClick(this);"></em><span>{{subjectName}}</span>
        </div>
    </li>
</script>
<script src="${ctxStatic}/hsun/front/js/pagejs/talkView/jquery.slimscroll.min.js${v}" type="text/javascript"></script>
<script>
    $(function(){
        //输入框获取焦点
        $('.form-group .hastext').each(function(){
            $(this).focus(function(){
                $(this).parent('div').removeClass('has-error');
            });
//            $(this).blur(function(){
//                if(!$(this).val()){
//                    $(this).parent('div').addClass('has-error');
//                }
//            });
        });
        //编辑器获取焦点
        contextCkeditor.on( 'focus', function( e ) {
            $('#cke_context').css('borderColor','#D3D3D3');
        } );

        //点击保存
        $('#save').off('click').on('click',function(){
            var bj = true;
            var ch = /[a-zA-Z0-9_][\u4e00-\u9fa5]/ ;
            var inps = $('.form-group .hastext');
            inps.each(function(index){
                if(!$(this).val()){
                    bj = false;
                    $(this).parent('div').addClass('has-error');
                }
            });

            if(!contextCkeditor.getData().replace(ch)) {
                $('#cke_context').css('borderColor','#a94442');
                return;
            }

            if(bj){
                $.ajax({
                    'url':'${ctx}/teacher/add.jhtml',
                    'type':'post',
                    'dataType': "json",
                    'data':{
                        'name':$('input[name = name]').val(),
                        'education':$('textarea[name = education]').val(),
                        'career':contextCkeditor.getData(),
                        'isStar':$('select[name = isStar]').val(),
                        'picPath':$('#logo').val(),
                        'sort':$('input[name = sort]').val(),
                        'subjectId':$('input[name = subjectId]').val()
                    },
                    success:function(ret){
                        if(ret.success){
                            layer.msg(
                                    '修改成功',
                                    {
                                        anim:4,
                                        time:3000
                                    }
                            );
                            window.location.href = "${ctx}/teacher/toList.jhtml"
                        }else{
                            layer.msg(
                                    '保存失败',
                                    {
                                        anim:4,
                                        time:3000
                                    }
                            );
                        }

                    }
                });
            }
        });

        //加载专业树
        var isTree = function(){
            var that = this;
            this.onecontainer = $('#onecontainer');  //第一层容器
            this.model        = $('#model').html();   //第一层末班
            this.model2        = $('#model_2').html();   //第二层末班
            //初始化树
            this.loadTree = function(){
                $.ajax({
                    'url':'${ctx}/course/subj/list.jhtml',
                    'type':'get',
                    'dataType': "json",
                    success:function(ret){
//                        console.log(ret.data);
                        var datas = ret.data;
                        var domString;

                        for(var i in datas){
                            var dictionary = datas[i];
                            if(dictionary.parentId == '0'){
                                domString = that.comPile(that.model,dictionary);
                                that.onecontainer.append(domString);

                                that.chirldData(ret.data,dictionary.subjectId);



                            }
                        }

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

                that.title_one = $('.one_title');
                that.title_one.find('span').off('click').on('click',that.selId);

                $(".istree").slimScroll({
                    color:'#E4E4E4'
                });
                that.posTree();
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
                var isname = $(this).parent('.one_title').data('name');
                $('input[name = subjectId]').val(isid);
                $('input[name = subjectName]').val(isname);
                $('#istree').hide();
            }

            //位置
            this.posTree = function(){
                var isY = $('input[name = subjectName]').offset().top + $('input[name = subjectName]').outerHeight();
                var isX = $('input[name = subjectName]').offset().left;
                $('#istree').css({'top':isY,'left':isX});
            };

            selsub = function(e,is){
                $('#istree').show();
            }
            //数据正则匹配方法
            this.comPile = function(templateString , dictionary){
                return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                    return dictionary[$1];
                });
            }

            this.init = function(){
                this.loadTree();
            }
        }
        var istree = new isTree;
        istree.init();

    });
</script>
</body>
</html>