package magicalzhu.github.io.service;

import magicalzhu.github.io.bean.Department;
import magicalzhu.github.io.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2017/4/27 0027.
 * @author Administrator
 */
@Service
public class DepartmentService {
    //显示所有的部门信息
    @Autowired
    private DepartmentMapper departmentMapper;
    @Transactional(readOnly = true)
    public List<Department> getDepts(){
        List<Department> depts=departmentMapper.selectByExample(null);
        return depts;
    }
}
