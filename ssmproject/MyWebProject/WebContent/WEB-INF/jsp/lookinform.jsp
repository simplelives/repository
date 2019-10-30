<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看信息</title>
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
#con{
	width:1200px;
	height:auto;
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
<% String path = request.getContextPath(); %>
<div id="daohang">
</div>
<div id="con">
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
<table cellspacing="20">
<c:forEach var="i" begin="0" end="${goodsList.size()/3-1 }">
<tr>
<td width="300px"><img alt="待发现" src="<%=path %>/images/goods/${goodsList.get(3*i).getPic()}"/>
${goodsList.get(3*i).getTime()} ${goodsList.get(3*i).getWord() }</td>
<td width="300px"><img alt="待发现" src="<%=path %>/images/goods/${goodsList.get(3*i+1).getPic()}"/>
${goodsList.get(3*i+1).getTime()} ${goodsList.get(3*i+1).getWord() }</td>
<td width="300px"><img alt="待发现" src="<%=path %>/images/goods/${goodsList.get(3*i+2).getPic()}"/>
${goodsList.get(3*i+2).getTime()} ${goodsList.get(3*i+2).getWord() }</td>
</tr>
</c:forEach>
</table>
</div>
</div>
</body>
</html>