package magicalzhu.github.io.service;

import magicalzhu.github.io.bean.Employee;
import magicalzhu.github.io.bean.EmployeeExample;
import magicalzhu.github.io.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    @Transactional(readOnly = true)
    public List<Employee> getEmps(){
        return employeeMapper.selectByExampleWithDept(null);
    }
    //添加员工的信息
    @Transactional(readOnly = false)
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }
    //根据员工的姓名查询员工的信息,返回true表示可用
    @Transactional(readOnly =true)
    public boolean checkUser(String empName) {
        EmployeeExample example=new EmployeeExample();

        EmployeeExample.Criteria criteria=example.createCriteria();     //获取Criteria对象
        criteria.andEmpNameEqualTo(empName);                            //拼装查询条件

        long count=employeeMapper.countByExample(example);
        return  count==0;
    }
    @Transactional(readOnly = true)
    public Employee getEmpById(Integer id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }
    @Transactional(readOnly = false)
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
    // 删除 : 单个的删除,按照员工的id删除员工的信息
    @Transactional(readOnly = false)
    public void deleteById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
}
