<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String user_id = request.getParameter("user_id");
	String sql = "select statu from 16_s4_user where user_id= "+user_id;
	ResultSet rs = dbUtil.executeQuery(sql);
	if(rs.next()){
		out.print(rs.getString("statu"));
	}else{
		out.print("no user!");
}
%>