<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<title>个人中心</title>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}" />
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/usercenter/css/center2.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/usercenter/css/center.css${v}">
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/usercenter/css/icon.css${v}">
	<script src="${ctxStatic}/hsun/front/usercenter/js/jquery.min.js${v}"></script>
	<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}" />

	<link rel="stylesheet" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

	<style>
		/*#header .active a{*/
			/*color: #1d272c;*/
			/*background-color: #fff;*/
		/*}*/
		.nav-tabs li:last-child{
			display: none;
		}
		.containers{
			bottom:100px;
		}
		.per_center_fr{
			position: relative;
		}
		.per_center_fr iframe{
			min-height: 754px !important;
			padding:0;margin:0;
			background:#fff;
			padding-bottom:30px;
		}
		#load_image{
			position: absolute;
			display: none;
			/*background: red;*/
			background: url('${ctxStatic}/hsun/front/usercenter/images/loading2.gif') #fff no-repeat center 200px;
			top: 0;left: 0;right: 0;bottom: 0;
		}

	</style>


</head>
<body>
	<div id="divheader"></div>
	<div class="over bg1 container">
		<div id="per_center" class="per_center over auto">
			<div class="per_center_fl fl">
				<div id="fl_infor" class="fl_infor over">
					<div class="fl_infor_for">
						<div class="fl fl_infor_img">
							<!-- <img src="${ctxStatic}/images/userphoto.jpg" alt=""> -->
							<c:set var="userphoto" value="${ctxStatic}/images/userphoto.jpg"/>
							<c:if test="${not empty fns:getUser().photo}">
								<c:set var="userphoto" value="${fns:getUser().photo}"/>
							</c:if>
							<img src="${userphoto}"/>
						</div>
						<div class="fl fl_infor_account">
							<p class="account_num">${fns:getUser().name}</p>
							<p class="account_type"><i class="account_logo"></i>${fns:getUser().name}</p>
						</div>
						<div class="clear"></div>
						<ul class="fl_infor_class">
							<li>
								<p class="bor_r">
									<span>0</span>
									积分
								</p>
							</li>
							<li>
								<p>
									<span>0</span>
									学币
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div id="user-using" class="user-using">
				    <ul>
				    	<!-- 个人设置 -->
				    	<li>
				            <div class="mt up_user"><span href="javascript:;"><i class="icona-set"></i>个人设置</span><b class="icona-right2"></b></div>
				            <div class="mc mc1">
				                <p><a class="user_btn" data-src="${ctxRoot}/a/sys/user/info" href="javascript:void(0);"><i class="icona-ellipsesm"></i>个人信息</a></p>
				                <p><a class="user_btn" data-src="${ctxRoot}/a/sys/user/modifyPwd" href="javascript:void(0);"><i class="icona-ellipsesm"></i>安全管理</a></p>
				            </div>
				        </li>
				        <!-- 我的消息 -->
						<%--<li><a class="user_btn" data-src="wdxx" href="javascript:void(0);"><i class="icona-msg"></i>我的问答</a></li>--%>
						<li>
							<div class="mt up_user"><span href="javascript:;"><i class="center_video "></i>我的课程</span><b class="icona-right2"></b></div>
							<div class="mc mc2">
								<p><a class="user_btn" data-src="${ctxRoot}/course/myCourses" href="javascript:void(0);"><i class="icona-ellipsesm"></i>在学视频</a></p>
								<!--  <p><a class="user_btn" data-src="standard_collection.html" href="javascript:void(0);"><i class="icona-ellipsesm"></i>标准收藏</a></p> -->
								<p><a class="user_btn" data-src="${ctxRoot}/course/myFavourites" href="javascript:void(0);"><i class="icona-ellipsesm"></i>课程收藏</a></p>
							</div>
						</li>

						<li>
							<div class="mt up_user"><span href="javascript:;"><i class="icona-msg"></i>我的问答</span><b class="icona-right2"></b></div>
							<div class="mc mc2">
								<p><a class="user_btn" data-src="${ctxRoot}/qa/myqa/list" href="javascript:void(0);"><i class="icona-ellipsesm"></i>我的提问</a></p>
								<!--  <p><a class="user_btn" data-src="standard_collection.html" href="javascript:void(0);"><i class="icona-ellipsesm"></i>标准收藏</a></p> -->
								<p><a class="user_btn" data-src="${ctxRoot}/qa/myrepqa/list" href="javascript:void(0);"><i class="icona-ellipsesm"></i>我的回答</a></p>
							</div>
						</li>
						<!-- 我的收藏 -->
						<li>
				            <div class="mt up_user"><span href="javascript:;"><i class="icona-shoucang2"></i>我的收藏</span><b class="icona-right2"></b></div>
				            <div class="mc mc2">
				                <p><a class="user_btn" data-src="library_collection.html" href="javascript:void(0);"><i class="icona-ellipsesm"></i>文库收藏</a></p>
				            </div>
				        </li>
				    </ul>
				</div>

				
			</div>
			<div class="per_center_fr fr">
					<iframe frameborder="0" src="${ctxRoot}/a/sys/user/info" id="center_iframe" name="center_iframe" width="100%" scrolling="no"  marginwidth="0" marginheight="0" >
						

					</iframe>
					<div id="load_image">	
							
					</div>
	               <!--  <h1>纠错记录</h1>
	                <table class="table-record">
	                    <thead>
		                    <tr>
		                        <td class=" fixed-width fixed-width1">试题ID</td>
		                        <td class="no-width no-width1">纠错内容</td>
		                        <td class=" fixed-width fixed-width2">纠错状态</td>
		                        <td class=" fixed-width fixed-width3">纠错奖励</td>
		                        <td class=" fixed-width fixed-width4">操作</td>
		                    </tr>
	                    </thead>
	                    <tbody id="jiucuo">
		                    <tr>
		                        <td class=" fixed-width fixed-width1">试题ID111111111111111111111</td>
		                        <td class="no-width no-width1">纠错内容</td>
		                        <td class=" fixed-width fixed-width2">纠错状态</td>
		                        <td class=" fixed-width fixed-width3">纠错奖励</td>
		                        <td class=" fixed-width fixed-width4"><a href="javascript:void(0);">查看回复</a></td>
		                    </tr>
		                     <tr>
		                        <td class=" fixed-width fixed-width1">试题ID111111111111111111111</td>
		                        <td class="no-width no-width1">纠错内容</td>
		                        <td class=" fixed-width fixed-width2">纠错状态</td>
		                        <td class=" fixed-width fixed-width3">纠错奖励</td>
		                        <td class=" fixed-width fixed-width4"><a href="javascript:void(0);">查看回复</a></td>
		                    </tr>
	                    </tbody>
	                </table> -->
			</div>
		</div>
	</div>

	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
	<script>
		

		$(function(){

			var Center = function(){
				var that = this;
				this.userbtn = $('.user_btn');
				this.upuser  = $('.up_user');
				this.perfr   = $('.per_center_fr');
				this.load_image  = $('#load_image');
				this.percenterfr = $('#center_iframe');
				this.divheader   = $('#divheader');

				this.userBtn = function(){
					$('#load_image').show();
					var htmlName = $(this).attr('data-src');
					that.userbtn.removeClass('using-active');
					$(this).addClass('using-active');
					that.onload(htmlName);
					// iframeHeight();
				};

				this.onload = function(p){
					// that.percenterfr.load(p);
					var timestamp = new Date().getTime();
					that.percenterfr.attr('src',p+'?time='+timestamp);
				};
				//默认frame加载内容

				this.upUser = function(){
					if($(this).parent('li').find('.mc').css('display') == 'none'){
						$(this).parent('li').addClass('bg2');
						$(this).parent('li').find('.mc').show();
					}else{
						$(this).parent('li').removeClass('bg2');
						$(this).parent('li').find('.mc').hide();
					}
					
				};
				
				this.loadHead = function(){
					that.divheader.load(projectname + "/page/include/headerquestion.html"+timestamps);
				};
				this.init = function(){
					this.loadHead();
					this.upuser.off('click').on('click',this.upUser);
					this.userbtn.off('click').on('click',this.userBtn);
				}
			};

			var center = new Center();
			center.init();
		});

		function hei(){
			var mainheight = $("#center_iframe").contents().find("body").height()+20;
		    $("#center_iframe").height(mainheight);
		    $('#load_image').hide();
		}

		function alertAnim(msg){
			layer.msg(
					msg,
					{
						anim:4,
						time:3000
						// title:'系统提示',
					}
			);
		}
		//iframe高度自适应
		// function iframeHeight(){
		// 	$("#center_iframe").load(function () {
		// 	    var mainheight = $(this).contents().find("body").height()+20;
		// 	    $(this).height(mainheight);
			    
		// 	});
		// }
		
	</script>
</body>
</html>