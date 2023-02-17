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
    <title>영화 등록</title>
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
        <%@include file="../header.jsp" %>
        <%
            request.setCharacterEncoding("utf-8");

            if (login.getGrade() != 3) {
                response.sendRedirect("/film/printList.jsp");
            }
        %>
        <form action="/film/register_logic.jsp" method="post" enctype="multipart/form-data">
            <main class="container">
                <div class="row g-5">
                    <!-- 자세한 정보 -->
                    <div class="col-md-8 mb-5">
                        <article class="blog-post">
                            <h2 class="blog-post-title">
                                영화 등록하기
                            </h2>
                            <hr>
                            <h2 class="blog-post-title">
                                <input type="text" name="title" id="title" placeholder="영화 제목" class="form-control"/>
                            </h2>
                            <hr>
                            <div class="col-12">
                                <table class="col-12">
                                    <tr>
                                        <td class="col-1">감독</td>
                                        <td><input type="text" name="director" id="director" placeholder="영화 감독" class="form-control col-auto"></td>
                                    </tr>
                                    <tr>
                                        <td class="col-1">등급</td>
                                        <td>
                                            <select name="rating" id="rating" class="form-control">
                                                <option selected value="">영화 등급을 선택해주세요.</option>
                                                <option value="전체 관람가">전체 관람가</option>
                                                <option value="12세 이상 관람가">12세 이상 관람가</option>
                                                <option value="15세 이상 관람가">15세 이상 관람가</option>
                                                <option value="청소년 관람불가">청소년 관람불가</option>
                                                <option value="제한 관람가">제한 관람가</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <hr>
                            <h4 class="blog-post-title">줄거리</h4>
                            <div>
                                <textarea name="description" id="description" rows="8" placeholder="영화의 줄거리를 입력해주세요." class="form-control"></textarea>
                            </div>
                            <div class="text-center mt-2">
                                <button type="submit" class="btn btn-outline-success">등록</button>
                                <button class="btn btn-outline-danger">취소</button>
                            </div>
                        </article>
                    </div>
                    <!-- 간단한 정보 -->
                    <div class="col-md-4">
                        <div class="position-sticky">
                            <div class="p-4 mb-3 rounded shadow-sm" style="background-color: #f2f2f2">
                                <div class="form-group">
                                    <label for="poster" class="mb-2">포스터 이미지</label>
                                    <input type="file" class="form-control-file" id="poster" name="poster_image" onchange="readImage(this)">
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
    function readImage(input) {
        if(input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("preview").src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            document.getElementById("preview").src = "";
        }
    }
</script>