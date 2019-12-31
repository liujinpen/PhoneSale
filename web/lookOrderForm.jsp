<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/12
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@page import="JavaBean.Login" %>
<%@ page import="java.sql.*" %>
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
            if(linkurl.indexOf("lookOrderForm.jsp")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>查看订单</title>
</head>
<body>
 <div style="margin-top: 40px; text-align: center">
     <%
         if(loginBean==null){
             response.sendRedirect("login.jsp");
         }
         else{
             boolean b=loginBean.getLogin_name()==null||loginBean.getLogin_name().length()==0;
             if(b){
                 response.sendRedirect("login.jsp");
             }
         }
         Connection connection;
         Statement statement;
         ResultSet resultSet;
         try {
             Class.forName("com.mysql.jdbc.Driver");
         }catch (Exception e){ }
         try {
             String uri="jdbc:mysql://127.0.0.1/mobileshop?user=root&password=1234&characterEncoding=GB2312";
             connection= DriverManager.getConnection(uri);
             statement=connection.createStatement();
             String cdn="SELECT id,mess,sum FROM orderform WHERE logname='"+loginBean.getLogin_name()+"'";
             resultSet=statement.executeQuery(cdn);
             out.print("<table id='table-3'>");
             out.print("<tr>");
             out.print("<th>"+"订单号");
             out.print("<th>"+"订单详情");
             out.print("<th>"+"订单价格");
             out.print("</tr>");
             while (resultSet.next()){
                 out.print("<tr>");
                 out.print("<td>"+resultSet.getString(1)+"</td>");
                 out.print("<td>"+resultSet.getString(2)+"</td>");
                 out.print("<td>"+resultSet.getString(3)+"</td>");
                 out.print("</tr>");
             }
             out.print("</table>");
             connection.close();
         }catch (SQLException exp){
             System.out.println(exp);
         }
     %>
     <a href="index.jsp"><button class="btn">返回主页</button></a>
 </div>
 <div style=" position: fixed;left: 30px;  bottom: 30px">
     <img src="images/shop.png" width="250px" height="250px">
</div>
</body>
</html>
