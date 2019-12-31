<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/14
  Time: 0:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<html>
<head>
    <%@include file="head.txt"%>
    <script type="text/javascript">
        var nav = document.getElementById("menu");
        var links = nav.getElementsByTagName("li");
        var lilen = nav.getElementsByTagName("a");
        var currenturl = document.location.href;
        for (var i=0;i<lilen.length;i++)
        {
            var linkurl = lilen[i].getAttribute("href");
            console.log(linkurl);
            if(linkurl.indexOf("Exit.jsp")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>退出登录</title>
</head>
<body>
<div style="width: fit-content; margin-top: 70px;margin-left: auto;margin-right: auto; text-align: center; font-size: 25px">
    退出登录则清除你的登录信息<br>
    ------------------------------------------
    <form action="handle_exit" method="post">
        <br><input type="submit" name="g" value="点击此处退出登录">
    </form>
</div>
</body>
</html>
