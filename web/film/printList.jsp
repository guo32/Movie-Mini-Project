<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.ReviewController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오후 5:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="../assets/js/film/searchFilmTitle.js"></script>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);

    int pageNo;
    try {
        String pageStr = request.getParameter("pageNo");
        pageNo = Integer.parseInt(pageStr);
    } catch (Exception e) {
        pageNo = 1;
    }

    ArrayList<FilmDTO> filmList = filmController.selectAll(pageNo);

    int totalPage = filmController.countTotalPage();
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

    pageContext.setAttribute("filmList", filmList);
    pageContext.setAttribute("currentPage", pageNo);
    pageContext.setAttribute("startPage", startNum);
    pageContext.setAttribute("endPage", endNum);
    pageContext.setAttribute("totalPage", totalPage);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <!-- search -->
        <div class="d-flex align-items-center mb-4 search-form">
            <input type="search" id="film-search" name="film-search" class="form-control w-100" placeholder="영화 제목 검색"
                   onkeypress="if(event.keyCode==13) {search()}"/>
            <button type="button" class="flex-shrink-0 dropdown btn" onclick="search()">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search"
                     viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                </svg>
            </button>
        </div>
        <c:if test="${login != null && login.grade == 3}">
            <button class="btn btn-outline-success btn-sm mb-2" onclick="location.href='/film/register.jsp'">영화 등록하기
            </button>
        </c:if>
        <div id="film-list">
            <c:choose>
                <c:when test="${empty filmList}">
                    <div>
                        등록된 영화가 없습니다.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="film" items="${filmList}">
                            <div class="col">
                                <div class="card shadow-sm">
                                    <svg class="bd-placeholder-img card-img" width="100%" height="290"
                                         xmlns="http://www.w3.org/2000/svg" role="img"
                                         aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice"
                                         focusable="false">
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
                                    <a href="/film/printOne.jsp?id=${film.id}" class="stretched-link"></a>
                                </div>
                                <div class="text-center my-1">
                                    <%
                                        ReviewController reviewController = new ReviewController(connectionMaker);
                                        pageContext.setAttribute("reviewController", reviewController);
                                    %>
                                    <b>${film.title}</b>
                                    <p class="fw-light text-secondary">★ <fmt:formatNumber value="${reviewController.calculateRatingAverageByFilmId(film.id)}"
                                                                      pattern="0.0#"/></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="d-flex justify-content-center">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a href="/film/printList.jsp?pageNo=${1}" class="page-link">
                                        <span>&lt;</span>
                                    </a>
                                </li>
                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <c:choose>
                                        <c:when test="${currentPage eq i}">
                                            <li class="page-item active">
                                                <a href="/film/printList.jsp?pageNo=${i}" class="page-link">
                                                    <span>${i}</span>
                                                </a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a href="/film/printList.jsp?pageNo=${i}" class="page-link">
                                                    <span>${i}</span>
                                                </a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="page-item">
                                    <a href="/film/printList.jsp?pageNo=${totalPage}" class="page-link">
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
