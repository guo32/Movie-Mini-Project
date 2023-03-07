<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-07
  Time: 오후 3:47
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
    request.setCharacterEncoding("utf-8");

    UserDTO login = (UserDTO) session.getAttribute("login");
    if (login == null || login.getGrade() != 3) {
        response.sendRedirect("../index.jsp");
    }

    int id = Integer.parseInt(request.getParameter("id"));

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    userController.delete(id);
%>
<script>
    Swal.fire({
        icon: "success",
        text: "정상적으로 처리되었습니다.",
    }).then(() => {
        location.href = "/user/printList.jsp";
    });
</script>
</body>
</html>
