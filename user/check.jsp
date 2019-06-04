<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	String sql = "select * from 16_s4_user where email= '"+email+"' and password = '"+pwd+"'";
	out.print(email);
	out.print(pwd);
	ResultSet rs = dbUtil.executeQuery(sql);
	if(rs.next()){
		session.setAttribute("16_s4_blog_user_id",rs.getString("user_id"));
		out.print(rs.getString("user_id"));
	}else{
        out.print("false");
}
%>