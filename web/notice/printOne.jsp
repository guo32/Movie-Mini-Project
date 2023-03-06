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
            <table class="table table-borderless">
                <thead class="table-secondary">
                <tr>
                    <th>[${noticeCategoryController.selectNameById(notice.category_id)}] ${notice.title}</th>
                    <td class="d-flex justify-content-end"><span class="text-secondary fw-light mx-1">등록일</span>
                        <span>
                            <fmt:formatDate value="${notice.entry_date}" pattern="YY.MM.dd"/>
                        </span>
                    </td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td colspan="2">
                        ${notice.content}
                    </td>
                </tr>
                </tbody>
            </table>
        </main>
        <%@include file="../footer.jsp" %>
    </div>
</div>
</body>
</html>
