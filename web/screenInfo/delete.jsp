<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.ScreenInformationController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-22
  Time: 오후 1:26
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
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ScreenInformationController screenInformationController = new ScreenInformationController(connectionMaker);

    screenInformationController.delete(id);
%>
<script>
    alert("정상적으로 삭제되었습니다.");
    location.href = "/screenInfo/edit.jsp";
</script>
</body>
</html>
