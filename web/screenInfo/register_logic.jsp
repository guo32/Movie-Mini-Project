<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.ScreenInformationController" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.ScreenInformationDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-22
  Time: 오전 10:31
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
        response.sendRedirect("/screenInfo/printList.jsp");
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ScreenInformationController screenInformationController = new ScreenInformationController(connectionMaker);

    int cinema_id = Integer.parseInt(request.getParameter("cinema_id"));
    int theater_id = Integer.parseInt(request.getParameter("theater_id"));
    int film_id = Integer.parseInt(request.getParameter("film_id"));
    String start_time_string = formatter.format(dateFormat.parse(request.getParameter("start_time")));
    Timestamp start_time = Timestamp.valueOf(start_time_string);
    String end_time_string = formatter.format(dateFormat.parse(request.getParameter("end_time")));
    Timestamp end_time = Timestamp.valueOf(end_time_string);

    ScreenInformationDTO screenInformationDTO = new ScreenInformationDTO();
    screenInformationDTO.setCinema_id(cinema_id);
    screenInformationDTO.setTheater_id(theater_id);
    screenInformationDTO.setFilm_id(film_id);
    screenInformationDTO.setStart_time(start_time);
    screenInformationDTO.setEnd_time(end_time);

    screenInformationController.insert(screenInformationDTO);

    response.sendRedirect("/screenInfo/printList.jsp");
%>
</body>
</html>
