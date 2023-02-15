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

    String newPassword = request.getParameter("newPassword");
    String oldPassword = request.getParameter("oldPassword");
    String nickname = request.getParameter("nickname");

    UserDTO userDTO = userController.selectById(login.getId());
    if (!userDTO.getPassword().equals(oldPassword)) {
%>
<script>
    alert("[회원 정보 수정 실패]\n회원 정보 수정에 실패하였습니다.")
    history.go(-1);
</script>
<%
    } else {
        if (!newPassword.equals("")) {
            userDTO.setPassword(newPassword);
        }
        userDTO.setNickname(nickname);
        userController.update(userDTO);

        session.invalidate();
%>
<script>
    alert("[회원 정보 수정 성공] 다시 로그인해주세요.");
    location.href = "/user/login.jsp";
</script>
<%
    }
%>
</body>
</html>
