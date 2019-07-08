<%
response.setStatus(403);

//获取异常类
Throwable ex = Exceptions.getThrowable(request);

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	if (ex!=null && StringUtils.startsWith(ex.getMessage(), "msg:")){
		out.print(StringUtils.replace(ex.getMessage(), "msg:", ""));
	}else{
		out.print("操作权限不足.");
	}
}

//输出异常信息页面
else {
%>
<%@page import="com.hsun.ywork.common.web.Servlets"%>
<%@page import="com.hsun.ywork.common.utils.Exceptions"%>
<%@page import="com.hsun.ywork.common.utils.StringUtils"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>403 - 操作权限不足</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>

	<meta name="viewport" content="width=device-width,initial-scale=1.0">
	<style>
		body,html{
			height:100%;
		}
		.container-fuild{
			display: flex;
			justify-content:center;
			align-items:center;
			height:100%;
			padding:0 20px;
		}
		.container-middle{
			padding:0 20px 20px;
			border:2px solid #0A91AE;
			border-radius:10px;

		}
		@media screen and (min-width: 750px){
			.container-middle{
				width:450px;
				margin:0 auto;
			}
			.container-middle .page-header h3{
				font-size:18px;
			}
		}
		@media screen and (max-width: 750px) {
			.container-middle{
				width:100%;
			}
			.container-middle .page-header h3{
				font-size:16px;
			}
		}
	</style>
</head>
<body>
	<div class="container-fuild">
		<div class="container-middle">

			<div class="page-header"><h3>访请确定您已经登录系统，并且具有访问此页面的权限。</h3></div>
			<%
				if (ex!=null && StringUtils.startsWith(ex.getMessage(), "msg:")){
					out.print("<div>"+StringUtils.replace(ex.getMessage(), "msg:", "")+" <br/> <br/></div>");
				}
			%>
			<div><a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a></div>
		</div>

		<script>try{top.$.jBox.closeTip();}catch(e){}</script>
	</div>
</body>
</html>
<%
} out = pageContext.pushBody();
%>