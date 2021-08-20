<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%
	String basePath = request.getScheme() + "://" +
			request.getServerName() + ":" + request.getServerPort() +
			request.getContextPath() + "/";
%>
<html>
<head>
	<base href="<%=basePath%>">
	<script type="text/javascript" src="static/jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript">
	</script>
	<title>欢迎来到注册界面！</title>
<meta charset="UTF-8">
</head>
<body>
	<script type="text/javascript">
		document.location.href = "login.jsp";
	</script>
</body>
</html>