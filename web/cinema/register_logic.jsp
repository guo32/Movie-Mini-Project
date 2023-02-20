<%@ page import="model.UserDTO" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="controller.TheaterController" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-20
  Time: 오후 9:04
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
        response.sendRedirect("/film/printList.jsp");
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    CinemaController cinemaController = new CinemaController(connectionMaker);

    String realFolder = request.getSession().getServletContext().getRealPath("/resource/img");
    int maxSize = 10 * 1024 * 1024;
    String encType = "UTF-8";

    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
    String name = multi.getParameter("name");
    String country = multi.getParameter("country");
    String autonomous_district = multi.getParameter("autonomous_district");
    String detailed_address = multi.getParameter("detailed_address");
    String phone = multi.getParameter("phone");
    String[] theaterNames = multi.getParameterValues("theater_name");
    String[] theaterCapacities = multi.getParameterValues("theater_capacity");

    Enumeration file = multi.getFileNames();
    String fname = (String) file.nextElement();
    String filename = multi.getFilesystemName(fname);

    CinemaDTO cinemaDTO = new CinemaDTO();
    cinemaDTO.setName(name);
    cinemaDTO.setCountry(country);
    cinemaDTO.setAutonomous_district(autonomous_district);
    cinemaDTO.setDetailed_address(detailed_address);
    cinemaDTO.setPhone(phone);
    cinemaDTO.setImage(filename);

    cinemaController.insert(cinemaDTO);

    int cinemaId = cinemaController.selectTheNewest();

    TheaterController theaterController = new TheaterController(connectionMaker);
    for (int i = 0; i < theaterNames.length; i++) {
        TheaterDTO theaterDTO = new TheaterDTO();
        theaterDTO.setCinema_id(cinemaId);
        theaterDTO.setName(theaterNames[i]);
        theaterDTO.setCapacity(Integer.parseInt(theaterCapacities[i]));
        theaterController.insert(theaterDTO);
    }

    response.sendRedirect("../cinema/printOne.jsp?id=" + cinemaId);
%>
</body>
</html>
