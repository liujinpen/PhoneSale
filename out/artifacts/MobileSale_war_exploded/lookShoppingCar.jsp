<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/12
  Time: 17:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@page import="JavaBean.Login" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
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
            if(linkurl.indexOf("lookShoppingCar")!=-1){
                links[i].className="active";
            }
        }
    </script>
    <title>购物车</title>
</head>
<body style="text-align: center">
<div>
    <%
        StringBuffer buyGoods=new StringBuffer();
        double priceSum=0;
        if(loginBean==null){
            response.sendRedirect("login.jsp");
        }
        else{
            boolean b=loginBean.getLogin_name()==null||loginBean.getLogin_name().length()==0;
            if(b){
                response.sendRedirect("login.jsp");
            }
        }
        LinkedList car =loginBean.getCar();
        if(car==null){
            out.print("<h2>购物车没有物品</h2>");
        }
        else{
            Iterator<String>iterator=car.iterator();
            int n=0;
            out.print("<h2>购物车中的物品：</h2>");
            out.print("<table id='table-3'>");
            while (iterator.hasNext()){
                String goods=iterator.next();
                String showGoods="";
                n++;
                int index=goods.lastIndexOf("#");
                if (index!=-1){
                    priceSum+=Double.parseDouble(goods.substring(index+1));
                    showGoods=goods.substring(0,index);
                }
                buyGoods.append(n+":"+showGoods);
                String del="<form style='padding-top:12px' action='deleteServlet' method='post'>"+
                        "<input type='hidden' name='delete' value="+goods+">"+
                        "<input  type='submit' value='删除'></form>";
                out.print("<tr>");
                out.print("<td>"+showGoods+"</td>");
                out.print("<td>"+del+"</td>");
                out.print("</tr>");
            }
            out.print("</table>");
        }
    %>
    <form action="buyServlet" method="post">
        <input type="hidden" name="buy" value="<%= buyGoods%>">
        <input type="hidden" name="price" value="<%= priceSum%>">
        <input type="submit" value="生成订单">
    </form>
    <a href="byPageShow.jsp"><button class="btn">继续浏览</button></a>

</div>
<div style=" position: fixed;left: 30px;  bottom: 30px">
    <img src="images/shop.png" width="250px" height="250px">

</body>
</html>
