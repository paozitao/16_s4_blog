<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*" %>
<%
	DatabaseUtil dbUtil = new DatabaseUtil();
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String title = request.getParameter("title");
	String detail = request.getParameter("detail");
	java.util.Date date = new java.util.Date();
	Timestamp timestamp=new Timestamp(date.getTime());
	String sql =null;
	if(id.equals("0")){
		sql = "insert into 16_s4_blog(name,title,detail,statu,create_time,update_time) values('"+name+"','"+title+"','"+detail+"',1,'"+timestamp+"','"+timestamp+"')";
}else{
		sql = "update blog set statu =1,update_time='"+timestamp+"' where blog_id = "+id;
}
	dbUtil.executeUpdate(sql);
%>
<%=name%>
<%=title%>
<%=timestamp%>