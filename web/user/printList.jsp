<%@ page import="controller.UserController" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-21
  Time: 오후 2:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원 관리</title>
    <link href="../resource/img/sunfishicon.svg" rel="shortcut icon" type="image/x-icon">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resource/css/main.css"/>
</head>
<body>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <c:choose>
            <c:when test="${login == null}">
                <%
                    response.sendRedirect("/user/login.jsp");
                %>
            </c:when>
            <c:when test="${login.grade != 3}">
                <%
                    response.sendRedirect("../index.jsp");
                %>
            </c:when>
            <c:otherwise>
                <%
                    request.setCharacterEncoding("utf-8");
                    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
                    UserController userController = new UserController(connectionMaker);

                    ArrayList<UserDTO> userList = userController.selectAll();
                    pageContext.setAttribute("userList", userList);
                %>
                <main class="container">
                    <div class="row g-5">
                        <div class="col-md-8 mb-5">
                            <article class="blog-post">
                                <h2 class="blog-post-title">회원 관리</h2>
                                <hr>
                                <table class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>아이디</th>
                                        <th>닉네임</th>
                                        <th>등급</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="user" items="${userList}">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.username}</td>
                                            <td>${user.nickname}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.grade == 1}">일반 회원</c:when>
                                                    <c:when test="${user.grade == 2}">전문 평론가</c:when>
                                                    <c:otherwise>관리자</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </article>
                        </div>
                        <div class="col-md-4">
                            <ul>
                                <li>
                                    <div class="btn btn-outline-success btn-sm mb-2" data-bs-toggle="modal"
                                         data-bs-target="#requestGradeList">등업 신청 현황
                                    </div>
                                    <%@ include file="/user/request_gradeList_manager.jsp" %>
                                </li>
                            </ul>
                        </div>
                    </div>
                </main>
            </c:otherwise>
        </c:choose>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
