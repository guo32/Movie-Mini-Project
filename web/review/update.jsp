<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-20
  Time: 오후 1:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        request.setCharacterEncoding("utf-8");

        UserDTO login = (UserDTO) session.getAttribute("login");
        if (login == null) {
            response.sendRedirect("../user/login.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));
        int film_id = Integer.parseInt(request.getParameter("film_id"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        ReviewController reviewController = new ReviewController(connectionMaker);
        FilmController filmController = new FilmController(connectionMaker);

        pageContext.setAttribute("film", filmController.selectById(film_id));
        pageContext.setAttribute("review", reviewController.selectById(id));
    %>
    <title>리뷰 수정 : ${film.title}</title>
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
        <div class="row my-5 align-items-center">
            <div class="row justify-content-center">
                <div class="col-11" style="background-color: #F2F2F2; border-radius: 1em;">
                    <form action="../review/update_action.jsp?id=${review.id}&film_id=${film.id}" method="post">
                        <table class="m-3">
                            <tr>
                                <td class="col-10">
                                    <select class="form-select" id="rating" name="rating">
                                        <option value="1" <c:if test="${review.rating == 1}">selected</c:if>>★☆☆☆☆
                                        </option>
                                        <option value="2" <c:if test="${review.rating == 2}">selected</c:if>>★★☆☆☆
                                        </option>
                                        <option value="3" <c:if test="${review.rating == 3}">selected</c:if>>★★★☆☆
                                        </option>
                                        <option value="4" <c:if test="${review.rating == 4}">selected</c:if>>★★★★☆
                                        </option>
                                        <option value="5" <c:if test="${review.rating == 5}">selected</c:if>>★★★★★
                                        </option>
                                    </select>
                                </td>
                                <c:choose>
                                    <c:when test="${login.grade == 1}">
                                        <td>
                                            <button type="submit"
                                                    class="btn btn-outline-success mx-1">수정
                                            </button>
                                        </td>
                                    </c:when>
                                    <c:when test="${login.grade == 2}">
                                        <td rowspan="2">
                                            <button type="submit"
                                                    class="btn btn-outline-success mx-1">수정
                                            </button>
                                        </td>
                                    </c:when>
                                </c:choose>
                            </tr>
                            <tr>
                                <td>
                                    <c:if test="${login.grade == 2}"><textarea class="form-control mt-2"
                                                                               id="review_content"
                                                                               name="review_content"
                                                                               placeholder="평론을 작성해주세요.">${review.review_content}</textarea></c:if>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
