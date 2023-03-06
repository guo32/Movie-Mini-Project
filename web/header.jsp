<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserDTO" %>
<%
    UserDTO login = (UserDTO) session.getAttribute("login");
    pageContext.setAttribute("login", login);
%>
<nav class="py-2 border-bottom rounded-bottom" style="background-color: #031059">
    <div class="container d-flex flex-wrap">
        <ul class="nav me-auto"></ul>
        <c:choose>
            <c:when test="${login == null}">
                <ul class="nav">
                    <li class="nav-item mx-2">
                        <a href="/user/login.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">로그인</a>
                    </li>
                    <li style="color: #d9d9d9">|</li>
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
                    <li style="color: #d9d9d9">|</li>
                    <li class="nav-item mx-2">
                        <a href="/user/logout.jsp" class="link-light text-decoration-none" style="font-size: 0.9em">로그아웃</a>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
<header class="p-3 text-bg-r-light border-bottom border-secondary mb-3">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                <%--<span style="color: #023E73; margin-right: 10px">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
                      <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
                      <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
                    </svg>
                </span>--%>
                <svg class="bi me-2" width="55" height="50" role="img" aria-label="Bootstrap">
                    <image href="/resource/img/sunfishiconblue.svg" height="100%"/>
                </svg>
                <span style="color: #023E73">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-left-fill" viewBox="0 0 16 16">
                      <path d="m3.86 8.753 5.482 4.796c.646.566 1.658.106 1.658-.753V3.204a1 1 0 0 0-1.659-.753l-5.48 4.796a1 1 0 0 0 0 1.506z"/>
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-left-fill" viewBox="0 0 16 16">
                      <path d="m3.86 8.753 5.482 4.796c.646.566 1.658.106 1.658-.753V3.204a1 1 0 0 0-1.659-.753l-5.48 4.796a1 1 0 0 0 0 1.506z"/>
                    </svg>
                </span>
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0 mx-4">
                <li><a href="/" class="nav-link px-3 text-secondary fw-bold">Home</a></li>
                <li><a href="/film/printList.jsp" class="nav-link px-3 text-dark fw-bold">영화</a></li>
                <li><a href="/cinema/printList.jsp" class="nav-link px-3 text-dark fw-bold">극장</a></li>
                <li><a href="/screenInfo/printList.jsp" class="nav-link px-3 text-dark fw-bold">상영 정보</a></li>
                <c:if test="${login.grade == 3}">
                    <li class="nav-item mx-1">
                        <a href="/user/printList.jsp" class="nav-link px-2 text-dark fw-bold">회원</a>
                    </li>
                </c:if>
            </ul>

            <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
                <input type="search" class="form-control form-control-dark text-bg-light" placeholder="Search..." aria-label="Search">
            </form>
        </div>
    </div>
</header>