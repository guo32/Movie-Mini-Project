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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
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
                        <article class="blog-post">
                            <div class="hstack gap-3 pb-2 mb-2">
                                <span class="blog-post-title fs-4">회원 관리</span>
                                <span class="d-flex ms-auto">
                                    <div class="btn btn-outline-success btn-sm mb-2" data-bs-toggle="modal"
                                         data-bs-target="#requestGradeList">등업 신청 현황
                                    </div>
                                    <%@ include file="/user/request_gradeList_manager.jsp" %>
                                </span>
                            </div>
                            <hr>
                            <table class="table">
                                <thead class="table-secondary">
                                <tr>
                                    <th>번호</th>
                                    <th>아이디</th>
                                    <th>닉네임</th>
                                    <th>등급</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${userList}">
                                    <c:if test="${user.username != 'admin'}">
                                        <script>
                                            function checkDelete(id) {
                                                console.log(id);
                                                Swal.fire({
                                                    icon: 'warning',
                                                    title: '회원 강제 탈퇴',
                                                    text: '정말로 탈퇴시키겠습니까?',
                                                    showCancelButton: true,
                                                }).then((result) => {
                                                    if (result.isConfirmed) {
                                                        location.href = "/user/delete_user.jsp?id=" + id;
                                                    }
                                                });
                                            }
                                        </script>
                                        <tr>
                                            <td class="fw-light text-secondary">${user.id}</td>
                                            <td>${user.username}</td>
                                            <td>${user.nickname}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.grade == 1}">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                             fill="currentColor" class="bi bi-1-square-fill bg-info"
                                                             viewBox="0 0 16 16">
                                                            <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Zm7.283 4.002V12H7.971V5.338h-.065L6.072 6.656V5.385l1.899-1.383h1.312Z"/>
                                                        </svg>
                                                        일반 회원
                                                    </c:when>
                                                    <c:when test="${user.grade == 2}">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                             fill="currentColor" class="bi bi-2-square-fill bg-warning"
                                                             viewBox="0 0 16 16">
                                                            <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Zm4.646 6.24v.07H5.375v-.064c0-1.213.879-2.402 2.637-2.402 1.582 0 2.613.949 2.613 2.215 0 1.002-.6 1.667-1.287 2.43l-.096.107-1.974 2.22v.077h3.498V12H5.422v-.832l2.97-3.293c.434-.475.903-1.008.903-1.705 0-.744-.557-1.236-1.313-1.236-.843 0-1.336.615-1.336 1.306Z"/>
                                                        </svg>
                                                        전문 평론가
                                                    </c:when>
                                                    <c:otherwise>
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                             fill="currentColor" class="bi bi-3-square-fill bg-danger"
                                                             viewBox="0 0 16 16">
                                                            <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Zm5.918 8.414h-.879V7.342h.838c.78 0 1.348-.522 1.342-1.237 0-.709-.563-1.195-1.348-1.195-.79 0-1.312.498-1.348 1.055H5.275c.036-1.137.95-2.115 2.625-2.121 1.594-.012 2.608.885 2.637 2.062.023 1.137-.885 1.776-1.482 1.875v.07c.703.07 1.71.64 1.734 1.917.024 1.459-1.277 2.396-2.93 2.396-1.705 0-2.707-.967-2.754-2.144H6.33c.059.597.68 1.06 1.541 1.066.973.006 1.6-.563 1.588-1.354-.006-.779-.621-1.318-1.541-1.318Z"/>
                                                        </svg>
                                                        관리자
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${login.id != user.id}">
                                                    <span class="badge bg-warning text-dark" data-bs-toggle="modal"
                                                          data-bs-target="#updateUserForManager${user.id}">관리</span>
                                                    <%@ include file="/user/update_user_manager.jsp" %>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </article>
                    </div>
                </main>
            </c:otherwise>
        </c:choose>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>