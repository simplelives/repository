<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>交流中心</title>
<script src="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/js/SpryAssets/SpryMenuBarVertical.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://cdn.bootcss.com/jquery/3.1.0/jquery.min.js"></script>  
<script type="text/javascript" src="http://cdn.bootcss.com/sockjs-client/1.1.1/sockjs.js"></script>  

<script type="text/javascript">
	var host = window.location.host;
    var websocket = null; 
    if ('WebSocket' in window) { 
        //Websocket的连接  
        websocket = new WebSocket("ws://"+host+"/MyWebProject/guidian/websocket/socketServer.do");//WebSocket对应的地址   
    }else if ('MozWebSocket' in window) {  
        //Websocket的连接  
    	websocket = new MozWebSocket("ws://"+host+"/MyWebProject/guidian/websocket/socketServer.do");//WebSocket对应的地址 
    }  
    else {  
        //SockJS的连接 
    	websocket = new SockJS("http://"+host+"/MyWebProject/guidian/sockjs/socketServer.do");    //SockJS对应的地址
    }  
    websocket.onopen = onOpen;  
    websocket.onmessage = onMessage;  
    websocket.onerror = onError;  
    websocket.onclose = onClose;  
  
    function onOpen(openEvt) {  
        //alert(openEvt.Data);   
    }  
  
    function onMessage(evt) {  
        $("#content").append(evt.data+"<br>"); // 接收后台发送的数据
    }  
    function onError() {  
    	
    }  
    function onClose() {  
    }  
  
    function doSend() {  
        if (websocket.readyState == websocket.OPEN) {
        	$("#content").append("本人："+$("#inputMsg").val()+"<br>");
            websocket.send($("#targetName").val()+"@"+$("#inputMsg").val());//调用后台handleTextMessage方法  
            
        } else {  
        
            alert("连接失败!"+websocket.readyState);  
        }  
    }  
  
    window.close = function () {  
        websocket.onclose();  
    }  
</script>
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
#con{
	width:1200px;
	height:auto;
}
#MenuBar1{
	height:300px;
	background-color:#eeeeee;
	float:left;
	}
#base{
	float:left;
}
#content{
	float:left;
	box-shadow:0px 0px 5px red;
}
</style>
</head>

<body bgcolor="#eeeeee">
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
<div id="base">
请输入目标名称：<input type="text" id = "targetName" /><br/><br/>
请输入：<textarea rows="3" cols="80" id="inputMsg" name="inputMsg"></textarea><br/><br/>  
<button onclick="doSend();">发送</button>
</div> 
<div id="content">
</div>
</div>
</body>
</html>