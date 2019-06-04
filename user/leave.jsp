<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*" %>
<%
	session.removeAttribute("16_s4_blog_user_id");
    response.setHeader("Refresh","0;url=../index.jsp");  
%>