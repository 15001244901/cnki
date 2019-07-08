<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
	<title>纠错记录</title>
	<link rel="stylesheet" href="${ctxStatic}/hsun/front/usercenter/css/error_correction.css${v}">

</head>
<body>
	<div class="user-con">
        <h1>纠错记录</h1>
        <table class="table-record">
            <thead>
                <tr>
                	<td class="no-width no-width1">纠错内容</td>
                    <td class=" fixed-width fixed-width1">提交时间</td>
                    <td class=" fixed-width fixed-width2">纠错状态</td>
                    <!-- <td class=" fixed-width fixed-width3">纠错奖励</td> -->
                    <td class=" fixed-width fixed-width4">操作</td>
                </tr>
            </thead>
            <tbody id="jiucuo">
               <!--  <tr>
                    <td class="no-width no-width1">纠错内容</td>
                     <td class=" fixed-width fixed-width1">2017-7-18</td>
                    <td class=" fixed-width fixed-width2">纠错状态</td>
                    <td class=" fixed-width fixed-width3">纠错奖励</td>
                    <td class=" fixed-width fixed-width4"><a href="javascript:void(0);">查看回复</a></td>
                </tr> -->

            </tbody>
        </table>
        <div class="divPage" id="pagehtml">
        	
		</div>
    </div>
    <script type="text/template" id="template"> 
		<tr>
            <td class="no-width no-width1">{{content}}</td>
             <td class=" fixed-width fixed-width1">{{createDate}}</td>
            <td class=" fixed-width fixed-width2">{{errstate}}</td>
            <!-- <td class=" fixed-width fixed-width3">纠错奖励</td> -->
            <td class=" fixed-width fixed-width4"><a href="{{href}}" target="_blank">查看试题</a></td>
        </tr>
	</script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/jquery.min.js${v}"></script>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>
	<script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
  	<script type="text/javascript" src="${ctxStatic}/hsun/front/usercenter/js/error_correction.js${v}"></script>
</body>
</html>