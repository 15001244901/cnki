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
	<style>

	</style>
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
							<li class="btn btn-default btn-info fl" data-type="0"><a href="organizationManage.html">组织机构</a></li>
							<li class="btn btn-default fr" data-type="1"><a href="roleManage.html">角色管理</a></li>
						</ul>
						<div class="cont_left_cont_cont">
							<!-- <div class="compony_name">
								<span class="glyphicon glyphicon-triangle-bottom"></span>
								<em>三河环迅科技有限公司</em>
								<span class="glyphicon glyphicon-option-vertical fr pt11 pb11 show_set">
									<div class="set_part_btn">
										<p  data-toggle="modal" data-target="#exampleModal" class="reset_part_name">修改名称</p>
										<p class="add_part">添加子集</p>
									</div>
								</span>
							</div> -->
							<ul class="dash_line dash_pos tree_container" id="onecontainer">
				               
				            </ul>
						</div>
					</div>

				</div>
				<div class="cont_right col-md-9 col-sm-8">
					<div class="cont_right_title">
						<p>
							<b class="title_company color_333"></b><span class="color_g title_part"></span>
							<a id="add_part_btn" class="fr"
							   data-toggle="modal"
							   data-target="#exampleModal"
							   data-pid="0"
							   data-id=""
							>添加部门</a></p>
						<%--<div class="cont_right_title_nav">--%>
							<%--<span class="color_g title_company"></span><span class="title_part"></span>--%>
						<%--</div>--%>
					</div>
					
					<div class="cont_right_cont2 mt20">
						<div class="cont_right_cont_title"><span class="glyphicon glyphicon-user"></span>部门人员</div>
						<div class="bs-example bs-example-standalone" data-example-id="dismissible-alert-js">
							<div class="alert alert-warning alert-dismissible fade in" role="alert">
								<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
								<strong>注意!</strong> 在添加成员前,请先在左侧部门列表中选中想要添加的部门
							</div>
						</div>
						<div class="list-group">
							<div class="list-group-item list-group-item-success set_part">
								<a class="btn btn-default" id="addpeople">添加成员</a>
								<%--<a class="btn btn-default">调整部门</a>--%>
								<%--<a class="btn btn-default">调整顺序</a>--%>
								<%--<a class="btn btn-danger">批量删除</a>--%>
							</div>
							<div class="list-group-item employee_title">
								<span class="wid15">丨姓名</span>
								<span class="wid15">丨工号</span>
								<span class="wid15">丨岗位</span>
								<span class="wid15">丨电话</span>
								<span class="wid25">丨邮箱</span>
								<span class="wid15">丨操作</span>
							</div>

							<div class="employee_container">

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 模态窗口1  增加部门 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="exampleModalLabel">修改信息</h4>
				</div>
				<div class="modal-body">
					<form id="partdata">
						<div class="form-group">
							<label class="control-label">名称:</label>
							<input type="text" class="form-control" name="name">
						</div>
						<div class="form-group">
							<label class="control-label">排序:</label>
							<input class="form-control" name="code">
						</div>
						<input type="hidden" name="type" value="2">
						<input type="hidden" name="parent.id" value="">
						<input type="hidden" name="grade" value="1">
					</form>
					<input type="hidden" name="id" value="">
				</div>
				<div class="modal-footer">
					<span id="save_part_fail" class="fl _fail"><i class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></i><b>添加失败</b></span>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="save_part">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 模态窗口2  删除部门提示窗口-->
	<div class="modal fade" id="confirm_del" tabindex="-1" role="dialog"    	aria-labelledby="mySmallModalLabel">
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
					<span id="del_part_fail" class="fl _fail"><i class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></i><b>添加失败</b></span>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="confirm_del_part">确定</button>
				</div>
			</div>
		</div>
	</div>
	<%--模态窗口3  增加用户--%>
	<div class="modal fade" id="resetUser" tabindex="-1" role="dialog" aria-labelledby="resetUserLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body">
					<style>
						.sel_office .form-control{
							background: #eee;
						}
						.office_one{
							border: 1px solid #777;
							border-radius: 4px;
							padding:2px 6px;
							font-size: 12px;
						}
						.office_one i{
							padding-left: 6px;
							font-style: normal;
							font-size: 15px;
						}


					</style>
					<form class="form-horizontal" id="userdata">
						<div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><font color="red">* </font>部门:</label>
								<div class="col-sm-10 sel_office">
									<%--<select class="form-control" name="office.id" >--%>
										<%--<option value="">1</option>--%>
										<%--<option value="">2</option>--%>
										<%--<option value="">3</option>--%>
										<%--<option value="">4</option>--%>
										<%--<option value="">5</option>--%>
									<%--</select>--%>
									<div class="form-control" >
										<%--<span class="office_one">监察部<i>×</i></span>--%>
									</div>

								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><font color="red">* </font>工号:</label>
								<div class="col-sm-10">
									<input  class="form-control" type="text" name="no">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><font color="red">* </font>姓名:</label>
								<div class="col-sm-10">
									<input  class="form-control" type="text" name="name">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><font color="red">* </font>登录名:</label>
								<div class="col-sm-10">
									<input  class="form-control" name="loginName" type="text" placeholder="登录名为手机号">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">邮箱:</label>
								<div class="col-sm-10">
									<input  class="form-control" type="email" name="email">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">手机:</label>
								<div class="col-sm-10">
									<input  class="form-control" type="text" name="mobile">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">岗位:</label>
								<div class="col-sm-10">
									<select class="form-control" name="post" >
										<option value="">1</option>
										<option value="">2</option>
										<option value="">3</option>
										<option value="">4</option>
										<option value="">5</option>
									</select>
								</div>
							</div>
						</div>
						<%--公司id--%>
						<input type="hidden" name="company.id">
						<%--用户类型--%>
						<input type="hidden" name="userType" value="3">
						<%--角色--%>
						<input type="hidden" name="roleIdList" value="6">
						<%--部门id--%>
						<input type="hidden" name="office.id" value="">
						<%--是否让登录--%>
						<input type="hidden" name="loginFlag" value="1">
					</form>
				</div>
				<div class="modal-footer">
					<span id="save_user_fail" class="fl _fail"><i class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></i><b></b></span>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="save_user_data">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 模态窗口5  删除人员提示窗口-->
	<div class="modal fade" id="delUser" tabindex="-1" role="dialog"    	aria-labelledby="delUserLabel">
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
					<span id="del_part_user" class="fl _fail"><i class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></i><b>添加失败</b></span>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="confirm_del_user">确定</button>
				</div>
			</div>
		</div>
	</div>

	<input type="hidden" id="company_id" value="">
	<input type="hidden" id="part_id" value="">
	<input type="hidden" id="part_name" value="">

	<script id="model_0" type="text/template">
		<li>
			<div class="compony_name" id="sub-{{id}}" data-id="{{id}}">
				<span class="glyphicon glyphicon-triangle-bottom pl15"></span>
				<em class="sel_click" onclick="partUser(this,'{{id}}')">{{name}}</em>
				<span class="glyphicon glyphicon-option-vertical fr pt11 pb11 pr10 show_set company_set_btn">
					<div class="set_part_btn">

					    <p 	
						    class="add_part" 
						    data-toggle="modal" 
						    data-target="#exampleModal" 
						    data-pid="{{parentId}}" 
						    data-id="{{id}}"
						    data-name="{{name}}"
						    data-code="{{code}}"
						    >
						    添加部门
						</p>
					</div>
				</span>
			</div>
			<ul class="dash_line dash_pos">
            </ul>
		</li>
	</script>
    <script id="model_2" type="text/template">
        <li>
			<i class="togger_click glyphicon glyphicon-menu-down {{hide}}"></i>
			<div class="one_title" id="sub-{{id}}" data-id="{{id}}" onclick="partUser(this,'{{id}}')">
                <em class="bg"></em><i class="sel select"></i><span class="sel_click">{{name}}</span>
                <b class="glyphicon glyphicon-option-vertical fr pt5 pb5 show_set">
                	<div class="set_part_btn ">
						<p
								class="add_part {{noadd}}"
								data-toggle="modal"
								data-target="#exampleModal"
								data-pid="{{parentId}}"
								data-id="{{id}}"
								data-name="{{name}}"
								data-code="{{code}}"
						>
							添加部门
						</p>
						<p  
							data-toggle="modal" 
							data-target="#exampleModal" 
							data-name="{{name}}"
							data-code="{{code}}"
							data-pid="{{parentId}}" 
						    data-id="{{id}}"
							data-reset="1"
							class="reset_part_name"
						>修改名称
						</p>
						<p class="del_part" onclick="delPart(this,'{{id}}')">删除部门</p>
					</div>
                </b>
            </div>
            <ul class="dash_line dash_pos ml19">
            </ul>
        </li>
    </script>

     <!-- 角色模板 -->
	<script id="model_role" type="text/template">
     	<li>
            <div class="one_title" id="rol-{{id}}" data-id="{{id}}">
                <em class="bg"></em><span onclick="selClick(this);"><i class="sel select"></i><span>{{name}}</span></span>
                <b class="glyphicon glyphicon-option-vertical fr pt5 pb5 show_set">
                	<div class="set_part_btn">
						<p  
							data-toggle="modal" 
							data-target="#exampleModal" 
							data-name="{{name}}"
						    data-id="{{id}}"
							data-reset="1"
							class="reset_part_name"
						>修改名称
						</p>
						<p class="del_part" onclick="delPart(this,'{{id}}')">删除部门</p>
					</div>
                </b>
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
			<span class="wid25">{{email}}</span>
			<span class="wid15"><a onclick="resetUser('{{id}}')">设置</a><a onclick="delUser('{{id}}')">删除</a></span>
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
			var organizemanage = function(){
				var that = this;

				this.seltype = $('.cont_left_cont_title');   //组织架构和角色容器

				//部门管理
				this.addpart = $('.add_part');            //获取增加部门按钮
				this.reset_part = $('.reset_part_name'); //修改部门名称
				this.reset_bj = false;                     //0增加部门，1修改部门名称
				this.save_part = $('#save_part');         //保存部门修改

				//人员列表
				this.employee_container = $('.employee_container');  //人员列表容器
				this.model_user      = $('#model_user').html();        //人员列表模板
				this.employee_page    = $('.employee_page');          //人员列表分页容器
				this.addpeople        =  $('#addpeople');              //增加人员按钮

				//人员管理
				this.save_user_data = $('#save_user_data');          //保存人员添加按钮
				this.add_reset_bj = false;                             //判断是增加人员，还是修改人员信息.false为增加

				//右侧头部公司管理按钮
				this.title_add = $('#add_part_btn');
				this.titleAdd = function(){
					var companyid = $('#'+company_id).val();
					console.log(companyid);
					$('#sub-'+companyid).find('.add_part').trigger('click');
				};

				//保存部门修改
				this.savePart = function(){
					var isname = $('#partdata  input[name=name]').val();
					if(!$.trim(isname)){
						that.showFailText('名称不能为空','save_part_fail');
						return;
					}
					var formdata = $('#partdata').serialize();

					if(that.reset_bj){
						formdata = formdata+'&id='+$('#exampleModal input[name=id]').val();
					}

					$.ajax({
						'url':urlpath_a+'/sys/office/save.jhtml',
                        'type':'post',
                        'dataType': "json",
                        data:formdata,
                        success:function(ret){
                        	//console.log(ret);
                        	if(ret.success){
                        		subtree.loadTree();
                        		$('#exampleModal').modal('hide');
                        	}else{
                    			that.showFailText(ret.msg,'save_part_fail');
                        	}
                        }
					})
				};

				// 显示错误提示
				this.showFailText = function(text,id){
					$('#'+id+' b').html(text);
					$('#'+id).show();
					setTimeout(function(){
        				$('#'+id).hide();
        			},3000);
				};

				//删除部门
				delPart = function(is,id){
					$('#confirm_del').modal('show');

					$('#confirm_del_part').off('click').on('click',function(){
						$.ajax({
							'url':urlpath_a+'/sys/office/delete.jhtml?id='+id,
	                        'type':'post',
	                        'dataType': "json",
	                        success:function(ret){
	                        	//console.log(ret);
	                        	if(ret.success){
	                        		subtree.loadTree();
	                        		$('#confirm_del').modal('hide');
	                        	}else{
	                    			that.showFailText(ret.msg,'del_part_fail');
	                        	}
	                        }
						});
					});
				};

				//设置部门模态窗口
				$('#exampleModal').on('show.bs.modal', function (event) {
					var button = $(event.relatedTarget);
					var recipient = button.html();
					var id = button.data('id');
					var pid = button.data('pid');
					var modal = $(this);

					that.reset_bj = false;
					if(button.data('reset') == "1"){
						var isname = button.data('name') || '';
						var iscode = button.data('code') == 'undefined'? '': button.data('code');
						modal.find('.modal-body input[name="name"]').val(isname);
						modal.find('.modal-body input[name="code"]').val(iscode);
						modal.find('.modal-body input[name="id"]').val(id);
						modal.find('.modal-body input[name="parent.id"]').val(pid);
						that.reset_bj = true;
					}else{
						modal.find('.modal-body input[name="parent.id"]').val(id);
					}

					modal.find('.modal-title').text(recipient);
				});

				//设置人员窗口
				this.addUserBtn = function(){
					var is_companyid = $('#company_id').val();
					var is_partid = $('#part_id').val();
					if(is_companyid == is_partid || !is_partid){
						return;
					}
					that.loadResrtUserData('data');
					$('#resetUser').modal('show');
				};

				$('#resetUser').on('show.bs.modal', function (event) {
					var button = $(event.relatedTarget);
					var recipient = button.html();
					if(recipient != '添加成员'){
						recipient = '用户设置'
					}

					var is_companyid = $('#company_id').val();
					var is_partid = $('#part_id').val();
					var is_partname = $('#part_name').val();

					var parthtml = '<span class="office_one">'+is_partname+'<i>×</i></span>';
					$('.sel_office .form-control').html(parthtml);

					var modal = $(this);
					modal.find('.modal-title').html(recipient+'<em class="isprompt">提示：登录名必须为手机号，密码为登录名后六位</em>');
					modal.find('.modal-body input[name="office.id"]').val(is_partid);
					modal.find('.modal-body input[name="company.id"]').val(is_companyid);


				});

				$('#resetUser').on('hide.bs.modal', function (event){
					//更改标记为增加人员
					that.add_reset_bj = false;
				});

				//保存新增人员设置
				this.saveUserSet = function(){
					var userdata = $('#userdata');
					var formdata = userdata.serialize();

					var officeid = userdata.find('input[name="office.id"]').val();
					var name = userdata.find('input[name="name"]').val();
					var no = userdata.find('input[name="no"]').val();
					var loginName = userdata.find('input[name="loginName"]').val();
					var mobile = userdata.find('input[name="mobile"]').val();

					if(!$.trim(officeid)){
						that.showFailText('所在部门必填','save_user_fail');
						return;
					}else if(!$.trim(name)){
						that.showFailText('用户名必填','save_user_fail');
						return;
					}else if(!$.trim(no)){
						that.showFailText('工号必填','save_user_fail');
						return;
					}else if(!(/^1[34578]\d{9}$/.test(loginName))){
						that.showFailText('登录名格式错误','save_user_fail');
						return;
					}
					if($.trim(mobile) && !(/^1[34578]\d{9}$/.test(mobile))){
						that.showFailText('手机号码格式错误','save_user_fail');
						return;
					}

					var newPassword = loginName.substr(-6,6);
					if(that.add_reset_bj){
						formdata = formdata +'&id='+ that.add_reset_bj+'&oldLoginName='+ loginName;
					}else{
						formdata = formdata +'&newPassword='+ newPassword +'&confirmNewPassword='+newPassword;
					}

					$.ajax({
						'url': urlpath_a+'/sys/user/save.jhtml ',
						'type':'post',
						'dataType': "json",
						data:formdata,
						success:function(ret){
							//console.log(ret);
							if(ret.success){
								that.loadUser('1',officeid);
								$('#resetUser').modal('hide');
							}else{
								that.showFailText(ret.msg,'save_user_fail');
							}
						}
					});
				};

				//删除人员设置
				delUser = function(id){
					$('#delUser').modal('show');
					var officeid = $('#part_id').val();
					$('#confirm_del_user').off('click').on('click',function(){
						$.ajax({
							'url':urlpath_a + '/sys/user/delete.jhtml?id='+id,
							'type':'post',
							'dataType': "json",
							success:function(ret){
								if(ret.success){
									that.loadUser(1,officeid);
									$('#delUser').modal('hide');
								}else{
									that.showFailText(ret.msg,'del_user_fail');
								}
							}
						});
					});
				};

				//从新设置人员
				resetUser = function(id){
					$.ajax({
						'url':urlpath_a + '/sys/user/load.jhtml?id='+id,
						'type':'post',
						'dataType': "json",
						success:function(ret){
							//console.log(ret.user);
							if(ret.success){
								var data = ret.user;
								if(!data){
									return;
								}

								that.add_reset_bj = id;

								var partobj = that.findPartId(ret.user.id);

								that.loadResrtUserData(data);
								$('#resetUser').modal('show');
								$('#userdata input[name="office.id"]').val(partobj.id);
								var parthtml = '<span class="office_one">'+partobj.name+'<i>×</i></span>';
								$('.sel_office .form-control').html(parthtml);
							}

						}
					});
				};

				//寻找部门id
				this.findPartId = function(isid){
					var partid = [];
					$.ajax({
						'url':urlpath_a + '/sys/office/listOffices4Manager.jhtml',
						'type':'post',
						async:false,
						'dataType': "json",
						success:function(ret){
							if(ret.success){
								var datas = ret.data;
								for(var i=0;i<datas.length;i++){
									if(datas[i].users && datas[i].users.length>0){
										var user = datas[i].users;
										for(var j=0;j<user.length;j++){
											if(user[j].id == isid){
												partid = datas[i];
												break;
											}
										}
									}

								}
							}

						}
					});
					return partid;
				};

				//重新设置时添加载入人员信息
				this.loadResrtUserData = function(data){
					$('#userdata input[name=no]').val(data.no || '');
					$('#userdata input[name=name]').val(data.name || '');
					$('#userdata input[name=loginName]').val(data.loginName || '');
					$('#userdata select[name=post]').val(data.post || '');

					$('#userdata input[name=mobile]').val(data.mobile || '');
					$('#userdata input[name=email]').val(data.email || '');


					//隐藏域
					$('#userdata input[name=userType]').val(data.userType || '3');
					<%--角色--%>
					//$('#userdata input[name=roleIdList]').val(data.roleIdList || '6');
				};

				//设置人员模态窗口的部门选项
				this.selPart = function(obj){
					if(!obj){
						$('.sel_office').html('<select class="form-control" name="office.id"></select>');
						return;
					}
					var parthtml = [];
					parthtml.push('<select class="form-control" name="office.id" value="">');
					for(var i=0;i<obj.length;i++){
						parthtml.push('<option value="'+obj[i].id+'">'+obj[i].name+'</option>')
					}
					parthtml.push('</select >');
					$('.sel_office .form-control').html(parthtml.join(""))
				};

				//加载用户
				this.loadUser = function(num,id){
					$.ajax({
						'url': urlpath_a + '/sys/user/listData?office.id='+id,
                        'type':'get',
                        'dataType': "json",
						'data':{
							'pageSize':10,
							'pageNo':(num || 1)
						},
                        success:function(ret){
							//console.log(ret);
							if(ret.list){
								that.employee_container.html('');
								var datas = ret.list;
								var page = '<div class="list-group-item employee_page">'+ret.frontPageHtml+'</div>'
								for(var i in datas){
									var dictionary = datas[i];
									if(!dictionary.postName){
										dictionary.postName = '暂无'
									}
									if(!dictionary.mobile){
										dictionary.mobile = '暂无'
									}
									if(!dictionary.email){
										dictionary.email = '暂无'
									}
									if(!dictionary.no){
										dictionary.no = '暂无'
									}
									domString = subtree.comPile(that.model_user,dictionary);
									that.employee_container.append(domString);

								}
								that.employee_container.append(page);
							}else{
								var nodata = '<div class="list-group-item nodata"></div>';
								that.employee_container.html(nodata);
							}
							that.leftHeight();
                        },
						error:function(){
							var nodata = '<div class="list-group-item nodata"></div>';
							that.employee_container.html(nodata);
						}
					})
				};

				//加载岗位信息
				this.postData = function(){
					$.ajax({
						'url': urlpath_a + '/sys/dict/listData.jhtml',
						'type':'get',
						'dataType': "json",
						'data':{
							type: 'dic_exam_questionpost' //岗位
						},
						success:function(ret){
							if(ret.success && ret.data){
								var datas = ret.data;
								var optionarr = [];
								for(var i=0; i<datas.length; i++){
									optionarr.push('<option value="'+datas[i].value+'">'+datas[i].label+'</option>')
								}
								$('select[name=post]').html(optionarr.join(""));
							}
						},
						error:function(ret){

						}
					})
				};

				//点击部门显示部门用户
				partUser = function(is,id){
					var sel_child = $(is).find('.sel');
					$('.bgc_1').removeClass('bgc_1');
					if($(is).find('span').length>0){
						$('#part_name').val($(is).find('span').html());
						$('.title_part').html(' &gt; '+ $(is).find('span').html());
						$(is).addClass('bgc_1');
					}else{
						$('.title_part').html('');
					}
					$('#part_id').val(id); //将所选部门id放入隐藏域

					$('.selected').removeClass('selected');
					if($(is).find('i').hasClass('select')){
						sel_child.addClass('selected');
					}
					that.loadUser(1,id);
				};
				//用户分页
				page = function(num){
					var officeid = $('#part_id').val();
					that.loadUser(num,officeid);
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

				this.init = function(){
					$('#divheader').load(projectname + "/page/include/headerquestion.html"+timestamps);
					//加载岗位信息
					this.postData();
					//保存增家部门
					this.save_part.off('click').on('click',this.savePart);
					//点击增加人员事件
					this.addpeople.off('click').on('click',this.addUserBtn);
					//保存新增人员
					this.save_user_data.off('click').on('click',this.saveUserSet);

					this.minHeight();
				}
			};
			var organizeManage = new organizemanage;
			organizeManage.init();

		    var subTree = function(){
                var that = this;
                this.onecontainer = $('#onecontainer');  //第一层容器

                this.model2        = $('#model_2').html();   //第二层末班
                this.model0        = $('#model_0').html();   //第0层末班

                //初始化树
                this.loadTree = function(){
                    $.ajax({
                        'url':urlpath_a+'/sys/office/listOffices4Manager.jhtml',
                        'type':'get',
                        'dataType': "json",
                        success:function(ret){
                            //console.log(ret);
							var jgld_bj = ret.JGLD;

                            var datas = ret.data;
                            var domString;
                            if(!ret.success){
                            	return;
                            }
                            that.onecontainer.html('');

							var companydata = ret.company;
							var companyString = that.comPile(that.model0,companydata);
							that.onecontainer.append(companyString);
							organizeManage.loadUser(1,companydata.id);  //加载用户
							$('#company_id').val(companydata.id);     //将公司id放入隐藏域
							$('.title_company').text(companydata.name);
							$('.title_part').html('');
							$('#part_id').val(companydata.id);
							$('#part_name').val('');
							$('#add_part_btn').data('id',companydata.id);
							$('#add_part_btn').data('pid',companydata.parentId);

							if(!jgld_bj){
								$('#add_part_btn').hide();
								$('.company_set_btn').hide();
							}

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
                        }
                    })
                };

                this.chirldData = function(obj,id){
                    var datas = obj;
                    for(var i in datas){
                        var dictionary = datas[i];
                        if(dictionary.parentId == id){
                        	dictionary.isleaf = that.haveChild(datas,dictionary.id);
							var classLength = dictionary.parentIds.split(",");
							if(classLength.length > 3){
								dictionary.noadd = 'hide';
							}else{
								dictionary.noadd = '';
							}

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

                selClick = function(is){
                    var sel_child = $(is).parent('.one_title').parent('li').find('.sel');

                    if($(is).find('i').hasClass('select')){
                        sel_child.removeClass('select');
                        sel_child.addClass('selected');
                    }else{
                        sel_child.removeClass('selected');
                        sel_child.addClass('select');
                    }
                };

                //数据正则匹配方法
                this.comPile = function(templateString , dictionary){
                    return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                        return dictionary[$1];
                    });
                };

                this.init = function(){
                    this.loadTree();
					$('.tree_container ').off('click').on('click','.togger_click',this.toggerClick);
					$('.tree_container ').on('mouseenter','.togger_click',function(){
						$(this).next('.one_title').addClass('one_title_bg');
					});
					$('.tree_container ').on('mouseleave','.togger_click',function(){
						$(this).next('.one_title').removeClass('one_title_bg');
					})
                }
            }

            var subtree = new subTree;
            subtree.init();
		});
	</script>
</body>
</html>