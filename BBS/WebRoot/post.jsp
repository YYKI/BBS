<%@ page pageEncoding="utf8"%>
<%@ page import="java.sql.*,  bbs.*, java.util.*"%>


<%
 request.setCharacterEncoding("utf8");

String action = request.getParameter("action");
if(action!=null && action.trim().equals("post")){
	String title = request.getParameter("title");
	//System.out.println(title);
	String cont = request.getParameter("cont");
	Connection conn = DB.getConn();
	
	boolean autoCommit = conn.getAutoCommit();
	conn.setAutoCommit(false);
	
	int rootid = -1;
	String sql = "insert into article values (null, ?, ?, ?, ?, now(), ?)";
	PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	pstmt.setInt(1, 0);
	pstmt.setInt(2, rootid);
	pstmt.setString(3, title);
	pstmt.setString(4, cont);
	pstmt.setInt(5, 0);
	pstmt.executeUpdate();
	ResultSet rs = pstmt.getGeneratedKeys();
	while(rs.next()){
		rootid = rs.getInt(1);
		System.out.println(rootid);
	}
	
	Statement stmt = DB.createStmt(conn);
	stmt.executeUpdate("update article set rootid = " + rootid + " where id ="+rootid);
	
	conn.commit();
	conn.setAutoCommit(autoCommit);
	
	DB.close(pstmt);
	DB.close(stmt);
	DB.close(conn);
	
	response.sendRedirect("articleFlat.jsp");
}


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 :</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?threadID=744236">
<script type = "text/javascript" src = ckeditor/ckeditor.js></script>


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
<div id="jive-flatpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><p class="jive-breadcrumbs"> <a href="http://bbs.chinajavaworld.com/index.jspa">首页</a> &#187; <a href="http://bbs.chinajavaworld.com/forumindex.jspa?categoryID=1">ChinaJavaWorld技术论坛|Java世界_中文论坛</a> &#187; <a href="http://bbs.chinajavaworld.com/category.jspa?categoryID=2">Java 2 Platform, Standard Edition (J2SE)</a> &#187; <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0">Java语言*初级版</a> </p>
          <p class="jive-page-title"> 主题: 新主题 </p></td>
        <td width="1%"><div class="jive-accountbox"></div></td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><a href="http://bbs.chinajavaworld.com/post%21reply.jspa?threadID=744236"><img src="images/reply-16x16.gif" alt="回复本主题" border="0" height="16" width="16"></a></td>
          <td class="jive-icon-label"><a id="jive-reply-thread" href="reply.jsp">回复本主题</a> </td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div id="jive-message-holder">
            <div class="jive-message-list">
              <div class="jive-table">
                <div class="jive-messagebox">
                 <form action = "post.jsp" method = "post">
                 	<input type = "hidden" name = "action" value = "post">
            		标题:<input type="text" name = "title"><br>
            		内容:<textarea name = "cont" rows = "15" cols = "80"  ></textarea>
            		<script type = "text/javascript" >CKEDITOR.replace('cont');</script>
            		<br>
            		<input type = "submit" value = "submit">
                 </form>
                
						
                </div>
              </div>
            </div>
            
            <div class="jive-message-list-footer">
           
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tbody>
                  <tr>
                    <td nowrap="nowrap" width="1%"></td>
                    <td align="center" width="98%"><table border="0" cellpadding="0" cellspacing="0">
                        <tbody>
                          <tr>
                            <td><a href="article.jsp"><img src="images/arrow-left-16x16.gif" alt="返回到主题列表" border="0" height="16" hspace="6" width="16"></a> </td>
                            <td><a href="article.jsp">返回到主题列表</a> </td>
                          </tr>
                        </tbody>
                      </table></td>
                    <td nowrap="nowrap" width="1%">&nbsp;</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div></td>
        <td width="1%"></td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
