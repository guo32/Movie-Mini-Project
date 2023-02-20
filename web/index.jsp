<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="controller.CinemaController" %><%--
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
    <link href="/resource/img/filmicongreen.svg" rel="shortcut icon" type="image/x-icon">
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
<%
    request.setCharacterEncoding("utf-8");

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    CinemaController cinemaController = new CinemaController(connectionMaker);

    ArrayList<FilmDTO> filmList = filmController.selectAll(1);
    ArrayList<CinemaDTO> cinemaList = cinemaController.selectAll(1);

    pageContext.setAttribute("cinemaList", cinemaList);
    pageContext.setAttribute("filmList", filmList);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="/header.jsp" %>
        <c:choose>
            <c:when test="${empty filmList}">
                <div>
                    등록된 영화가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <c:forEach var="film" items="${filmList}">
                            <div class="swiper-slide">
                                <img src="/resource/img/${film.poster}">
                                <a href="/film/printOne.jsp?id=${film.id}" class="stretched-link"></a>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
                <script>
                    var swiper = new Swiper(".mySwiper", {
                        slidesPerView: 4,
                        spaceBetween: 30,
                        loop: true,
                        // centeredSlides: true,
                        pagination: {
                            el: ".swiper-pagination",
                            clickable: true,
                        },
                    });
                </script>
                <div class="row">
                    <div class="col-6">
                        <div class="col-12 p-3 rounded shadow-sm my-2" style="background-color: rgba(191, 187, 184, 0.5) !important;">
                            <h4 class="mb-3" onclick="location.href='/film/printList.jsp'">영화</h4>
                            <c:forEach var="film" items="${filmList}" begin="0" end="3">
                                <div class="row">
                                    <div class="col mb-6">
                                        <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-m d-250 position-relative">
                                            <div class="col p-4 d-flex flex-column position-static content-mini-box">
                                                <h4 class="mb-1">${film.title}</h4>
                                                <a href="/film/printOne.jsp?id=${film.id}" class="stretched-link">상세보기</a>
                                            </div>
                                            <div class="col-auto d-none d-lg-block">
                                                <svg class="bd-placeholder-img" width="100" height="120" role="img"
                                                     preserveAspectRatio="xMidYMid slice" focusable="false">
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
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="col-12 p-3 rounded shadow-sm my-2" style="background-color: rgba(191, 187, 184, 0.5) !important;">
                            <h4 class="mb-3" onclick="location.href='/cinema/printList.jsp'">극장</h4>
                            <c:choose>
                                <c:when test="${empty cinemaList}">
                                    <div>
                                        등록된 극장이 없습니다.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cinema" items="${cinemaList}" begin="0" end="4">
                                        <div class="row">
                                            <div class="col mb-6">
                                                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-m d-250 position-relative">
                                                    <div class="col p-4 d-flex flex-column position-static content-mini-box">
                                                        <p class="card-text mb-auto text-muted text-truncate"><b class="fs-5 mx-2 mt-1 text-dark">
                                                                ${cinema.name}</b> ${cinema.country} ${cinema.autonomous_district} ${cinema.detailed_address} | ${cinema.phone}
                                                        </p>
                                                        <a href="/cinema/printOne.jsp?id=${cinema.id}" class="stretched-link"></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        <%@ include file="/footer.jsp" %>
    </div>
</div>
</body>
</html>