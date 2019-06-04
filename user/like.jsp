<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*" %>
<%
    DatabaseUtil dbUtil = new DatabaseUtil();
    ResultSet rs = null;
	String user_id = request.getParameter("user_id");
	String blog_id = request.getParameter("blog_id");
    String sql4 = "select * from 16_s4_blog where blog_id="+blog_id;
    rs = dbUtil.executeQuery(sql4);
    rs.next();
    int like = rs.getInt("like_count");
    String sql5 = null;
    String sql = "select * from 16_s4_blog_like where user_id = "+user_id+" and blog_id = "+blog_id;
    rs = dbUtil.executeQuery(sql);
    if(rs.next()){
        String id = rs.getString("id");
        String sql2 ="delete from 16_s4_blog_like where id = "+blog_id;
        like--;
        sql5 = "update 16_s4_blog set like_count="+like+" where blog_id = "+blog_id ;
        dbUtil.executeUpdate(sql2);
        dbUtil.executeUpdate(sql5);
    }else{
        String sql3 = "insert into 16_s4_blog_like(user_id,blog_id) values("+user_id+","+blog_id+")";
        like++;
        sql5 = "update 16_s4_blog set like_count="+like+" where blog_id = "+blog_id ;
        dbUtil.executeUpdate(sql3);
        dbUtil.executeUpdate(sql5);
    }
%>