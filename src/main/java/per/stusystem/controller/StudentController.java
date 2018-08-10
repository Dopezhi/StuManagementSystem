package per.stusystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import per.stusystem.pojo.Student;
import per.stusystem.service.StudentService;
import per.stusystem.service.SystemService;
import per.stusystem.utils.Msg;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StudentController {
    @Autowired
    StudentService  studentService;

    @Autowired
    SystemService systemService;

    //学生登录时从登录端→学生端 信息的传递
    String acrossId;
    String acrossName;


    /**
     * 获取浏览器search_cookie  (第一种，实现的是记住上次的登录状态，下次打开网页时自动补入账号密码等)
     * 解释：为什么只能记住一个账号密码，因为cookie上有三行信息，第一是name,第二是password,第三是其他，你传入的值都会被重新刷新，一直只有三行
     */
//    @RequestMapping(value = "/search_cookie",method = RequestMethod.POST)
//    @ResponseBody
//    public Msg searchCookieOne(HttpServletRequest request) throws UnsupportedEncodingException {
//        String userName="";
//        String password="";
//        Cookie[] cookies=request.getCookies();
//        if(cookies!=null&&cookies.length>0){
//            //遍历Cookie
//            for(int i=0;i<cookies.length;i++){
//                Cookie cookie=cookies[i];
//                //此处类似与Map有name和value两个字段,name相等才赋值,并处理编码问题
////                System.out.println(cookie.getName());
//                if("name".equals(cookie.getName())){
////                    System.out.println("这里");
//                    userName=java.net.URLDecoder.decode(cookie.getValue(),"utf-8");
//                }
//                if("password".equals(cookie.getName())){
//                    password=cookie.getValue();
//                }
//            }
//        }
//            return Msg.success().add("password",password).add("userName",userName);
//
//
//    }


    /**
     * 获取浏览器search_cookie  (第二种，下次打开网页时账号自己输入，账号与cookie的相同才补上密码)
     * 思路：先用两个Str取出来cookies中的账号与密码，inputName与userName相同返回正确
     */
    @RequestMapping(value = "/search_cookie/{inputName}",method = RequestMethod.POST)
    @ResponseBody
    public Msg searchCookie(@PathVariable(value = "inputName") String inputName, HttpServletRequest request) throws UnsupportedEncodingException {
        String userName="";
        String password="";
        Cookie[] cookies=request.getCookies();
        if(cookies!=null&&cookies.length>0){
            //遍历Cookie
            for(int i=0;i<cookies.length;i++){
                Cookie cookie=cookies[i];
                //此处类似与Map有name和value两个字段,name相等才赋值,并处理编码问题
//                System.out.println(cookie.getName());
                if("name".equals(cookie.getName())){
//                    System.out.println("这里");
                    userName=java.net.URLDecoder.decode(cookie.getValue(),"utf-8");
                }
                if("password".equals(cookie.getName())){
                    password=cookie.getValue();
                }
            }
            if(inputName.equals(userName)){
                return Msg.success().add("password",password);
            }
        }
        return Msg.fail();


    }


    /**
     * 记住密码功能 （Test）
     */

    @RequestMapping(value = "/remember/{dataStr}",method = RequestMethod.POST)
    @ResponseBody
    public void addCookie(@PathVariable(value = "dataStr")String dataStr, String userName, String password, HttpServletResponse response, HttpServletRequest request) throws UnsupportedEncodingException {
        //解析字符串
        String [] strings=dataStr.split("-");
        userName=strings[0];
        password=strings[1];
        String rememberMe=strings[2];

        if(!userName.equals("") && !password.equals("")){
            System.out.println("0");
            //创建Cookie
            Cookie nameCookie=new Cookie("name",URLEncoder.encode(userName,"utf-8"));
            Cookie pswCookie=new Cookie("password",password);

            //设置Cookie的父路径
            nameCookie.setPath(request.getContextPath()+"/");
            pswCookie.setPath(request.getContextPath()+"/");

            //获取是否保存Cookie
            if(rememberMe==null ||rememberMe.equals("false")){//不保存Cookie
                nameCookie.setMaxAge(0);
                pswCookie.setMaxAge(0);
                System.out.println("1");
            }else{//保存Cookie的时间长度，单位为秒
                nameCookie.setMaxAge(7*24*60*60);
                pswCookie.setMaxAge(7*24*60*60);
                System.out.println("2");
            }
            //加入Cookie到响应头
            response.addCookie(nameCookie);
            response.addCookie(pswCookie);
        }
        //遍历一下cookie
//        Cookie[] cookies=request.getCookies();
//        for (int i = 0; i < cookies.length; i++) {
//            System.out.println(cookies[i].getName()+"-"+cookies[i].getValue());
//        }
    }



    /**
     * 注册按钮  最傻的注册 没有之一(赶时间)
     */
    @RequestMapping(value="/reg/{str}",method=RequestMethod.POST)
    @ResponseBody
    public Msg reg(@PathVariable String str,String other) {
        String []strs=str.split("-");
        String []others=other.split("-");
        for (String string : others) {
            System.out.println(string);
        }
//		System.out.println("=========");
//		for (String string : strs) {
//			System.out.println(string);
//		}
        String stuId=strs[0];
        String stuName=strs[1];
        String stuPwd=strs[2];
        String stuGender=strs[3];
        String stuGradeId=strs[4];

        String stuEmail;
        String stuIdf;
        if(others[0].equals("emailNull")) {
            stuEmail=null;
        }else {
            stuEmail=others[0];
        }
        if(others[1].equals("stuIdfNull")) {
            stuIdf=null;
        }else {
            stuIdf=others[1];
        }
        Student regStudent=new Student(Integer.valueOf(stuId), stuName, stuPwd, stuEmail, stuGender,
                stuIdf, Integer.valueOf(stuGradeId));
//		System.out.println(regStudent);
        studentService.regStudent(regStudent);
        //执行跨越操作
//		int NumInTable=studentService.getNumInTable(regStudent.getStuId());
        acrossId=String.valueOf(regStudent.getStuId());
        acrossName=regStudent.getStuName();

        return Msg.success();
    }
    /**
     * 跨越页面时获取到上一个页面时的信息
     */
    @RequestMapping(value = "/across",method = RequestMethod.GET)
    @ResponseBody
    public Msg getAcrossMessage(){
        return Msg.success().add("acrossId",acrossId).add("acrossName",acrossName);
    }

    /**
     * 学生登录操作
     */
    @RequestMapping(value = "/login/{stuId}",method = RequestMethod.POST)
    @ResponseBody
    public Msg loginStuById(@PathVariable(value = "stuId") int stuId, String stuPwd){
        if(String.valueOf(stuId).equals("888")){
            boolean flag=systemService.systemLogin(String.valueOf(stuId),stuPwd);
            if(flag==true){
                return Msg.success().add("key", "manager");
            }
        }
        Student student=studentService.loginStuByIdAndPwd(stuId,stuPwd);
        if(student==null){
            return Msg.fail().add("msg", "用户名或者密码不正确");
        }else{
            acrossId=String.valueOf(student.getStuId());
            acrossName=student.getStuName();
            return Msg.success();
        }
    }


    /**
     * 更新学生
     * 学生端的更新  因为列表序列化已经设置学号为disable 不能传值
     */
    @RequestMapping(value = "/updateByStuSystem/{updateStuId}",method = RequestMethod.POST)
    @ResponseBody
    public Msg updateByStu(Student student,@PathVariable(value = "updateStuId")int stuId){
        student.setStuId(stuId);
        studentService.updateByRecord(student);
        int numInTable=studentService.getNumInTable(stuId);
        return Msg.success().add("NumInTable",numInTable);
    }



    /**
     * 更新学生  如果他更新主键的话，其实也就相当于新建了一个学生 ，如果不更新主键，其实就是简单的更新
     * 管理端的更新
     */
    @RequestMapping(value="/update/{updateStuId}",method=RequestMethod.POST)
    @ResponseBody
    public Msg updateByMgt(Student student,@PathVariable(value="updateStuId")int updateStuId) {
        if(studentService.getStuById(student.getStuId())==null) {
            studentService.saveNewStu(student);
            studentService.deleteStuById(updateStuId);
            int NumInTable=studentService.getNumInTable(student.getStuId());
            return Msg.success().add("NumInTable", NumInTable).add("UpdateOrSave", "save");
        }else {
            studentService.updateByRecord(student);
            return Msg.success().add("UpdateOrSave", "update");
        }

    }

    /**
     * 通过id获取学生信息 (为编辑窗口布局以及查看按钮布局)
     */
    @RequestMapping(value="/stu/{id}",method=RequestMethod.POST)
    @ResponseBody
    public Msg getStu(@PathVariable("id") int id) {
        Student student=studentService.getStuById(id);
        return Msg.success().add("stu", student);

    }
    /**
     * 通过id查找学生是否存在，存在则返回对应的在数据表的行号 （查找）
     */
    @RequestMapping(value="/search/{id}",method=RequestMethod.POST)
    @ResponseBody
    public Msg getStuInRow(@PathVariable("id") int id) {
        Student student=studentService.getStuById(id);
        if(student==null) {
            return Msg.fail().add("msg", "没有此学生的信息");
        }else {
            int numInTable=studentService.getNumInTable(student.getStuId());
            return Msg.success().add("NumInTable",numInTable);
        }
    }
    /**
     * 删除学生 （包括单个或者多个）
     */
    @RequestMapping(value="/stuDelete/{stuId}",method=RequestMethod.DELETE)
    @ResponseBody()
    public Msg deleteById(@PathVariable(value="stuId")String stuIds) {
        if(stuIds.contains("-")) {
            List<Integer> ids=new ArrayList<>();
            String [] stuIdStrs=stuIds.split("-");
            for (String string : stuIdStrs) {
                ids.add(Integer.valueOf(string));
            }
            studentService.deleteStuByList(ids);
            return Msg.success();

        }else {
            int stuId=Integer.valueOf(stuIds);
            studentService.deleteStuById(stuId);
            return Msg.success();
        }
    }

    /**
     * 新增学生
     */
    @RequestMapping(value="/stu",method=RequestMethod.POST)
    @ResponseBody
    public Msg saveNewStudent(Student student) {
        studentService.saveNewStu(student);
        int NumInTable=studentService.getNumInTable(student.getStuId());
        return Msg.success().add("NumInTable", NumInTable);
    }

    /**
     * 检查学号是否可用
     */
    @RequestMapping(value="/checkId",method=RequestMethod.POST)
    @ResponseBody
    public Msg checkStuId(@RequestParam(value="stuId") Integer stuId ) {
        String regex="^[0-9_-]{3,9}$";
        if(!(String.valueOf(stuId).matches(regex))) {
            return Msg.fail().add("va_msg", "学号必须是3-9个数字组合");
        }
        boolean flag=studentService.checkIdExistNot(stuId);
        if(flag==true) {
            return Msg.fail().add("va_msg", "已存在该学号");
        }
        return Msg.success();

    }

    /**
     * 获取学生列表展示在页面。
     * @return
     */
    @RequestMapping("/stus")
    @ResponseBody
    public Msg getStusWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
        //这不是一个分页查询;
        //引入PageHelper分页插件
        //在查询之前只需要调用 ,传入页码以及每页的数据条数,一页5条数据，
        //从第几页开始，一页有5数据
        PageHelper.startPage(pn, 5);

        //startPage 紧跟的这个查询就是一个分页查询
        List<Student>stus=studentService.getAll();

    //导入PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
    //封装了详细的分页信息，包括有我们查询出来的数据  传入连续显示的页数,

    //原理：我在页面中请求emps请求，也就是默认请求第一页的数据，上面也设置了默认是1，并且一页有5页数据，用pageInfo设置了连续显示5页
    //每当我在页面点击第几页，会相当于再发送一个请求，这里的Pn就变成了第几页开始的。
    PageInfo page = new PageInfo(stus,5);
        return Msg.success().add("pageInfo", page);

}

//    /**
//     * 获取学生列表展示在页面，传统的测试mvc格式
//     * @return
//     */
//    @RequestMapping("/stus")
//    public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,
//                          Model model) {
//        //这不是一个分页查询;
//        //引入PageHelper分页插件
//        //在查询之前只需要调用 ,传入页码以及每页的数据条数,一页5条数据
//        PageHelper.startPage(pn, 5);
//
//        //startPage 紧跟的这个查询就是一个分页查询
//        List<Student>students=studentService.getAll();
//
//        //导入PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
//        //封装了详细的分页信息，包括有我们查询出来的数据  传入连续显示的页数,
//        PageInfo page = new PageInfo(students,5);
//        model.addAttribute("pageInfo",page);
//
//        return "/list";
//    }
}
