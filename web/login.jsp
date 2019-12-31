<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/11
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="JavaBean.Login" %>
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
            if(linkurl.indexOf("login")!=-1){
                links[i].className="active";
            }
        }
        function display(id){
            var traget=document.getElementById(id);
            if(traget.style.display=="none"){
                traget.style.display="";
            }else{
                traget.style.display="none";
            }
        }
    </script>
    <title>登录</title>
</head>
<body>
<div style="margin-top: 40px;margin-left: auto; margin-right: auto; width: fit-content;  font-size: 45px; text-align: center">
    登录<br><br>
    <form action="handle_login" method="post">
        <table cellpadding="5px" style="margin: auto; font-size: 20px" >
            <tr>
                <td>登录名称：</td><td><input type="text" name="login_name"></td>
            </tr>
            <tr>
                <td>登录密码：</td><td><input type="password" name="login_pwd"></td>
            </tr>
            <tr>
                <td><br></td>
            </tr>
            <tr align="center">
                <td colspan="5"><input type="submit" value="登录"></td>
            </tr>
        </table>
    </form>
</div>

<div style="margin-top: 40px;margin-left: auto; margin-right: auto; width: fit-content; text-align: center; font-size: 25px">
    <button onclick="display('table')"><jsp:getProperty name="loginBean" property="backNews"/><br>
        （点击查看登录信息）<br></button>

    <table cellpadding="5px" style="margin: auto; font-size: 25px; text-align: center; display: none" id="table" >
        <tr>
            <td>会员名称：<jsp:getProperty name="loginBean" property="login_name"/></td>
        </tr>
        <tr>
            <td><jsp:getProperty name="loginBean" property="return_index"/></td>
        </tr>
        <tr>
            <td><jsp:getProperty name="loginBean" property="return_login"/></td>
        </tr>
    </table>
</div>
</body>
</html>
