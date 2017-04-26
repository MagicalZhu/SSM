package magicalzhu.github.io.test;

import magicalzhu.github.io.bean.Department;
import magicalzhu.github.io.bean.Employee;
import magicalzhu.github.io.dao.DepartmentMapper;
import magicalzhu.github.io.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author Administrator
 * 测试Dao-->
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private SqlSession sqlSession;
    //1.测试Department
    @Test    //插入部门信息(带哪个插入哪个)
    public void TestAddDept(){
       departmentMapper.insertSelective(new Department(null,"开发部"));
       departmentMapper.insertSelective(new Department(null,"测试部"));
    }
    @Test   //测试单条插入员工数据
    public void TestAddEmp(){
        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
    }
    @Test   //测试批量添加
    public void TestBatchAdd(){
        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid, "M", uid+"@atguigu.com", 1));
        }
    }
}
