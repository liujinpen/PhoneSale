<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/10
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="JavaBean.Register" %>
<jsp:useBean id="registerBean" class="JavaBean.Register" scope="session"/>
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
            if(linkurl.indexOf("inputRegisterMess")!=-1){
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
    <title>注册</title>
</head>
<body>
<div style="margin-top: 80px;margin-left: auto; margin-right: auto; width: fit-content;  font-size: 25px; text-align: center">
    用户名由字母、数字、下划线组成，带*的项必须填写<br><br>
    <form action="handle_register" method="post">
        <table cellpadding="5px" style="margin: auto; font-size: 20px" >
            <tr>
                <td>用户名称：</td><td><input type="text" name="register_name"> *</td>
                <td>&nbsp&nbsp&nbsp</td>
                <td>真实姓名：</td><td><input type="text" name="register_real_name"></td>
            </tr>
            <tr>
                <td>用户密码：</td><td><input type="password" name="register_pwd"> *</td>
                <td></td>
                <td>重复密码：</td><td><input type="password" name="register_re_pwd"> *</td>
            </tr>
            <tr>
                <td>联系电话：</td><td><input type="text" name="register_phone"></td>
                <td></td>
                <td>邮寄地址：</td><td><input type="text" name="register_address"></td>
            </tr>
            <tr>
                <td><br></td>
            </tr>
            <tr align="center">
                <td colspan="5"><input type="submit" value="注册"></td>
            </tr>
        </table>
    </form>
</div>

<div style="margin-top: 40px;margin-left: auto; margin-right: auto; width: fit-content; text-align: center; font-size: 25px">
    <button onclick="display('table')"><jsp:getProperty name="registerBean" property="backNews"/><br>
        （点击查看注册信息）<br></button>

    <table cellpadding="5px" style="margin: auto; font-size: 25px; text-align: center; display: none" id="table" >
        <tr>
            <td>会员名称：<jsp:getProperty name="registerBean" property="logname"/></td>
        </tr>
        <tr>
            <td>姓名：<jsp:getProperty name="registerBean" property="realname"/></td>
        </tr>
        <tr>
            <td>地址：<jsp:getProperty name="registerBean" property="address"/></td>
        </tr>
        <tr>
            <td>电话：<jsp:getProperty name="registerBean" property="phone"/></td>
        </tr>
    </table>
</div>

</body>
</html>
