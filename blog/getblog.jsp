<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*,java.text.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String id = request.getParameter("id");
	String sql = "select * from 16_s4_blog where blog_id = "+id;
	String sql2 = "null";
	String sql3 = "null";
	ResultSet rs = dbUtil.executeQuery(sql);
	if(rs.next()){
	    Timestamp timestamp2 = rs.getTimestamp("create_time");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH");
    	String time = sdf.format(timestamp2);
		String name = rs.getString("name");
		String title = rs.getString("title");
		String detail = rs.getString("detail");
    	String browse = rs.getString("browse_count");
    	String like = rs.getString("like_count");
    	sql2 = "update 16_s4_blog set browse_count = 1+ "+browse+" where blog_id =" + id;
    	dbUtil.executeUpdate(sql2);
    	%><%=time%>
<%=title%>
<%=name%>
<%=detail%>
<%=browse%><%
}
%>
