<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人基本信息</title>
<script src="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function exit(){
	var r = confirm("确认要退出吗？");
	if(r==true){
		window.location.href="./exit.do";
	}
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
<div id="content">
<table width="500px" height="500px" cellspacing="0" cellpadding="0" style="margin-top:5px">
<tr>
<td align="center" colspan="2" width="300px" height="100px" style="color:white; background-color:#00355d; font-size:23px">个人基本信息</td>
</tr>
<tr>
<td align="center" width="300px" height="100px">姓名:<c:out value="${list.get(0)}"></c:out></td>
<td rowspan="2" align="center" width="200px" height="200px"><img src="<%=request.getContextPath() %>/images/<c:out value="${list.get(4)}"></c:out>.jpg">头像</td>
</tr>
<tr>
<td align="center" width="300px" height="100px">性别:<c:out value="${list.get(1)}"></c:out></td>
</tr>
<tr>
<td align="center" width="300px" height="100px">年龄:<c:out value="${list.get(2)}"></c:out></td>
</tr>
<tr>
<td align="center" width="300px" height="100px">QQ邮箱:<c:out value="${list.get(3)}"></c:out></td>
</tr>
</table>
</div>
</body>
</html>