<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.UserGradeRequestController" %>
<%@ page import="model.UserGradeRequestDTO" %>
<%@ page import="controller.UserController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-21
  Time: 오후 3:28
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
    UserDTO login = (UserDTO) session.getAttribute("login");
    if (login == null || login.getGrade() != 3) {
        response.sendRedirect("../index.jsp");
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserGradeRequestController userGradeRequestController = new UserGradeRequestController(connectionMaker);
    UserController userController = new UserController(connectionMaker);

    int edit = Integer.parseInt(request.getParameter("edit"));
    int id = Integer.parseInt(request.getParameter("id"));
    UserGradeRequestDTO userGradeRequestDTO = userGradeRequestController.selectById(id);
    UserDTO userDTO = userController.selectById(userGradeRequestDTO.getUser_id());

    if (userDTO != null) {
        if (edit == 1) {
            // 수락
            userGradeRequestDTO.setStatus("Y");
            userDTO.setGrade(userGradeRequestDTO.getRequest_grade());
            userController.updateGrade(userDTO);
        } else {
            // 거절
            userGradeRequestDTO.setStatus("R");
        }

        userGradeRequestController.update(userGradeRequestDTO);
    }
%>
<script>
    alert("정상적으로 처리되었습니다.");
    location.href = "/user/printList.jsp";
</script>
</body>
</html>
