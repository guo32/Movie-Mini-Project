<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-15
  Time: 오전 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    UserDTO login = (UserDTO) session.getAttribute("login");

    if (login == null) {
        response.sendRedirect("/user/login.jsp");
    }

    userController.delete(login.getId());
    session.invalidate();
%>
<script>
    alert("정상적으로 탈퇴되었습니다.");
    location.href = "../index.jsp";
</script>
</body>
</html>
