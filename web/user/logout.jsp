<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-14
  Time: 오후 3:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    session.invalidate();
    response.sendRedirect("/index.jsp");
%>
</body>
</html>
