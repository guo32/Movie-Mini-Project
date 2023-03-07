<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.NoticeController" %>
<%@ page import="model.NoticeDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-03-07
  Time: 오전 10:35
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
    NoticeController noticeController = new NoticeController(connectionMaker);

    NoticeDTO noticeDTO = noticeController.selectById(id);
    if (noticeDTO == null) {
        response.sendRedirect("../assets/error_page.jsp");
    }

    assert noticeDTO != null;
    noticeDTO.setTitle(request.getParameter("title"));
    noticeDTO.setCategory_id(Integer.parseInt(request.getParameter("category")));
    noticeDTO.setContent(request.getParameter("content"));

    noticeController.update(noticeDTO);

    response.sendRedirect("/notice/printOne.jsp?id=" + id);
%>
</body>
</html>
