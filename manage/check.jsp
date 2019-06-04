<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String un = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String sql = "select * from 16_s4_admin where name= '"+un+"' and password = '"+pwd+"'";
	ResultSet rs = dbUtil.executeQuery(sql);
	if(rs.next()){
		session.setAttribute("16_s4_admin",1);
		out.print("true"); 
	}else{
        //response.setHeader("Refresh","0;url=../admin.html");
        out.print("false");
}
%>