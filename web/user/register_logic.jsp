<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오후 4:04
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
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    String username = request.getParameter("username");
    String password = userController.encrypt(request.getParameter("password"));
    String nickname = request.getParameter("nickname");

    UserDTO newUser = new UserDTO();
    newUser.setUsername(username);
    newUser.setPassword(password);
    newUser.setNickname(nickname);

    boolean result = userController.insert(newUser);

    if (result) {
        response.sendRedirect("/index.jsp");
    } else {
%>
<script>
    Swal.fire({
        icon: "warning",
        title: "유효하지 않은 아이디",
        text: "회원가입에 실패하였습니다.",
    }).then(() => {
        history.go(-1);
    });
</script>
<%
    }
%>
</body>
</html>