<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/12
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@page import="JavaBean.Login" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<jsp:useBean id="loginBean" class="JavaBean.Login" scope="session"/>
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
            if(linkurl.indexOf("lookMobile")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>购买成功</title>
</head>
<body style="text-align: center">
<%
    String currentGoods=(String)session.getAttribute("currentGoods");
%>
<div style="font-size: 25px;margin-top: 80px;width: fit-content;margin-left: auto;margin-right: auto">
    <h2>手机：<%= currentGoods%>&nbsp;已放入购物车</h2>
    <br><a href="lookShoppingCar.jsp"><button class="btn">点击此处查看购物车</button></a><br>
    <br><a href="byPageShow.jsp"><button class="btn">点击此处继续浏览</button></a>
</div>
<div style=" position: fixed;left: 30px;  bottom: 30px">
    <img src="images/shop.png" width="250px" height="250px">
</div>
</body>
</html>
