<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="model.UserDTO" %>
<%@ page import="controller.UserGradeRequestController" %>
<%@ page import="model.UserGradeRequestDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-21
  Time: 오전 11:42
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
    if (login == null) {
        response.sendRedirect("../index.jsp");
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserGradeRequestController userGradeRequestController = new UserGradeRequestController(connectionMaker);

    UserGradeRequestDTO userGradeRequestDTO = new UserGradeRequestDTO();
    userGradeRequestDTO.setUser_id(login.getId());
    userGradeRequestDTO.setRequest_grade(Integer.parseInt(request.getParameter("request_grade")));

    userGradeRequestController.insert(userGradeRequestDTO);
%>
<script>
    Swal.fire({
        icon: "success",
        text: "정상적으로 신청되었습니다.",
    }).then(() => {
        location.href = "/user/mypage.jsp";
    });
</script>
</body>
</html>
