<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-15
  Time: 오전 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="model.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <c:if test="${login == null}">
        <%
            request.setCharacterEncoding("utf-8");
            response.sendRedirect("/user/login.jsp");
        %>
    </c:if>
    <title>회원 정보 수정</title>
    <link href="../resource/img/filmicongreen.svg" rel="shortcut icon" type="image/x-icon">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="../resource/css/main.css"/>
</head>
<body>
<script>
    function checkForm() {
        // let newPassword = document.getElementById("newPassword").value;
        let oldPassword = document.getElementById("oldPassword").value;
        let nickname = document.getElementById("nickname").value;

        if (oldPassword == '' || oldPassword == null) {
            alert("기존 비밀번호를 입력해주세요.");
            return;
        }
        if (nickname == '' || nickname == null) {
            alert("닉네임은 비워둘 수 없습니다.");
            return;
        }

        document.updateForm.submit();
    }
</script>
<div class="container-fluid">
    <div class="container">
        <%@ include file="../header.jsp"%>
        <div class="row my-5 align-items-center">
            <div class="row justify-content-center">
                <div class="col-6" style="background-color: #F2F2F2; border-radius: 1em;">
                    <form action="/user/update_logic.jsp" method="post" name="updateForm">
                        <div class="row justify-content-center m-3" style="font-size: xx-large">
                            회원 정보 수정
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="form-floating">
                                    <input type="text" id="username" name="username" class="form-control"
                                           value="${login.username}" disabled>
                                    <label for="username">아이디</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="form-floating">
                                    <input type="password" id="newPassword" name="newPassword" class="form-control"
                                           placeholder="새 비밀번호">
                                    <label for="newPassword">새 비밀번호</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="form-floating">
                                    <input type="password" id="oldPassword" name="oldPassword" class="form-control"
                                           placeholder="기존 비밀번호">
                                    <label for="oldPassword">기존 비밀번호</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="form-floating">
                                    <input type="text" id="nickname" name="nickname" class="form-control"
                                           value="${login.nickname}">
                                    <label for="nickname">닉네임</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-10 text-center">
                                <div class="btn btn-outline-primary col-5" onclick="checkForm()">수정</div>
                                <div class="col-5 btn btn-outline-danger" onclick="location.href='/user/mypage.jsp'">취소
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
