<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*" %>
<%
    if(session.getAttribute("16_s4_admin")==null){
%>
	<script>
        history.back();
    </script>
<%
}else if((int)session.getAttribute("16_s4_admin")==1){
	DatabaseUtil dbUtil = new DatabaseUtil();
	String id = request.getParameter("id");
	String statu = request.getParameter("statu");
	java.util.Date date = new java.util.Date();
	Timestamp timestamp=new Timestamp(date.getTime());
	String sql = "update 16_s4_user set statu = "+statu+" where user_id = "+id;
	dbUtil.executeUpdate(sql);
}
%>