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
    <title>등업 신청</title>
    <link href="/resource/img/filmicongreen.svg" rel="shortcut icon" type="image/x-icon">
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
        <%@ include file="../header.jsp" %>
        <%
            if (login == null) {
                response.sendRedirect("../index.jsp");
            }
        %>
        <div class="row my-5 align-items-center">
            <div class="row justify-content-center">
                <div class="col-6" style="background-color: #F2F2F2; border-radius: 1em;">
                    <form action="/user/request_grade_logic.jsp" method="post" name="registerForm">
                        <div class="row justify-content-center m-3" style="font-size: xx-large">
                            등업 신청
                        </div>
                        <div class="row justify-content-center mb-2">
                            <div class="col-10">
                                <div class="row justify-content-center m-2 bg-light p-4 rounded">
                                    <div class="form-check col-5">
                                        <input type="radio" name="request_grade" id="request_grade1" value="2" class="form-check-input">
                                        <label class="form-check-label" for="request_grade1">
                                            전문 평론가
                                        </label>
                                    </div>
                                    <div class="form-check col-5">
                                        <input type="radio" name="request_grade" id="request_grade2" value="3" class="form-check-input">
                                        <label class="form-check-label" for="request_grade2">
                                            관리자
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-10 text-center">
                                <button class="btn btn-outline-primary col-5">신청</button>
                                <div class="col-5 btn btn-outline-danger" onclick="location.href='/user/mypage.jsp?id=${login.id}'">취소
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
