<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.ScreenInformationController" %>
<%@ page import="model.ScreenInformationDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-22
  Time: 오후 2:09
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

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    String start_time_string = formatter.format(dateFormat.parse(request.getParameter("start_time")));
    Timestamp start_time = Timestamp.valueOf(start_time_string);
    String end_time_string = formatter.format(dateFormat.parse(request.getParameter("end_time")));
    Timestamp end_time = Timestamp.valueOf(end_time_string);

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ScreenInformationController screenInformationController = new ScreenInformationController(connectionMaker);

    ScreenInformationDTO screenInformationDTO = screenInformationController.selectById(id);
    screenInformationDTO.setStart_time(start_time);
    screenInformationDTO.setEnd_time(end_time);
    System.out.println(screenInformationDTO.toString());

    screenInformationController.update(screenInformationDTO);

    response.sendRedirect("/screenInfo/edit.jsp");
%>
</body>
</html>
