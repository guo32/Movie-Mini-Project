<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="controller.*" %>
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
    <title>극장 정보 수정</title>
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
<script>
    let checkForm = function () {
        let name = document.getElementById("name").value;
        let country = document.getElementById("country").value;
        let autonomous_district = document.getElementById("autonomous_district").value;
        let detailed_address = document.getElementById("detailed_address").value;
        let phone = document.getElementById("phone").value;

        if (name == '' || name == null) {
            alert("극장명은 비워둘 수 없습니다.");
            return;
        }
        if (country == '' || country == null) {
            alert("시도는 비워둘 수 없습니다.");
            return;
        }
        if (autonomous_district == '' || autonomous_district == null) {
            alert("자치구는 비워둘 수 없습니다.");
            return;
        }
        if (detailed_address == '' || detailed_address == null) {
            alert("상세 주소는 비워둘 수 없습니다.");
            return;
        }
        if (phone == '' || phone == null) {
            alert("전화번호는 비워둘 수 없습니다.");
            return;
        }

        document.cinemaForm.submit();
    }
</script>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <%
            request.setCharacterEncoding("utf-8");

            if (login == null || login.getGrade() != 3) {
                response.sendRedirect("/cinema/printList.jsp");
            }

            int id = Integer.parseInt(request.getParameter("id"));
            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            CinemaController cinemaController = new CinemaController(connectionMaker);
            CinemaDTO cinemaDTO = cinemaController.selectById(id);

            pageContext.setAttribute("cinema", cinemaDTO);

            TheaterController theaterController = new TheaterController(connectionMaker);
            pageContext.setAttribute("theaterList", theaterController.selectByCinemaId(id));
        %>
        <form name="cinemaForm" action="/cinema/update_logic.jsp?id=${cinema.id}" method="post" enctype="multipart/form-data">
            <main class="container">
                <div class="row g-5">
                    <!-- 극장 기본 정보 수정 -->
                    <div class="col-md-8 mb-5">
                        <article class="blog-post">
                            <h2 class="blog-post-title">
                                극장 정보 수정하기
                            </h2>
                            <hr>
                            <h2 class="blog-post-title">
                                <input type="text" name="name" id="name" placeholder="극장 이름" value="${cinema.name}" class="form-control"/>
                            </h2>
                            <hr>
                            <div class="col-12">
                                <table class="col-12">
                                    <tr>
                                        <td class="col-1">주소</td>
                                        <td>
                                            <input type="text" name="country" id="country" placeholder="시도" value="${cinema.country}" class="form-control"/>
                                        </td>
                                        <td>
                                            <input type="text" name="autonomous_district" id="autonomous_district" placeholder="자치구" value="${cinema.autonomous_district}" class="form-control"/>
                                        </td>
                                        <td class="col-6">
                                            <input type="text" name="detailed_address" id="detailed_address" placeholder="상세 주소" value="${cinema.detailed_address}" class="form-control"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-1">전화</td>
                                        <td colspan="3">
                                            <input type="text" name="phone" id="phone" placeholder="-를 포함한 전화 번호" value="${cinema.phone}" class="form-control col-auto"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <hr>
                            <table class="col-12">
                                <tr>
                                    <td class="col-11"><h4 class="blog-post-title col-10">상영관</h4></td>
                                    <td>
                                        <button type="button" onclick="addTheaterForm()" class="btn btn-outline-success mb-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"/>
                                            </svg>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                            <script>
                                i = 0;
                                function addTheaterForm() {
                                    let newTheaterList = document.getElementById("newTheaterList");

                                    let tableTr = document.createElement("tr");
                                    tableTr.id = "addItem" + i;
                                    let tableTd1 = document.createElement("td");
                                    tableTd1.innerHTML = '<input type="hidden" name="theater_id" value=""/><input type="text" name="theater_name" class="theater_name form-control" placeholder="상영관 이름"/>';
                                    tableTr.appendChild(tableTd1);

                                    let tableTd2 = document.createElement("td");
                                    tableTd2.innerHTML = '<input type="text" name="theater_capacity" class="theater_capacity form-control" placeholder="수용 인원"/>';
                                    tableTr.appendChild(tableTd2);

                                    let tableTd3 = document.createElement("td");

                                    tableTd3.innerHTML = '<button type="button" id=' + i + ' onclick="removeElement(this.id)" class="btn btn-danger"> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11A.5.5 0 0 1 2 8Z"/></svg></button>';
                                    tableTr.appendChild(tableTd3);

                                    newTheaterList.appendChild(tableTr);
                                    i++;
                                }

                                function removeElement(id) {
                                    const tr = document.getElementById("addItem" + id);
                                    tr.remove();
                                }
                            </script>
                            <div class="col-12">
                                <table class="col-12" id="newTheaterList">
                                    <c:forEach var="theater" items="${theaterList}">
                                        <tr id="item${theater.id}">
                                            <td class="col-8">
                                                <input type="hidden" name="theater_id" value="${theater.id}"/>
                                                <input type="text" name="theater_name" class="theater_name form-control" placeholder="상영관 이름" value="${theater.name}"/>
                                            </td>
                                            <td class="col-3">
                                                <input type="text" name="theater_capacity" class="theater_capacity form-control" placeholder="수용 인원" value="${theater.capacity}"/>
                                            </td>
                                            <td>
                                                <button type="button" onclick="{
                                                    const tr = document.getElementById('item${theater.id}');
                                                    tr.remove();
                                                    /*location.href = '../theater/delete.jsp?id=${theater.id}';*/
                                                }" class="btn btn-danger">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-lg" viewBox="0 0 16 16">
                                                        <path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11A.5.5 0 0 1 2 8Z"/>
                                                    </svg>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div class="text-center mt-2">
                                <button type="button" class="btn btn-outline-success" onclick="checkForm()">수정</button>
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
                                    <c:choose>
                                        <c:when test="${cinema.image != null}">
                                            <img id="preview" width="100%" height="250" class="bg-light mt-2" src="../resource/img/${cinema.image}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img id="preview" width="100%" height="250" class="bg-light mt-2"/>
                                        </c:otherwise>
                                    </c:choose>
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