<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-15
  Time: 오전 10:54
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

    UserDTO login = (UserDTO) session.getAttribute("login");

    if (login == null) {
        response.sendRedirect("/user/login.jsp");
    }

    String newPassword = userController.encrypt(request.getParameter("newPassword"));
    String oldPassword = userController.encrypt(request.getParameter("oldPassword"));
    String nickname = request.getParameter("nickname");

    UserDTO userDTO = userController.auth(login.getUsername(), oldPassword);
    if (userDTO == null) {
%>
<script>
    Swal.fire({
        icon: "warning",
        title: "회원 정보 수정 실패",
        text: "회원 정보 수정에 실패하였습니다.",
    }).then(() => {
        history.go(-1);
    });
</script>
<%
    } else {
        if (!newPassword.equals(userController.encrypt(""))) {
            userDTO.setPassword(newPassword);
        } else {
            userDTO.setPassword(oldPassword);
        }
        userDTO.setNickname(nickname);
        userController.update(userDTO);

        session.invalidate();
%>
<script>
    Swal.fire({
        icon: "success",
        title: "회원 정보 수정 성공",
        text: "다시 로그인해주세요.",
    }).then(() => {
        location.href = "/user/login.jsp";
    });
</script>
<%
    }
%>
</body>
</html>
