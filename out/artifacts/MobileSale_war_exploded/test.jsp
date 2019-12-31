<%--
  Created by IntelliJ IDEA.
  User: 22715
  Date: 2019/11/11
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript">
        function display(id){
            var traget=document.getElementById(id);
            if(traget.style.display=="none"){
                traget.style.display="";
            }else{
                traget.style.display="none";
            }
        }
    </script>
</head>
<body>
<input type="button" onclick="display('table')" value="点击我">
<table cellpadding="5px" style="margin: auto; font-size: 25px; text-align: center" id="table">
    <tr>
        <td>会员名称：</td>
    </tr>
    <tr>
        <td>姓名：</td>
    </tr>
    <tr>
        <td>地址：</td>
    </tr>
    <tr>
        <td>电话：</td>
    </tr>
</table>

</body>
</html>
