<%@ page import="controller.ReviewController" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-15
  Time: 오후 4:44
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

    int id = Integer.parseInt(request.getParameter("id"));
    int film_id = Integer.parseInt(request.getParameter("film_id"));

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ReviewController reviewController = new ReviewController(connectionMaker);

    reviewController.delete(id);

    response.sendRedirect("../film/printOne.jsp?id=" + film_id);
%>
</body>
</html>
