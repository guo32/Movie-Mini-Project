<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-22
  Time: 오후 2:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<html>
<head>
    <title>에러 페이지</title>
    <link href="/resource/img/sunfishicon.svg" rel="shortcut icon" type="image/x-icon">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resource/css/main.css"/>
    <!-- Swiper -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
</head>
<body>
<div class="container-fluid">
    <div class="container">
        <%@include file="/header.jsp" %>
        <div class="row my-5 align-items-center">
            <div class="row justify-content-center">
                <div class="col-6 text-center mt-4">
                    <h4 class="mb-4">문제가 발생했습니다.</h4>
                    <button type="button" class="btn btn-outline-success" onclick="history.go(-1)">이전 페이지로</button>
                </div>
            </div>
        </div>
        <div class="fixed-bottom">
            <%@include file="/footer.jsp" %>
        </div>
    </div>
</div>
</body>
</html>