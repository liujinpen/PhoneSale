<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/12
  Time: 19:59
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
            if(linkurl.indexOf("lookShoppingCar.jsp")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>生成订单情况</title>
</head>
<body>
<%
    String orderResult=(String)session.getAttribute("orderResult");
%>
<div style="font-size: 25px;margin-top: 80px;width: fit-content;margin-left: auto;margin-right: auto;text-align: center">
    <h2><%= orderResult%></h2>
    <%
        if(orderResult.indexOf("成功")!=-1){
    %>      <br><a href="lookOrderForm.jsp"><button class="btn">点击此处查看订单</button></a><br>
    <% }
    %>
    <br><a href="index.jsp"><button class="btn">点击此处返回主页</button></a>
</div>
<div style=" position: fixed;left: 30px;  bottom: 30px">
    <img src="images/shop.png" width="250px" height="250px">
</div>
</body>
</html>
