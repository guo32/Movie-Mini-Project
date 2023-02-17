<%@ page import="model.UserDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.TheaterDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-14
  Time: 오후 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%
        request.setCharacterEncoding("utf-8");

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        CinemaController cinemaController = new CinemaController(connectionMaker);

        CinemaDTO cinemaDTO = cinemaController.selectById(id);
        pageContext.setAttribute("cinema", cinemaDTO);
    %>
    <title>극장 : ${cinema.name}</title>
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
        <main class="container">
            <div class="row g-5">
                <!-- 자세한 정보 -->
                <div class="col-md-8 mb-5">
                    <article class="blog-post">
                        <h2 class="blog-post-title">${cinema.name}</h2>
                        <hr>
                        <p class="blog-post-meta">
                            주소 | ${cinema.country} ${cinema.autonomous_district} ${cinema.detailed_address}
                        </p>
                        <p class="blog-post-meta">
                            전화 | ${cinema.phone}
                        </p>
                        <hr>
                        <h4 class="blog-post-title">상영정보</h4>
                        <p>가장 최신의 상영정보 5개 출력하기</p>
                        <hr>
                        <h4 class="blog-post-title">상영관</h4>
                        <%
                            TheaterController theaterController = new TheaterController(connectionMaker);
                            ArrayList<TheaterDTO> theaterList = theaterController.selectByCinemaId(id);

                            pageContext.setAttribute("theaterList", theaterList);
                        %>
                        <div class="col-12">
                            <c:choose>
                                <c:when test="${empty theaterList}">
                                    <p>해당 영화관이 보유 중인 상영관이 없습니다.</p>
                                </c:when>
                                <c:otherwise>
                                    <table class="table table-hover border-top">
                                        <tbody>
                                        <c:forEach var="theater" items="${theaterList}">
                                            <tr>
                                                <td class="col-3 text-center table-light">${theater.name}</td>
                                                <td>&nbsp;&nbsp;${theater.capacity}석</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </article>
                </div>
                <!-- 간단한 정보 -->
                <div class="col-md-4">
                    <div class="position-sticky">
                        <div class="p-4 mb-3 rounded shadow-sm" style="background-color: #f2f2f2">
                            <svg width="100%" height="420" class="rounded mb-2 shadow-sm"
                                 style="background-color: #FFFFFF">
                                <c:choose>
                                    <c:when test="${cinema.image == null}">
                                        <rect width="100%" height="100%" fill="#0d0d0d"></rect>
                                        <text x="40%" y="50%" fill="#f2f2f2">No image</text>
                                    </c:when>
                                    <c:otherwise>
                                        <image href="../resource/img/${cinema.image}" width="100%" height="100%"/>
                                    </c:otherwise>
                                </c:choose>
                            </svg>
                            <h6 style="color: #0d0d0d">"${cinema.name}" 사진</h6>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
