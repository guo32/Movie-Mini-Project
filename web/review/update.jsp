<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MySqlConnectionMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-02-20
  Time: 오후 1:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="updateReviewForm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title fs-5" id="exampleModalLabel">리뷰 수정</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="../review/update_action.jsp?id=${review.id}&film_id=${film.id}" method="post">
                <div class="modal-body col-12">
                    <table class="m-3 col-10">
                        <tr>
                            <td>
                                <select class="form-select" id="rating" name="rating">
                                    <option value="1" <c:if test="${review.rating == 1}">selected</c:if>>★☆☆☆☆
                                    </option>
                                    <option value="2" <c:if test="${review.rating == 2}">selected</c:if>>★★☆☆☆
                                    </option>
                                    <option value="3" <c:if test="${review.rating == 3}">selected</c:if>>★★★☆☆
                                    </option>
                                    <option value="4" <c:if test="${review.rating == 4}">selected</c:if>>★★★★☆
                                    </option>
                                    <option value="5" <c:if test="${review.rating == 5}">selected</c:if>>★★★★★
                                    </option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <c:if test="${login.grade == 2}"><textarea class="form-control mt-2"
                                                                           id="review_content"
                                                                           name="review_content"
                                                                           placeholder="평론을 작성해주세요.">${review.review_content}</textarea></c:if>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success btn-sm" data-bs-dismiss="modal">수정</button>
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
