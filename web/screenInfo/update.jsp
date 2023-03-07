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
%>
<div class="modal fade" id="screenInfoUpdate${screenInfo.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title fs-5">상영 시간 편집</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/screenInfo/update_logic.jsp?id=${screenInfo.id}" method="post" id="update-form">
                <div class="modal-body">
                    <table class="col-12">
                        <tr id="tr-for-start-time">
                            <td class="col-2">시작 시간</td>
                            <td>
                                <input type="datetime-local" id="start_time" name="start_time" class="form-control" value="${screenInfo.start_time}"/>
                            </td>
                        </tr>
                        <tr id="tr-for-end-time">
                            <td>종료 시간</td>
                            <td>
                                <input type="datetime-local" id="end_time" name="end_time" class="form-control" value="${screenInfo.end_time}"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <div class="btn btn-success btn-sm" onclick="submitForm()">수정</div>
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>