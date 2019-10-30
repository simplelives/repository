<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登录</title>
<link rel="stylesheet" href="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="https://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script src="http://code.jquery.com/jquery-3.2.0.js"></script>
<script>
$(document).ready(function() {
	var i = 0;
	$("#form1").show();
	$("#form2").hide();
	$("#p1").hide();
    $("#login").click(function(){
    		i = i+1;
			$("#a1").animate({left:'0px'}).css("z-index","1");
			$("#a2").animate({left:'0px'}).css("z-index","2");
			$("#form2").hide(1000);
			$("#form1").show(1000);
			$("#p1").hide();
			$("#p2").fadeIn(3000);
			$("#p3").fadeIn(3000);
			if(i%2==1){
				$.post({
					url: "./login.do",
					data: $("#logform").serialize(),
					success: function(data){
						if(data=="success"){
							window.location.href="./main.do";
						}else if(data=="error"){
							alert("登录失败，账号或密码错误！");
						}
							
					}
				});
				i = i-1;
			}
		});
	$("#register").click(function(){
			i = i+1;
			$("#a1").animate({left:'400px'}).css("z-index","2");
			$("#a2").animate({left:'-400px'}).css("z-index","1");
			$("#form2").show(1000);
			$("#form1").hide(1000);
			$("#p2").hide();
			$("#p3").hide();
			$("#p1").fadeIn(4000);
			if(i%2==0){
				if($("#regusername").val()==""||$("#regpassword").val()==""){
					alert("用户名或密码不能为空!");
				}else{
				$.post({
					url: "./register.do",
					data: $("#regform").serialize(),
					success: function(data){
						if(data=="ok"){
							alert("注册成功！");
							i = i+1;
							$("#a1").animate({left:'0px'}).css("z-index","1");
							$("#a2").animate({left:'0px'}).css("z-index","2");
							$("#form2").hide(1000);
							$("#form1").show(1000);
							$("#p1").hide();
							$("#p2").fadeIn(3000);
							$("#p3").fadeIn(3000);
						}else if(data=="no"){
							alert("注册失败！用户名已存在！");
						}
					}
				});
				}
				i = i-1;
			}
		});
	
});
</script>
<style>
body{
	height:100%;	
	}
#content{
	margin:0 auto;
	width:800px;
	height:500px;
	position:relative;
	top:60px;
	}
#a1{
	width:400px;
	height:500px;
	position:relative;
	background-color:#FFF;
	box-shadow:10px 10px 5px #666666;
	z-index:1;
	float:left;
	}
#a2{
	width:400px;
	height:500px;
	position:relative;
	background-color: #F06;
	box-shadow:10px 10px 5px #666666;
	z-index:2;
	float:left;
	}
#login{
	width:150px;
	position:relative;
	left:120px;
	}
#register{
	width:150px;
	position:relative;
	left:120px;
	}
#form1{
	width:300px;
	height:200px;
	margin:0 auto;
	position:relative;
	top:80px;
	}
#form2{
	width:300px;
	height:360px;
	margin:0 auto;
	position:relative;
	top:50px;
	}
</style>
</head>
<body bgcolor="#CCCCCC">
<div id="content">
<div id="a1">
<div id="form1">
  <div data-role="main" class="ui-content">
    <form id="logform">
      <input type="text" name="username" placeholder="用户名" id="username">
      <input type="password" name="password" placeholder="密码" id="password">
      
    </form>
  </div>
</div>
<button id="login">登录</button>
<p id="p1" align="center" style="font-size:25px; color:#F06">等你加入</p>
</div>
<div id="a2">
<div id="form2">
  <div data-role="main" class="ui-content">
    <form id="regform">
      <input type="text" name="username" placeholder="用户名" id="regusername">
      <input type="password" name="password" placeholder="密码" id="regpassword">
      <input type="text" name="name" placeholder="姓名">
      <select name="sex">
      	<option value="man">男
        <option value="female">女
      </select>
      <input type="text" name="age" placeholder="年龄">
      <input type="email" name="mail" placeholder="qq邮箱">
    </form>
  </div>
</div>

<button id="register">注册</button>
<p id="p2" align="center" style="color:#FFF; font-size:30px">桂林电子科技大学北海校区</p>
<p id="p3" align="center" style="color:#FFF; font-size:20px">网上交流平台</p>
</div>
</body>
</html>