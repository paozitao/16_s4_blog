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
        int pageSize = 10;
        DatabaseUtil dbUtil = new DatabaseUtil();
        String getCount = " select count(*) from 16_s4_user";
        ResultSet rs=dbUtil.executeQuery(getCount);
        rs.next();
        int count = rs.getInt("count(*)");
        int pageNum = (count-1)/pageSize+1;
%>
    <script>
        var current_page = 1
        var PageNum = <%=pageNum%>
    </script>
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
                            <li><a >博文那片山头</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="review.jsp">评论那块场子</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a class='btn btn-info active' href="user.jsp">游客那帮孩子</a></li>
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
    <h2 class="bg-info text-center">用户管理</h2>
    <table class="table table-hover table-bordered table-responsive manage-li">
        <thead>
        <tr>
            <th class="col-lg-2 text-center">用户ID</th>
            <th class="col-lg-2 text-center">用户昵称</th>
            <th class="col-lg-2 text-center">创建时间</th>
            <th class="col-lg-1 text-center">状态</th>
            <th class="col-lg-4 text-center">操作</th>
        </tr>
        </thead>
    <tbody id="tbody">
        <%
        String sql = "select user_id,user_name,statu,create_time from 16_s4_user order by create_time Asc limit "+pageSize;
        rs=dbUtil.executeQuery(sql);
        while(rs.next()){
        Timestamp timestamp2 = rs.getTimestamp("create_time");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = sdf.format(timestamp2);
        String id = rs.getString("user_id");
        String name = rs.getString("user_name");
        String statu = rs.getString("statu");
        %>
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
        <%
        }
        }
        %>
        </tbody>
    </table>
    <div class="row text-center">
    <div class="col-sm-2"><a class="btn btn-primary fa fa-hand-o-right" id="forwardPage">上一页</a></div>
    <div class="col-sm-2"><a class="btn btn-primary fa fa-hand-o-right" id="nextPage">下一页</a></div>
        <div class="col-sm-6 input-group" style="height: 30px">
            <a id="pageMessage" class="col-sm-3 btn btn-info" style="height: 30px;">1/4</a>
            <input type="text" class="col-sm-3 " id="goPage" style="height: 30px">
            <a class="btn btn-primary col-sm-3" id="go" style="height: 30px">跳转到此页</a>
        </div>

    </div>
</div>
<script>
    $('#nextPage').click(
        function () {
            if(current_page<PageNum){
                $.get("../user/getUserByPage.jsp?pageSize=10&pageNum="+(current_page+1),function (data) {
                    $('#tbody').html(data);
                    current_page++;
                    $('#pageMessage').html(current_page+"/"+PageNum);
                })
            }
            else{
                alert("已经是最后一页！");
            }
        }
    )
    $('#forwardPage').click(
    function () {
    if(current_page>1){
    $.get("../user/getUserByPage.jsp?pageSize=10&pageNum="+(current_page-1),function (data) {
    $('#tbody').html(data);
    current_page--;
    $('#pageMessage').html(current_page+"/"+PageNum);
    })
    }
    else{
    alert("已经是第一页！");
    }
    }
    )
    $('#go').click(
        function(){
            var position = parseInt($('#goPage').val())
            if(position>0&&position<=PageNum){
    $.get("../user/getUserByPage.jsp?pageSize=10&pageNum="+position,function (data) {
    $('#tbody').html(data);
    current_page = position
    $('#pageMessage').html(current_page+"/"+PageNum);
    })
    }else{
    alert("请输入正确的跳转位置！")
    }
        }
    )

    window.onload= function () {
        $('#pageMessage').html(current_page+"/"+PageNum);
    }

    function blockUser(id){
        if($("#"+id+" th[name='statu']").html().trim()=="冻结"){
            alert("该用户已经处于冻结状态")
        }
        else{
            if(confirm("是否冻结？")){
                $.get("../user/userChange.jsp?id="+id+"&statu="+0,function () {
                    $("#"+id+" th[name='statu']").html('冻结')
                })
            }
        }
    }
    function normalUser(id){
        if($("#"+id+" th[name='statu']").html().trim()=="正常"){
            alert("该用户已经处于正常状态")
        }
        else{
            if(confirm("是否恢复此用户？")){
                $.get("../user/userChange.jsp?id="+id+"&statu="+1,function () {
                    $("#"+id+" th[name='statu']").html('正常')
                })
            }
        }

    }
    function userDelete(id) {
        if($("#"+id+" th[name='statu']").html().trim()=="已删除"){
            alert("该用户已经被删除")
        }else {
            if(confirm("是否删除？")){
                $.get("../user/userChange.jsp?id="+id+"&statu="+(-1),function () {
                    $("#"+id+" th[name='statu']").html('已删除')
                })
            }
        }
    }

</script>
</body>
</html>