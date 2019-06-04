<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="database.DatabaseUtil,java.sql.*,java.text.*" %>
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
</head>
<body >
<div class="container" style="width: 70%">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand text-center" href="#">
                    <img src="../src/pic/favicon.ico" style="position:relative;bottom: 20%;: margin-bottom: 20%">
                </a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active"><a class="btn" href="../manage/manage.jsp">写点啥</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">巡巡山<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="../manage/blog.jsp" class='btn btn-info'>博文那片山头</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="../manage/review.jsp">评论那块场子</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="../manage/user.jsp">游客那帮孩子</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-right">
                    <div class="form-group">
                        <input type="text" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-info">查找</button>
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
    <div class="row text-center"><h2 id="massage">写点啥吧</h2></div>
    <form class="form-horizontal" name="frm" action="/blog">
        <div class="form-group text-center">
            <label class="col-lg-3 control-label text-center">标题</label>
            <div class="col-lg-3 text-center">
                <input type="text" class="form-control" id="name" name="name" placeholder="标题">
            </div>
        </div>
        <div class="form-group text-center">
            <label class="col-sm-3 control-label text-center">标签</label>
            <div class="col-sm-3 text-center">
                <input type="text" class="form-control" name="pwd" id="title" placeholder="博文的标签">
            </div>
        </div><br>
        <h4 class="col-lg-6 text-center">正文</h4>
        <h4 class="col-lg-6 text-center">Markdown效果</h4>
        <div class="form-group">
            <div class="col-lg-6 text-center">
                <textarea name="detail" id="detail" placeholder="开始我们的date吧！" ></textarea>
            </div>
            <div class="col-lg-6" id="md">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-3 text-center">
                <a type="button" class="btn btn-primary" id="save">保存</a>
            </div>
            <div class="col-sm-3 text-center">
                <a type="button" class="btn btn-warning" id="clear">重写</a>
            </div>
            <div class="col-sm-3 text-center">
                <a type="button" class="btn btn-danger" id="delete">删除</a>
            </div>
            <div class="col-sm-3 text-center">
                <a type="button" class="btn btn-info" id="public">发布</a>
            </div>
        </div>
    </form>
</div>
<script>
    $('#clear').click(function () {
        if(confirm("是否重写此博文？")){
            $('#name').val("");
            $('#detail').val("");
            $('#md').html("");
            $('#title').val("");
            $('body,html').animate({scrollTop:0},200);
            $('#massage').text("重写，小伙子，我喜欢！");
    }
})
        $('#delete').click(function () {
        if(confirm("是否删除此博文，写新的？")){
            $('#name').val("");
            $('#detail').val("");
            $('#md').html("");
            $('#title').val("");
            $('#massage').text("写新博文");
            current_id=0;
            $.get("/blog/blog/blogChange.jsp?id="+current_id+"&statu="+(-1),function(){
                alert("删除成功！")
            })
        }


    })
    //发布到博客中
    $('#public').click(function () {
        if(confirm("是否发布？")){
            var name = $('#name').val()
            var detail = $('#detail').val()
            var title = $('#title').val()
            var flag = 0;
            var url = "/blog/blog/public.jsp?name="+name+"&detail="+detail+"&title="+title+"&id="+current_id
            $.get(url,function () {
                flag=1
                alert("发布成功！");
            })
            if(flag==0){
                alert("发布失败，找找bug！");}
        }

    })
    //保存内容，不发布
    $('#save').click(function () {
        if(confirm("是否保存？")){
            var name = $('#name').val()
            var detail = $('#detail').val()
            var title = $('#title').val()
            var flag=0;
            var url = "/blog/blog/save.jsp?name="+name+"&detail="+detail+"&title="+title+"&id="+current_id;
            $.get(url,function () {
                alert("保存成功！")
                flag=1
            })
            if(flag==0){
                alert("保存失败，找找bug！");}
        }

    })

    $("#detail").on("keyup blur",function () {

        $('#md').html(marked($("#detail").val()))
    })

    $(document).on("keyup blur mouseover",function(){
        if($('#name').val()==''||$('#detail').val()==''||$('#title').val()==''){
            $('#save').addClass("disabled")
            $('#public').addClass("disabled")
        }else{
            $('#save').removeClass("disabled")
            $('#public').removeClass("disabled")
        }
    })
    $(document).ready(function(){
        // alert("12")
    });
</script>
</body>
<%
    String id = request.getParameter("id");
String sql = "select * from 16_s4_blog where blog_id="+id;
ResultSet rs = (new DatabaseUtil()).executeQuery(sql);
if(rs.next()){
Timestamp timestamp2 = rs.getTimestamp("create_time");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time = sdf.format(timestamp2);
%>
<script type="text/javascript">
    var current_id = <%=rs.getInt("blog_id")%>;
    $('#name').val("<%=rs.getString("name")%>");
    $('#detail').val("<%=rs.getString("detail")%>");
    $('#md').html(marked("<%=rs.getString("detail")%>"));
    $('#title').val("<%=rs.getString("title")%>");
    $('#massage').text("创建日期：<%=time%>");
</script>
<%
}else{
%>
<script type="text/javascript">
    var current_id =0;
</script>
<%
}
}
%>
</html>