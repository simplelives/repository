<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改密码</title>
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
		url: "./modpwdjude.do",
		data: $("#form").serialize(),
		success: function(data){
			if(data=="success"){
				alert("修改成功");
				$("#orgpwd").val("");
				$("#newpwd").val("");
				$("#compwd").val("");
			}else{
				alert("修改失败");
				$("#orgpwd").val("");
				$("#newpwd").val("");
				$("#compwd").val("");
			}
		}
	});
}
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
<form  id="form">
原密码：<input type="password" name="orgpwd" id="orgpwd"><br/><br/>
新密码：<input type="password" name="newpwd" id="newpwd"><br/><br/>
再次确认密码：<input type="password" name="compwd" id="compwd"><br/><br/>
</form>
<button onclick="func()">确认提交</button>
</div>
</body>
</html>