<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html style="overflow-x:hidden;overflow-y:hidden;">
<head>
	<title><sitemesh:title/></title><!--  - Powered By GeCoder -->
	<%@include file="/WEB-INF/views/include/head_materialize.jsp" %>
	<sitemesh:head/>
</head>
<body>
	<sitemesh:body/>
	<%@include file="/WEB-INF/views/include/foot_materialize.jsp" %>
</body>
</html>