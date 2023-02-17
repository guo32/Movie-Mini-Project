<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.FilmController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-17
  Time: 오후 4:50
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
    FilmController filmController = new FilmController(connectionMaker);

    int id = Integer.parseInt(request.getParameter("id"));

    filmController.delete(id);

    response.sendRedirect("/film/printList.jsp");
%>
</body>
</html>
