<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.NoticeController" %>
<%@ page import="model.NoticeDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-06
  Time: 오후 1:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");

    UserDTO login = (UserDTO) session.getAttribute("login");
    if (login == null || login.getGrade() != 3) {
        response.sendRedirect("/notice/printList.jsp");
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    NoticeController noticeController = new NoticeController(connectionMaker);

    NoticeDTO noticeDTO = new NoticeDTO();

    noticeDTO.setWriter_id(login.getId());
    noticeDTO.setCategory_id(Integer.parseInt(request.getParameter("category")));
    noticeDTO.setTitle(request.getParameter("title"));
    noticeDTO.setContent(request.getParameter("content"));

    if (noticeController.insert(noticeDTO)) {
        response.sendRedirect("/notice/printList.jsp");
    } else {
%>
<script>
    Swal.fire({
        icon: "error",
        text: "문제가 발생했습니다.",
    }).then((result) => {
        history.go(-1);
    });
</script>
<%
    }
%>
</body>
</html>
