<%@ page pageEncoding="utf8"%>
<%@ page import="java.sql.*,  bbs.*, java.util.*"%>

<%@ include file = "_sessionCheck.jsp" %>

<%
        int id = Integer.parseInt(request.getParameter("id"));
		int pid = Integer.parseInt(request.getParameter("pid"));
		boolean isleaf =Boolean.parseBoolean(request.getParameter("isleaf"));
		String url = request.getParameter("from");
		
		boolean autoCommit = true;
		Connection conn = DB.getConn();
		Statement stmt = null;
		ResultSet rs = null;
		 
try {
  		autoCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);
  		
  		delete(conn, id, isleaf);
  		String sql = "select count(*) where pid = "+ pid;
  		stmt = DB.createStmt(conn);
  		rs = DB.executeQuery(stmt,sql);
  		
  		if(rs==null){
  			DB.executeUpdate(conn, "update article set isleaf = 0 where id = " + pid);
  		}
  		
  		conn.commit();
	} finally {
		conn.setAutoCommit(autoCommit);
		if(rs!=null)
		{DB.close(rs);}
		DB.close(stmt);
		DB.close(conn);
	}
		
	response.sendRedirect(url);
 %>
 
 <%!
 	private void delete ( Connection conn, int id, boolean isleaf ){
 		if(! isleaf){
 			String sql = "select* from article where pid = "+ id;
 			Statement stmt = DB.createStmt(conn);
 			ResultSet rs = DB.executeQuery(stmt,sql);
 			try {
				while(rs.next()) {
					delete(conn, rs.getInt("id"), rs.getInt("isleaf") == 0);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DB.close(rs);
				DB.close(stmt);
			}
 		}
 		
 		DB.executeUpdate(conn, "delete from article where id = "+ id );
 	}
  %>
 

  
 