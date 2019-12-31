<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/11
  Time: 19:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@page import="JavaBean.DataByPage" %>
<%@ page import="com.sun.rowset.CachedRowSetImpl" %>
<%@ page import="javax.swing.text.TabableView" %>
<%@ page import="java.sql.SQLException" %>
<jsp:useBean id="dataBean" class="JavaBean.DataByPage" scope="session"/>
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
    <title>浏览</title>
</head>
<body style="text-align: center">

<table id="table-3" style="margin-top: 80px">
    <tr>
        <th>手机标识号</th>
        <th>手机名称</th>
        <th>手机制造商</th>
        <th>手机价格</th>
        <th>查看详情</th>
        <th>添加到购物车</th>
    </tr>
    <jsp:setProperty name="dataBean" property="pageSize" param="pageSize"/>
    <jsp:setProperty name="dataBean" property="currentPage" param="currentPage"/>
    <%
        CachedRowSetImpl rowSet=dataBean.getRowSet();
        if(rowSet==null){
            out.print("没有任何查询信息，无法浏览");
            return;
        }
        int totalRecord= 0;
        //返回记录有几条
        try {
            rowSet.last();
            totalRecord = rowSet.getRow();
        } catch (SQLException e) {
            System.out.println(e);
        }


        int pageSize=dataBean.getPageSize();
        int totalPages;//总页数
        if(totalRecord % pageSize==0){
            totalPages=totalRecord/pageSize;
        }
        else{
            totalPages=totalRecord/pageSize+1;
        }
        dataBean.setTotalPages(totalPages);



        if(totalPages>=1){
            //当前页面小于1  设置为总页数
            if(dataBean.getCurrentPage()<1){
                dataBean.setCurrentPage(dataBean.getTotalPages());
            }
            //当前页面大于总页数  设置为第一页
            if(dataBean.getCurrentPage()>dataBean.getTotalPages()){
                dataBean.setCurrentPage(1);
            }

            //准备显示第几页的内容  则利用该公式定位到rowSetz中的第index行
            int index=(dataBean.getCurrentPage()-1) * pageSize+1;
            rowSet.absolute(index);

            boolean boo=true;
            for(int i=1;i<=pageSize&&boo;i++){
                String number=rowSet.getString(1);
                String name=rowSet.getString(2);
                String maker=rowSet.getString(3);
                String price=rowSet.getString(4);


                String goods="("+number+","+name+","+maker+","+price+")#"+price;
                goods=goods.replaceAll("\\p{Blank}","");

                String button="<form style='padding-top:12px' action='putGoodsServlet' method='post'>"+
                        "<input type='hidden' name='java' value="+goods+">"+
                        "<input  type='submit' value='放入购物车'></form>";
                String detail="<form style='padding-top:12px' action='showDetail.jsp' method='post'>"+
                        "<input type='hidden' name='xijie' value="+number+">"+
                        "<input type='submit' value='查看细节'></form>";
                out.print("<tr>");
                out.print("<td>"+number+"</td>");
                out.print("<td>"+name+"</td>");
                out.print("<td>"+maker+"</td>");
                out.print("<td>"+price+"</td>");
                out.print("<td>"+detail+"</td>");
                out.print("<td>"+button+"</td>");
                out.print("</tr>");
                boo=rowSet.next();
            }
        }
    %>
</table>
<br>全部记录数：<%= totalRecord%>
<br>每页最多显示<jsp:getProperty name="dataBean" property="pageSize"/>条信息
<br>当前显示第<span style="color: blue"><jsp:getProperty name="dataBean" property="currentPage"/></span>页，共有
<span style="color: blue"><jsp:getProperty name="dataBean" property="totalPages"/></span>页。

<table style="margin: 10px auto"  cellspacing="0">
    <tr style="margin-bottom: 0px">
        <td colspan="3" >
            <form action="" method="post">
                <input type="hidden" name="currentPage" value="<%= dataBean.getCurrentPage()-1%>">
                <input style="width: fit-content;" type="submit" name="g" value="上一页">
            </form>
        </td>
        <td>
            <form action="" method="post">
                <input type="hidden" name="currentPage" value="<%= dataBean.getCurrentPage()+1%>">
                <input style="width: fit-content; " type="submit" name="g" value="下一页">
            </form>
        </td>
    </tr>
</table>
<table style="margin: 10px auto"  cellspacing="0">
    <tr>
        <td>
            <form action="" method="post">
                每页显示<input  style="width: 1cm" type="text" name="pageSize" value="<%= dataBean.getPageSize()%>">
                条记录<input style="width: fit-content; "type="submit" name="g" value="确定">
            </form>
        </td>
        <td width="90px">
            &nbsp;&nbsp;&nbsp;&nbsp;
        </td>
        <td>
            <form action="" method="post">
                输入页码：<input style="width: 1cm" type="text" name="currentPage" value="<%= dataBean.getCurrentPage()%>">
                <input style="width: fit-content; "type="submit" name="g" value="确定">
            </form>
        </td>
    </tr>
</table>
<div style=" position: fixed;left: 0px;  bottom: 0px">
    <img src="images/11.png" width="473" height="400">
</div>
</body>
</html>
