<%@ page import="model.UserDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="controller.UserController" %>
<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-20
  Time: 오후 4:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>극장 등록</title>
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
</head>
<body>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <%
            request.setCharacterEncoding("utf-8");

            if (login == null || login.getGrade() != 3) {
                response.sendRedirect("/cinema/printList.jsp");
            }
        %>
        <form name="cinemaForm" action="/cinema/register_logic.jsp" method="post" enctype="multipart/form-data">
            <main class="container">
                <div class="row g-5">
                    <!-- 극장 기본 정보 입력 -->
                    <div class="col-md-8 mb-5">
                        <article class="blog-post">
                            <h2 class="blog-post-title">
                                극장 등록하기
                            </h2>
                            <hr>
                            <h2 class="blog-post-title">
                                <input type="text" name="name" id="name" placeholder="극장 이름" class="form-control"/>
                            </h2>
                            <hr>
                            <div class="col-12">
                                <table class="col-12">
                                    <tr>
                                        <td class="col-1">주소</td>
                                        <td>
                                            <input type="text" name="country" id="country" placeholder="시도" class="form-control"/>
                                        </td>
                                        <td>
                                            <input type="text" name="autonomous_district" id="autonomous_district" placeholder="자치구" class="form-control"/>
                                        </td>
                                        <td class="col-6">
                                            <input type="text" name="detailed_address" id="detailed_address" placeholder="상세 주소" class="form-control"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-1">전화</td>
                                        <td colspan="3">
                                            <input type="text" name="phone" id="phone" placeholder="-를 포함한 전화 번호" class="form-control col-auto"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <hr>
                            <h4 class="blog-post-title">상영관</h4>
                            <script>
                                function addTheaterForm() {
                                    let newTheaterList = document.getElementById("newTheaterList");

                                    let tableTr = document.createElement("tr");
                                    let tableTd1 = document.createElement("td");
                                    tableTd1.innerHTML = '<input type="text" name="theater_name" class="theater_name form-control" placeholder="상영관 이름"/>';
                                    tableTr.appendChild(tableTd1);

                                    let tableTd2 = document.createElement("td");
                                    tableTd2.innerHTML = '<input type="text" name="theater_capacity" class="theater_capacity form-control" placeholder="수용 인원"/>';
                                    tableTr.appendChild(tableTd2);

                                    /*let tableTd3 = document.createElement("td");
                                    tableTd3.innerHTML = '<button type="button" onclick="addTheaterForm()" class="btn btn-success">추가</button>';
                                    tableTr.appendChild(tableTd3);*/

                                    newTheaterList.appendChild(tableTr);
                                }
                            </script>
                            <div class="col-12">
                                <table class="col-12" id="newTheaterList">
                                    <tr>
                                        <td>
                                            <input type="text" name="theater_name" class="theater_name form-control" placeholder="상영관 이름"/>
                                        </td>
                                        <td class="col-3">
                                            <input type="text" name="theater_capacity" class="theater_capacity form-control" placeholder="수용 인원"/>
                                        </td>
                                        <td>
                                            <button type="button" onclick="addTheaterForm()" class="btn btn-success">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                                    <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"/>
                                                </svg>
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="text-center mt-2">
                                <button type="submit" class="btn btn-outline-success">등록</button>
                                <div class="btn btn-outline-danger" onclick="location.href='/cinema/printList.jsp'">취소</div>
                            </div>
                        </article>
                    </div>
                    <!-- 극장 이미지 불러오기 -->
                    <div class="col-md-4">
                        <div class="position-sticky">
                            <div class="p-4 mb-3 rounded shadow-sm" style="background-color: #f2f2f2">
                                <div class="form-group">
                                    <label for="image" class="mb-2">극장 이미지</label>
                                    <input type="file" class="form-control-file" id="image" name="cinema_image" onchange="readImage(this)">
                                    <img id="preview" width="100%" height="250" class="bg-light mt-2"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </form>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
<script>
    function checkForm() {
        document.cinemaForm.onsubmit;
    }
</script>