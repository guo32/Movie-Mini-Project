<%@ page import="controller.FilmController" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.ScreenInformationController" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
        if (cinemaDTO == null) {
            response.sendRedirect("../assets/error_page.jsp");
        }
        pageContext.setAttribute("cinema", cinemaDTO);
    %>
    <title>극장 : ${cinema.name}</title>
    <link href="../resource/img/sunfishicon.svg" rel="shortcut icon" type="image/x-icon">
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
</head>
<body>
<script>
    function checkDelete() {
        Swal.fire({
            icon: "warning",
            text: "극장 <${cinema.name}>을(를) 정말로 삭제하시겠습니까?",
            showCancelButton: true,
        }).then((result) => {
            if (result.isConfirmed) {
                location.href = "/cinema/delete.jsp?id=" + ${cinema.id};
            }
        });
    }
</script>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <main class="container">
            <div class="row g-5">
                <!-- 자세한 정보 -->
                <div class="col-md-8 mb-5">
                    <div class="mb-2">
                        <button class="badge bg-dark fw-light border-0"
                                onclick="location.href='/cinema/printList.jsp'">목록
                        </button>
                        <c:if test="${login != null && login.grade == 3}">
                            <button class="badge bg-success fw-light border-0"
                                    onclick="location.href='/cinema/update.jsp?id=${cinema.id}'">수정
                            </button>
                            <button class="badge bg-danger fw-light border-0" onclick="checkDelete()">삭제</button>
                        </c:if>
                    </div>
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
                        <%
                            TheaterController theaterController = new TheaterController(connectionMaker);
                            ArrayList<TheaterDTO> theaterList = theaterController.selectByCinemaId(id);

                            ScreenInformationController screenInformationController = new ScreenInformationController(connectionMaker);
                            ArrayList<ScreenInformationDTO> screenInformationList = screenInformationController.selectByCinemaId(id);

                            FilmController filmController = new FilmController(connectionMaker);

                            Date date = new Date();
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
                            ArrayList<ScreenInformationDTO> screenInformationListForToday = screenInformationController.selectByCinemaAndDate(id, sdf.format(date));

                            // pageContext.setAttribute("screenInfoList", screenInformationList);
                            pageContext.setAttribute("screenInfoList", screenInformationListForToday);
                            pageContext.setAttribute("theaterList", theaterList);
                            pageContext.setAttribute("theaterController", theaterController);
                            pageContext.setAttribute("filmController", filmController);
                            pageContext.setAttribute("now", date);
                        %>
                        <!-- today -->
                        <p class="text-secondary"><fmt:formatDate value="${now}" pattern="YYYY-MM-dd"/></p>

                        <div class="col-12">
                            <c:choose>
                                <c:when test="${empty screenInfoList}">
                                    <p>상영 정보가 존재하지 않습니다.</p>
                                </c:when>
                                <c:otherwise>
                                    <table class="table table-hover border-top">
                                        <tbody>
                                        <c:forEach var="screenInfo" items="${screenInfoList}">
                                            <tr>
                                                <td class="col-3 text-center table-secondary">
                                                    <a class="link-dark text-decoration-none" href="../film/printOne.jsp?id=${screenInfo.film_id}">${filmController.selectById(screenInfo.film_id).title}</a>
                                                </td>
                                                <td>&nbsp;&nbsp;
                                                    <fmt:formatDate value="${screenInfo.start_time}"
                                                                    pattern="HH:mm"/>
                                                    -
                                                    <fmt:formatDate value="${screenInfo.end_time}"
                                                                    pattern="HH:mm"/>
                                                    <span class="mx-2 badge bg-success fw-light">${theaterController.selectById(screenInfo.theater_id).name}</span>
                                                    <span class="badge bg-secondary fw-light">${theaterController.selectById(screenInfo.theater_id).capacity}석</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <hr>
                        <h4 class="blog-post-title">상영관</h4>
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
                                                <td class="col-3 text-center table-secondary">${theater.name}</td>
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
                                        <image href="../resource/img/no_image.JPG" width="100%" height="100%"/>
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
