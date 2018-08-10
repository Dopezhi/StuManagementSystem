<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html >
<html>
<head>
<meta  charset="utf-8">
<title>学生管理系统注册</title>
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
#msg{
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
	<!-- 注册界面 填写更多信息 的模态框 -->
<div class="modal fade" id="regDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  	<div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">填写更多信息</h4>
      </div>
 	<div class="modal-body">
      <!-- 添加内联表单  name最好是跟bean相同，springmvc会为我们封装成类-->
        <form class="form-horizontal">
            <div class="form-group">
               <label for="stuName_reg_static" class="col-sm-2 control-label">姓名</label>
               <div class="col-sm-10">
                 <input class="form-control" id="stuName_reg_static" type="text" placeholder="名字必须是2-5个中文或者6-16位英文数字组合" >
                 <span id="helpBlock" class="help-block"></span>
               </div>
             </div>
			 <div class="form-group">
			   <label for="email_detail_static" class="col-sm-2 control-label">email</label>
			   <div class="col-sm-10">
			     <input class="form-control" id="email_detail_static" type="text" placeholder="邮箱格式需正确，可不填" >
			     <span id="helpBlock" class="help-block"></span>
			   </div>
			 </div>
			  <div class="form-group">
			   <label class="col-sm-2 control-label">性别</label>
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
			   <label for="stuIdf_detail_static" class="col-sm-2 control-label">介绍</label>
			   <div class="col-sm-10">
			     <textarea class="form-control" rows="3" name="stuIdf" id="stuIdf_detail_static" style="margin: 0px -2.31534px 0px 0px; width: 379px; height: 89px;" ></textarea>
			     <span id="msg" class="help-block"></span>
			   </div>
			 </div>	
	 
		</form>
	</div>
	<div class="modal-footer">
	     <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="reg_detail_btn">确定</button>
	 </div>
</div>	 
</div>
</div>


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
            <form class="form-horizontal" id="reg_form">
                <span class="heading">用户注册</span>
                <div class="form-group">
                    <input type="text" class="form-control" id="reg_input_stuId" placeholder="学生学号">
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control" id="reg_input_stuPwd" placeholder="密　码">
                    <i class="fa fa-lock"></i>
                    <a href="#" class="fa fa-question-circle"></a>
                </div>
                 <div class="form-group">
                    <input type="password" class="form-control" id="reg_input_stuPwd_again" placeholder="确认密码">
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group">
                    <span id="message"> </span>
                </div>
                <div class="form-group">
                    <div class="main-checkbox">
                        <input type="checkbox" value="None" id="checkbox1" name="check"/>
                        <label for="checkbox1"></label>
                    </div>
                    <span class="text">填写更多信息</span>
                    <!-- <button type="button" class="btn btn-default" id="login_more_btn">more</button> -->
                    <button type="button" class="btn btn-default" id="login_btn">注册</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script  type="text/javascript">
	//当学生学号输入框变化时，检查有没有重复的id
	$("#reg_input_stuId").change(function() {
		$("#message").text("");
		$("#login_btn").attr("error","");
		var stuId=$("#reg_input_stuId").val();
        var regId=/^[0-9_-]{3,9}$/;
        if(!regId.test(stuId)){
            $("#message").text("学号必须是3-9个数字组合");
            $("#login_btn").attr("error","error");
            return false;
        }
		$.ajax({
			url:"${APP_PATH}/checkId",
			type:"POST",
			data:"stuId="+stuId,
			success:function(result){
				if(result.code==200){
					$("#message").text(result.extend.va_msg);
					$("#login_btn").attr("error","error");
					return false;
				}
			}
		});
	});

	//当密码框输入时，进行校验
	$("#reg_input_stuPwd").change(function() {
		$("#message").text("");
		$("#login_btn").attr("error","");
		var stuPwd=$(this).val();
		var regPwd=/^[a-zA-Z0-9_-]{3,9}$/;
		if(!regPwd.test(stuPwd)){
			$("#message").text("密码必须是3-9位英文数字组合");
			$("#login_btn").attr("error","error");
			return false;
		}
	});

	//确认密码框以及输入密码的验证
	$("#reg_input_stuPwd_again").change(function() {
		$("#message").text("");
		$("#login_btn").attr("error","");
		var stuPwd=$("#reg_input_stuPwd").val();
		var stuPwdAgain=$(this).val();
		if(stuPwd!=stuPwdAgain){
			$("#message").text("两次密码输入不一致");
		    $("#login_btn").attr("error","error");
		    return false;
		}
	});

	//注册按钮事件
	$("#login_btn").click(function() {
		if($(this).attr("error")=="error"){
			return false;
		}else{

		}
	});
	//当点击填写更多信息时
	$("#checkbox1").click(function() {
		getGrades("#grade_update_area");
		$('#regDetailModal').modal({
				backdrop:"true", //如果设置成static就不会消失
			});
	});

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


    //当点确定按钮时，关闭模态框
    $("#reg_detail_btn").click(function() {
       $("#regDetailModal").modal('hide');
    });

    //绑定注册单击事件
    $("#login_btn").click(function() {
        if($(this).attr("error")=="error"){
            alert("你填写的信息有误，请检查");
            return false;
        }
       //获取一系列信息看是否正确
       var stuId=$("#reg_input_stuId").val();
       var stuName=$("#stuName_reg_static").val();
       var stuPwd=$("#reg_input_stuPwd").val();
       var stuEmail=$("#email_detail_static").val();
       var stuGender=$("#regDetailModal input[name=stuGender]").val();
       var stuGradeId=$("#regDetailModal select").val();
       var stuIdf=$("#stuIdf_detail_static").val();

       // if(stuEmail==""){
       //  alert("1");
       // }
       // if(stuIdf==""){
       //  alert("2");
       // }
       if(!validate_reg_form()){
          return false;
       }
       if(stuGradeId==null){
        alert("你还没填写更多信息");
        return false;
       }
       if(stuName==""){
        alert("你还没填写姓名");
        return false;
       }
       var str=stuId+'-'+stuName+'-'+stuPwd+'-'+stuGender+'-'+stuGradeId;
       //有个奇怪的现象，当这两个为空的时候，那边是显示越界异常
       if(stuEmail==""){
        stuEmail="emailNull";
       }
       if(stuIdf==""){
        stuIdf="stuIdfNull";
       }
       var other=stuEmail+"-"+stuIdf;
       console.log(str);
       console.log(other);

       $.ajax({
            url:"${APP_PATH}/reg/"+str,
            type:"POST",
            data:"other="+other,
            success:function(result){
                if(result.code==100){
                    window.location.href = "http://localhost:8080/StuManagementSystem/index2.jsp";
                }
            }
       });
    });

    //更多信息输入框中 姓名的输入验证
    $("#stuName_reg_static").change(function() {
        var stuName=this.value;
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if(!regName.test(stuName)){
            $("#msg").text('名字必须是2-5个中文或者6-16位英文数字组合');
            $("#login_btn").attr("error","error");
        }else{
            $("#msg").text('');
            $("#login_btn").attr("error","");
        }
    });

    //更多信息的输入框中 邮箱的输入验证
    $("#email_detail_static").change(function() {
        var stuEmail=this.value;
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(stuEmail)){
            $("#msg").text('邮箱格式输入错误');
            $("#login_btn").attr("error","error");
        }else{
            $("#msg").text('');
            $("#login_btn").attr("error","");
        }
    });

    //前端校验表单数据
    function validate_reg_form() { 
        //获取表单里的学生学号，并添加正则表达式   3 到9的数字
        var stuId=$("#reg_input_stuId").val();
        var regId=/^[0-9_-]{3,9}$/;
        //获取表单的中的密码，并添加正则表达式
        var stuPwd=$("#reg_input_stuPwd").val();
        var regPwd=/^[a-zA-Z0-9_-]{3,9}$/;
        
        if(!regId.test(stuId)){
            show_validate_msg("error","学号必须是3-9个数字组合");
            return false;
        }else{
            show_validate_msg("success"," ");
        }
        
        if(!regPwd.test(stuPwd)){
            show_validate_msg("error","密码必须是3-9位英文数字组合");
            return false;
        }else{
            show_validate_msg("success"," ");
        }
        
        return true;
    }

    function show_validate_msg(status,msg) {
        $("#message").text("");
        $("#login_btn").attr("error","");
        if(status=="success"){
            
        }else{
            $("#message").text(msg);
            $("#login_btn").attr("error","error");
        }
    }

</script>
</body>
</html>