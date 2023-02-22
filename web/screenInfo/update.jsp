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
            <form action="/screenInfo/update_logic.jsp?id=${screenInfo.id}" method="post">
                <div class="modal-body">
                    <table class="col-12">
                        <tr>
                            <td class="col-2">시작 시간</td>
                            <td>
                                <input type="datetime-local" name="start_time" class="form-control"/>
                            </td>
                        </tr>
                        <tr>
                            <td>종료 시간</td>
                            <td>
                                <input type="datetime-local" name="end_time" class="form-control"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-success btn-sm" data-bs-dismiss="modal">수정</button>
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>