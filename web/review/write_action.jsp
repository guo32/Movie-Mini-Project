<%@ page import="model.UserDTO" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-15
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

    UserDTO login = (UserDTO) session.getAttribute("login");
    if (login == null) {
        response.sendRedirect("../user/login.jsp");
    }

    int film_id = Integer.parseInt(request.getParameter("film_id"));
    int rating = Integer.parseInt(request.getParameter("rating"));
    String review_content = request.getParameter("review_content");

    ReviewDTO reviewDTO = new ReviewDTO();
    reviewDTO.setWriter_id(login.getId());
    reviewDTO.setFilm_id(film_id);
    reviewDTO.setRating(rating);
    if (review_content != null) {
        if (!review_content.equals("")) {
            reviewDTO.setReview_content(review_content);
        }
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ReviewController reviewController = new ReviewController(connectionMaker);
    reviewController.insert(reviewDTO);

    response.sendRedirect("../film/printOne.jsp?id=" + film_id);
%>
</body>
</html>
