<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/11
  Time: 16:35
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
            if(linkurl.indexOf("lookMobile")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>浏览手机</title>
</head>
<body>
<div style="width: fit-content; margin-top: 100px;margin-left: auto;margin-right: auto; text-align: center; font-size: 25px">
    <%
        int [] id=new int[3];
        String [] mobileCategory=new String[3];
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }catch (Exception e){}
        String uri="jdbc:mysql://127.0.0.1/mobileshop?user=root&password=1234&characterEncoding=GB2312";
        Connection connection;
        Statement statement;
        ResultSet resultSet;
        try {
            connection= DriverManager.getConnection(uri);
            statement=connection.createStatement();
            //读取mobileClassify表，获取分类
            resultSet=statement.executeQuery("SELECT * FROM mobileClassify");
            int i=0;
            while (resultSet.next()){
                id[i]=resultSet.getInt(1);
                mobileCategory[i]=resultSet.getString(2);
                i++;
            }
            connection.close();
        }catch (Exception e){
            out.print(e);
        }
    %>
    选择一类手机，分类查看此类手机 ☟<br><br>
    <form action="queryServlet" method="post">
        <select name="fenleiNumber">
            <option value="<%= id[0]%>"><%= mobileCategory[0]%></option>
            <option value="<%= id[1]%>"><%= mobileCategory[1]%></option>
            <option value="<%= id[2]%>"><%= mobileCategory[2]%></option>
        </select>
        <input type="submit" value="查看">
    </form>
</div>
<div style="width: fit-content;margin-top: 20px;margin-left: auto;margin-right: auto; text-align: center">
    <img src="images/one.png" width="680" height="680">
</div>
</body>
</html>
