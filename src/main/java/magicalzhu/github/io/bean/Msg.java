package magicalzhu.github.io.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Administrator
 * 用于返回Json数据的通用的类
 */
public class Msg {
    private int code;       //状态码
    private String msg;     //提示信息
    private Map<String,Object> extend=new HashMap<>();      //用户要返回给浏览器的数据

    //定义两个成功和失败的快捷方式
    public static  Msg success(){
        Msg result=new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }
    public static  Msg fail(){
        Msg result=new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }
    //定义添加模型数据的方法
    public  Msg  add(String key,Object value){
       this.getExtend().put(key,value);
       return  this;
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

    public Msg(int code, String msg, Map<String, Object> extend) {
        this.code = code;
        this.msg = msg;
        this.extend = extend;
    }

    public Msg() {
    }

    @Override
    public String toString() {
        return "Msg{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", extend=" + extend +
                '}';
    }
}
