<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.ScreenInformationController" %>
<%@ page import="controller.FilmController" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="controller.TheaterController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-21
  Time: 오전 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>상영 정보</title>
    <link href="../resource/img/filmicongreen.svg" rel="shortcut icon" type="image/x-icon">
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
    <script src="../assets/js/cinema/changeCinemaList.js"></script>
    <script src="../assets/js/screenInfo/changeScreenInfoList.js"></script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    /* 날짜 및 요일 추출 */
    LocalDate date = LocalDate.now();
    LinkedHashMap<LocalDate, String> dateMap = new LinkedHashMap<>();

    DayOfWeek dayOfWeek = date.getDayOfWeek();
    dateMap.put(date, dayOfWeek.getDisplayName(TextStyle.SHORT, Locale.KOREAN));

    for (int i = 0; i < 2; i++) {
        date = date.plusDays(1);
        dayOfWeek = date.getDayOfWeek();
        dateMap.put(date, dayOfWeek.getDisplayName(TextStyle.SHORT, Locale.KOREAN));
    }

    pageContext.setAttribute("dateSet", dateMap.entrySet());

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ScreenInformationController screenInformationController = new ScreenInformationController(connectionMaker);
    FilmController filmController = new FilmController(connectionMaker);
    CinemaController cinemaController = new CinemaController(connectionMaker);
    TheaterController theaterController = new TheaterController(connectionMaker);

    pageContext.setAttribute("screenInfoList", screenInformationController.selectAll());
    pageContext.setAttribute("filmController", filmController);
    pageContext.setAttribute("cinemaController", cinemaController);
    pageContext.setAttribute("theaterController", theaterController);
    pageContext.setAttribute("countryList", cinemaController.selectCountry());
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <div class="rounded mb-3">
            <div class="container d-flex flex-wrap">
                <ul class="nav me-auto" id="country-list">
                    <c:forEach var="country" items="${countryList}">
                        <li class="nav-item me-1 rounded-top p-2" id="item-${country}" onclick="changeCinema('${country}', 1)" <c:if test="${country == '서울'}">style="background-color: #023E73; color: #FFFFFF"</c:if><c:if test="${country != '서울'}">style="background-color: #d9d9d9; color: #0d0d0d"</c:if>>
                                ${country}
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="rounded p-1" style="background-color: #023E73;">
                <ul class="nav col-12 col-md-auto mb-2 mb-md-0" id="cinema-list">
                    <c:forEach var="cinema" items="${cinemaController.selectByCountry('서울')}">
                        <li>
                            <a class="nav-link p-1 link-dark bg-light m-1 rounded" style="font-size: 90%" onclick="changeScreenInfo(${cinema.id})">${cinema.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <c:if test="${login != null && login.grade == 3}">
            <button class="btn btn-outline-success btn-sm mb-2" onclick="location.href='/screenInfo/register.jsp'">상영 정보 등록하기</button>
            <button class="btn btn-outline-secondary btn-sm mb-2"  onclick="location.href='/screenInfo/edit.jsp'">상영 정보 편집하기</button>
        </c:if>
        <div class="row row-cols-1 row-cols-md-3 mb-3 text-center" id="screen-info-wrap">
            <c:forEach var="date" items="${dateSet}">
                <div class="col">
                    <div class="card mb-4 rounded-3 shadow-sm">
                        <div class="card-header py-3">
                            <h6 class="text-secondary">${date.key}</h6>
                            <h4 class="my-0 fw-normal">${date.value}</h4>
                        </div>
                        <div class="card-body">
                            <c:forEach var="info" items="${screenInfoList}">
                                <c:if test="${date.key == info.start_time.toLocalDateTime().toLocalDate()}">
                                    <table class="table table-sm">
                                        <thead class="table-secondary text-center">
                                        <tr>
                                            <td>
                                                <span onclick="location.href='../film/printOne.jsp?id=${info.film_id}'">${filmController.selectById(info.film_id).title}</span>
                                                <span class="badge rounded-pill text-bg-success fw-lighter">${cinemaController.selectById(info.cinema_id).name}</span>
                                                <span class="badge rounded-pill text-bg-warning fw-lighter">${theaterController.selectById(info.theater_id).name}</span>
                                            </td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td><fmt:formatDate value="${info.start_time}" pattern="HH:mm"/> - <fmt:formatDate value="${info.end_time}" pattern="HH:mm"/> ${theaterController.selectById(info.theater_id).capacity}석</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <%@ include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
