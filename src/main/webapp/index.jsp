<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Json版的员工列表</title>
    <!---导入JQuery,BootStrap的CSS和JS-->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--员工修改的模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">
                <!---修改员工信息的表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@163.com">
                            <span id="helpBlock33" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!--员工添加的模态框-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <!---添加员工信息的表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="Yoey">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@163.com">
                            <span id="helpBlock3" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">               <!--标题-->
        <div class="col-md-12">
            <h3>员工管理系统</h3>
        </div>
    </div>
    <div class="row">        <!--按钮-->
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary btn-sm" id="emp_add_modal_btn">添加</button>
            <button class="btn btn-danger btn-sm" >删除</button>
        </div>
    </div>
    <p></p>
    <div class="row">       <!--显示表格数据-->
        <div col-md-12>
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>DepartmentName</th>
                        <th>Option</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">       <!--分页的信息-->
        <div class="col-md-6" id="page_info_area"></div>            <!--分页的文字信息(共多少页)-->
        <div class="col-md-6" id="page_nav_area"></div>              <!--分页导航信息-->
    </div>
</div>

<script type="text/javascript">
/* 1. 页面加载完成后,直接发送Ajax请求,得到分页数据
*       |--url :请求地址,data :请求的参数 type :请求的方式  success:请求成功的回调函数
* */
var totalRecord;        //总的记录数
var currentPage;        //当前页数
var lastPage;
$(function(){
    to_page(1);
});
function to_page(pn){

    $.ajax({
        url:"${pageContext.request.contextPath}/emps",
        data:"pn="+pn,
        type:"GET",
        success:function(result){
            //1、解析并显示员工数据
            build_emps_tables(result);
            //2、解析并显示分页信息
            build_page_info(result);
            //3、解析显示分页条数据
            build_page_nav(result);
        }
    });
}

/* 解析并显示分页信息 */
function build_page_info(result){
    $("#page_info_area").empty();       //清空分页的详细信息
    $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页").append(" ")
                        .append("共"+result.extend.pageInfo.pages+"页").append(" ")
                        .append("共"+result.extend.pageInfo.total+"记录");
    totalRecord = result.extend.pageInfo.total;
    currentPage = result.extend.pageInfo.pageNum;
}

/* 解析并显示分页导航条信息 */
function build_page_nav(result){
    $("#page_nav_area").empty();                         //清空分页导航条的信息
    var ul = $("<ul></ul>").addClass("pagination");
    var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));    //首页
    var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));      //上一页
    if(result.extend.pageInfo.hasPreviousPage == false){        //如果没有上一页的数据,就不显示
        firstPageLi.addClass("disabled");
        prePageLi.addClass("disabled");
    }else{                                                      //如果有上一页的信息,点击需要可以跳转页面
        firstPageLi.click(function(){
            to_page(1);
        });
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum - 1);
        });
    }
    var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));                  //下一页
    var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));     //末页
    if(result.extend.pageInfo.hasNextPage == false){           //没有下一页就不显示
        nextPageLi.addClass("disabled");
        lastPageLi.addClass("disabled");
    }else{
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        });
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });
    }
    ul.append(firstPageLi).append(prePageLi);
    $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
        var numLi = $("<li></li>").append($("<a></a>").append(item));
        if(result.extend.pageInfo.pageNum == item){
            numLi.addClass("active");
        }
        numLi.click(function(){
            to_page(item);
        });
        ul.append(numLi);
    });
    ul.append(nextPageLi).append(lastPageLi);
    var navEle = $("<nav></nav>").append(ul);
    navEle.appendTo("#page_nav_area");
}
/* 解析并显示员工数据 */
function build_emps_tables(result){
    $("#emps_table tbody").empty();             //清空table表格
    var emps=result.extend.pageInfo.list;      //获取json数据中的所有员工信息
    $.each(emps,function (index,item) {       //使用JQuery中的$.each()函数遍历所有的员工信息
        //创建员工信息节点
        var empIdTd=$("<td></td>").append(item.empId);
        var empNameTd = $("<td></td>").append(item.empName);
        var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
        var emailTd = $("<td></td>").append(item.email);
        var deptNameTd = $("<td></td>").append(item.department.deptName);
        //创建修改和删除的按钮节点,并且分别为其添加编辑和删除的id值
        var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                          .append($("<span></span>").addClass("glyphicon glyphicon-pencil ")).append("编辑");
        var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                                            .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
        editBtn.attr("edit-id",item.empId);
        delBtn.attr("del-id",item.empId);
        var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
        $("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd)
                      .append(btnTd)
                      .appendTo("#emps_table tbody");
    });
}
/* 点击新增按钮弹出模态框 */
$("#emp_add_modal_btn").click(function(){
    //1. 发送查出部门信息Ajax请求,显示在下拉列表中
        getDepts("#empAddModal select");
    //2.清除表单数据
    reset_form("#empAddModal form");
    //2.弹出模态框
    $("#empAddModal").modal();
});
/*清空表单样式及内容*/
function reset_form(ele){
    $(ele)[0].reset();
    //清空表单样式
    $(ele).find("*").removeClass("has-error has-success");
    $(ele).find(".help-block").text("");
}
/* 查询所有的部门信息,并且显示在下拉列表中 */
function getDepts(selectDom) {
    $(selectDom).empty();       //清空下拉框中的数据
    $.ajax({            //发送获取所有部门信息的Ajax请求
        url:"${pageContext.request.contextPath}/depts",
        type:"GET",
        success:function (result) {
            //显示部门信息
            $.each(result.extend.depts,function (index,item) {
               var option=$("<option></option>").append(item.deptName).attr("value",item.deptId)
                                                .appendTo(selectDom);
            });
        }
    });
}
/* 显示校验的信息(传入需要校验的节点,状态以及提示信息)*/
function show_validate_msg(ele,status,msg){
    $(ele).parent().removeClass("has-success has-error");           //每次校验前,清除样式
    $(ele).next("span").text("");                                   //显示提示信息使用的span
    if(status=="success"){
        $(ele).parent().addClass("has-success");
        $(ele).next("span").text(msg);
    }else if(status=="error"){
        $(ele).parent().addClass("has-error");
        $(ele).next("span").text(msg);
    }
}
/* 校验要提交给服务器的数据 */
function validate_add_form() {
    // 1.校验用户名
    var empName=$("#empName_add_input").val();
    var regName =/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;    //用户名可以是2-5位中文或者3-16位英文和数字的组合
    if( !regName.test(empName)){
        show_validate_msg("#empName_add_input", "error", "用户名必须是3-5位中文或者6-16位英文和数字的组合");
        return false;
    }else{
        show_validate_msg("#empName_add_input", "success", "");
    }
    // 2.校验邮箱地址
    var email = $("#email_add_input").val();
    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(! regEmail.test(email)){
        show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
        return false;
    }else{
        show_validate_msg("#email_add_input", "success", "");
    }
    return true;
}
/*  校验用户名是否存在 */
$("#empName_add_input").change(function () {
    var empName=$(this).val();     //获取用户名
    $.ajax({
        url:"${pageContext.request.contextPath}/checkUser",
        data:"empName="+empName,
        type:"GET",
        success:function (result) {
            if(result.code==100){
                show_validate_msg("#empName_add_input","success","用户名可用");
                $("#emp_save_btn").attr("ajax-va","success");       //如果用户名可以使用,那么就在更新按钮上添加ajax-va的属性值为success
            }else{
                show_validate_msg("#empName_add_input","error",result.extend.ajaxValidate);
                $("#emp_save_btn").attr("ajax-va","error");         //如果用户名已经存在,那么就在更新按钮上添加ajax-va的属性值为error
            }
        }
    });
});
/* 向数据库中添加数据 */
$("#emp_save_btn").click(function () {
    // 1.将模态框中填写的数据发送给服务器进行保存
    // 2.先对要提交给服务器的数据进行校验
    if( !validate_add_form()){
        return false;
    }
    // 3、校验用户名是不是已经重复
    if($(this).attr("ajax-va")=="error"){
        return false;
    }
    // 4.发送Ajax请求,保存员工信息
    $.ajax({
        url:"${pageContext.request.contextPath}/emp",
        data:$("#empAddModal form").serialize(),
        type:"POST",
        success:function (result) {
            if(result.code==100){
                alert(result.msg);
                $("#empAddModal").modal('hide');        //关闭模态框
                to_page(totalRecord);                   //显示最后一页的数据
            }
            if(result==200){
                if(undefined != result.extend.errorFields.email){
                    //显示邮箱错误信息
                    show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                }
                if(undefined != result.extend.errorFields.empName){
                    //显示员工名字的错误信息
                    show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                }
            }
        }
    });
});

/* 弹出修改员工信息的模态框 */
$(document).on("click",".edit_btn",function(){
        // 1.发送Ajax请求,显示部门列表
         getDepts("#empUpdateModal select");

        // 2.显示员工信息
        getEmp($(this).attr("edit-id"));

        // 3.把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

        // 4.弹出模态框
        $("#empUpdateModal").modal();
});
/*根据id查询员工的信息*/
function getEmp(id){
    $.ajax({
        url:"${pageContext.request.contextPath}/emp/"+id,
        type:"GET",
        success:function(result){
            var empData = result.extend.emp;        //获取查询得到的员工信息,并且给输入框赋值
            $("#empName_update_static").text(empData.empName);
            $("#email_update_input").val(empData.email);
            $("#empUpdateModal input[name=gender]").val([empData.gender]);
            $("#empUpdateModal select").val([empData.dId]);
        }
    });
}

/* 更新员工的信息 */
$("#emp_update_btn").click(function () {
    //1、校验邮箱信息
    var email = $("#email_update_input").val();
    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(!regEmail.test(email)){
        show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
        return false;
    }else{
        show_validate_msg("#email_update_input", "success", "");
    }
    // 2. 使用Ajax发送PUT请求,修改员工信息
    $.ajax({
        url:"${pageContext.request.contextPath}/emp/"+$(this).attr("edit-id"),
        type:"PUT",
        //data:$("#empUpdateModal form").serialize()+"&_method=PUT",             可以在参数后面加上&_method=PUT,发送PUT请求
        data:$("#empUpdateModal form").serialize(),                              //获取修改模态框中的表单数据
        success:function (result) {
            alert(result.msg);
            $("#empUpdateModal").modal("hide");                 //关闭修改信息的模态框
            to_page(currentPage);                               //返回当前的页面(就是为了刷新当前的页面信息)
        }
    });
});

/*删除单个员工的信息,按照id删除*/
$(document).on("click",".delete_btn",function () {
    var empName=$(this).parents("tr").find("td:eq(1)").text();          //获取要删除的员工姓名
    var empId=$(this).attr("del-id");                                   //获取要删除的员工的id
    var flag=confirm("确定要删除"+empName+"吗?");
    if(flag){
        $.ajax({
            url:"${pageContext.request.contextPath}/emp/"+empId,
            type:"DELETE",
            success:function(result){
                alert(result.msg);
                to_page(currentPage);
            }
        });
    }
});
</script>
</body>
</html>


























