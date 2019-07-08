<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/css/organization/mytree.css">
    <link rel="stylesheet" href="${ctxStatic}/hsun/front/css/organization/base.css">
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
    <style>
        @media (min-width: 768px){
            .container {
                 width: 100%;
            }
        }
        /*左一 begin*/
        .one_title{
            cursor: pointer;
        }
        .glyphicon{
            font-size: 12px;
            color: #888;
            padding-right: 5px;
        }
        .part_user{
            border-right:1px solid #eee;
            border-left:1px solid #eee;
        }

        .user_list li{
            height:30px;
            line-height: 30px;
            padding-left:18px;
        }
        .user_list .pointer{
            cursor: pointer;
        }
        .user_list li:hover{
            background: #DFF0D8
        }

        .user_list .nodata{
            min-height: 100px;
        }
        #seled_user, #seled_user .glyphicon{
            color: #449d44;
        }
        #seled_user .color_red{
            color: #d9534f;
        }

        .compony_name{
            height: 36px;
            line-height: 36px;
            font-size: 15px;
            background-color: #5bc0de;
            border-radius: 3px;
            margin-bottom: 10px;
        }
        .compony_name .glyphicon{
            color: #F5F7FF;
            font-size: 12px;
        }
        .compony_name em{
            font-style: normal;
            color: #F5F7FF;
        }

        em.sel_click{
            cursor: pointer;
        }
        /*左一 over*/
        .togger_click{
            right:0;
            color: #fff;
        }
    </style>
</head>
<body id="body">
    <div id="container" class="container">
        <div class="row">
            <div class="col-md-4 col-sm-4 part">
                <ul class="dash_line dash_pos tree_container" id="onecontainer">

                </ul>
            </div>
            <div class="col-md-4 col-sm-4 part_user">
                <div class="compony_name">
                    <span class="glyphicon glyphicon-triangle-bottom pl15"></span>
                    <em>当前待选人员</em>
                </div>
                <ul id="sel_user_container" class="user_list">

                </ul>
            </div>
            <div class="col-md-4 col-sm-4 part_seled">
                <div class="compony_name">
                    <span class="glyphicon glyphicon-triangle-bottom pl15"></span>
                    <em>当前角色已选人员</em>
                </div>
                <ul id="seled_user" class="user_list">

                </ul>
            </div>
        </div>
    </div>
    <script id="model_0" type="text/template">
        <li>
            <div class="compony_name" id="sub-{{id}}" data-id="{{id}}">
                <span class="glyphicon glyphicon-triangle-bottom pl15"></span>
                <em class="sel_click" onclick="partUser(this,'{{id}}','1')">{{name}}</em>
            </div>
            <ul class="dash_line dash_pos">
            </ul>
        </li>
    </script>
    <script id="model_2" type="text/template">
        <li>
            <i class="togger_click glyphicon glyphicon-menu-down {{hide}}"></i>
            <div class="one_title" id="sub-{{id}}" data-id="{{id}}"  onclick="partUser(this,'{{id}}')">
                <em class="bg"></em><span class="sel_click"><i class="sel select"></i><span>{{name}}</span></span>
            </div>
            <ul class="dash_line dash_pos ml19">
            </ul>
        </li>
    </script>

    <script src="${ctxStatic}/jquery/jquery-1.11.1.min.js"></script>
    <script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
    <script>
//        $(function(){
            var roleAllot = function(){
                var that = this;

                this.onecontainer = $('#onecontainer');  //部门容器
                this.sel_user_container = $('#sel_user_container');  //选中部门人员列表容器
                this.seled_user = $('#seled_user');  //选中部门已分配人员列容器

                this.model2        = $('#model_2').html();   //第二层末班
                this.model0        = $('#model_0').html();   //第0层末班

                this.partId;   //承载选择的部门id
                this.seledUsers =[]; //承载以分配人员列表

                //初始部门
                this.loadPart = function(){
                    $.ajax({
                        'url':urlpath_a+'/sys/office/listOffices4Manager.jhtml',
                        'type':'get',
                        'dataType': "json",
                        success:function(ret){
                            //console.log(ret);
                            var datas = ret.data;
                            var domString;
                            if(!ret.success){
                                return;
                            }
                            that.onecontainer.html('');

                            var companydata = ret.company;
                            var companyString = that.comPile(that.model0,companydata);
                            that.onecontainer.append(companyString);

                            for(var i in datas){
                                var dictionary = datas[i];
                                if(dictionary.parentId == companydata.id || !datas[i].parentId){
                                    dictionary.isleaf = that.haveChild(datas,dictionary.id);

                                    if(!dictionary.isleaf){
                                        dictionary.hide = 'hide'
                                    }else{
                                        dictionary.hide = ''
                                    }

                                    domString = that.comPile(that.model2,dictionary);
                                    that.onecontainer.append(domString);

                                    if(dictionary.isleaf){
                                        that.chirldData(ret.data,dictionary.id);
                                    }

                                }
                            }
                            $('.compony_name .sel_click').trigger('click');
                        }
                    })
                };
                this.chirldData = function(obj,id){
                    var datas = obj;
                    for(var i in datas){
                        var dictionary = datas[i];
                        if(dictionary.parentId == id){
                            dictionary.isleaf = that.haveChild(datas,dictionary.id);
                            if(!dictionary.isleaf){
                                dictionary.hide = 'hide'
                            }else{
                                dictionary.hide = ''
                            }
                            domString = that.comPile(that.model2,dictionary);
                            $('#sub-'+id).next('ul').append(domString);

                            if(dictionary.isleaf){
                                that.chirldData(datas,dictionary.id);
                            }
                        }
                    }
                };
                //判断是否有下级
                this.haveChild = function(obj,id){
                    var datas = obj;
                    var hasleaf = false;
                    for(var i in datas){
                        var dictionary = datas[i];
                        if(dictionary.parentId == id){
                            hasleaf = true;
                        }
                        if(hasleaf){
                            break;
                        }
                    }
                    return hasleaf;
                };

                //点击部门显示部门用户
                partUser = function(is,id,bj){
                    var sel_child = $(is).parent('li').find('.sel');

                    $('.selected').removeClass('selected');
                    if($(is).find('i').hasClass('select')){
                        sel_child.addClass('selected');
                    }
                    that.loadUser(id);
                    that.partId = id;

                    if(bj){
                        $('.part_user').find('.compony_name').find('em').html('全公司 - 待选人员');
                    }else{
                        var isname = $(is).find('.sel_click').find('span').html();
                        $('.part_user').find('.compony_name').find('em').html(isname + ' - 待选人员');
                    }
                };
                this.loadUser = function(id){
                    $.ajax({
                        'url': urlpath_a+'/sys/role/viewOfficeUsers.jhtml?officeId='+id,
                        'type':'get',
                        'dataType': "json",
                        success:function(ret){
                            //console.log(ret);
                            var datas = ret.data;
                            that.sel_user_container.html('');

                            if(ret.data && ret.data.length>0){
                                var userlist = [];
                                for(var i=0;i<datas.length;i++){

                                    if(that.examUsers(datas[i].id)){
                                        userlist.push('<li class="pointer" onclick="addRole(this,\''+datas[i].id+'\')" data-add="0" data-id="'+datas[i].id+'"><i class="glyphicon glyphicon-user color_red"></i><span class="color_red">'+datas[i].name+'</span></li>')
                                    }
                                }
                                if(userlist.length>0){
                                    that.sel_user_container.html(userlist.join(""));
                                }else{
                                    var nodata = '<div class="nodata"></div>';
                                    that.sel_user_container.html(nodata);
                                }
                            }else{
                                var nodata = '<div class="nodata"></div>';
                                that.sel_user_container.html(nodata);
                            }

                            that.partUserHeight();

                        },
                        error:function(){

                        }
                    })
                };

                //添加到角色
                addRole = function (is,id) {
                    var addbj = $(is).data('add');

                    if(addbj == "0"){
                        $(is).data('add','1');
                        that.seled_user.append($(is));
                        if($('#seled_user').find('.nodata').length>0){
                            $('#seled_user').find('.nodata').remove()
                        }
                    }else{
                        that.loadUser(that.partId);
                        $(is).remove();
                    }
                    that.countArr();
                };
                //计算选中数组
                this.countArr = function(id){
                    var list = $('#seled_user').find('li');
                    var isusers = [];
                    list.each(function(el,index){
                        var isid = $(this).data('id');
                        isusers.push(isid);
                    });
                    that.seledUsers = isusers;
                    //console.log(that.seledUsers)
                };
                //循环选中数组，查看当前用户是否选中
                this.examUsers = function(id){
                    var datas = that.seledUsers;
                    var isbj = true;
                    for(var i = 0; i<datas.length; i++){
                        if(datas[i] == id){
                            isbj = false;
                            break;
                        }
                    }
                    return isbj;
                };

                //显示已添加角色
                this.seledUser = function(id){
                    var roleid =  that.getQueryString('roleid');
                    //console.log(roleid);
                    $.ajax({
                        'url': urlpath_a+'/sys/role/viewAssignedUsers.jhtml?id='+roleid,
                        'type':'get',
                        'dataType': "json",
                        success:function(ret){
                            //console.log(ret);
                            var datas = ret.data;
                            if(ret.data.length>0){
                                var userlist = [];
                                for(var i=0;i<datas.length;i++){
                                    userlist.push('<li data-add="1" data-id="'+datas[i].id+'"><i class="glyphicon glyphicon-user"></i><span>'+datas[i].name+'</span></li>');
                                    that.seledUsers.push(datas[i].id);
                                }
                                that.seled_user.html(userlist.join(""));

                            }else{
                                var nodata = '<div class="nodata"></div>';
                                that.seled_user.html(nodata);
                            }


                        },
                        error:function(){

                        }
                    })
                };

                this.partUserHeight = function(){
                    $('.part_user').css({'height':'auto'});
                    var isheight = $('.row').height();
                    $('.part_user').css({'height':isheight});
                };

                //数据正则匹配方法
                this.comPile = function(templateString , dictionary){
                    return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                        return dictionary[$1];
                    });
                };

                //获取地址参数
                this.getQueryString = function(key) {
                    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
                    var result = window.location.search.substr(1).match(reg);
                    return result ? decodeURIComponent(result[2]) : null;
                };

                this.toggerClick = function(event){
                    event.stopPropagation();
                    event.preventDefault();
                    var is_next = $(this).next('.one_title').next('ul');
                    if(is_next.find('li').length<1){
                        return;
                    }
                    if(is_next.css('display') == 'none'){
                        is_next.slideDown();
                    }else{
                        is_next.slideUp();
                    }
                };

                this.init = function(){
                    that.seledUser();
                    this.loadPart();
                    $('.container ').off('click').on('click','.togger_click',this.toggerClick);
                    $('.container').on('mouseenter','.togger_click',function(){
                        $(this).next('.one_title').addClass('one_title_bg');
                        $(this).css({'color':'#777'});
                    });
                    $('.container').on('mouseleave','.togger_click',function(){
                        $(this).next('.one_title').removeClass('one_title_bg');
                        $(this).css({'color':'#fff'});
                    })
                    $('.container').on('mouseenter','.one_title',function(){
                        $(this).prev('.togger_click').css({'color':'#777'});
                    });
                    $('.container').on('mouseleave','.one_title',function(){
                        $(this).next('.one_title').removeClass('one_title_bg');
                        $(this).prev('.togger_click').css({'color':'#fff'})
                    })
                }
            };

            var roleallot = new roleAllot;
            roleallot.init();
//        });

    </script>
</body>
</html>