<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.util.*,java.text.*" %>
<%
    DatabaseUtil dbUtil = new DatabaseUtil();
    String sql2 = "null";
    String sql3 = "null";
    String user_id = (String) session.getAttribute("16_s4_blog_user_id");
    ResultSet rs = null;
    String getCount = "select count(*) from 16_s4_blog where statu = 1 ";
    int pageSize = 5;
    rs=dbUtil.executeQuery(getCount);
    rs.next();
    int count = rs.getInt("count(*)");
    int pageNum = (count-1)/pageSize+1;
%>
    <script>
    var current_page = 1
    var PageNum = <%=pageNum%>
    var pageSize = <%=pageSize%>
    </script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="src/pic/favicon.ico">
    <title>白荷</title>
    <script src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/cssmain.css">
    <link rel="stylesheet" href="//cdnjs.loli.net/ajax/libs/mdui/0.4.1/css/mdui.min.css">
    <script src="//cdnjs.loli.net/ajax/libs/mdui/0.4.1/js/mdui.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/hover.css/2.3.1/css/hover-min.css" rel="stylesheet">
</head>
<body class="bg-gray" onselectstart="return false;">
<div class="bg-gray index-bg2"></div>
<div class="to-top">
    <a href="#"><i class="fa fa-arrow-circle-up fa-5x"></i></a>
</div>
<nav class="navbar  bg-white navbar-fixed-top" id="banner">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <a class="navbar-brand text-center " href="index.jsp">
                <img src="src/pic/favicon.ico" style="position:relative;bottom: 20%;: margin-bottom: 20%">
            </a>
        </div>
        <p class="navbar-text"><a href="index.jsp" class="navbar-link hvr-underline-from-center">Kazusa</a></p>
        <p class="navbar-text active "><a  href="index.jsp" class=" navbar-link hvr-underline-from-center"><i class="fa fa-home fa-lg"></i>首页</a></p>
<%
    if(user_id==null){
    %>  <p class="navbar-text "><a href="user/login.html" class="navbar-link hvr-underline-from-center"><i class="fa fa-user "></i>登录</a></p>
        <p class="navbar-text "><a href="user/register.html" class="navbar-link hvr-underline-from-center"><i class="fa fa-calendar-plus-o fa-x2"></i>注册</a></p>
        <%    
}else{
    String sql4 = "select user_name from 16_s4_user where user_id = "+ user_id;
    rs = dbUtil.executeQuery(sql4);
    rs.next();
    String user_name = rs.getString("user_name");
%>
        <p class="navbar-text "><a class="navbar-link hvr-underline-from-center"><i class="fa fa-user "></i>欢迎,<%=user_name%></a></p>
        <p class="navbar-text "><a id="leave" class="navbar-link hvr-underline-from-center"><i class="fa fa-sign-in fa-x2"></i>注销</a></p>
<%
}
    %>
         <p class="navbar-text navbar-right "><a href="admin.html" class="navbar-link hvr-underline-from-center"><i class="fa fa-sign-in fa-x2"></i>管理员登录</a></p>
        <form class="navbar-form navbar-right" name="search" action="blog/searchn.jsp">
            <div class="form-group">
                <input type="text" class="form-control " placeholder="标题" id="blogName" name="blogName">
            </div>
            <button type="submit" class="btn btn-info hvr-grow">查找</button>
        </form>
        <ul class="nav navbar-nav navbar-right btn-group">
            <li class="dropdown  ">
                <a class="dropdown-toggle hvr-grow navbar-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">标签<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="blog/searcht.jsp?blogTitle=日记"><i class="fa fa-pencil fa-fw"></i>日记</a></li>
                    <li><a href="blog/searcht.jsp?blogTitle=心情"><i class="fa fa-plane fa-fw"></i>心情</a></li>
                    <li><a href="blog/searcht.jsp?blogTitle=技术"><i class="fa fa-spinner fa-spin fa-fw"></i>技术</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
</div>

    <div id = "blogs" >
        <%
        String sql = "select * from 16_s4_blog where statu = 1 order by update_time desc limit "+pageSize;
        rs = dbUtil.executeQuery(sql);
        while(rs.next()){
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
    </div>
    <div class="container" STYLE="width: 50%;">
    <div class="row text-center">
    <div class="col-sm-3"><a class="btn btn-primary fa fa-hand-o-right" id="forwardPage">上一页</a></div>
    <div class="col-sm-3"><a class="btn btn-primary fa fa-hand-o-right" id="nextPage">下一页</a></div>
    <div class="col-sm-6 input-group" style="height: 30px">
    <a id="pageMessage" class="col-sm-3 btn btn-info" style="height: 30px;"></a>
    <input type="text" class="col-sm-3 " id="goPage" style="height: 30px">
    <a class="btn btn-primary col-sm-3" id="go" style="height: 30px">跳转到此页</a>
    </div>

    </div>
    </div>

<script>
    $('#nextPage').click(
    function () {
    if(current_page<PageNum){
    $.get("blog/getBlogByPage.jsp?pageSize="+pageSize+"&pageNum="+(current_page+1),function (data) {
    $('#blogs').html(data);
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
                $.get("blog/getBlogByPage.jsp?pageSize="+pageSize+"&pageNum="+(current_page-1),function (data) {
                    $('#blogs').html(data);
                    current_page--;
                    $('#pageMessage').html(current_page+"/"+PageNum);
    })
    }
    else{
    alert("已经是第一页！");
    }})


    $('#go').click(
    function(){
    var position = parseInt($('#goPage').val())
    if(position>0&&position<=PageNum){
    $.get("blog/getBlogByPage.jsp?pageSize="+pageSize+"&pageNum="+position,function (data) {
    $('#blogs').html(data);
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

    var inst = new mdui.Headroom('#banner');
    $(".to-top").click(function(){
        $('body,html').animate({scrollTop:0},300);
    })
        $(document).on("keyup blur mouseover",function(){
        if($('#blogName').val()==''){
            $('#find').addClass("disabled")
        }else{
            $('#find').removeClass("disabled")
        }
    })
    $('#leave').click(
        function(){
            if(confirm("确认离开？")){
                location.href='user/leave.jsp'
            }

        }
    )
</script>
</body>
</html>