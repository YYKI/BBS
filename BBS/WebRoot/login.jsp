<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	String action = request.getParameter("action");
	if(action != null && action.trim().equals("login")){
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(username == null || !username.trim().equals("admin")){
			out.println("username is not valid");
		}else if(password == null || !password.trim().equals("admin")){
				out.println("password is not valid");
		}else{
			session.setAttribute("adminlogined", "true");
			response.sendRedirect("articleFlat.jsp");
		}
	}
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <form action = 'login.jsp' method = "post">
  <input type = hidden name = "action" value = "login">
    用户名：<input type = text name = "username"></input><br>
    密　码：<input type = password name = "password"></input>
  <br>
  <input type = "submit" value = "登录"></input>
  </form>
    
  </body>
</html>
