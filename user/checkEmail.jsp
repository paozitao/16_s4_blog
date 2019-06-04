<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String email = request.getParameter("email");
	String sql = "select * from 16_s4_user where email= '"+email+"'";
	ResultSet rs = dbUtil.executeQuery(sql);
	if(rs.next()){
		out.print("true"); 
	}else{
        out.print("false");
}
%>