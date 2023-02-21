<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-14
  Time: 오후 5:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>마이페이지</title>
    <link href="../resource/img/filmicongreen.svg" rel="shortcut icon" type="image/x-icon">
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
            <c:otherwise>
                <script>
                    function checkDelete() {
                        let result = confirm("정말로 탈퇴하시겠습니까?");

                        if (result) {
                            location.href = "/user/delete.jsp?id" + ${login.id};
                        }
                    }
                </script>
                <main class="container">
                    <div class="row g-5">
                        <div class="col-md-8 mb-5">
                            <article class="blog-post">
                                <h2 class="blog-post-title">회원 정보</h2>
                                <hr>
                                <table class="table table-striped">
                                    <tr>
                                        <th class="col-4">아이디</th>
                                        <td>${login.username}</td>
                                    </tr>
                                    <tr>
                                        <th class="col-4">닉네임</th>
                                        <td>${login.nickname}</td>
                                    </tr>
                                    <tr>
                                        <th class="col-4">회원 등급</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${login.grade == 1}">
                                                    일반 회원
                                                </c:when>
                                                <c:when test="${login.grade == 2}">
                                                    전문 평론가
                                                </c:when>
                                                <c:when test="${login.grade == 3}">
                                                    관리자
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </table>
                            </article>
                        </div>
                        <div class="col-md-4">
                            <ul>
                                <c:if test="${login.grade != 3}">
                                    <li>
                                        <div class="btn btn-outline-success btn-sm mb-2" onclick="location.href='request_grade.jsp'">등업 신청</div>
                                    </li>
                                    <li>
                                        <div class="btn btn-outline-success btn-sm mb-2" data-bs-toggle="modal" data-bs-target="#requestGradeList">등업 신청 현황</div>
                                        <%@ include file="/user/request_gradeList.jsp" %>
                                    </li>
                                </c:if>
                                <li>
                                    <div class="btn btn-outline-success btn-sm mb-2" onclick="location.href='/user/update.jsp'">회원 정보 수정</div>
                                </li>
                                <li>
                                    <div class="btn btn-outline-danger btn-sm mb-2" onclick="checkDelete()">회원 탈퇴</div>
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
