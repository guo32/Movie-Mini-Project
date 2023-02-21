<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.UserGradeRequestController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.UserGradeRequestDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-21
  Time: 오후 1:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setCharacterEncoding("utf-8");
    UserGradeRequestController userGradeRequestController = new UserGradeRequestController(connectionMaker);

    ArrayList<UserGradeRequestDTO> userGradeRequestList = userGradeRequestController.selectByStatus("N");
    pageContext.setAttribute("requestList", userGradeRequestList);
    pageContext.setAttribute("userController", userController);
%>
<div class="modal fade" id="requestGradeList" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title fs-5" id="exampleModalLabel">등업 신청 현황</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <c:choose>
                    <c:when test="${empty requestList}">
                        신청 내역이 없습니다.
                    </c:when>
                    <c:otherwise>
                        <table class="table table-striped text-center">
                            <thead>
                            <tr>
                                <th>아이디</th>
                                <th>신청 등급</th>
                                <th>신청일</th>
                                <th>상태</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="request" items="${requestList}">
                                <tr>
                                    <td>${userController.selectById(request.user_id).username}</td>
                                    <td>
                                        <c:if test="${request.request_grade == 2}">전문 평론가</c:if>
                                        <c:if test="${request.request_grade == 3}">관리자</c:if>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${request.request_date}" pattern="YY/MM/dd HH:mm"/>
                                    </td>
                                    <td>
                                        <div class="badge bg-warning fw-light">미처리</div>
                                    </td>
                                    <td>
                                        <button type="button" class="badge bg-success fw-light border border-0" onclick="location.href='/user/update_request_grade.jsp?edit=1&id=${request.id}'">수락</button>
                                        <button type="button" class="badge bg-danger fw-light border border-0" onclick="location.href='/user/update_request_grade.jsp?edit=0&id=${request.id}'">거절</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>