<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("user_name");
	java.util.Date date = new java.util.Date();
	Timestamp timestamp=new Timestamp(date.getTime());
	String sql = "insert into 16_s4_user(email,user_name,password,create_time) values('"+email+"','"+name+"','"+pwd+"','"+timestamp+"')";
	dbUtil.executeUpdate(sql);
	String sql2 = "select * from 16_s4_user where email= '"+email+"' and password = '"+pwd+"'";
	ResultSet rs = dbUtil.executeQuery(sql2);
	if(rs.next()){
	session.setAttribute("16_s4_blog_user_id",rs.getString("user_id"));
    response.setHeader("Refresh","0;url=../index.jsp");
}
%>