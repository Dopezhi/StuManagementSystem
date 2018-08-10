<%--
  Created by IntelliJ IDEA.
  User: Dopezhi
  Date: 2018/7/20
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html >
<html>
<head>
    <meta charset="utf-8">
    <title>学生管理系统学生端</title>
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
    <style type="text/css">
        body {
            overflow-x:hidden;
            overflow-y:hidden;
        }
    </style>
</head>
<body >

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
            <a class="navbar-brand">Dopezhi</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <!-- <li><a href="#">学生管理系统管理端</a></li> -->
                <li><p class="navbar-text" style="font-size: 16px;">学生管理系统学生端</p></li>
            </ul>
            <form class="navbar-form navbar-left">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search" id="nav_search_input">
                </div>
                <button type="button" class="btn btn-default" id="nav-search">查找</button>
            </form>

            <ul class="nav navbar-nav navbar-right">
                <li><a class="navbar-brand">
                    <img alt="Brand" src="image/edm.jpg" width="30px" height="30px">
                </a></li>
                <li class="dropdown">
                    <a  class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="nav_stuId"><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a id="nav_myself">我的信息</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="http://localhost:8080/StuManagementSystem/login.jsp">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>




<!-- 学生编辑更新的模态框 -->
<div class="modal fade" id="stuUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">我的信息</h4>
            </div>
            <div class="modal-body">
                <!-- 添加内联表单  name最好是跟bean相同，springmvc会为我们封装成类-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="stuId_update_input" class="col-sm-2 control-label">我的学号</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuId" class="form-control" id="stuId_update_input" disabled="disabled" >
                            <span id="helpBlock" class="help-block"></span>
                            <span class="icon"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuName_update_input" class="col-sm-2 control-label">我的姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuName" class="form-control" id="stuName_update_input" >
                            <span id="helpBlock" class="help-block"></span>
                            <span class="icon"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuPwd_update_input" class="col-sm-2 control-label">我的密码</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuPwd" class="form-control" id="stuPwd_update_input" >
                            <span id="helpBlock" class="help-block"></span>
                            <span class="icon"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">我的email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input">
                            <span id="helpBlock" class="help-block"></span>
                            <span class="icon"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">我的性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="stuGender" id="gender1_update_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="stuGender" id="gender2_update_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="grade_update_area" class="col-sm-2 control-label">班级</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 然后由数据库取出来 -->
                            <select class="form-control" name="gradeId" id="grade_update_area">

                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuIdf_update_static" class="col-sm-2 control-label">个人介绍</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="3" name="stuIdf" id="stuIdf_update_static"></textarea>
                            <span id="helpBlock" class="help-block"></span>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="stu_update_btn">保存</button>
            </div>
        </div>
    </div>
</div>




<!-- 学生其他 按钮 的模态框 -->
<div class="modal fade" id="stuDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">其他信息</h4>
            </div>
            <div class="modal-body">
                <!-- 添加内联表单  name最好是跟bean相同，springmvc会为我们封装成类-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="stuName_detail_static" class="col-sm-2 control-label">学生姓名</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="stuName_detail_static" type="text" disabled>
                            <span id="helpBlock" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_detail_static" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input class="form-control" id="email_detail_static" type="text" disabled>
                            <span id="helpBlock" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuIdf_detail_static" class="col-sm-2 control-label">个人介绍</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="3" name="stuIdf" id="stuIdf_detail_static" disabled="disabled"></textarea>
                            <span id="helpBlock" class="help-block"></span>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>



<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class=".col-md-12">
            <h1 align="center">学生信息显示</h1>
            <h3  align="center">学生端</h3>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-12 col-md-offset-10">
            <!-- 			<button class="btn btn-info" id="stu_add_modal_btn">查看</button>
                        <button class="btn btn-success" id="stu_search_all_btn">查找</button>
                        <button class="btn btn-danger" id="stu_delete_all_btn">删除</button> -->

        </div>
    </div>
    <!-- 显示表格信息 -->
    <div class="row">
        <div class=".col-md-12">
            <table class="table table-hover" id="stus_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>学号</th>
                    <th>学生姓名</th>
                    <th>性别</th>
                    <th>班级</th>
                    <th>其他</th>
                </tr>
                </thead>
                <tbody>


                </tbody>
            </table>

        </div>

    </div>
    <!-- 显示分页条 -->
    <div class="row">
        <!-- 分页文字信息 -->
        <div class=".col-md-6 " id="page_info_area">

        </div>

        <!-- 分页条 -->
        <div class=".col-md-12 col-md-offset-6" id="page_nav_area">

        </div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord;	//当前总记录数
    var currentPage;	//当前的第几页

    var beforeInfo;    //打开个人信息之前的信息
    var afterInfo;	   //打开个人信息后面的信息  主要判断有没有发生改变 如果有则触发改变事件
    $(function() {
        //一开始就去首页
        to_page(1);
        get_across();
    });

    //获取跨越的用户名以及密码
    function get_across(){
        $.ajax({
            url:"${APP_PATH}/across",
            type:"GET",
            success:function(result){
                $("#nav_stuId").text(result.extend.acrossName);
                $("#nav_stuId").attr("realId",result.extend.acrossId);
            }
        });
    }


    //到第几页的方法
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/stus",
            data:"pn="+pn,
            type:"GET",
            success:function(result){

                totalRecord=result.extend.pageInfo.total;

                //console.log(result);
                //1.解析并显示员工数据
                build_stus_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                // //3.解析并显示分页条
                build_page_nav(result);
                // $.each($(".check_item"),function(index,item){
                // 			// stuNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                // 			// del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
                // 			console.log($(item).parents("tr").find('td:eq(1)').text());
                // 		});
            }
        });
        get_across();

    }
    function to_page_for_checked(pn,inputId){
        $.ajax({
            url:"${APP_PATH}/stus",
            data:"pn="+pn,
            type:"GET",
            success:function(result){

                totalRecord=result.extend.pageInfo.total;

                //console.log(result);
                //1.解析并显示员工数据
                build_stus_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                // //3.解析并显示分页条
                build_page_nav(result);
                $.each($(".check_item"),function(){
                    // stuNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                    // del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
                    var stuId=$(this).parents("tr").find('td:eq(1)').text();
                    // console.log(stuId);
                    if(stuId==inputId){
                        // $(this).prop('checked', true);
                        $(this).parents("tr").addClass('success');
                    }
                });
            }
        });
        get_across();
    }

    //1.解析并显示员工数据
    function build_stus_table(result) {
        //清空table表格
        $("#stus_table tbody").empty();

        var stus=result.extend.pageInfo.list;
        //对于请求得来的五条数据的集合进行遍历，遍历后的每一条都将加入到<tbody>中
        $.each(stus,function(index,item){
            //alert(item.empName);
            var checkboxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var stuIdTd=$("<td></td>").append(item.stuId);
            var stuNameTd=$("<td></td>").append(item.stuName);
            // var stuPwdTd=$("<td></td>").append(item.stuPwd);
            var stuGender=item.stuGender=="M"?"男":"女";
            var stuGenderTd=$("<td></td>").append(stuGender);
            //var emailTd=$("<td></td>").append(item.email);
            var gradeTd=$("<td></td>").append(item.grade.gradeName);
            var otherBtn=$("<button></button>").addClass("btn btn-success btn-sm look_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-search")).append("查看");
            otherBtn.attr("look-id",item.stuId);
            var otherTd=$("<td></td>").append(otherBtn);


            // var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
            // .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            // editBtn.attr("edit-id",item.stuId);

            // var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
            // .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            // delBtn.attr("del-id",item.stuId);

            // var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //能链式操作的原因：append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkboxTd)
                .append(stuIdTd)
                .append(stuNameTd)
                // .append(stuPwdTd)
                .append(stuGenderTd)
                .append(gradeTd)
                .append(otherTd)
                // .append(btnTd)
                .appendTo("#stus_table tbody");
        });
    }

    //2.解析并显示分页信息
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,"
            +"总"+result.extend.pageInfo.pages+"页,总"
            +result.extend.pageInfo.total+"条记录");
        //记录当前第几页
        currentPage=result.extend.pageInfo.pageNum;
    }

    //3.解析并显示分页条
    function build_page_nav(result) {

        //清空分页条
        $("#page_nav_area").empty();

        //$("#page_nav_area").append
        //分别定义首页以及末页的  前一页以及后一页的li   当点击首页尾页的时候再重新发送ajax请求
        var ul=$("<ul></ul>").addClass("pagination");

        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));

        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));

        //判断当前页有没有前一页和首页，没有的话就设置成这两个按键为不可操作按键
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为了避免不可操作键发出的ajax请求
            firstPageLi.click(function() {
                to_page(1);
            });

            prePageLi.click(function() {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));

        var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

        //同理判断当前页有没有后一页和尾页，没有的话就设置成这两个按键为不可操作按键
        if(result.extend.pageInfo.hasNextPage==false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else{

            nextPageLi.click(function() {
                to_page(result.extend.pageInfo.pageNum+1);
            });

            lastPageLi.click(function() {
                to_page(result.extend.pageInfo.pages);
            });
        }
        //按照框架的镶嵌添加
        ul.append(firstPageLi).append(prePageLi);

        //遍历页码号 item表示遍历的每一个个体
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }

            //为这里的每一页都绑定单击事件
            numLi.click(function() {
                to_page(item);
            });

            ul.append(numLi);
        });



        ul.append(nextPageLi).append(lastPageLi);

        var navEle=$("<nav></nav>").append(ul);
        //这里又不用穿$
        navEle.appendTo("#page_nav_area");
    }



    //重置方法 form 表单数据 以及样式的方法
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error has-feedback");
        $(ele).find(".help-block").text("");
        $(ele).find(".icon").removeClass("glyphicon glyphicon-ok form-control-feedback");
        $(ele).find(".icon").removeClass("glyphicon glyphicon-remove form-control-feedback");
    }

    //为模态框打开后 获取部门列表的信息
    function getGrades(ele) {
        //清空样式
        $(ele).empty();

        $.ajax({
            url:"${APP_PATH}/grades",
            type:"GET",
            success:function(result){
                var gradesInfo=result.extend.grades;
                $.each(gradesInfo,function(index,item){
                    var selectLi=$("<option></option>").append(item.gradeName).attr("value",item.gradeId);
                    selectLi.appendTo(ele);
                });
            }
        });
    }



    //前端校验表单数据
    function validate_add_form() {
        //获取表单里的学生学号，并添加正则表达式   3 到9的数字
        var stuId=$("#stuId_add_input").val();
        var regId=/^[0-9_-]{3,9}$/;
        //获取表单里的姓名 ，并添加正则表达式.
        var stuName=$("#stuName_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        //获取表单的中的密码，并添加正则表达式
        // var stuPwd=$("#stuPwd_add_input").val();
        // var regPwd=/^[a-zA-Z0-9_-]{3,9}$/;
        //获取表单的email,并添加邮箱的正则表达式
        var stuEmail=$("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if(!regId.test(stuId)){
            show_validate_msg("#stuId_add_input","error","学号必须是3-9个数字组合");
            return false;
        }else{
            show_validate_msg("#stuId_add_input","success"," ");
        }

        if(!regName.test(stuName)){
            show_validate_msg("#stuName_add_input","error","名字必须是2-5个中文或者6-16位英文数字组合");
            return false;
        }else{
            show_validate_msg("#stuName_add_input","success"," ");
        }
        // if(!regPwd.test(stuPwd)){
        // 	show_validate_msg("#stuPwd_add_input","error","密码必须是3-9位英文数字组合");
        // 	return false;
        // }else{
        // 	show_validate_msg("#stuPwd_add_input","success"," ");
        // }

        if(!regEmail.test(stuEmail)){
            show_validate_msg("#email_add_input","error","邮箱格式输入错误");
            return false;
        }else{
            show_validate_msg("#email_add_input","success"," ");
        }
        return true;
    }

    //显示文本框 下面的提示信息!
    //校验表单数 据  姓名 邮箱等
    //因为样式是从现有样式添加进去的 所以每次加新样式的时候，要把旧样式删除
    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error has-feedback");
        $(ele).next("span").text("");
        $(ele).next("span").next("span").removeClass("glyphicon glyphicon-ok form-control-feedback");
        $(ele).next("span").next("span").removeClass("glyphicon glyphicon-remove form-control-feedback");
        if(status=="success"){
            $(ele).parent().addClass("has-success has-feedback");
            $(ele).next("span").text(msg);
            $(ele).next("span").next("span").addClass("glyphicon glyphicon-ok form-control-feedback");
        }else{
            $(ele).parent().addClass("has-error has-feedback");
            $(ele).next("span").text(msg);
            $(ele).next("span").next("span").addClass("glyphicon glyphicon-remove form-control-feedback");
        }
    }
    //进行后台校验（有没有重复的学号）当输入框有改变的时候就发出ajax请求
    //有个值得思考的问题：虽然这里存在用户给了提示，但是  保存按钮还是会生效 但是又不可能编程正常的方法（内嵌的好）,这样可以通过加一点特殊属性


    //列表内查看 其他 按钮
    $(document).on("click",".look_btn",function(){
        getStu($(this).attr("look-id"),"stuDetailModal");
        //在模态框之前获取学生信息
        $('#stuDetailModal').modal({
            backdrop:"true", //如果设置成static就不会消失
        });
    });
    //获取学生信息
    function getStu(id,location){
        $.ajax({
            url:"${APP_PATH}/stu/"+id,
            type:"POST",
            success:function(result){
                if(location=="stuDetailModal"){
                    setMsgInDetail(result);
                }else if(location=="stuUpdateModal"){
                    setMsgInUpdate(result);
                    // beforeInfo=$("#stuUpdateModal form").serialize();
                    // console.log(beforeInfo);
                }
            }
        });
    }

    //获取学生信息之 给查看窗口布局
    function setMsgInDetail(result){
        var stuData=result.extend.stu;
        $("#stuName_detail_static").val(stuData.stuName);
        $("#email_detail_static").val(stuData.email);
        $("#stuIdf_detail_static").val(stuData.stuIdf);
    }
    //获取学生信息之 给编辑窗口布局
    function setMsgInUpdate(result){
        var stuData=result.extend.stu;
        $("#stuId_update_input").val(stuData.stuId);
        $("#stuName_update_input").val(stuData.stuName);
        $("#stuPwd_update_input").val(stuData.stuPwd);
        $("#email_update_input").val(stuData.email);
        $("#stuUpdateModal input[name=stuGender]").val([stuData.stuGender]);
        $("#stuUpdateModal select").val(stuData.gradeId);
        $("#stuIdf_update_static").val(stuData.stuIdf);
        beforeInfo=$("#stuUpdateModal form").serialize();
        console.log(beforeInfo);

    }



    $("#nav_myself").click(function() {
        // var stuId=$("#nav_stuId").text();
        var stuId=$("#nav_stuId").attr("realid");
        reset_form("#stuUpdateModal form");
        getGrades("#grade_update_area");
        getStu(stuId,"stuUpdateModal");
        $("#stu_update_btn").attr("update-id",stuId);
        $("#stu_update_btn").attr("ajax-va","");
        //获取这个表单初始状态信息
        //在模态框之前获取学生信息
        $('#stuUpdateModal').modal({
            backdrop:"true", //如果设置成static就不会消失
        });
    });


    //统一实现及填及时显示是否可用
    $("#stuName_update_input").change(function() {
        var stuName=this.value;
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if(!regName.test(stuName)){
            show_validate_msg("#stuName_update_input","error","名字必须是2-5个中文或者6-16位英文数字组合");
            $("#stu_update_btn").attr("ajax-va","error");
            return false;
        }else{
            show_validate_msg("#stuName_update_input","success"," ");
            $("#stu_update_btn").attr("ajax-va","success");
        }

    });
    $("#stuPwd_update_input").change(function() {
        var stuPwd=this.value;
        var regPwd=/^[a-zA-Z0-9_-]{3,9}$/;
        if(!regPwd.test(stuPwd)){
            show_validate_msg("#stuPwd_update_input","error","密码必须是3-9位英文数字组合");
            $("#stu_update_btn").attr("ajax-va","error");
            return false;
        }else{
            show_validate_msg("#stuPwd_update_input","success"," ");
            $("#stu_update_btn").attr("ajax-va","success");
        }

    });
    $("#email_update_input").change(function() {
        var stuEmail=this.value;
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(stuEmail)){
            show_validate_msg("#email_update_input","error","邮箱格式输入错误");
            $("#stu_update_btn").attr("ajax-va","error");
            return false;
        }else{
            show_validate_msg("#email_update_input","success"," ");
            $("#stu_update_btn").attr("ajax-va","success");
        }

    });

    //为更新按钮绑定单击事件
    $("#stu_update_btn").click(function(){
        afterInfo=$("#stuUpdateModal form").serialize();
        // console.log(beforeInfo);
        console.log(afterInfo);
        if($("#stu_update_btn").attr("ajax-va")=="error"){
            return false;
        }
        else{
            if(beforeInfo==afterInfo){
                $("#stuUpdateModal").modal('hide');
            }else{
                if(confirm("确定要更新信息吗?")){
                    var updateStuId=$("#stu_update_btn").attr("update-id");
                    // var testString="hello";
                    $.ajax({
                        <%--url:"${APP_PATH}/updateByStuSystem/"+updateStuId,--%>
                        url:"${APP_PATH}/updateByStuSystem/"+updateStuId,
                        type:"POST",
                        data:$("#stuUpdateModal form").serialize(),
                        // data:{student:$("#stuUpdateModal form").serialize(),stuId:updateStuId},
                        success:function(result){
                            alert("更新成功");
                            var page=parseInt((result.extend.NumInTable)/5)+1;
                            console.log(page);
                            var inRow=result.extend.NumInTable%5;
                            console.log(inRow);
                            //如果余数是0 证明是第五行数据  如果是其他，就是正常的
                            $("#stuUpdateModal").modal('hide');
                            if(inRow==0){
                                to_page_for_checked(page-1,updateStuId);
                            }else{
                                to_page_for_checked(page,updateStuId);
                            }
                            $("#stuUpdateModal").modal('hide');

                        }
                    });
                }else{
                    $("#stuUpdateModal").modal('hide');
                }
            }


        }
    });


    //处理全选以及全不选
    $("#check_all").click(function() {
        //原生的属性值用prop属性值
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".check_item",function(){
        //判断当前已经选中的单选按钮是不是等于所有单选按钮个数，如果等于  就是给全选按钮设置属性
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    $("#nav-search").click(function() {
        var stuId=$("#nav_search_input").val();
        var regId=/^[0-9_-]{3,9}$/;
        console.log(stuId);
        if(!regId.test(stuId)){
            alert("学号必须是3-9个数字组合");
            return false;
        }else{
            $.ajax({
                url:"${APP_PATH}/search/"+stuId,
                type:"POST",
                success:function(result){
                    if(result.code==200){
                        alert(result.extend.msg);
                        return false;
                    }else{
                        var page=parseInt((result.extend.NumInTable)/5)+1;
                        console.log(page);
                        var inRow=result.extend.NumInTable%5;
                        console.log(inRow);
                        //如果余数是0 证明是第五行数据  如果是其他，就是正常的
                        if(inRow==0){
                            to_page_for_checked(page-1,stuId);
                            // to_page(page-1,stuId);
                            // $("#stus_table").find("td:eq(29)")
                            // 					.prop("checked",true);
                            //stuNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                            //del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";

                        }else{
                            to_page_for_checked(page,stuId);
                            // to_page(page,stuId);
                            // var flag=$("#stus_table form").find("tr:eq("+inRow+")");
                            // flag.find("td:eq(0)").prop("checked",true);
                            // console.log(flag);
                        }
                    }
                }
            });
        }


    });

</script>

</body>
</html>