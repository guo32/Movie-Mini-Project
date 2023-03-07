<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="updateUserForManager${user.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title fs-5" id="exampleModalLabel">회원 관리</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/user/update_user_grade.jsp?id=${user.id}" method="post">
                    <table class="table table-borderless">
                        <tr>
                            <td>아이디</td>
                            <td>
                                <input type="text" value="${user.username}" class="form-control" disabled />
                            </td>
                        </tr>
                        <tr>
                            <td>닉네임</td>
                            <td>
                                <input type="text" value="${user.nickname}" class="form-control" disabled />
                            </td>
                        </tr>
                        <tr>
                            <td>등급</td>
                            <td>
                                <select class="form-control" name="grade" id="grade">
                                    <option value="1" <c:if test="${user.grade == 1}">selected</c:if>>일반 회원</option>
                                    <option value="2" <c:if test="${user.grade == 2}">selected</c:if>>전문 평론가</option>
                                    <option value="3" <c:if test="${user.grade == 3}">selected</c:if>>관리자</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="text-center">
                                    <button type="button" class="btn btn-outline-danger btn-sm" onclick="checkDelete(${user.id})">강제 탈퇴</button>
                                    <button type="submit" class="btn btn-outline-success btn-sm">정보 변경</button>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>