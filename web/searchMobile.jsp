<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/12
  Time: 22:28
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
            if(linkurl.indexOf("searchMobile")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>查询手机</title>
</head>
<body>
<div style="width: fit-content; margin-top: 70px;margin-left: auto;margin-right: auto; text-align: center; font-size: 25px">
    查询时可以输入手机的版本号或者手机名称及价格<br>
    手机名称支持模糊查询<br>
    输入价格在俩个数值之间：例如(8000-10000)<br>
    ------------------------------------------
    <form action="searchByConditionServlet" method="post">
        <br>输入查询信息：<input type="text" name="searchMess"><br><br>
        <input style="width: fit-content" type="radio" name="radio" value="mobile_version">手机版本号
        <input style="width: fit-content" type="radio" name="radio" value="mobile_name" checked="checked">手机名称
        <input style="width: fit-content" type="radio" name="radio" value="mobile_price">手机价格<br>
        <br><input type="submit" name="g" value="查询">
    </form>
</div>
<div style="position: fixed;bottom: 0px;left: 100px">
    <img src="images/search.png" width="361px" height="260px">
</div>
<div style="position: fixed;bottom: 0px;right: 10px">
    <img src="images/search2.png" width="676" height="500">
</div>
</body>
</html>
