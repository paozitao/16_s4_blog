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
                            <li><a class='btn btn-info active'>博文那片山头</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="review.jsp">评论那块场子</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="user.jsp">游客那帮孩子</a></li>
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
    <h2 class="bg-info text-center">博文管理</h2>
    <table class="table table-hover table-bordered table-responsive manage-li">
        <thead>
            <tr>
                <th class="col-lg-2 text-center">博文标题</th>
                <th class="col-lg-2 text-center">博文标签</th>
                <th class="col-lg-2 text-center">创建时间</th>
                <th class="col-lg-1 text-center">状态</th>
                <th class="col-lg-4 text-center">操作</th>
            </tr>
        </thead>
        <%    
            DatabaseUtil dbUtil = new DatabaseUtil();
            String sql = "select name,title,statu,create_time,blog_id from 16_s4_blog order by create_time Desc";
            ResultSet rs=dbUtil.executeQuery(sql);
        while(rs.next()){
            Timestamp timestamp2 = rs.getTimestamp("create_time");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = sdf.format(timestamp2);
            String id = rs.getString("blog_id");
            String title = rs.getString("title");
            String name = rs.getString("name");
            String statu = rs.getString("statu");
        %>
        <tbody >
            <tr id="<%=id%>">
                <th class="col-lg-2 text-center"><%=name%></th>
                <th class="col-lg-2 text-center"><%=title%></th>
                <th class="col-lg-2 text-center"><%=time%></th>
                <th class="col-lg-1 text-center" name="statu">
                    <%
                    if(statu.equals("1")){
                    out.print("已发布");
                }else if (statu.equals("0")){
                    out.print("待发布");
                    }else {
                    out.print("已删除");
                }
                    %>
                        
                </th>
                <th class="col-lg-5 text-center">
                   <a class="col-lg-3 btn btn-info text-center " onclick="blogUpdate(<%=id%>)"><i class="fa fa-paint-brush fa-lg"></i>修改</a>
                    <a class="col-lg-3 btn btn-primary text-center" onclick="blogpublic(<%=id%>)"><i class="fa fa-rocket fa-lg"></i>发布</a>
                    <a class="col-lg-3 btn btn-warning text-center" onclick="blogCancel(<%=id%>)"><i class="fa fa-window-close-o fa-lg"></i>取消发布</a>
                    <a class="col-lg-3 btn btn-danger  text-center" onclick="blogDelete(<%=id%>)"><i class="fa fa-trash-o fa-lg"></i>删除</a>
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
    function blogUpdate(id){
        window.location.href="../blog/blogUpdate.jsp?id="+id
    }
    function blogCancel(id){
        if($("#"+id+" th[name='statu']").html().trim()=="待发布"){
            alert("已经处于未发布状态")
        }
        else{
            if(confirm("是否取消发布？")){
                $.get("../blog/blogChange.jsp?id="+id+"&statu="+0,function () {
                    $("#"+id+" th[name='statu']").html('待发布')
                })
            }
        }

    }
    function blogpublic(id) {
        if($("#"+id+" th[name='statu']").html().trim()=="已发布"){
            alert("已经处于发布状态")
        }else{
            if(confirm("是否发布？")){
                $.get("../blog/blogChange.jsp?id="+id+"&statu="+1,function () {
                    $("#"+id+" th[name='statu']").html('已发布')
                })
            }
        }

    }
    function blogDelete(id) {
        if($("#"+id+" th[name='statu']").html().trim()=="已删除"){
            alert("已经处于删除状态")
        }else {
            if(confirm("是否删除？")){
                $.get("../blog/blogChange.jsp?id="+id+"&statu="+(-1),function () {
                    $("#"+id+" th[name='statu']").html('已删除')
                })
            }
        }
    }

</script>
</body>
</html>