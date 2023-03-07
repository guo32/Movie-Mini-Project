<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.NoticeController" %>
<%@ page import="model.NoticeDTO" %>
<%@ page import="controller.NoticeCategoryController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%
        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        NoticeController noticeController = new NoticeController(connectionMaker);
        NoticeCategoryController noticeCategoryController = new NoticeCategoryController(connectionMaker);

        NoticeDTO noticeDTO = noticeController.selectById(id);
        if (noticeDTO == null) {
            response.sendRedirect("../assets/error_page.jsp");
        }
        pageContext.setAttribute("notice", noticeDTO);
        pageContext.setAttribute("noticeCategoryController", noticeCategoryController);
        pageContext.setAttribute("previous", noticeController.selectPreviousByCurrentId(id));
        pageContext.setAttribute("next", noticeController.selectNextByCurrentId(id));
    %>
    <title>${notice.title}</title>
    <link href="../resource/img/sunfishicon.svg" rel="shortcut icon" type="image/x-icon">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resource/css/main.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="container">
        <%@include file="../header.jsp" %>
        <main class="container">
            <div class="hstack gap-3 pb-2 mb-2 border-bottom">
                <span class="fs-4">공지사항</span>
                <span class="d-flex ms-auto">
                    <button class="badge bg-dark fw-light border-0 mx-1"
                            onclick="location.href='/notice/printList.jsp'">목록
                    </button>
                    <c:if test="${login != null && login.grade == 3}">
                        <button class="badge bg-success fw-light border-0"
                                onclick="location.href='/notice/update.jsp?id=${notice.id}'">수정
                        </button>
                        <button class="badge bg-danger fw-light border-0 mx-1" onclick="checkDelete()">삭제</button>
                    </c:if>
                </span>
            </div>
            <table class="table table-borderless">
                <thead class="table-secondary">
                <tr>
                    <th>[${noticeCategoryController.selectNameById(notice.category_id)}] ${notice.title}</th>
                    <td class="d-flex justify-content-end" style="font-size: 90%">
                        <span class="text-secondary fw-light mx-1">등록일</span>
                        <span>
                            <fmt:formatDate value="${notice.entry_date}" pattern="YY.MM.dd"/>
                        </span>
                        <c:if test="${notice.modify_date != null}">
                            <span class="vr"></span>
                            <span class="text-secondary fw-light mx-1">수정일</span>
                            <span>
                            <fmt:formatDate value="${notice.modify_date}" pattern="YY.MM.dd"/>
                        </span>
                        </c:if>
                    </td>
                </tr>
                </thead>
            </table>
            <div>
                <div class="p-2">
                    ${notice.content}
                </div>
            </div>
            <div>
                <div class="border-top border-bottom py-2 border-secondary">
                    <span>이전글</span>
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                             class="bi bi-caret-up-fill" viewBox="0 0 16 16">
                          <path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
                        </svg>
                    </span>
                    <c:choose>
                        <c:when test="${previous == null}">
                            <span class="mx-2 text-secondary">이전 글이 없습니다.</span>
                        </c:when>
                        <c:otherwise>
                            <span class="mx-2 text-secondary" onclick="location.href='/notice/printOne.jsp?id=${previous.id}'">${previous.title}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="border-bottom py-2 border-secondary mb-2">
                    <span>다음글</span>
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                             class="bi bi-caret-down-fill" viewBox="0 0 16 16">
                          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
                        </svg>
                    </span>
                    <c:choose>
                        <c:when test="${next == null}">
                            <span class="mx-2 text-secondary">다음 글이 없습니다.</span>
                        </c:when>
                        <c:otherwise>
                            <span class="mx-2 text-secondary" onclick="location.href='/notice/printOne.jsp?id=${next.id}'">${next.title}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
