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

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="../src/pic/favicon.ico">

    <title>白荷</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/cssmain.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/marked.min.js"></script>
    <link rel="stylesheet" href="../css/md.css">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/hover.css/2.3.1/css/hover-min.css" rel="stylesheet">
</head>
<body >
<div class="container" style="width: 70%">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand text-center" href="../index.jsp">
                    <img src="../src/pic/favicon.ico" style="position:relative;bottom: 20%;: margin-bottom: 20%">
                </a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a class="btn" href="manage.jsp" onclick="$('#clear').click()">写点啥</a></li>
                    <li class="dropdown active">
                        <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">巡巡山<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="blog.jsp">博文那片山头</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="review.jsp" class='btn btn-info active'>评论那块场子</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a  href="user.jsp">游客那帮孩子</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-right" name="search" action="../blog/searchn.jsp">
                    <div class="form-group">
                        <input type="text" class="form-control " placeholder="标题" id="blogName" name="blogName">
                    </div>
                    <button type="submit" class="btn btn-info hvr-grow" id="find">查找</button>
                </form>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">标签分类<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../blog/searcht.jsp?blogTitle=日记"><i class="fa fa-pencil fa-fw"></i>日记</a></li>
                            <li><a href="../blog/searcht.jsp?blogTitle=心情"><i class="fa fa-plane fa-fw"></i>心情</a></li>
                            <li><a href="../blog/searcht.jsp?blogTitle=技术"><i class="fa fa-spinner fa-spin fa-fw"></i>技术</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <h2 class="bg-info text-center">评论管理</h2>
    <table class="table table-hover table-bordered table-responsive manage-li">
        <thead>
        <tr>
            <th class="col-lg-2 text-center">评论者ID</th>
            <th class="col-lg-2 text-center">评论内容</th>
            <th class="col-lg-2 text-center">发表时间</th>
            <th class="col-lg-1 text-center">状态</th>
            <th class="col-lg-4 text-center">操作</th>
        </tr>
        </thead>
        <%
        int pageSize = 10;
        DatabaseUtil dbUtil = new DatabaseUtil();
        String getCount = " select count(*) from 16_s4_review";
        ResultSet rs=dbUtil.executeQuery(getCount);
        rs.next();
        int count = rs.getInt("count(*)");
        int pageNum = count/pageSize;
        String sql = "select review_id,user_id,detail,statu,create_time from 16_s4_review order by create_time Asc limit "+pageSize;
        rs=dbUtil.executeQuery(sql);
        while(rs.next()){
        String id = rs.getString("review_id");
        Timestamp timestamp2 = rs.getTimestamp("create_time");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = sdf.format(timestamp2);
        String user_id = rs.getString("user_id");
        String detail = rs.getString("detail");
        String statu = rs.getString("statu");
        %>
        <tbody >
        <tr id="<%=id%>">
            <th class="col-lg-2 text-center"><%=user_id%></th>
            <th class="col-lg-2 text-center"><%=detail%></th>
            <th class="col-lg-2 text-center"><%=time%></th>
            <th class="col-lg-1 text-center" name="statu">
                <%
                if(statu.equals("1")){
                out.print("正常");
                }else {
                out.print("已删除");
                }
                %>
            </th>
            <th class="col-lg-5 text-center">
                <a class="col-lg-3 btn btn-info text-center " onclick="blockUser(<%=user_id%>)"><i class="fa fa-snowflake-o fa-lg"></i>冻结评论者</a>
                <div class="col-lg-1"></div>
                <a class="col-lg-3 btn btn-primary text-center" onclick="normalReview(<%=id%>)"><i class="fa fa-rocket fa-lg"></i>恢复此评论</a>
                <div class="col-lg-1"></div>
                <a class="col-lg-3 btn btn-danger  text-center" onclick="reviewDelete(<%=id%>)"><i class="fa fa-trash-o fa-lg"></i>删除</a>
            </th>
        </tr>
        </tbody>
        <%
        }
        }
        %>
    </table>
</div>
<script>
    function blockUser(id){
            if(confirm("是否冻结评论者？")){
                $.get("../user/userChange.jsp?id="+id+"&statu="+0,function () {
                    alert("此用户已被冻结，无法发布评论！")
                })
            }

    }
    function normalReview(id){
        if($("#"+id+" th[name='statu']").html().trim()=="正常"){
            alert("该评论处于正常状态")
        }
        else{
            if(confirm("是否恢复此评论？")){
                $.get("../review/reviewChange.jsp?id="+id+"&statu="+1,function () {
                    $("#"+id+" th[name='statu']").html('正常')
                })
            }
        }

    }
    function reviewDelete(id) {
        if($("#"+id+" th[name='statu']").html().trim()=="已删除"){
            alert("该评论已被删除")
        }else {
            if(confirm("是否删除？")){
                $.get("../review/reviewChange.jsp?id="+id+"&statu="+0,function () {
                    $("#"+id+" th[name='statu']").html('已删除')
                })
            }
        }
    }
</script>
</body>
</html>