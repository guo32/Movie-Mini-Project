<%@ page import="model.UserDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="controller.UserController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-14
  Time: 오후 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%
        request.setCharacterEncoding("utf-8");

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        FilmController filmController = new FilmController(connectionMaker);

        FilmDTO filmDTO = filmController.selectById(id);
        if (filmDTO == null) {
            response.sendRedirect("../assets/error_page.jsp");
        }
        pageContext.setAttribute("film", filmDTO);
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
<script>
    function checkDelete() {
        let result = confirm("영화 <${film.title}>을(를) 정말로 삭제하시겠습니까?");

        if (result) {
            location.href = "/film/delete.jsp?id=" + ${film.id};
        }
    }
</script>
<body>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <main class="container">
            <div class="row g-5">
                <!-- 자세한 정보 -->
                <div class="col-md-8 mb-5">
                    <div class="mb-2">
                        <button class="badge bg-dark fw-light border-0"
                                onclick="location.href='/film/printList.jsp'">목록
                        </button>
                        <c:if test="${login != null && login.grade == 3}">
                            <button class="badge bg-success fw-light border-0"
                                    onclick="location.href='/film/update.jsp?id=${film.id}'">수정
                            </button>
                            <button class="badge bg-danger fw-light border-0" onclick="checkDelete()">삭제</button>
                        </c:if>
                    </div>
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
                        <%
                            UserController userController = new UserController(connectionMaker);
                            ReviewController reviewController = new ReviewController(connectionMaker);
                            ArrayList<ReviewDTO> reviewList = reviewController.selectByFilmId(id);
                            double[] ratingAverageArray = reviewController.calculateRatingAverageArrayByFilmId(id);

                            pageContext.setAttribute("reviewList", reviewList);
                            pageContext.setAttribute("userController", userController);
                            pageContext.setAttribute("ratingAverage", reviewController.calculateRatingAverageByFilmId(id));
                            pageContext.setAttribute("ratingAverageArray", ratingAverageArray);
                            if (login != null) {
                                pageContext.setAttribute("validateRegister", reviewController.validateRegisterReview(id, login.getId()));
                            }
                        %>
                        <hr class="mt-5">
                        <h4 class="blog-post-title">리뷰</h4>
                        <div class="col-12">
                            <c:choose>
                                <c:when test="${login == null}">
                                    로그인 후 리뷰를 남겨보세요.
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${validateRegister == false}">
                                            이미 평점을 남겼습니다.
                                        </c:when>
                                        <c:when test="${login.grade == 3}">
                                            관리자는 평점을 남길 수 없습니다.
                                        </c:when>
                                        <c:otherwise>
                                            <form action="../review/write_action.jsp?film_id=<%=id%>" method="post">
                                                <table>
                                                    <tr>
                                                        <td class="col-10">
                                                            <select class="form-select" id="rating" name="rating">
                                                                <option value="1">★☆☆☆☆</option>
                                                                <option value="2">★★☆☆☆</option>
                                                                <option value="3">★★★☆☆</option>
                                                                <option value="4">★★★★☆</option>
                                                                <option value="5">★★★★★</option>
                                                            </select>
                                                        </td>
                                                        <c:choose>
                                                            <c:when test="${login.grade == 1}">
                                                                <td>
                                                                    <button type="submit"
                                                                            class="btn btn-outline-success mx-2">등록
                                                                    </button>
                                                                </td>
                                                            </c:when>
                                                            <c:when test="${login.grade == 2}">
                                                                <td rowspan="2">
                                                                    <button type="submit"
                                                                            class="btn btn-outline-success mx-2">등록
                                                                    </button>
                                                                </td>
                                                            </c:when>
                                                        </c:choose>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <c:if test="${login.grade == 2}">
                                                                <textarea class="form-control mt-2" id="review_content"
                                                                          name="review_content"
                                                                          placeholder="평론을 작성해주세요."></textarea>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:choose>
                        <c:when test="${empty reviewList}">
                            <div class="shadow-sm rounded p-2 mt-2" style="background-color: #F2F2F2">
                                아직 등록된 리뷰가 없습니다.
                            </div>
                        </c:when>
                        <c:otherwise>
                        <div class="row col-12">
                            <div class="col-4">
                                <div class="shadow-sm rounded p-2 mt-2 col-12" style="background-color: #F2F2F2">
                                    <table class="table table-borderless">
                                        <tr>
                                            <td class="text-center">
                                                전체 평점 평균
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-center">
                                                <b class="fs-4"><fmt:formatNumber value="${ratingAverage}"
                                                                                  pattern="0.0#/5"/></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-center fs-5" style="color: #023E73">
                                                <c:choose>
                                                    <c:when test="${ratingAverage < 2}">★</c:when>
                                                    <c:when test="${ratingAverage < 3}">★★</c:when>
                                                    <c:when test="${ratingAverage < 4}">★★★</c:when>
                                                    <c:when test="${ratingAverage < 5}">★★★★</c:when>
                                                    <c:when test="${ratingAverage == 5}">★★★★★</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="shadow-sm rounded p-2 mt-2 col-12" style="background-color: #F2F2F2">
                                    <table class="table table-borderless">
                                        <tr>
                                            <td class="text-center">
                                                일반 회원 평점 평균
                                            </td>
                                        </tr>
                                        <c:choose>
                                            <c:when test="${ratingAverageArray[0] == 0}">
                                                <tr>
                                                    <td class="text-center">
                                                        <b class="fs-6">입력된 평점 없음</b>
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td class="text-center">
                                                        <b class="fs-4"><fmt:formatNumber
                                                                value="${ratingAverageArray[0]}"
                                                                pattern="0.0#/5"/></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-center fs-5" style="color: #023E73">
                                                        <c:choose>
                                                            <c:when test="${ratingAverageArray[0] < 2}">★</c:when>
                                                            <c:when test="${ratingAverageArray[0] < 3}">★★</c:when>
                                                            <c:when test="${ratingAverageArray[0] < 4}">★★★</c:when>
                                                            <c:when test="${ratingAverageArray[0] < 5}">★★★★</c:when>
                                                            <c:when test="${ratingAverageArray[0] == 5}">★★★★★</c:when>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="shadow-sm rounded p-2 mt-2 col-12" style="background-color: #F2F2F2">
                                    <table class="table table-borderless">
                                        <tr>
                                            <td class="text-center">
                                                평론가 평점 평균
                                            </td>
                                        </tr>
                                        <c:choose>
                                            <c:when test="${ratingAverageArray[1] == 0}">
                                                <tr>
                                                    <td class="text-center">
                                                        <b class="fs-6">입력된 평점 없음</b>
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td class="text-center">
                                                        <b class="fs-4"><fmt:formatNumber
                                                                value="${ratingAverageArray[1]}"
                                                                pattern="0.0#/5"/></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-center fs-5" style="color: #023E73">
                                                        <c:choose>
                                                            <c:when test="${ratingAverageArray[1] < 2}">★</c:when>
                                                            <c:when test="${ratingAverageArray[1] < 3}">★★</c:when>
                                                            <c:when test="${ratingAverageArray[1] < 4}">★★★</c:when>
                                                            <c:when test="${ratingAverageArray[1] < 5}">★★★★</c:when>
                                                            <c:when test="${ratingAverageArray[1] == 5}">★★★★★</c:when>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>
                            </div>
                            <c:forEach var="review" items="${reviewList}">
                            <div class="shadow-sm rounded p-2 mt-3" style="background-color: #F2F2F2">
                                <table class="table table-borderless">
                                    <tr>
                                        <td class="col-10" style="color: #023E73">
                                            <c:choose>
                                                <c:when test="${review.rating == 1}">★☆☆☆☆ 1</c:when>
                                                <c:when test="${review.rating == 2}">★★☆☆☆ 2</c:when>
                                                <c:when test="${review.rating == 3}">★★★☆☆ 3</c:when>
                                                <c:when test="${review.rating == 4}">★★★★☆ 4</c:when>
                                                <c:when test="${review.rating == 5}">★★★★★ 5</c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${review.writer_id == login.id}">
                                                <span class="badge bg-success fw-light" data-bs-toggle="modal"
                                                      data-bs-target="#updateReviewForm">수정</span>
                                                <%@include file="../review/update.jsp" %>
                                                <span class="badge bg-danger fw-light"
                                                      onclick="if(confirm('정말로 삭제하시겠습니까?')) {
                                                              location.href='../review/delete_action.jsp?id=' + ${review.id} + '&film_id=' + <%=id%>;
                                                              }">삭제</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <c:if test="${review.review_content != null}">
                                        <tr>
                                            <td colspan="2">${review.review_content}</td>
                                        </tr>
                                    </c:if>
                                    <tr>
                                        <td class="fw-light text-muted" style="font-size: 0.8em"
                                            colspan="2">${userController.selectNicknameById(review.writer_id)} |
                                            <fmt:formatDate value="${review.entry_date}"
                                                            pattern="YYYY.MM.dd hh:mm"/></td>
                                    </tr>
                                </table>
                            </div>
                            </c:forEach>
                            </c:otherwise>
                            </c:choose>
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
