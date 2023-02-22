<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.ScreenInformationController" %>
<%@ page import="controller.FilmController" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="controller.TheaterController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-22
  Time: 오후 1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>상영 정보 편집하기</title>
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
    ScreenInformationController screenInformationController = new ScreenInformationController(connectionMaker);
    FilmController filmController = new FilmController(connectionMaker);
    CinemaController cinemaController = new CinemaController(connectionMaker);
    TheaterController theaterController = new TheaterController(connectionMaker);

    pageContext.setAttribute("screenInfoList", screenInformationController.selectAll());
    pageContext.setAttribute("filmController", filmController);
    pageContext.setAttribute("cinemaController", cinemaController);
    pageContext.setAttribute("theaterController", theaterController);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <c:choose>
            <c:when test="${login != null && login.grade != 3}">
                <%
                    response.sendRedirect("/screenInfo/printList.jsp");
                %>
            </c:when>
            <c:otherwise>
                <h2 class="blog-post-title">
                    상영 정보 편집하기
                </h2>
                <hr>
                <div>
                    <c:choose>
                        <c:when test="${empty screenInfoList}">
                            등록된 상영 정보가 없습니다.
                        </c:when>
                        <c:otherwise>
                            <table class="table table-hover text-center">
                                <thead>
                                <tr>
                                    <th class="col-2">영화명</th>
                                    <th class="col-2">극장명</th>
                                    <th class="col-2">상영관</th>
                                    <th class="col-2">시작 시간</th>
                                    <th class="col-2">종료 시간</th>
                                    <th class="col-2"></th>
                                </tr>
                                </thead>
                            </table>
                            <c:forEach var="screenInfo" items="${screenInfoList}">
                                <table class="table table-hover text-center">
                                    <tbody>
                                    <tr>
                                        <td class="col-2">${filmController.selectById(screenInfo.film_id).title}</td>
                                        <td class="col-2">${cinemaController.selectById(screenInfo.cinema_id).name}</td>
                                        <td class="col-2">${theaterController.selectById(screenInfo.theater_id).name}</td>
                                        <td class="col-2">
                                            <fmt:formatDate value="${screenInfo.start_time}" pattern="yy/MM/dd HH:mm"/>
                                        </td>
                                        <td class="col-2">
                                            <fmt:formatDate value="${screenInfo.end_time}" pattern="yy/MM/dd HH:mm"/>
                                        </td>
                                        <td class="col-2">
                                            <div class="badge bg-warning fw-light" data-bs-toggle="modal"
                                                 data-bs-target="#screenInfoUpdate${screenInfo.id}">수정
                                            </div>
                                            <div class="badge bg-danger fw-light"
                                                 onclick="if(confirm('정말로 삭제하시겠습니까?')) {
                                                         location.href = '/screenInfo/delete.jsp?id=' + ${screenInfo.id};
                                                         }">삭제
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <%@include file="/screenInfo/update.jsp" %>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:otherwise>
        </c:choose>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
