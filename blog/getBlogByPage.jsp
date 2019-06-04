<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*,java.text.*" %>
<%
    DatabaseUtil dbUtil = new DatabaseUtil();
    int pageSize = Integer.parseInt(request.getParameter("pageSize"));
    int pageNum = Integer.parseInt(request.getParameter("pageNum"));
    //        int sum=Integer.parseInt(pageSize)*Integer.parseInt(pageNum);
    int sum = pageSize*pageNum;
        String getCount = " select count(*) from 16_s4_blog where statu=1";
        ResultSet rs=dbUtil.executeQuery(getCount);
        rs.next();
        int count = rs.getInt("count(*)");
    String sql = "select * from 16_s4_blog where statu = 1 order by update_time desc";
        rs=dbUtil.executeQuery(sql);
        rs.absolute((pageNum-1)*pageSize);
        while(rs.next()&&(rs.getRow()<=sum)){
        Timestamp timestamp2 = rs.getTimestamp("create_time");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String time = sdf.format(timestamp2);
        String name = rs.getString("name");
        String title = rs.getString("title");
        String detail = rs.getString("detail");
        String browse = rs.getString("browse_count");
        String like = rs.getString("like_count");
        String review = rs.getString("review_count");
        String id = rs.getString("blog_id");
        String detailsmall = "null";
        if(detail.length()>25){
            detailsmall = detail.substring(0,24)+"...";  
    }else{
            detailsmall = detail;
        }
%>
<div class="container" STYLE="width: 50%;">
    <div class="row ">
        <div class="col-lg-12 ">
            <div class="thumbnail mdui-hoverable ">
                <div class="caption ">
                    <h2 class="hvr-underline-from-center blog-title"><a href="blog/blog.jsp?id=<%=id%>"><%=name%></a></h2>
                    <p class="blog-detail"><%=detailsmall%></p>
                    <p><a class="bg-info imargin mr-2"><i class="fa fa-tag fg-2x"></i><%=title%></a></p>
                    <div class="row imargin">
                        <div class="col-lg-6 text-center"><a ><i class="fa fa-calendar "></i><%=time%></a></div>
                        <div class="col-lg-2"><i class="fa fa-eye "></i><%=browse%></div>
                        <div class="col-lg-2"><i class="fa fa-commenting "></i><%=review%></div>
                        <div class="col-lg-2"><i class="fa fa-thumbs-o-up "></i><%=like%></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
        <%
        }
%>
