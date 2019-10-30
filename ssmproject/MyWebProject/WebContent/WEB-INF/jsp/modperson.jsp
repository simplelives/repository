<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改个人基本信息</title>
<script src="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
<script src="http://code.jquery.com/jquery-3.2.0.js"></script>
<script>
function exit(){
	var r = confirm("确认要退出吗？");
	if(r==true){
		window.location.href="./exit.do";
	}
}
function func(){
	$.post({
		url: "./sendmail.do",
		success: function(data){
			if(data=="success"){
				alert("验证码已发送到您的QQ邮箱");
				
			}else{
				alert("请等待");
			}
		}
	});
}
$(document).ready(function(){
	$("#commit").click(function(){
		$.post({
			url: "./modifyperson.do",
			data: $("#form").serialize(),
			success: function(data){
				if(data=="success"){
					alert("修改成功");
					$("#name").val("");
					$("#sex").val("男");
					$("#age").val("");
					$("#mail").val("");
					$("#validate").val("");
				}else if(data=="error"){
					alert("修改失败");
					$("#name").val("");
					$("#sex").val("男");
					$("#age").val("");
					$("#mail").val("");
					$("#validate").val("");
				}
			}
		});
	});
});
</script>
<style>
body{
	margin:0;
	pdding:0;
	}
#daohang{
	width:auto;
	height:130px;
	margin:0;
	background:url(<%=request.getContextPath() %>/images/daohang.jpg);
	}
#MenuBar1{
	height:300px;
	background-color:#eeeeee;
	float:left;
	}
#content{
	width:400px;
	height:400px;
	margin-left:200px;
	float:left;
}
</style>
</head>

<body bgcolor="#eeeeee">
<div id="daohang">
</div>
<ul id="MenuBar1" class="MenuBarVertical">
  <li><a class="MenuBarItemSubmenu" href="#">个人信息</a>
    <ul>
      <li><a href="./person.do">个人基本信息</a></li>
      <li><a href="./modperson.do">修改基本信息</a></li>
      <li><a href="./modpwd.do">修改密码</a></li>
    </ul>
  </li>
  <li><a href="./campus.do">校园动态</a></li>
  <li><a class="MenuBarItemSubmenu" href="#">失物招领</a>
    <ul>
      <li><a href="./lookinform.do">查看信息</a></li>
      <li><a href="./issuance.do">发布信息</a></li>
    </ul>
  </li>
  <li><a href="./communicate.do">交流中心</a></li>
  <li><a href="#" onclick="exit()">退出登录</a></li>
</ul>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgRight:"<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBarRightHover.gif"});
</script>
<div id="content" align="right">
    <form id="form">
      姓名：<input type="text" name="name" placeholder="姓名" id="name"><br/><br/>
      性别：<select name="sex" id="sex">
      	<option value="man">男
        <option value="female">女
      </select><br/><br/>
      年龄：<input type="text" name="age" placeholder="年龄" id="age"><br/><br/>
      QQ邮箱：<input type="email" name="mail" placeholder="qq邮箱" id="mail"><br/><br/>
      验证码：<input type="text" name="validate" placeholder="输入验证码" id="validate"><br/><br/>
    </form>
    <button id="yanzheng" onclick="func()">获取验证码</button><br/><br/>
    <button id="commit">确认修改</button>
</div>
</body>
</html>