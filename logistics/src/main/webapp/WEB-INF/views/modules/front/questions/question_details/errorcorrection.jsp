<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">
		<title>地理云课堂</title>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">
		<%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>--%>
		
		
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}"></script>
		<%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
		<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
		<script type="text/javascript">
			$.ajax({
				url:urlpath+'/validateUser.jhtml',
				async:false,
				success:function(ret) {
					if(!ret.data) {
						top.window.location.href = urlpath+'/frontlogin';
					}
				}
			});
		</script>
		<style>
			#footer{
				display: none;
			}
			.btn{
				cursor: pointer;
				border:none;
				color: #fff;
				padding:5px 10px;
				border-radius: 3px;
				transition: background-color 0.3s;
			}
			.closePage{
				 background: #F59B4D;
			 }
			.closePage:hover{
				background: #F78324;
			}
			.saveError{
				background: #5FC98B;
			}
			.saveError:hover{
				background: #3db06e;
			}
			#inp_img{
				height:30px;
				border:1px solid #A9A9A9;
			}
		</style>
	</head>

	<body>
		<div>
			<div style="margin-top: 10px;margin-left:20px;font-size: 14px;">
				为方便我们排查错误，请您详细描述本题错误，例如：
			</div>
			<div>
				<textarea id="txtContent" style="width: 535px;height: 120px;margin: 10px 20px;"></textarea>
			</div>
			<div>
				<div style="width: 500px;margin-left: 20px;">
					<input style="height: 30px;vertical-align: top;" type="text" name="text" maxlength="5" placeholder="验证码" id="inp_text">
					<span id="fault" class="color4 fz12 fault"></span>
					<img style="clear: both;" src="${ctxRoot}/servlet/validateCodeServlet" onclick="$('.validateCodeRefresh').click();" alt="" id="inp_img" class="mid validateCode">

					<a style="margin-left: 10px;position: absolute;margin-top: 6px;text-decoration: none;color: #007AFF;font-size: 13px;" href="javascript:" onclick="$('.validateCode').attr('src','${ctxRoot}/servlet/validateCodeServlet?'+new Date().getTime());" class="mid validateCodeRefresh" style="">看不清</a>
				</div>
			</div>
			<div style="text-align: center;margin-top: 20px;">
				<input class="closePage btn" type="button" value="关闭" onclick="errorcorrection.closePage()" />
				<input class="saveError btn" type="button" value="提交错误" onclick="errorcorrection.saveError()" />
				<input type="hidden" id="hidQid" />
			</div>
		</div>
	</body>

</html>
<script type="text/javascript" src="${ctxStatic}/hsun/front/js/pagejs/questions/question_details/errorcorrection.js${v}"></script>