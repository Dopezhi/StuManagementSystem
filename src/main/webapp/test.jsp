<%--
  Created by IntelliJ IDEA.
  User: Dopezhi
  Date: 2018/7/23
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>hello</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- web 路径
        不以/开始的相对路径，找资源，以当前的资源的路径为基准，经常容易出问题
        以/开始的相对路径，找资源不是从当前资源开始，是以服务器的根路径开始
        htttp://localhost:3306/crud
     -->
    <!-- 引入jquey  -->
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <!-- 引入css样式  -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入js文件  -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url:"${APP_PATH}/hello",
                type:"POST",
                success:function () {
                    
                }
            });
        });
        
    </script>
</body>
</html>
