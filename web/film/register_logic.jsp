<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.UserDTO" %>
<%@ page import="model.FilmDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-17
  Time: 오후 8:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.Enumeration" %>
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
    FilmController filmController = new FilmController(connectionMaker);

    // String realFolder = application.getRealPath("/resource/img");
    String realFolder = request.getSession().getServletContext().getRealPath("/resource/img");
    int maxSize = 10 * 1024 * 1024;
    String encType = "UTF-8";

    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
    String title = multi.getParameter("title");
    String director = multi.getParameter("director");
    String rating = multi.getParameter("rating");
    String description = multi.getParameter("description");

    Enumeration file = multi.getFileNames();
    String fname = (String) file.nextElement();
    String filename = multi.getFilesystemName(fname);

    FilmDTO filmDTO = new FilmDTO();
    filmDTO.setTitle(title);
    filmDTO.setDirector(director);
    filmDTO.setRating(rating);
    filmDTO.setDescription(description);
    filmDTO.setPoster(filename);

    filmController.insert(filmDTO);

    response.sendRedirect("/film/printList.jsp");
%>
</body>
</html>
