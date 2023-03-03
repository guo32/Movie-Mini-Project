<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="controller.FilmController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-21
  Time: 오후 8:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>상영 정보 등록</title>
    <link href="../resource/img/filmicongreen.svg" rel="shortcut icon" type="image/x-icon">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="../resource/css/main.css"/>
    <script type="text/javascript" src="../resource/javascript/readImage.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="../assets/js/screenInfo/changeSelectOption.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="container">
        <%@ include file="../header.jsp" %>
        <%
            request.setCharacterEncoding("utf-8");

            if (login == null || login.getGrade() != 3) {
                response.sendRedirect("/screenInfo/printList.jsp");
            }

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            CinemaController cinemaController = new CinemaController(connectionMaker);
            TheaterController theaterController = new TheaterController(connectionMaker);
            FilmController filmController = new FilmController(connectionMaker);

            pageContext.setAttribute("countryList", cinemaController.selectCountry());
            pageContext.setAttribute("cinemaList", cinemaController.selectAll());
            pageContext.setAttribute("theaterList", theaterController.selectAll());
            pageContext.setAttribute("filmList", filmController.selectAll(1));
        %>
        <script>
            /*function changeCinema(v) {
                let value = v;
                let theater_select = document.querySelector(".theater-select");

                theater_select.options.length = 0;

                let option = document.createElement("option");
                option.innerText = "상영관 선택";
                option.value = "-1";
                theater_select.append(option);

                <c:forEach var="theater" items="${theaterList}">
                    if("${theater.cinema_id}" == value) {
                        let option = document.createElement("option");
                        option.innerText = "${theater.name}(${theater.capacity}석)"
                        option.value = "${theater.id}";
                        theater_select.append(option);
                    }
                </c:forEach>
            }*/
        </script>
        <form name="cinemaForm" action="/screenInfo/register_logic.jsp" method="post">
            <main class="container">
                <div class="row g-5">
                    <!-- 극장 기본 정보 입력 -->
                    <div class="col-md-12 mb-5">
                        <article class="blog-post">
                            <h2 class="blog-post-title">
                                상영 정보 등록하기
                            </h2>
                            <hr>
                            <div class="col-12">
                                <table class="col-12">
                                    <tr>
                                        <td class="col-2">극장</td>
                                        <td>
                                            <select id="country" name="country" class="form-control country-select" onchange="changeCountry(this.value)">
                                                <option value="null">시도 선택</option>
                                                <c:forEach var="country" items="${countryList}">
                                                    <option value="${country}">${country}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                            <select id="autonomous_district" name="autonomous_district" class="form-control autonomous-district-select" onchange="changeAutonomousDistrict(this.value)">
                                                <option value="-1">자치구 선택</option>
                                            </select>
                                        </td>
                                        <td class="col-6">
                                            <select id="cinema_id" name="cinema_id" class="form-control cinema-select" onchange="changeCinema(this.value)">
                                                <option value="-1">영화관 선택</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-2">상영관</td>
                                        <td colspan="3">
                                            <select id="theater_id" name="theater_id" class="form-control theater-select">
                                                <option value="-1">상영관 선택</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-2">영화</td>
                                        <td colspan="3">
                                            <select id="film_id" name="film_id" class="form-control">
                                                <option value="-1">영화 선택</option>
                                                <c:forEach var="film" items="${filmList}">
                                                    <option value="${film.id}">${film.title}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-2">시작하는 시간</td>
                                        <td colspan="3">
                                            <input type="datetime-local" name="start_time" id="start_time"
                                                   class="form-control col-auto"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-2">끝나는 시간</td>
                                        <td colspan="3">
                                            <input type="datetime-local" name="end_time" id="end_time"
                                                   class="form-control col-auto"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="text-center mt-2">
                                <button type="submit" class="btn btn-outline-success">등록</button>
                                <div class="btn btn-outline-danger" onclick="location.href='/screenInfo/printList.jsp'">
                                    취소
                                </div>
                            </div>
                        </article>
                    </div>
                </div>
            </main>
        </form>
        <%@ include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
