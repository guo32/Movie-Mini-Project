<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="model.NoticeCategoryDTO" %>
<%@ page import="controller.NoticeCategoryController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.NoticeController" %>
<%@ page import="model.NoticeDTO" %>
<%@ page import="controller.UserController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-06
  Time: 오전 9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>공지사항</title>
    <link href="/resource/img/sunfishicon.svg" rel="shortcut icon" type="image/x-icon">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resource/css/main.css"/>
    <!-- Swiper -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="../assets/js/notice/changeNoticeList.js"></script>
</head>
<body>
<%
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    NoticeCategoryController noticeCategoryController = new NoticeCategoryController(connectionMaker);
    ArrayList<NoticeCategoryDTO> categoryList = noticeCategoryController.selectAll();

    NoticeController noticeController = new NoticeController(connectionMaker);

    int pageNo;
    try {
        String pageStr = request.getParameter("pageNo");
        pageNo = Integer.parseInt(pageStr);
    } catch (Exception e) {
        pageNo = 1;
    }

    ArrayList<NoticeDTO> noticeList = noticeController.selectAll(pageNo);

    int totalPage = noticeController.countTotalPage();
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

    UserController userController = new UserController(connectionMaker);

    pageContext.setAttribute("noticeList", noticeList);
    pageContext.setAttribute("categoryList", categoryList);
    pageContext.setAttribute("noticeCategoryController", noticeCategoryController);
    pageContext.setAttribute("userController", userController);
    pageContext.setAttribute("currentPage", pageNo);
    pageContext.setAttribute("startPage", startNum);
    pageContext.setAttribute("endPage", endNum);
    pageContext.setAttribute("totalPage", totalPage);
%>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <div>
            <h4>공지사항</h4>
            <hr>
            <!-- search -->
            <div class="d-flex align-items-center mb-4 search-form">
                <input type="search" id="cinema-search" name="cinema-search" class="form-control w-100"
                       placeholder="공지사항 검색"
                       onkeypress="if(event.keyCode==13) {search()}"/>
                <button type="button" class="flex-shrink-0 dropdown btn" onclick="search()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                         class="bi bi-search"
                         viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                    </svg>
                </button>
            </div>
            <!-- list -->
            <c:if test="${login != null && login.grade == 3}">
                <button class="btn btn-outline-success btn-sm mb-2" onclick="location.href='/notice/register.jsp'">공지사항
                    등록하기
                </button>
            </c:if>
            <div>
                <div>
                    <ul class="nav me-auto" id="ul-for-items">
                        <li id="item-0" class="nav-item me-1 rounded-top p-2" style="background-color: #e2e3e5;"
                            onclick="location.href = '/notice/printList.jsp'">전체
                        </li>
                        <c:forEach var="category" items="${categoryList}">
                            <li id="item-${category.id}" class="nav-item me-1 rounded-top p-2"
                                style="background-color: #031059; color: #FFFFFF;"
                                onclick="changeList(${category.id})">${category.name}</li>
                        </c:forEach>
                    </ul>
                </div>
                <div id="div-for-list">
                    <c:choose>
                        <c:when test="${empty noticeList}">
                            <p class="mt-2">아직 등록된 글이 없습니다.</p>
                        </c:when>
                        <c:otherwise>
                            <table class="table" id="table-for-list">
                                <thead class="table-secondary" id="thead-for-list">
                                <tr>
                                    <th>번호</th>
                                    <th>카테고리</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                </tr>
                                </thead>
                                <tbody id="tbody-for-list">
                                <c:forEach var="notice" items="${noticeList}">
                                    <tr onclick="location.href='/notice/printOne.jsp?id=${notice.id}'">
                                        <td>${notice.id}</td>
                                        <td>${noticeCategoryController.selectNameById(notice.category_id)}</td>
                                        <td>${notice.title}</td>
                                        <td>${userController.selectById(notice.writer_id).nickname}</td>
                                        <td><fmt:formatDate value="${notice.entry_date}" pattern="YY.MM.dd"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="d-flex justify-content-center">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <li class="page-item">
                                            <a href="/cinema/printList.jsp?pageNo=${1}" class="page-link">
                                                <span>&lt;</span>
                                            </a>
                                        </li>
                                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                            <c:choose>
                                                <c:when test="${currentPage eq i}">
                                                    <li class="page-item active">
                                                        <a href="/cinema/printList.jsp?pageNo=${i}" class="page-link">
                                                            <span>${i}</span>
                                                        </a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="page-item">
                                                        <a href="/cinema/printList.jsp?pageNo=${i}" class="page-link">
                                                            <span>${i}</span>
                                                        </a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item">
                                            <a href="/cinema/printList.jsp?pageNo=${totalPage}" class="page-link">
                                                <span>&gt;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>