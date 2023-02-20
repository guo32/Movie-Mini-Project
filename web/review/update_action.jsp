<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-20
  Time: 오후 2:11
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

    int id = Integer.parseInt(request.getParameter("id"));
    int film_id = Integer.parseInt(request.getParameter("film_id"));

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    ReviewController reviewController = new ReviewController(connectionMaker);

    int rating = Integer.parseInt(request.getParameter("rating"));
    String review_content = request.getParameter("review_content");

    ReviewDTO reviewDTO = reviewController.selectById(id);
    reviewDTO.setFilm_id(film_id);
    reviewDTO.setRating(rating);
    if (review_content != null) {
        if (!review_content.equals("")) {
            reviewDTO.setReview_content(review_content);
        }
    }

    reviewController.update(reviewDTO);
%>
<script>
    /* 부모 창 새로 고침 */
    opener.parent.location.reload();
    window.close();
</script>
</body>
</html>
