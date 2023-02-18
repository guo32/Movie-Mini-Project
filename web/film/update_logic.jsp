<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-18
  Time: 오후 2:33
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
    FilmController filmController = new FilmController(connectionMaker);

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

    FilmDTO filmDTO = filmController.selectById(id);
    filmDTO.setTitle(title);
    filmDTO.setDirector(director);
    filmDTO.setRating(rating);
    filmDTO.setDescription(description);
    if (filename != null) {
        filmDTO.setPoster(filename);
    }

    filmController.update(filmDTO);

    response.sendRedirect("/film/printOne.jsp?id=" + id);
%>
</body>
</html>
