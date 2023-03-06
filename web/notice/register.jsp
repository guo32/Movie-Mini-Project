<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-06
  Time: 오전 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>공지사항 등록</title>
    <link href="../resource/img/sunfishicon.svg" rel="shortcut icon" type="image/x-icon">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="../resource/css/main.css"/>
    <link rel="stylesheet" type="text/css" href="../resource/css/editor.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="../assets/js_library/build/ckeditor.js"></script>
    <script src="../assets/js/notice/register.js"></script>
    <script src="../assets/js/checkDoubleSubmit.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <c:if test="${login == null}">
            <% response.sendRedirect("/notice/printList.jsp"); %>
        </c:if>
        <c:if test="${login.grade != 3}">
            <% response.sendRedirect("/notice/printList.jsp"); %>
        </c:if>
        <form id="register-form" name="registerForm" method="post" action="/notice/register_logic.jsp">
            <h3 class="blog-post-title">
                공지사항 등록하기
            </h3>
            <hr>
            <h2 class="blog-post-title" id="input-for-title">
                <input type="text" name="title" id="title" placeholder="공지사항 제목" class="form-control"/>
            </h2>
            <div class="col-12 mb-2" id="input-for-category">
                <select name="category" id="category" class="form-control">
                    <option selected value="">카테고리를 선택해주세요.</option>
                    <option value="1">일반</option>
                    <option value="2">회원</option>
                    <option value="3">영화</option>
                    <option value="4">극장</option>
                </select>
            </div>
            <textarea id="editor" name="content"></textarea>
            <div class="text-center mt-2">
                <button type="button" class="btn btn-outline-success" onclick="submitForm()">등록</button>
                <div class="btn btn-outline-danger" onclick="location.href='/notice/printList.jsp'">취소
                </div>
            </div>
        </form>
        <%@include file="../footer.jsp" %>
    </div>
</div>
<script>
    ClassicEditor.create(document.querySelector('#editor'), {}).catch(error => {
        console.log(error)
    });
</script>
</body>
</html>
