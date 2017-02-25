<%@ page pageEncoding="utf8"%>
<%@ page import="java.sql.*,  bbs.*, java.util.*"%>


<%
 request.setCharacterEncoding("utf8");
 String search = request.getParameter("search");
 System.out.println(search);
 if(search == null){
 	search = "";
 }
%>

<%
boolean logined = false;
String adminLogined = (String)session.getAttribute("adminlogined");
if(adminLogined != null && adminLogined.trim().equals("true")) {
	logined = true;
} 
 %>

<%
	int pageSize = 2;
 	int pageNo = 1;

	Connection conn = DB.getConn();
	String sql1 ="select count(*) from article where title like '%"+search+"%' or cont like '%"+search+"%' "; 
	Statement stmt = DB.createStmt(conn);
	 System.out.println(sql1);
	ResultSet rs1 = DB.executeQuery(stmt,sql1);
	
	rs1.next();
	int totalPages =(int)Math.ceil(rs1.getInt(1)/(float)pageSize);
	out.println(rs1.getInt(1));
 	
	String pageNoo = request.getParameter("pageNo");
	if(pageNoo!=null){
		pageNo = Integer.parseInt(pageNoo);
	}
	if(pageNo == 0)
	pageNo = 1;
	if(pageNo == totalPages+1)
	pageNo = totalPages;
	
	int begin = (pageNo-1)*pageSize;
	String sql = "select* from article  where title like '%"+search+"%' or cont like '%"+search+"%' limit "+ begin + "," + pageSize ;
	ResultSet rs = DB.executeQuery(stmt, sql); 
	
	List<Article> articles = new ArrayList<Article>();
	try {
		while(rs.next()) {
			Article a = new Article();
			a.initFromRs(rs);
			articles.add(a);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
	    DB.close(conn);
		DB.close(rs);
		DB.close(rs1);
		DB.close(stmt);
		
	}

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 : Java语言*初级版</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?forumID=20">
<script language="JavaScript" type="text/javascript" src="images/common.js"></script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td width="140"><a href="http://bbs.chinajavaworld.com/index.jspa"><img src="images/header-left.gif" alt="Java|Java世界_中文论坛|ChinaJavaWorld技术论坛" border="0"></a></td>
      <td><img src="images/header-stretch.gif" alt="" border="0" height="57" width="100%"></td>
      <td width="1%"><img src="images/header-right.gif" alt="" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-forumpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="98%"><p class="jive-breadcrumbs">论坛: Java语言*初级版
            (模仿)</p>
          <p class="jive-description"> 探讨Java语言基础知识,基本语法等 大家一起交流 共同提高！谢绝任何形式的广告 </p>
          </td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><a href="http://bbs.chinajavaworld.com/post%21default.jspa?forumID=20"><img src="images/post-16x16.gif" alt="发表新主题" border="0" height="16" width="16"></a></td>
          <td class="jive-icon-label"><a id="jive-post-thread" href="post.jsp">发表新主题</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;isBest=1"></a></td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td><span class="nobreak"> 页:
          <%=totalPages %> - <span class="jive-paginator"> [ <a href="search.jsp?pageNo=<%= pageNo-1 %>">上一页</a> | <a href="search.jsp?pageNo=1" class="">1</a> <a href="search.jsp?pageNo=2" class="jive-current">2</a> <a href="search.jsp?pageNo=3" class="">3</a>  | <a href="search.jsp?pageNo=<%= pageNo+1 %>&search=<%= search %>">下一页</a> ] </span> </span></td>
      <td>
      <form action = "search.jsp" method = "post">
      <input type = "text" name = "search"/>
      <input type = "submit" value = "搜索"/>
      </form>
      </td>
      </tr>
      
      </tbody>
     
  </table>
   
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div class="jive-thread-list">
            <div class="jive-table">
              <table summary="List of threads" cellpadding="0" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th class="jive-first" colspan="3"> 主题 </th>
                    <th class="jive-author"> <nobr> 作者
                      &nbsp; </nobr> </th>
                    <th class="jive-view-count"> <nobr> 浏览
                      &nbsp; </nobr> </th>
                    <th class="jive-msg-count" nowrap="nowrap"> 回复 </th>
                    <th class="jive-last" nowrap="nowrap"> 最新帖子 </th>
                  </tr>
                </thead>
                <tbody>
                <%
                String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
                       url += request.getContextPath();
                       url += request.getServletPath();
                       //String url = request.getRequestUrl();
                       url += request.getQueryString() == null ? "" : ("?" + request.getQueryString());//问号后面的内容
                    //System.out.println(url);
                  
                Iterator<Article> it = articles.iterator(); 
                int i=1;
                while(it.hasNext()){
                	Article a = it.next();
                	String classStr = i%2==0?"jive-even":"jive-odd";
                	
				%>
                  <tr class=<%=classStr %>>
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                    <% if(logined){ %>
                    <td nowrap="nowrap" width="1%">&nbsp;
                	<a href="delete.jsp?id=<%=a.getId()%>&isLeaf=<%=a.isLeaf()%>&pid=<%=a.getPid() %>&from=<%=url %>">DEL</a>
                      &nbsp;</td>
                      <%} %>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-1" href="articleFlatDetail.jsp?id=<%=a.getId() %>"><%=a.getTitle() %></a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226030">yyk</a> </span></td>
                    <td class="jive-view-count" width="1%"> 104</td>
                    <td class="jive-msg-count" width="1%"> 5</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(a.getPdate()) %>  --> <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780182#780182" title="jingjiangjun" style="">jingjiangjun &#187;</a> </div></td>
                  </tr>
                  <%
                   i++;
                   } %>
                </tbody>
              </table>
            </div>
          </div>
          <div class="jive-legend"></div></td>
      </tr>
    </tbody>
  </table>
  <br>
  <br>
</div>
</body>
</html>
