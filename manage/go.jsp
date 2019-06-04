<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*,java.text.*" %>
<%
    if(session.getAttribute("16_s4_admin")==null){
%>
    <script>
        history.back();
    </script>
<%
}else if((int)session.getAttribute("16_s4_admin")==1){
    DatabaseUtil dbUtil = new DatabaseUtil();
    int pageSize = Integer.parseInt(request.getParameter("pageSize"));
    int pageNum = Integer.parseInt(request.getParameter("pageNum"));
    //        int sum=Integer.parseInt(pageSize)*Integer.parseInt(pageNum);
    int sum = pageSize*pageNum;
        String getCount = " select count(*) from 16_s4_user";
        ResultSet rs=dbUtil.executeQuery(getCount);
        rs.next();
        int count = rs.getInt("count(*)");
        out.print(count);
                out.print(sum);
        String sql = "select user_id,user_name,statu,create_time from 16_s4_user order by create_time Asc ";
        rs=dbUtil.executeQuery(sql);
        rs.absolute((pageNum-1)*pageSize);
        while(rs.next()&&(rs.getRow()<=sum)){
        out.print(count);
        Timestamp timestamp2 = rs.getTimestamp("create_time");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = sdf.format(timestamp2);
        String id = rs.getString("user_id");
        String name = rs.getString("user_name");
        String statu = rs.getString("statu");
%>
        <tbody >
        <tr id="<%=id%>">
            <th class="col-lg-2 text-center"><%=id%></th>
            <th class="col-lg-2 text-center"><%=name%></th>
            <th class="col-lg-2 text-center"><%=time%></th>
            <th class="col-lg-1 text-center" name="statu">
                <%
                if(statu.equals("1")){
                out.print("正常");
                }else if (statu.equals("0")){
                out.print("冻结");
                }else {
                out.print("已删除");
                }
                %>
            </th>
            <th class="col-lg-5 text-center">
                <a class="col-lg-3 btn btn-info text-center " onclick="blockUser(<%=id%>)"><i class="fa fa-snowflake-o fa-lg"></i>冻结</a>
                <div class="col-lg-1"></div>
                <a class="col-lg-3 btn btn-primary text-center" onclick="normalUser(<%=id%>)"><i class="fa fa-rocket fa-lg"></i>恢复</a>
                <div class="col-lg-1"></div>
                <a class="col-lg-3 btn btn-danger  text-center" onclick="userDelete(<%=id%>)"><i class="fa fa-trash-o fa-lg"></i>删除</a>
            </th>
        </tr>
        </tbody>
        <%
        }
}
%>
