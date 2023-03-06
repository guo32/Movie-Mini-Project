<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="model.NoticeDTO" %>
<%@ page import="controller.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Movie Management</title>
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
<%
    request.setCharacterEncoding("utf-8");

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    CinemaController cinemaController = new CinemaController(connectionMaker);
    NoticeController noticeController = new NoticeController(connectionMaker);
    NoticeCategoryController noticeCategoryController = new NoticeCategoryController(connectionMaker);

    ArrayList<FilmDTO> filmList = filmController.selectAll(1);
    ArrayList<CinemaDTO> cinemaList = cinemaController.selectAll(1);
    ArrayList<NoticeDTO> noticeList = noticeController.selectAll(1);

    pageContext.setAttribute("cinemaList", cinemaList);
    pageContext.setAttribute("filmList", filmList);
    pageContext.setAttribute("noticeList", noticeList);
    pageContext.setAttribute("noticeCategoryController", noticeCategoryController);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="/header.jsp" %>
        <!-- main slider -->
        <c:choose>
            <c:when test="${empty filmList}">
                <div>
                    등록된 영화가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="swiper mySwiper mb-5">
                    <div class="swiper-wrapper">
                        <c:forEach var="film" items="${filmList}">
                            <div class="swiper-slide">
                                <img src="/resource/img/${film.poster}">
                                <a href="/film/printOne.jsp?id=${film.id}" class="stretched-link"></a>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="swiper-scrollbar"></div>
                </div>
                <!-- Swiper JS -->
                <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

                <!-- Initialize Swiper -->
                <script>
                    var swiper = new Swiper(".mySwiper", {
                        scrollbar: {
                            el: ".swiper-scrollbar",
                            hide: true,
                            loop: true,

                        },
                    });
                </script>
            </c:otherwise>
        </c:choose>

        <!-- top 5 -->
        <c:choose>
            <c:when test="${empty filmList}">
                <div>
                    등록된 영화가 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="mb-2">
                    <h5><b>현재 상영작</b></h5>
                </div>
                <div class="row row-cols-md-5 g-4">
                    <c:forEach var="film" items="${filmList}" begin="0" end="4">
                        <div class="col">
                            <div class="card shadow-sm">
                                <img src="../resource/img/${film.poster}" width="100%" height="230" class="movie-img">
                                <a href="/film/printOne.jsp?id=${film.id}" class="stretched-link"></a>
                            </div>
                            <div class="text-center my-1">
                                <%
                                    ReviewController reviewController = new ReviewController(connectionMaker);
                                    pageContext.setAttribute("reviewController", reviewController);
                                %>
                                <b>${film.title}</b>
                                <p class="fw-light text-secondary">★ <fmt:formatNumber
                                        value="${reviewController.calculateRatingAverageByFilmId(film.id)}"
                                        pattern="0.0#"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="row">
            <div class="col-6">
                <div class="col-12 p-3 rounded shadow-sm my-2 border border-secondary">
                    <h5 class="mb-3" onclick="location.href='/film/printList.jsp'">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-info-circle" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                            <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
                        </svg>
                        <span class="mx-2">
                            공지사항
                        </span>
                    </h5>
                    <table class="table">
                        <c:forEach var="notice" items="${noticeList}" begin="0" end="4">
                            <tr>
                                <td class="text-secondary">[${noticeCategoryController.selectNameById(notice.category_id)}]</td>
                                <td>${notice.title}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div class="col-6">
                <div class="col-12 p-3 shadow-sm my-2 border-top border-bottom border-secondary">
                    <a class="text-dark text-decoration-none" href="/screenInfo/printList.jsp">
                        <h5>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                 class="bi bi-calendar4-week" viewBox="0 0 16 16">
                                <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v1h14V3a1 1 0 0 0-1-1H2zm13 3H1v9a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V5z"/>
                                <path d="M11 7.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-2 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
                            </svg>
                            <span class="mx-2">상영 정보</span>
                        </h5>
                    </a>
                </div>
                <div class="col-12 p-3 shadow-sm my-2 border-top border-bottom border-secondary">
                    <a class="text-dark text-decoration-none" href="/cinema/printList.jsp">
                        <h5>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                 class="bi bi-film" viewBox="0 0 16 16">
                                <path d="M0 1a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H1a1 1 0 0 1-1-1V1zm4 0v6h8V1H4zm8 8H4v6h8V9zM1 1v2h2V1H1zm2 3H1v2h2V4zM1 7v2h2V7H1zm2 3H1v2h2v-2zm-2 3v2h2v-2H1zM15 1h-2v2h2V1zm-2 3v2h2V4h-2zm2 3h-2v2h2V7zm-2 3v2h2v-2h-2zm2 3h-2v2h2v-2z"/>
                            </svg>
                            <span class="mx-2">극장 정보</span>
                        </h5>
                    </a>
                </div>
                <div class="col-12 p-3 shadow-sm my-2 border-top border-bottom border-secondary">
                    <a class="text-dark text-decoration-none" href="/notice/printList.jsp">
                        <h5>
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                 class="bi bi-info-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
                            </svg>
                            <span class="mx-2">공지사항</span>
                        </h5>
                    </a>
                </div>
                <div class="col-12 p-3 shadow-sm my-2 border-top border-bottom border-secondary">
                    <h5>
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-nut" viewBox="0 0 16 16">
                            <path d="m11.42 2 3.428 6-3.428 6H4.58L1.152 8 4.58 2h6.84zM4.58 1a1 1 0 0 0-.868.504l-3.428 6a1 1 0 0 0 0 .992l3.428 6A1 1 0 0 0 4.58 15h6.84a1 1 0 0 0 .868-.504l3.429-6a1 1 0 0 0 0-.992l-3.429-6A1 1 0 0 0 11.42 1H4.58z"/>
                            <path d="M6.848 5.933a2.5 2.5 0 1 0 2.5 4.33 2.5 2.5 0 0 0-2.5-4.33zm-1.78 3.915a3.5 3.5 0 1 1 6.061-3.5 3.5 3.5 0 0 1-6.062 3.5z"/>
                        </svg>
                        <span class="mx-2">준비 중</span>
                    </h5>
                </div>
            </div>
        </div>
        <%@ include file="/footer.jsp" %>
    </div>
</div>
</body>
</html>