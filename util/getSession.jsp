<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*" %>
<%
	String id =(String)session.getAttribute("16_s4_blog_user_id");
	if(id==null){
	out.print("no user");
}else{
	out.print(id);
}
%>