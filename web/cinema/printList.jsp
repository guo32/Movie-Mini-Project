<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="model.CinemaDTO" %><%--
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
    <title>극장 목록</title>
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
    <script src="../assets/js/cinema/searchCinema.js"></script>
    <script src="../assets/js/cinema/changeCinemaList.js"></script>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    CinemaController cinemaController = new CinemaController(connectionMaker);

    int pageNo;
    try {
        String pageStr = request.getParameter("pageNo");
        pageNo = Integer.parseInt(pageStr);
    } catch (Exception e) {
        pageNo = 1;
    }

    ArrayList<CinemaDTO> cinemaList = cinemaController.selectAll(pageNo);

    int totalPage = cinemaController.countTotalPage();
    int startNum;
    int endNum;

    if (totalPage <= 5) {
        startNum = 1;
        endNum = totalPage;
    } else if (pageNo <= 3) {
        startNum = 1;
        endNum = 5;
    } else if (pageNo > totalPage - 3) {
        startNum = totalPage - 4;
        endNum = totalPage;
    } else {
        startNum = pageNo - 2;
        endNum = pageNo + 2;
    }
    pageContext.setAttribute("cinemaList", cinemaList);
    pageContext.setAttribute("currentPage", pageNo);
    pageContext.setAttribute("startPage", startNum);
    pageContext.setAttribute("endPage", endNum);
    pageContext.setAttribute("totalPage", totalPage);
    pageContext.setAttribute("countryList", cinemaController.selectCountry());
    pageContext.setAttribute("cinemaController", cinemaController);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <h4>극장</h4>
        <hr>
        <div class="rounded mb-3">
            <div class="container d-flex flex-wrap">
                <ul class="nav me-auto" id="country-list">
                    <c:forEach var="country" items="${countryList}">
                        <li class="nav-item me-1 rounded-top p-2" id="item-${country}" onclick="changeCinema('${country}', 0)" <c:if test="${country == '서울'}">style="background-color: #023E73; color: #FFFFFF"</c:if><c:if test="${country != '서울'}">style="background-color: #d9d9d9; color: #0d0d0d"</c:if>>
                                ${country}
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="rounded p-1" style="border: 2px solid #023E73;">
                <ul class="nav col-12 col-md-auto mb-2 mb-md-0" id="cinema-list">
                    <c:forEach var="cinema" items="${cinemaController.selectByCountry('서울')}">
                        <li>
                            <a class="nav-link p-1 link-dark bg-light m-1 rounded" style="font-size: 90%" href="/cinema/printOne.jsp?id=${cinema.id}">${cinema.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!-- search -->
        <div class="d-flex align-items-center mb-4 search-form">
            <input type="search" id="cinema-search" name="cinema-search" class="form-control w-100" placeholder="영화관 검색"
                   onkeypress="if(event.keyCode==13) {search()}"/>
            <button type="button" class="flex-shrink-0 dropdown btn" onclick="search()">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search"
                     viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                </svg>
            </button>
        </div>
        <c:if test="${login != null && login.grade == 3}">
            <button class="btn btn-outline-success btn-sm mb-2" onclick="location.href='/cinema/register.jsp'">극장 등록하기
            </button>
        </c:if>
        <div id="cinema-list-in-page">
            <c:choose>
                <c:when test="${empty cinemaList}">
                    <div>
                        등록된 극장이 없습니다.
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- list -->
                    <c:forEach var="cinema" items="${cinemaList}">
                        <div class="row">
                            <div class="col mb-6">
                                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-3 shadow-sm h-m d-250 position-relative">
                                    <div class="col p-3 d-flex flex-column position-static">
                                        <p class="card-text mb-auto text-muted"><b class="fs-5 mx-2 mt-1 text-dark">
                                                ${cinema.name}</b> ${cinema.country} ${cinema.autonomous_district} ${cinema.detailed_address}
                                            | ${cinema.phone}
                                        </p>
                                        <a href="/cinema/printOne.jsp?id=${cinema.id}" class="stretched-link"></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="d-flex justify-content-center">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a href="/cinema/printList.jsp?pageNo=${1}" class="page-link">
                                        <span>&lt;</span>
                                    </a>
                                </li>
                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="page-item active">
                                                <a href="/cinema/printList.jsp?pageNo=${i}" class="page-link">
                                                    <span>${i}</span>
                                                </a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a href="/cinema/printList.jsp?pageNo=${i}" class="page-link">
                                                    <span>${i}</span>
                                                </a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="page-item">
                                    <a href="/cinema/printList.jsp?pageNo=${totalPage}" class="page-link">
                                        <span>&gt;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%@ include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
