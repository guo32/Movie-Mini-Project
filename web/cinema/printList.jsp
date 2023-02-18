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
    CinemaController cinemaController = new CinemaController(connectionMaker);

    ArrayList<CinemaDTO> cinemaList = cinemaController.selectAll();
    pageContext.setAttribute("cinemaList", cinemaList);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <c:choose>
            <c:when test="${empty cinemaList}">
                <div>
                    등록된 극장이 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="cinema" items="${cinemaList}">
                    <div class="row mb-2">
                        <div class="col mb-6">
                            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-m d-250 position-relative">
                                <div class="col p-3 d-flex flex-column position-static">
                                    <p class="card-text mb-auto text-muted"><b class="fs-5 mx-2 mt-1 text-dark">
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
        <%@ include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
