<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오후 5:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>영화 목록</title>
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
<%
    request.setCharacterEncoding("utf-8");

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);

    ArrayList<FilmDTO> filmList = filmController.selectAll();
    pageContext.setAttribute("filmList", filmList);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp"%>
        <c:choose>
            <c:when test="${empty filmList}">
                <div>
                    등록된 영화가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="film" items="${filmList}">
                    <div class="row mb-2">
                        <div class="col mb-6">
                            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-m d-250 position-relative">
                                <div class="col p-4 d-flex flex-column position-static">
                                    <h3 class="mb-1">${film.title}</h3>
                                    <p class="card-text mb-auto">${film.description}</p>
                                    <a href="/film/printOne.jsp?id=${film.id}" class="stretched-link">상세보기</a>
                                </div>
                                <div class="col-auto d-none d-lg-block">
                                    <svg class="bd-placeholder-img" width="200" height="250" role="img" preserveAspectRatio="xMidYMid slice" focusable="false">
                                        <c:choose>
                                            <c:when test="${film.poster == null}">
                                                <rect width="100%" height="100%" fill="#0d0d0d"></rect>
                                                <text x="30%" y="50%" fill="#f2f2f2">No image</text>
                                            </c:when>
                                            <c:otherwise>
                                                <image href="../resource/img/${film.poster}" width="100%"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <%@ include file="../footer.jsp"%>
    </div>
</div>
</body>
</html>
