<%--
  Created by IntelliJ IDEA.
  User: Dopezhi
  Date: 2018/7/20
  Time: 21:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html >
<html>
<head>
    <meta charset="utf-8">
    <title>学生管理系统登录</title>
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
    <style type="text/css" media="screen">
        .form-bg{
            background: #00b4ef;
        }
        .form-horizontal{
            background: #fff;
            padding-bottom: 40px;
            border-radius: 15px;
            text-align: center;
        }
        .form-horizontal .heading{
            display: block;
            font-size: 35px;
            font-weight: 700;
            padding: 35px 0;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 30px;
        }
        .form-horizontal .form-group{
            padding: 0 40px;
            margin: 0 0 25px 0;
            position: relative;
        }
        .form-horizontal .form-control{
            background: #f0f0f0;
            border: none;
            border-radius: 20px;
            box-shadow: none;
            padding: 0 20px 0 45px;
            height: 40px;
            transition: all 0.3s ease 0s;
        }
        .form-horizontal .form-control:focus{
            background: #e0e0e0;
            box-shadow: none;
            outline: 0 none;
        }
        .form-horizontal .form-group i{
            position: absolute;
            top: 12px;
            left: 60px;
            font-size: 17px;
            color: #c8c8c8;
            transition : all 0.5s ease 0s;
        }
        .form-horizontal .form-control:focus + i{
            color: #00b4ef;
        }
        .form-horizontal .fa-question-circle{
            display: inline-block;
            position: absolute;
            top: 12px;
            right: 60px;
            font-size: 20px;
            color: #808080;
            transition: all 0.5s ease 0s;
        }
        .form-horizontal .fa-question-circle:hover{
            color: #000;
        }
        .form-horizontal .main-checkbox{
            float: left;
            width: 20px;
            height: 20px;
            background: #11a3fc;
            border-radius: 50%;
            position: relative;
            margin: 5px 0 0 5px;
            border: 1px solid #11a3fc;
        }
        .form-horizontal .main-checkbox label{
            width: 20px;
            height: 20px;
            position: absolute;
            top: 0;
            left: 0;
            cursor: pointer;
        }
        .form-horizontal .main-checkbox label:after{
            content: "";
            width: 10px;
            height: 5px;
            position: absolute;
            top: 5px;
            left: 4px;
            border: 3px solid #fff;
            border-top: none;
            border-right: none;
            background: transparent;
            opacity: 0;
            -webkit-transform: rotate(-45deg);
            transform: rotate(-45deg);
        }
        .form-horizontal .main-checkbox input[type=checkbox]{
            visibility: hidden;
        }
        .form-horizontal .main-checkbox input[type=checkbox]:checked + label:after{
            opacity: 1;
        }
        .form-horizontal .text{
            float: left;
            margin-left: 7px;
            line-height: 20px;
            padding-top: 5px;
            text-transform: capitalize;
        }
        .form-horizontal .btn{
            float: right;
            font-size: 14px;
            color: #fff;
            background: #00b4ef;
            border-radius: 30px;
            padding: 10px 25px;
            border: none;
            text-transform: capitalize;
            transition: all 0.5s ease 0s;
        }
        #message{
            color: red;
        }
        @media only screen and (max-width: 479px){
            .form-horizontal .form-group{
                padding: 0 25px;
            }
            .form-horizontal .form-group i{
                left: 45px;
            }
            .form-horizontal .btn{
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body background="image/newlook.jpg">
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand">
                <img alt="Brand" src="image/edm.jpg" width="30px" height="30px">
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <!-- <li><a href="#">学生管理系统管理端</a></li> -->
                <li><p class="navbar-text" style="font-size: 16px;">学生管理系统</p></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="http://localhost:8080/StuManagementSystem/login.jsp">登录</a>
                </li>
                <li>
                    <a href="http://localhost:8080/StuManagementSystem/reg.jsp">注册</a>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <form class="form-horizontal">
                <span class="heading">用户登录</span>
                <div class="form-group">
                    <input type="email" class="form-control" id="login_input_stuId" placeholder="学生学号">
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control" id="login_input_stuPwd" placeholder="密　码">
                    <i class="fa fa-lock"></i>
                    <a href="#" class="fa fa-question-circle"></a>
                </div>
                <div class="form-group">
                    <span id="message"></span>
                </div>
                <div class="form-group">
                    <div class="main-checkbox">
                        <input type="checkbox" value="None" id="checkbox1" name="check"/>
                        <label for="checkbox1"></label>
                    </div>
                    <span class="text">记住密码</span>
                    <button type="button" class="btn btn-default" id="login_btn">登录</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    //正常的
    <%--$("#login_btn").click(function() {--%>
        <%--//利用后台记录登录的学号 显示页面一打开立马获取这个值 并渲染--%>
        <%--var stuId=$("#login_input_stuId").val();--%>
        <%--var stuPwd=$("#login_input_stuPwd").val();--%>
        <%--$.ajax({--%>
            <%--url:"${APP_PATH}/login/"+stuId,--%>
            <%--data:"stuPwd="+stuPwd,--%>
            <%--type:"POST",--%>
            <%--success:function(result){--%>
                <%--if(result.extend.key=="manager"){--%>
                    <%--window.location.href = "http://localhost:8080/StuManagementSystem/index.jsp";--%>
                    <%--return false;--%>
                <%--}--%>
                <%--if(result.code==200){--%>
                    <%--$("#message").text(result.extend.msg);--%>
                <%--}else{--%>
                    <%--window.location.href = "http://localhost:8080/StuManagementSystem/index2.jsp";--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    <%--});--%>

    /**
     * 适用于第一种方法的全填充(打开网页立即填充cookie的内容)，登录成功了再发送保存cookie的请求
     */

    /*
    //当打开网页的时候就自动填入属性
    $(function () {
        $.ajax({
            url:"${APP_PATH}/search_cookie",
            type:"POST",
            success:function (result) {
                $("#login_input_stuId").val(result.extend.userName);
                $("#login_input_stuPwd").val(result.extend.password);
            }
        });
    });

    //开始做记住密码的功能  id=checkbox1
    $("#login_btn").click(function() {
        var stuId=$("#login_input_stuId").val();
        var stuPwd=$("#login_input_stuPwd").val();
        //实验证明，这个是输出当前是选择（true） 不 （false）
        // alert($("#checkbox1").prop("checked"));
        var dataStr=stuId+"-"+stuPwd+"-"+$("#checkbox1").prop("checked");

        $.ajax({
            url:"${APP_PATH}/login/"+stuId,
            data:"stuPwd="+stuPwd,
            type:"POST",
            success:function(result){
                if(result.extend.key=="manager"){
                    window.location.href = "http://localhost:8080/StuManagementSystem/index.jsp";
                    return false;
                }
                if(result.code==200){
                    $("#message").text(result.extend.msg);
                }else{
                    $.ajax({
                        url:"${APP_PATH}/remember/"+dataStr,
                        type:"POST",
                        success:function (result) {

                        }
                    });
                    window.location.href = "http://localhost:8080/StuManagementSystem/index2.jsp";
                }
            }
        });
    });
    */

    /**
     * 适用于第二种方法的密码填充（当输入正确的账号才寻找cookie找密码）
     */

    //当输入的文本账号（有改变时就发请求查cookie）
    $("#login_input_stuId").change(function () {
        $.ajax({
            url:"${APP_PATH}/search_cookie/"+$("#login_input_stuId").val(),
            type:"POST",
            success:function (result) {
                if(result.code==100){
                    $("#login_input_stuPwd").val(result.extend.password);
                }
            }
        });
    });

    $("#login_btn").click(function() {
        var stuId=$("#login_input_stuId").val();
        var stuPwd=$("#login_input_stuPwd").val();
        //实验证明，这个是输出当前是选择（true） 不 （false）
        // alert($("#checkbox1").prop("checked"));
        var dataStr=stuId+"-"+stuPwd+"-"+$("#checkbox1").prop("checked");

        $.ajax({
            url:"${APP_PATH}/login/"+stuId,
            data:"stuPwd="+stuPwd,
            type:"POST",
            success:function(result){
                if(result.extend.key=="manager"){
                    window.location.href = "http://localhost:8080/StuManagementSystem/index.jsp";
                    return false;
                }
                if(result.code==200){
                    $("#message").text(result.extend.msg);
                }else{
                    $.ajax({
                        url:"${APP_PATH}/remember/"+dataStr,
                        type:"POST",
                        success:function (result) {

                        }
                    });
                    window.location.href = "http://localhost:8080/StuManagementSystem/index2.jsp";
                }
            }
        });
    });





</script>


</body>
</html>