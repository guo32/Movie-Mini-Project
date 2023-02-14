<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오후 3:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resource/css/main.css"/>
</head>
<body style="background-color: black">
<script>
    function checkForm() {
        let username = document.getElementById("username").value;
        let password = document.getElementById("password").value;
        let nickname = document.getElementById("nickname").value;

        if (username == '' || username == null) {
            alert("아이디는 비워둘 수 없습니다.");
            return;
        }
        if (password == '' || password == null) {
            alert("비밀번호는 비워둘 수 없습니다.");
            return;
        }
        if (nickname == '' || nickname == null) {
            alert("닉네임은 비워둘 수 없습니다.");
            return;
        }

        document.registerForm.submit();
    }
</script>
<div class="container-fluid">
    <div class="row vh-100 align-items-center">
        <div class="row justify-content-center">
            <div class="col-6" style="background-color: #F2F2F2; border-radius: 1em;">
                <form action="/user/register_logic.jsp" method="post" name="registerForm">
                    <div class="row justify-content-center m-3" style="font-size: xx-large">
                        회원가입
                    </div>
                    <div class="row justify-content-center mb-2">
                        <div class="col-10">
                            <div class="form-floating">
                                <input type="text" id="username" name="username" class="form-control" placeholder="아이디">
                                <label for="username">아이디</label>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center mb-2">
                        <div class="col-10">
                            <div class="form-floating">
                                <input type="password" id="password" name="password" class="form-control"
                                       placeholder="비밀번호">
                                <label for="password">비밀번호</label>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center mb-2">
                        <div class="col-10">
                            <div class="form-floating">
                                <input type="text" id="nickname" name="nickname" class="form-control"
                                       placeholder="닉네임">
                                <label for="nickname">닉네임</label>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-10 text-center">
                            <div class="btn btn-outline-primary col-5" onclick="checkForm()">회원가입</div>
                            <div class="col-5 btn btn-outline-danger" onclick="location.href='../index.jsp'">취소</div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
