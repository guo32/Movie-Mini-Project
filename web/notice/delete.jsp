<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.NoticeController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-07
  Time: 오전 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    NoticeController noticeController = new NoticeController(connectionMaker);

    noticeController.delete(id);
%>
<script>
    Swal.fire({
        icon: "success",
        text: "정상적으로 삭제되었습니다.",
    }).then(() => {
        location.href = "/notice/printList.jsp";
    });
</script>
</body>
</html>
