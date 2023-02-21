<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserDTO" %>
<%
    UserDTO login = (UserDTO) session.getAttribute("login");
    pageContext.setAttribute("login", login);
%>
<nav class="py-2 border-bottom rounded-bottom" style="background-color: #898C2B">
    <div class="container d-flex flex-wrap">
        <ul class="nav me-auto"></ul>
        <c:choose>
            <c:when test="${login == null}">
                <ul class="nav">
                    <li class="nav-item mx-2">
                        <a href="/user/login.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">로그인</a>
                    </li>
                    <li>|</li>
                    <li class="nav-item mx-2">
                        <a href="/user/register.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">회원가입</a>
                    </li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul class="nav">
                    <li class="nav-item mx-2">
                        <a href="/user/mypage.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">마이페이지</a>
                    </li>
                    <li>|</li>
                    <li class="nav-item mx-2">
                        <a href="/user/logout.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">로그아웃</a>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
    <a class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none" href="../index.jsp">
        Movie<br/>Management
    </a>
    <ul class="nav nav-pills">
        <c:if test="${login.grade == 3}">
            <li class="nav-item mx-1">
                <a href="/user/printList.jsp" class="nav-link link-dark">회원</a>
            </li>
        </c:if>
        <li class="nav-item mx-1">
            <a href="/film/printList.jsp" class="nav-link link-dark">영화</a>
        </li>
        <li class="nav-item mx-1">
            <a href="/cinema/printList.jsp" class="nav-link link-dark">극장</a>
        </li>
        <li class="nav-item mx-1">
            <a href="/screenInfo/printList.jsp" class="nav-link link-dark">상영 정보</a>
        </li>
    </ul>
</header>