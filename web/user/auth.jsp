<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-13
  Time: 오후 3:15
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
    UserController controller = new UserController(connectionMaker);

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    UserDTO userDTO = controller.auth(username, password);

    String address;

    if (userDTO == null) {
        address = "/index.jsp";
    } else {
        address = "/film/printList.jsp";
        session.setAttribute("login", userDTO);
    }

    response.sendRedirect(address);
%>
</body>
</html>
