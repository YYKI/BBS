<%
	
	String adminlogined =(String) session.getAttribute("adminlogined");
	if(adminlogined == null || !adminlogined.trim().equals("true")){
		response.sendRedirect("login.jsp");
		return;
	}
%>