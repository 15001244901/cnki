<%@ page language="java" pageEncoding="utf-8"%>
<%
String ts = String.valueOf(System.currentTimeMillis());
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>TomExam</title>
	<meta http-equiv="refresh" content="300;URL=heartbeat.jsp?t=<%=ts %>" />
</head>
<body>
	<%=new java.util.Date() %>
</body>
</html>


