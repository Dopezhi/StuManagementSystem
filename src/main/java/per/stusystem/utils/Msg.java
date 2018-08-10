package per.stusystem.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 用来定义通用的返回类
 * @author 36473
 *
 */
public class Msg {
    //状态码   100代表成功  200代表失败
    private int code;
    //提示信息
    private String msg;
    //返回给浏览器的数据
    private Map<String, Object> extend=new HashMap<String, Object>();

    //定义对成功信息的基本封装
    public static Msg success() {
        Msg msg=new Msg();
        msg.code=100;
        msg.msg="操作成功";
        return msg;
    }

    //定义对失败信息的基本封装
    public static Msg fail() {
        Msg msg=new Msg();
        msg.code=200;
        msg.msg="操作失败";
        return msg;
    }

    //这里涉及到一些基本知识，静态变量不可以调用非静态变量，因为静态变量是先创建的，除非你在方法里事先创建个对象
    //下面这种写法 this.getExtend().put(key, value); 意思是在被调用这个方法的Msg对象对他的map进行修改，最后还是返回这个Msg对象

    //用于添加返回给浏览器的数据
    public Msg add(String key,Object value) {
        this.getExtend().put(key, value);
        return this;
    }


    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Map<String, Object> getExtend() {
        return extend;
    }
    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }


}