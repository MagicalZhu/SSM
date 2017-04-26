<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Json版的员工列表</title>
    <!--引入BootStrap的Css-->
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--引入BootStrap的JS-->
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <!--引入Jquery-->
    <script src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.min.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <div class="row">               <!--标题-->
        <div class="col-md-12">
            <h3>员工管理系统</h3>
        </div>
    </div>
    <div class="row">        <!--按钮-->
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary btn-sm">添加</button>
            <button class="btn btn-danger btn-sm">删除</button>
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
                                          .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
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

</script>
</body>
</html>
