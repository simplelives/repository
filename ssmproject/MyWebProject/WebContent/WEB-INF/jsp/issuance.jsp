<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发布信息</title>
<script src="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
<script>
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
	margin-left:200px;
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
<p>上传的图片像素大小为300*200，单个图片大小5MB，总上传量不得超过10MB</p>
<form action="./upload.do" method="post" enctype="multipart/form-data">
上传图片：<input type="file" name="pic"><br/>
丢失地点：<input type="text" name="describe"><br/>
<input type="submit" value="提交">
</form>
<br/>
<c:out value="${msg}"></c:out>
</div>
</body>
</html>