<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String user_id = request.getParameter("user_id");
	String blog_id = request.getParameter("blog_id");
	String detail = request.getParameter("detail");
	String sql2 = "select user_name from 16_s4_user where statu=1 and  user_id ="+user_id;
	ResultSet rs = dbUtil.executeQuery(sql2);
	if(rs.next()){
	String user_name=rs.getString("user_name");
	java.util.Date date = new java.util.Date();
	Timestamp timestamp=new Timestamp(date.getTime());
	String sql =null;
	sql = "insert into 16_s4_review(user_name,detail,create_time,user_id,blog_id) values('"+user_name+"','"+detail+"','"+timestamp+"',"+user_id+","+blog_id+")";
	dbUtil.executeUpdate(sql);
	String addCount = "update 16_s4_blog set review_count = review_count +1 where blog_id = "+blog_id;
	dbUtil.executeUpdate(addCount);
}
%>