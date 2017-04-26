<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
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
                <table class="table table-hover">
                    <tr>
                        <th>ID</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>DepartmentName</th>
                        <th>Option</th>
                    </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender=="M"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName }</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true">编辑</span>
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span>
                            </button>
                        </th>
                    </tr>
                </c:forEach>
                </table>
            </div>
        </div>
        <div class="row">       <!--分页的信息-->
            <div class="col-md-6">               <!--分页的文字信息(共多少页)-->
                当前第 ${pageInfo.pageNum }页
                共 ${pageInfo.pages }页
                共 ${pageInfo.total } 条记录
            </div>
            <div class="col-md-6">               <!--分页导航信息-->
                <nav>
                    <ul class="pagination">
                        <li><a href="${pageContext.request.contextPath}/emps?pn=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <li>
                                <a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum -1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum }">
                                <li class="active"><a href="#">${page_Num }</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum }">
                                <li><a href="${pageContext.request.contextPath}/emps?pn=${page_Num }">${page_Num }</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum +1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
