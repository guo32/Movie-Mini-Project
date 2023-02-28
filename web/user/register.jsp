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
    <link href="/resource/img/filmicongreen.svg" rel="shortcut icon" type="image/x-icon">
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
    <script src="../assets/js/user/register.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="container">
        <nav class="py-2 border-bottom rounded-bottom" style="background-color: #031059">
            <div class="container d-flex flex-wrap">
                <ul class="nav me-auto"></ul>
                <ul class="nav">
                    <li class="nav-item mx-2">
                        <a href="/user/login.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">로그인</a>
                    </li>
                    <li style="color: #d9d9d9">|</li>
                    <li class="nav-item mx-2">
                        <a href="/user/register.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">회원가입</a>
                    </li>
                </ul>
            </div>
        </nav>
        <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
            <a class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none"
               href="/film/printList.jsp">
                Movie<br/>Management
            </a>
            <ul class="nav nav-pills">
                <li class="nav-item mx-1">
                    <a href="/film/printList.jsp" class="nav-link link-dark">영화</a>
                </li>
                <li class="nav-item mx-1">
                    <a href="/cinema/printList.jsp" class="nav-link link-dark">극장</a>
                </li>
                <li class="nav-item mx-1">
                    <a href="/screenInfo/printList.jsp" class="nav-link link-dark">상영 정보</a>
                </li>
            </ul>
        </header>
        <div class="row my-5 align-items-center">
            <div class="row justify-content-center">
                <div class="col-6" style="background-color: #F2F2F2; border-radius: 1em;">
                    <form action="/user/register_logic.jsp" method="post" name="registerForm" id="register-form">
                        <div class="row justify-content-center m-3" style="font-size: xx-large">
                            회원가입
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="form-floating" id="div-for-username">
                                    <input type="text" id="username" name="username" class="form-control"
                                           placeholder="아이디">
                                    <label for="username">아이디</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="form-floating" id="div-for-password">
                                    <input type="password" id="password" name="password" class="form-control"
                                           placeholder="비밀번호">
                                    <label for="password">비밀번호</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="form-floating" id="div-for-nickname">
                                    <input type="text" id="nickname" name="nickname" class="form-control"
                                           placeholder="닉네임">
                                    <label for="nickname">닉네임</label>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-10 text-center">
                                <div class="btn btn-outline-primary col-5" onclick="submitForm()">회원가입</div>
                                <div class="col-5 btn btn-outline-danger" onclick="location.href='../index.jsp'">취소
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
