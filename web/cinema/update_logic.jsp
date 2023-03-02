<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.CinemaController" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="model.CinemaDTO" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.TheaterDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-21
  Time: 오후 5:40
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

    int id = Integer.parseInt(request.getParameter("id"));

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
    String[] theaterIds = multi.getParameterValues("theater_id");
    String[] theaterNames = multi.getParameterValues("theater_name");
    String[] theaterCapacities = multi.getParameterValues("theater_capacity");

    Enumeration file = multi.getFileNames();
    String fname = (String) file.nextElement();
    String filename = multi.getFilesystemName(fname);

    CinemaDTO cinemaDTO = cinemaController.selectById(id);

    cinemaDTO.setName(name);
    cinemaDTO.setCountry(country);
    cinemaDTO.setAutonomous_district(autonomous_district);
    cinemaDTO.setDetailed_address(detailed_address);
    cinemaDTO.setPhone(phone);
    if (filename != null) {
        cinemaDTO.setImage(filename);
    }

    cinemaController.update(cinemaDTO);

    TheaterController theaterController = new TheaterController(connectionMaker);
    ArrayList<TheaterDTO> theaterList = theaterController.selectByCinemaId(id);

    TheaterDTO theaterDTO = null;
    if (theaterIds != null) {
        for (int i = 0; i < theaterIds.length; i++) {
            if (theaterIds[i].equals("")) {
                if (theaterNames[i].equals("") || theaterCapacities[i].equals("")) {
                    continue;
                } else {
                    theaterDTO = new TheaterDTO();
                    theaterDTO.setCinema_id(id);
                    theaterDTO.setName(theaterNames[i]);
                    theaterDTO.setCapacity(Integer.parseInt(theaterCapacities[i]));

                    theaterController.insert(theaterDTO);
                }
            } else {
                if (theaterNames[i].equals("") || theaterCapacities[i].equals("")) {
                    continue;
                } else {
                    theaterDTO = theaterController.selectById(Integer.parseInt(theaterIds[i]));
                    theaterList.remove(theaterDTO);
                    theaterDTO.setName(theaterNames[i]);
                    theaterDTO.setCapacity(Integer.parseInt(theaterCapacities[i]));

                    theaterController.update(theaterDTO);
                }
            }
        }
    }

    for (TheaterDTO theater : theaterList) {
        theaterController.delete(theater.getId());
    }

    response.sendRedirect("/cinema/printOne.jsp?id=" + id);
%>
</body>
</html>
