<%@ page import="model.UserDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.FilmDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-14
  Time: 오후 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        request.setCharacterEncoding("utf-8");

        /* 로그인 정보가 존재하지 않을 시 index 페이지 이동 */
        UserDTO login = (UserDTO) session.getAttribute("login");
        if (login == null) {
            response.sendRedirect("/index.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        FilmController filmController = new FilmController(connectionMaker);

        FilmDTO filmDTO = filmController.selectById(id);
        pageContext.setAttribute("film", filmDTO);
        pageContext.setAttribute("login", login);
    %>
    <title>영화 : ${film.title}</title>
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
                        <h2 class="blog-post-title">${film.title}</h2>
                        <hr>
                        <p class="blog-post-meta">
                            감독 | ${film.director}
                        </p>
                        <p class="blog-post-meta">
                            등급 | ${film.rating}
                        </p>
                        <hr>
                        <h4 class="blog-post-title">줄거리</h4>
                        <p>${film.description}</p>
                        <!-- 평점 -->
                        <hr class="mt-5">
                        <h4 class="blog-post-title">리뷰</h4>
                        <div class="col-6">
                            <form method="post">
                                <select class="form-select" id="rating" name="rating">
                                    <option value="1">★☆☆☆☆</option>
                                    <option value="2">★★☆☆☆</option>
                                    <option value="3">★★★☆☆</option>
                                    <option value="4">★★★★☆</option>
                                    <option value="5">★★★★★</option>
                                </select>
                                <c:if test="${login.grade == 2}">
                                    <textarea id="review" name="review" placeholder="평론을 작성해주세요."></textarea>
                                </c:if>
                            </form>
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
                                    <c:when test="${film.poster == null}">
                                        <rect width="100%" height="100%" fill="#0d0d0d"></rect>
                                        <text x="40%" y="50%" fill="#f2f2f2">No image</text>
                                    </c:when>
                                    <c:otherwise>
                                        <image href="../resource/img/${film.poster}" width="100%" height="100%"/>
                                    </c:otherwise>
                                </c:choose>
                            </svg>
                            <h6 style="color: #0d0d0d">"${film.title}" 포스터</h6>
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
