<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/13
  Time: 23:50
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
            if(linkurl.indexOf("searchMobile.jsp")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>查询失败</title>
</head>
<body>
<%
    String searchResult=(String)session.getAttribute("searchResult");
%>
<div style="font-size: 25px;margin-top: 80px;width: fit-content;margin-left: auto;margin-right: auto;text-align: center">
    <h2><%= searchResult%></h2>
    <br><a href="index.jsp"><button class="btn">点击此处返回主页</button></a><br>
    <br><a href="searchMobile.jsp"><button class="btn">点击此处返回查询</button></a>
</div>
<div style="position: fixed;bottom: 0px;left: 100px">
    <img src="images/search.png" width="361px" height="260px">
</div>
<div style="position: fixed;bottom: 0px;right: 10px">
    <img src="images/search2.png" width="676" height="500">
</div>
</body>
</html>
