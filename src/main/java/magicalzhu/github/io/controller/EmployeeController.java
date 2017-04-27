package magicalzhu.github.io.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import magicalzhu.github.io.bean.Department;
import magicalzhu.github.io.bean.Employee;
import magicalzhu.github.io.bean.Msg;
import magicalzhu.github.io.service.DepartmentService;
import magicalzhu.github.io.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Administrator
 * 用于处理员工信息的CRUD
 */

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private DepartmentService departmentService;
    @ResponseBody
    @RequestMapping(value = "/emps",method = RequestMethod.GET)
    //查询员工数据(分页查询-->返回json的方式)
    public Msg getEmpsWithJson(@RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn){
        PageHelper.startPage(pn,5);                      //引入PageHelper,传入页码和每一页的大小
        List<Employee> emps=employeeService.getEmps();
        PageInfo<Employee> info=new PageInfo<>(emps,6);    //使用PageInfo包装查询后的结果,以及分页导航的页数
        return Msg.success().add("pageInfo",info);
    }
    //显示添加信息
    @ResponseBody
    @RequestMapping(value = "/depts",method = RequestMethod.GET)
    public Msg getDepts(){
        List<Department> depts=departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
    //保存员工信息
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public  Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    //根据员工的姓名查询员工的信息
    @ResponseBody
    @RequestMapping(value = "/checkUser",method = RequestMethod.GET)
    public Msg getEmpByName(@RequestParam("empName")String empName){
        //判断用户名是不是合法的表达式
        String regx="(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(! empName.matches(regx)){
            return Msg.fail().add("ajaxValidate","用户名不合法");
        }
        boolean flag =employeeService.checkUser(empName);
        if(flag==false){
            return Msg.fail().add("ajaxValidate","用户名已经存在");
        } else {
            return Msg.success();
        }
    }
    //修改 :　根据员工的id查询员工的信息
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmpById(id);
        return Msg.success().add("emp", employee);
    }
    //修改 :　修改员工的信息
    @ResponseBody
    @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
 /*   //查询员工数据(分页查询-->普通的返回方式)
    @RequestMapping(value = "/emps",method = RequestMethod.GET)
    public String getEmps(@RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                          Map<String,Object> map){
        PageHelper.startPage(pn,5);                      //引入PageHelper,传入页码和每一页的大小
        List<Employee> emps=employeeService.getEmps();
        PageInfo<Employee> info=new PageInfo<>(emps,6);    //使用PageInfo包装查询后的结果,以及分页导航的页数
        map.put("pageInfo",info);
        return "list";
    }*/
}



























