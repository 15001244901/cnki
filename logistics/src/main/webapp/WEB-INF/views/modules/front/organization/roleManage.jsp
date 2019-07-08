<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/organization/mytree.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/organization/base.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/organization/public.css${v}">
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
</head>
<body>
<div id="divheader"></div>
<div id="container" class="mar20_80">
	<div class="container">
		<div class="row">
			<div class="cont_left col-md-3 col-sm-4">

				<%--<div class="input-group pl10 pr10">--%>
					<%--<input id="search" type="text" class="form-control" placeholder="Search for...">--%>
					<%--<span class="input-group-btn">--%>
				        	<%--<button id="search_btn" class="btn btn-default" type="button">Go!</button>--%>
				      	<%--</span>--%>
				<%--</div>--%>

				<div class="cont_left_cont clear">
					<ul class="cont_left_cont_title over pl10 pr10">
						<li class="btn btn-default fl" data-type="0"><a href="organizationManage.html">组织机构</a></li>
						<li class="btn btn-default btn-info fr" data-type="1"><a href="roleManage.html">角色管理</a></li>
					</ul>
					<div class="cont_left_cont_cont">
						<div>
							<div class="compony_name">
								<span class="glyphicon glyphicon-triangle-bottom pl15"></span>
								<em class="sel_click">默认</em>
							</div>
						</div>
						<ul class="dash_line dash_pos tree_container" id="onecontainer">

						</ul>
					</div>
				</div>

			</div>
			<div class="cont_right col-md-9 col-sm-8">
				<div class="cont_right_title">
					<p class="color_337ab7 mb13">
						<span class="glyphicon glyphicon-user pr10 fz16"></span><b class="title_company"></b>
                    </p>
				</div>

				<div class="bs-example bs-example-standalone" data-example-id="dismissible-alert-js">
					<div class="alert alert-warning alert-dismissible fade in" role="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
						<strong>注意!</strong> 在添加成员前,请先在左侧角色列表中选中想要添加的角色
					</div>
				</div>



				<div class="cont_right_cont2">
					<div class="list-group">
						<div class="list-group-item list-group-item-success set_part">
							<a class="btn btn-default" id="addpeople">添加成员</a>
						</div>
						<div class="list-group-item employee_title">
							<span class="wid15">丨姓名</span>
							<span class="wid15">丨工号</span>
							<span class="wid15">丨岗位</span>
							<span class="wid15">丨电话</span>
							<span class="wid30">丨邮箱</span>
							<span class="wid10">丨操作</span>
						</div>

						<div class="employee_container">

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 模态窗口1  增加角色人员 -->
<div class="modal fade bs-example-modal-lg" id="people" tabindex="-1" role="dialog" aria-labelledby="peopleLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="exampleModalLabel">编辑成员</h4>
			</div>
			<div class="modal-body">
                <iframe id="role_manage" name="role_manage" src="" frameborder="0" width="100%"></iframe>
			</div>
			<div class="modal-footer">
				<span id="save_role_fail" class="fl _fail"><i class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></i><b>添加失败</b></span>
				<span id="save_role_ok" class="fl _ok"><i class="glyphicon glyphicon-ok-sign" aria-hidden="true"></i><b>添加成功</b></span>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="save_role_user">保存</button>
			</div>
		</div>
	</div>
</div>
<!-- 模态窗口5  删除人员提示窗口-->
<div class="modal fade" id="delRoleUser" tabindex="-1" role="dialog"    	aria-labelledby="delRoleUserLabel">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" >信息提示</h4>
			</div>
			<div class="modal-body">
				<p>您确定要删除此条信息?</p>
			</div>
			<div class="modal-footer">
				<span id="del_role_user_fail" class="fl _fail"><i class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></i><b>移除失败</b></span>
				<span id="del_role_user_ok" class="fl _ok"><i class="glyphicon glyphicon-ok-sign" aria-hidden="true"></i><b>移除成功</b></span>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="confirm_del_user">确定</button>
			</div>
		</div>
	</div>
</div>

<%--角色模板--%>
<script id="model_2" type="text/template">
	<li>
		<div class="one_title" id="sub-{{id}}" data-id="{{id}}" onclick="partUser(this,'{{id}}')">
			<em class="bg"></em><i class="sel select"></i><span class="sel_click">{{name}}</span>
		</div>
		<ul class="dash_line dash_pos ml19">
		</ul>
	</li>
</script>
<%--用户模板--%>
<script id="model_user" type="text/template">
	<div class="list-group-item employee_name">
		<span class="wid15">{{name}}</span>
		<span class="wid15">{{no}}</span>
		<span class="wid15">{{postName}}</span>
		<span class="wid15">{{mobile}}</span>
		<span class="wid30">{{email}}</span>
		<span class="wid10"><a onclick="delRoleUser(this,'{{id}}')">移除</a></span>
	</div>
</script>

<script src="${ctxStatic}/jquery/jquery-1.11.1.min.js"></script>
<script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />
<script>
	$(function(){
		var rolemanage = function(){
			var that = this;
			this.onecontainer = $('#onecontainer');  //角色容器
            this.employee_container = $('.employee_container');  //角色用户容器

			this.model2        = $('#model_2').html();   //角色模板
            this.model_user = $('#model_user').html(); //角色用户模板

            this.addpeople = $('#addpeople');   //添加成员按钮
			this.save_role_user = $('#save_role_user'); //保存角色修改按钮

			this.roleId;  //承载选中的角色id

			//加载角色列表
			this.roleList = function(num,id){
				$.ajax({
					'url': urlpath_a+'/sys/role/listFrontRoles.jhtml',
					'type':'get',
					'dataType': "json",
					success:function(ret){
						//console.log(ret);
						var datas = ret.data;
						for(var i in datas){
							var dictionary = datas[i];
							domString = that.comPile(that.model2,dictionary);
							that.onecontainer.append(domString);
						}

						$('#onecontainer li').eq(0).children('.one_title').trigger('click');
					}
				})
			};
			//点击角色显示角色用户
			partUser = function(is,id){
				var sel_child = $(is).find('.sel');

                that.getRoleUser(id);
				that.roleId = id;

				if($(is).find('span').length>0){
					$('.title_company').html($(is).find('span').html());
				}
				$('.selected').removeClass('selected');
				$('.bgc_1').removeClass('bgc_1');
				if($(is).find('i').hasClass('select')){
					sel_child.addClass('selected');
					$(is).addClass('bgc_1');
				}

				var recipient = $(is).find('.sel_click').html();
				$('#people').find('.modal-title').text('当前角色-'+recipient);
			};

			//获取角色用户列表
            this.getRoleUser = function(id){
                $.ajax({
                    'url': urlpath_a+'/sys/role/viewAssignedUsers.jhtml?id='+id,
                    'type':'get',
                    'dataType': "json",
                    success:function(ret){
                        //console.log(ret);
                        var datas = ret.data;
                        if(datas && datas.length>0){
                            var domString = '';
                            for(var i in datas){
                                var dictionary = datas[i];
                                if(!dictionary.mobile){
                                    dictionary.mobile = '暂无'
                                }
								if(!dictionary.postName){
									dictionary.postName = '暂无'
								}
                                if(!dictionary.email){
                                    dictionary.email = '暂无'
                                }
                                if(!dictionary.no){
                                    dictionary.no = '暂无'
                                }
                                domString += that.comPile(that.model_user,dictionary);
                            }
                            that.employee_container.html(domString);
                        }else{
                            var nodata = '<div class="list-group-item nodata"></div>';
                            that.employee_container.html(nodata);
                        }
						that.leftHeight();
                    }
                });
            };

            //添加成员
            this.addPeopleFun = function(){
            	if(!that.roleId){
            		return;
				}
                $('#people').modal('show');
            };
            $('#people').on('show.bs.modal', function (e) {

				var modal = $(this);
				modal.find('iframe').prop('src','roleUserList.html?roleid='+that.roleId);
				var isheight = $(window).height();
				modal.find('iframe').css('height',isheight*80/100 -56 -65);
            });

			//点击保存的角色修改
			this.saveRoleUserFun = function(){
				var isdata = $("#role_manage")[0].contentWindow.roleallot.seledUsers;
				isdata = isdata.join(",");
				//console.log(isdata);
				$.ajax({
					'url': urlpath_a+'/sys/role/assignUsersToRole.jhtml',
					'type':'post',
					'dataType': "json",
					'data':{
						'id':that.roleId,
						'idsArr':isdata
					},
					success:function(ret){
						//console.log(ret);
						if(ret.success){
							that.showFailText(ret.msg,'save_role_ok');
							setTimeout(function(){
								$('#people').modal('hide');
							},3000);
							that.getRoleUser(that.roleId);

						}else{
							that.showFailText(ret.msg,'save_role_fail');
						}

					},
					error:function(){
						that.showFailText('保存失败','save_role_fail');
					}
				})
			};

			//移除当前人员
			delRoleUser = function(is,id){
				$('#delRoleUser').modal('show');
				var delis = $(is).closest('.list-group-item');

				$('#confirm_del_user').off('click').on('click',function(){
					$.ajax({
						'url': urlpath_a+'/sys/role/deleteUserFromRole.jhtml',
						'type':'post',
						'dataType': "json",
						'data':{
							'roleId':that.roleId,
							'userId':id
						},
						success:function(ret){
							//console.log(ret);
							if(ret.success){
								that.showFailText(ret.msg,'del_role_user_ok');
								delis.remove();
								setTimeout(function(){
									$('#delRoleUser').modal('hide');
								},3000);
							}else{
								that.showFailText(ret.msg,'del_role_user_fail');
							}

						},
						error:function(){
							that.showFailText('移除失败','save_role_fail');
						}
					})
				})

			};

			//设置左侧高度
			this.leftHeight = function(){
				$('.cont_left ').css({'height':'auto'});
				var isheight = $('.row').height();
				$('.cont_left ').css({'height':isheight});
			};
			//页面最小高度
			this.minHeight = function(){
				var minheight = $(window).height()-40;
				$('.row').css('min-height',minheight)
			};

			// 显示错误提示
			this.showFailText = function(text,id){
				if(text == '系统忙...'){
					text = '保存失败'
				}
				$('#'+id+' b').html(text);
				$('#'+id).show();
				setTimeout(function(){
					$('#'+id).hide();
				},3000);
			};

			//数据正则匹配方法
			this.comPile = function(templateString , dictionary){
				return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
					return dictionary[$1];
				});
			};

			this.init = function(){
				$('#divheader').load(projectname + "/page/include/headerquestion.html"+timestamps);
				this.roleList();
                //添加成员
                this.addpeople.off('click').on('click',this.addPeopleFun);
				//保存角色修改
				this.save_role_user.off('click').on('click',this.saveRoleUserFun);
				this.minHeight();
			}
		};
		var roleManage = new rolemanage;
		roleManage.init();

	});
</script>
</body>
</html>