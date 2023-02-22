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

    ArrayList<UserGradeRequestDTO> userGradeRequestList = userGradeRequestController.selectByUserId(login.getId());
    pageContext.setAttribute("requestList", userGradeRequestList);
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
                                <th>신청 등급</th>
                                <th>신청일</th>
                                <th>상태</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="request" items="${requestList}">
                                <tr>
                                    <td>
                                        <c:if test="${request.request_grade == 2}">전문 평론가</c:if>
                                        <c:if test="${request.request_grade == 3}">관리자</c:if>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${request.request_date}" pattern="YY/MM/dd HH:mm"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${request.status == 'N'}">
                                                <div class="badge bg-warning fw-light">미처리</div>
                                            </c:when>
                                            <c:when test="${request.status == 'Y'}">
                                                <div class="badge bg-success fw-light">수락</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="badge bg-dark fw-light">거절</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${request.status == 'N'}">
                                            <button type="button" class="badge bg-danger fw-light border border-0" onclick="if(confirm('취소하시겠습니까?')) {
                                                location.href = '/user/delete_request_grade.jsp?id=' + ${request.id};
                                            }">취소</button>
                                        </c:if>
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