<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%
	String basePath = request.getScheme() + "://" +
			request.getServerName() + ":" + request.getServerPort() +
			request.getContextPath() + "/";
%>
<html>
<head>
	<base href="<%=basePath%>">
	<title>欢迎来到注册界面！</title>
<link href="static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function () {
			if (window.top !== window){
				window.top.location = window.location;
			}
			$("#loginact").focus();
			$("#loginact").val("");
			$("#submitbutton").click(function () {
				login();
			})
			$(window).keydown(function (event) {
				if(event.keyCode === 13){
					login();
				}
			})
			$("#weatherBTN").click(function () {
				$.ajax({
					url:"user/queryWeather",
					data:{
						"city":$("#weather").val()
					},
					type:"get",
					dataType:"json",
					error:function () {
						var messagr = "${sessionScope.message}"
						if (messagr !== ''){
							alert("${sessionScope.message}");
						}else {
							alert("发生了未知的异常，请联系幽灵猫...");
						}
					},
					success:function (response) {
						$("#t1").html("当前城市:" + response.result.result.city);
						$("#t2").html("天气天气:" + response.result.result.weather);
						$("#t3").html("当前时间:" + response.result.result.date);
					}
				})
			})
		})
		function login() {
			var loginact = $.trim($("#loginact").val());
			var loginpwd = $.trim($("#loginpwd").val());
			if (loginact === "" || loginpwd === ""){
				$("#msg").html("账号或密码不能为空！");
				return false;
			}
			//alert("执行了登陆操作！");
			$.ajax({
				url:"user/loginJudgeActandPwd.do",
				data:{
					"loginAct":$("#loginact").val(),
					"loginPwd":$("#loginpwd").val()
				},
				type:"post",
				dataType:"json",
				error:function () {
					alert("发生了未知的错误！请联系幽灵猫.");
				},
				success:function (response) {
					$.each(response,function (index,element) {
						if (element.success){
							window.location.href = "static/workbench/index.jsp";
						}else {
							alert(element.exception);
							$("#msg").html(element.exception);
						}
					})
				}
			})
		}
	</script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="static/image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
	</div>
	<div style="position: absolute; top: 300px; left: 300px;">
		<input class="form-control" type="text" placeholder="请输入所在地查询天气" id="weather">
		<input type="button" id="weatherBTN" value="提交"><br>
		<span style="font-size: 30px; color: red;" id="t1"></span><br>
		<span style="font-size: 30px; color: red;" id="t2"></span><br>
		<span style="font-size: 30px; color: red;" id="t3"></span>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="static/workbench/index.jsp" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="loginact">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="loginpwd">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						
							<span id="msg" style="color: red"></span>
						
					</div>
					<button type="button" id="submitbutton" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>