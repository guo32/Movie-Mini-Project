<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오후 5:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화 목록</title>
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
<%
    UserDTO login = (UserDTO) session.getAttribute("login");
    if (login == null) {

    }
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp"%>
        <div class="row mb-2">
            <div class="col mb-6">
                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-m d-250 position-relative">
                    <div class="col p-4 d-flex flex-column position-static">
                        <h3 class="mb-0">Test</h3>
                        <p class="card-text mb-auto">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                        <a href="#" class="stretched-link">상세보기</a>
                    </div>
                    <div class="col-auto d-none d-lg-block">
                        <svg class="bd-placeholder-img" width="200" height="250" role="img" preserveAspectRatio="xMidYMid slice" focusable="false">
                            <rect width="100%" height="100%" fill="#ccc"></rect>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>
