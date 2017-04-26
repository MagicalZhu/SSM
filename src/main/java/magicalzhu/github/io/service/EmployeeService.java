package magicalzhu.github.io.service;

import magicalzhu.github.io.bean.Employee;
import magicalzhu.github.io.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Administrator
 * Service层
 */
@Service
public class EmployeeService {
    @Autowired
   private EmployeeMapper employeeMapper;
    //1.查询员工的数据(带有分页)
    public List<Employee> getEmps(){
        return employeeMapper.selectByExampleWithDept(null);
    }
}
