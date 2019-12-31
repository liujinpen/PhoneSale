<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/11
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@page import="JavaBean.Login" %>
<%@page import="java.sql.*" %>
<%@ page import="org.omg.PortableInterceptor.ServerRequestInfo" %>
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
    <style>
        /* Border styles */
        #table-3 thead, #table-3 tr {
            border-top-width: 1px;
            border-top-style: solid;
            border-top-color: rgb(235, 242, 224);
        }
        #table-3 {
            margin: 10px auto;
            border-bottom-width: 1px;
            border-bottom-style: solid;
            border-bottom-color: rgb(235, 242, 224);
        }

        /* Padding and font style */
        #table-3 td, #table-3 th {
            padding: 5px 10px;
            font-size: 16px;
            font-family: Verdana;
            color: rgb(149, 170, 109);
        }

        /* Alternating background colors */
        #table-3 tr:nth-child(even) {
            background: rgb(230, 238, 214)
        }
        #table-3 tr:nth-child(odd) {
            background: rgb(230, 238, 214)
        }
    </style>
    <title>详情</title>
</head>
<body style="text-align: center">
<table id="table-3" style="margin-top: 10px">
    <tr>
        <th>产品号</th>
        <th>名称</th>
        <th>制造商</th>
        <th>价格</th>
        <th><span style="color: blue; font-size: 20px">放入购物车</span></th>
    </tr>
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
    String mobileID=request.getParameter("xijie");
    out.print("<div style=\"margin-top: 30px; font-size: 25px\">" + " <span >产品号："+mobileID+"</span>" + "</div>");
    if(mobileID==null){
        out.print("没有产品号，无法查看细节");
        return;
    }
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
        String cdn="SELECT * FROM mobileForm WHERE mobile_version='"+mobileID+"'";
        resultSet=statement.executeQuery(cdn);
        String picture="7T.png";
        String datailMess="";
        while (resultSet.next()){
            String number=resultSet.getString(1);
            String name=resultSet.getString(2);
            String maker=resultSet.getString(3);
            String price=resultSet.getString(4);
            datailMess=resultSet.getString(5);
            picture=resultSet.getString(6);
            String goods="("+number+","+name+","+maker+","+price+")#"+price;
            goods=goods.replaceAll("\\p{Blank}","");
            String button="<form style='padding-top:12px' action='putGoodsServlet' method='post'>"+
                    "<input type='hidden' name='java' value="+goods+">"+
                    "<input  type='submit' value='放入购物车'></form>";
            out.print("<tr>");
            out.print("<td>"+number+"</td>");
            out.print("<td>"+name+"</td>");
            out.print("<td>"+maker+"</td>");
            out.print("<td>"+price+"</td>");
            out.print("<td>"+button+"</td>");
            out.print("</tr>");
        }
        out.print("</table>");
        out.print("<div style='margin-top: 30px; font-size: 25px'><span>商品详情：</span></div><br><br>");
        out.println("<div style='margin-top:10px; font-size:20px' align=center>"+datailMess+"</div>");
        String pic="<img style='margin-top:30px' src='images/"+picture+"'width=193 height=327></img>";
        out.print(pic);
        statement.close();
    }catch (SQLException exp){
        System.out.println(exp);
    }
%>
</table>

</body>
</html>
