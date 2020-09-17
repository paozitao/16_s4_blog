<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="database.DatabaseUtil,java.sql.*,java.util.*,java.text.*" %>
        <%
    DatabaseUtil dbUtil = new DatabaseUtil();
    String id = request.getParameter("id");
    String sql = "select * from 16_s4_blog where blog_id = "+id+" and statu = 1";
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String sql2 = "null";
    String sql3 = "null";
    ResultSet rs = null;
    String user_id = (String) session.getAttribute("16_s4_blog_user_id");//检测是否登录
%>
    <script>
    var user_id = 0;
    var is_like = false;
    </script>
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <link rel="icon" href="../src/pic/favicon.ico">
    <title>白荷</title>
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/cssmain.css">
    <link rel="stylesheet" href="//cdnjs.loli.net/ajax/libs/mdui/0.4.1/css/mdui.min.css">
    <script src="//cdnjs.loli.net/ajax/libs/mdui/0.4.1/js/mdui.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/marked.min.js"></script>
    <link rel="stylesheet" href="../css/md.css">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/hover.css/2.3.1/css/hover-min.css" rel="stylesheet">
    </head>
    <body class="bg-gray" onselectstart="return false">
    <div class="bg-gray index-bg2"></div>
    <div class="to-top">
    <a href="#"><i class="fa fa-arrow-circle-up fa-5x"></i></a>
    </div>
    <nav class="navbar bg-white navbar-fixed-top" id="banner">
    <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
    <a class="navbar-brand text-center">
    <img src="../src/pic/favicon.ico" style="position:relative;bottom: 20%;: margin-bottom: 20%">
    </a>
    </div>
    <p class="navbar-text"><a href="../index.jsp" class="navbar-link hvr-underline-from-center">Kazusa</a></p>
    <p class="navbar-text "><a href="../index.jsp" class="navbar-link hvr-underline-from-center"><i class="fa fa-home
    fa-lg"></i>首页</a></p>
        <%

            if(user_id==null){
    %>
    <p class="navbar-text "><a href="../user/login.html" class="navbar-link hvr-underline-from-center"><i class="fa
    fa-user "></i>登录</a></p>
    <p class="navbar-text "><a href="../user/register.html" class="navbar-link hvr-underline-from-center"><i class="fa
    fa-calendar-plus-o fa-x2"></i>注册</a></p>
        <%
}else{
    String sql4 = "select user_name from 16_s4_user where user_id = "+ user_id;
    rs = dbUtil.executeQuery(sql4);
    rs.next();
    String user_name = rs.getString("user_name");
%>
    <p class="navbar-text "><a class="navbar-link hvr-underline-from-center"><i class="fa fa-user
    "></i>欢迎,<%=user_name%></a></p>
    <p class="navbar-text "><a id="leave" class="navbar-link hvr-underline-from-center"><i class="fa fa-sign-in
    fa-x2"></i>注销</a></p>
    <script>
    user_id =<%=user_id%>
    </script>
        <%
    String sql5 = "select * from 16_s4_blog_like where user_id = "+user_id+" and blog_id = "+id;
    rs = dbUtil.executeQuery(sql5);
    if(rs.next()){
%>
    <script>
    is_like = true
    </script>
        <%
}
}
%>
    <form class="navbar-form navbar-right" action="searchn.jsp">
    <div class="form-group">
    <input type="text" class="form-control " placeholder="标题" name="blogName" id="blogName">
    </div>
    <button id="find" class="btn btn-info hvr-grow" type="submit" >查找</button>
    </form>
    <ul class="nav navbar-nav navbar-right btn-group">
    <li class="dropdown ">
    <a class="dropdown-toggle hvr-grow navbar-link" data-toggle="dropdown" role="button" aria-haspopup="true"
    aria-expanded="false">标签<span class="caret"></span></a>
    <ul class="dropdown-menu">
    <li><a href="searcht.jsp?blogTitle=日记"><i class="fa fa-pencil fa-fw"></i> 日记</a></li>
    <li><a href="searcht.jsp?blogTitle=心情"><i class="fa fa-plane fa-fw"></i> 心情</a></li>
    <li><a href="searcht.jsp?blogTitle=技术博文"><i class="fa fa-spinner fa-spin fa-fw"></i> 技术博文</a></li>
    </ul>
    </li>
    </ul>
    </div>
    </nav>
        <%
            rs = dbUtil.executeQuery(sql);
            if(rs.next()){
            Timestamp timestamp = rs.getTimestamp("create_time");
            String time = sdf.format(timestamp);
            String name = rs.getString("name");
            String title = rs.getString("title");
            String detail = rs.getString("detail");
            String browse = rs.getString("browse_count");
            String like = rs.getString("like_count");
            String review = rs.getString("review_count");
            sql2 = "update 16_s4_blog set browse_count = 1+ "+browse+" where blog_id =" + id;
            dbUtil.executeUpdate(sql2);
%>
    <div class="container " STYLE="width: 50%">
    <div class="col-sm-12 bg-white mdui-typo caption">
    <div class="row text-center">
    <h1 class="title"><%=name%></h1>
    <div class="mdui-typo">
    <hr/>
    </div>
    </div>
    <div class="row ">
    <div class="col-sm-2">
    <a class="bg-info btn disabled imargin"><i class="fa fa-tag fa-1x"></i><%=title%></a></div>
    <div class="col-lg-4">
    <a class="bg-bluel btn disabled imargin"><i class="fa fa-calendar fa-1x"></i><%=time%></a>
    </div>
    <div class="col-sm-2" >
    <a class="bg-info btn disabled imargin "><i class="fa fa-eye fa-1x"></i><%=browse%></a>
    </div>
    <div class="col-sm-2">
    <a class="bg-danger btn disabled imargin"><i class="fa fa-thumbs-o-up fa-1x"></i><%=like%></a>
    </div>
    <div class="col-sm-2">
    <a class="bg-warning btn disabled imargin"><i class="fa fa-commenting fa-1x"></i><%=review%></a>
    </div>
    </div>
    <div class="mdui-typo">
    <hr/>
    </div>
    <div class="row">
        <div class="col-lg-12" id="blog_md"><%=detail%>
        </div>
    </div>
    <div class="mdui-typo">
    <hr/>
    </div>
    <div class="row">
    <div class="mdui-typo">
    <blockquote>
    <p>梦中不觉秋已深，余情岂是为他人</p>
    <footer>白色相簿2</footer>
    </blockquote>
    </div>
    <div class="col-sm-12 text-center" style="margin-bottom: 2%">
    <a class="btn" id="like">
    <i class="fa fa-heart fa-lg"></i>点赞</a>
    </div>
    </div>
    </div>
    </div>
    <div class="mdui-typo">
    <hr/>
    </div>
    <div class="container bg-warning text-center" style="width: 80%;">
    <h1>评论区</h1>
    </div>
    <div class="mdui-typo">
    <hr/>
    </div>
        <%
}
        //获得评论
        String getReview = "select * from 16_s4_review where blog_id="+id;
        rs = dbUtil.executeQuery(getReview);
        while(rs.next()){
        Timestamp timestamp2 = rs.getTimestamp("create_time");
        String time2 = sdf.format(timestamp2);
        String user_name2 = rs.getString("user_name");
        String detail2 = rs.getString("detail");
        %>
    <div class="container" style="width: 50%;" id="reviews" name="review">
    <div class="row">
    <div class="col-sm-12">
    <div class="thumbnail ">
    <div class="text-center">
    <img src="../src/pic/favicon.ico" alt="head" class="img-circle"><%=user_name2%>
    </div>
    <div class="mdui-typo">
    <hr/>
    </div>
    <div class="caption">
    <p class="review ">
        <%=detail2%>
    </p>
    </div>
    <div class="mdui-typo">
    <hr/>
    </div>
    <div class="row">
    <div class="col-lg-6 text-center">
    <a class="bg-bluel btn disabled imargin"><i class="fa fa-calendar fa-1x"></i><%=time2%></a>
    </div>
    <div class="col-lg-6 text-center">
    <a class="btn btn-info hidden" name="callBack">回复</a>
    </div>
    </div>

    </div>
    </div>
    </div>
    </div>
        <%
        }
%>
    <div class="container" style="width: 50%;" name="review">
    <div class="row">
    <div class="col-sm-12">
    <div class="thumbnail ">
    <div class="text-center bg-info" >
    <a class="btn disabled"><i class="fa fa-edit fa-2x">写评论</i></a>
    </div>
    <div class="mdui-typo">
    <hr/>
    </div>
    <div class="caption row">
    <div class="input-group col-sm-11 ml-2">
    <span class="input-group-addon"><i class="fa fa-pencil fa-fw"></i></span>
    <textarea class="form-control review-text" type="text" id="review"></textarea>
    </div>
    <button class="col-sm-offset-10 btn btn-info back" id="public">评论</button>
    </div>
    </div>
    </div>
    </div>
    </div>
    </body>
    <script>
        window.onload = function(){
            $('#blog_md').html(marked($('#blog_md').html()));
        }
    var current_id =<%=id%>;
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
    location.href='../user/leave.jsp'
    }}
    )
    $(document).ready(function() {
    if(is_like){
    $('#like').html('<i class="fa fa-heart fa-lg"></i>取消点赞</a>')
    }else{
    $('#like').html('<i class="fa fa-heart fa-lg"></i>点赞</a>')
    }
    })

    $('#public').click(
    function(){
    if(user_id!=0){
        $.get("../user/checkUser.jsp?user_id="+user_id,function(data){
            if(data.trim()=='0'){
                alert("您由于最近的不当评论已被管理员冻结！")
                return
            }else{
    if(($('#review').val()=='null')){
    alert('评论不能为空!')
    }else{
    if(confirm("是否发布评论？")){
    $.get("../review/public.jsp?blog_id="+current_id+"&user_id="+user_id+"&detail="+$('#review').val(),function(){
    window.location.reload()
    })
    }
    }
    }
    })

    }else{
    alert("登录之后才能发布评论")
    }

    })
    $('#like').click(
    function(){
    if(user_id!=0){
    $.get("../user/like.jsp?user_id="+user_id+"&blog_id="+current_id,function(){
    is_like=!is_like
    if(is_like){
    $('#like').html('<i class="fa fa-heart fa-lg"></i>取消点赞</a>')
    }else{
    $('#like').html('<i class="fa fa-heart fa-lg"></i>点赞</a>')
    }
    })
    }
    else{
    alert('请登录以后后再点赞')
    }
    }
    )
    </script>
    </html>
