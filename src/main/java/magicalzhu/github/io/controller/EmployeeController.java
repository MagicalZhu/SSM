package magicalzhu.github.io.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import magicalzhu.github.io.bean.Employee;
import magicalzhu.github.io.bean.Msg;
import magicalzhu.github.io.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Administrator
 * 用于处理员工信息的CRUD
 */

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "/emps",method = RequestMethod.GET)
    //查询员工数据(分页查询-->返回json的方式)
    public Msg getEmpsWithJson(@RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn){
        PageHelper.startPage(pn,5);                      //引入PageHelper,传入页码和每一页的大小
        List<Employee> emps=employeeService.getEmps();
        PageInfo<Employee> info=new PageInfo<>(emps,6);    //使用PageInfo包装查询后的结果,以及分页导航的页数
        return Msg.success().add("pageInfo",info);
    }

    //查询员工数据(分页查询-->普通的返回方式)
    /*@RequestMapping(value = "/emps",method = RequestMethod.GET)
    public String getEmps(@RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                          Map<String,Object> map){
        PageHelper.startPage(pn,5);                      //引入PageHelper,传入页码和每一页的大小
        List<Employee> emps=employeeService.getEmps();
        PageInfo<Employee> info=new PageInfo<>(emps,6);    //使用PageInfo包装查询后的结果,以及分页导航的页数
        map.put("pageInfo",info);
        return "list";
    }*/
}



























