<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/12
  Time: 22:25
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
            if(linkurl.indexOf("changePassword.jsp")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>修改密码</title>
</head>
<body>
<div style="text-align: center;margin: auto auto">
    <h1>还未开发。。。</h1>
    <a href="index.jsp"><button class="btn">返回主页</button></a>
</div>
</body>
</html>
