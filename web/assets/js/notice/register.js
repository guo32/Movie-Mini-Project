let checkForm = () => {
    let title = $("#title").val();
    let category = $("#category").val();

    if (title.trim() == '' || title == null) {
        $("#input-for-title").append($(document.createElement("p")).text("ⓘ 제목은 비워둘 수 없습니다.").attr("class", "form-text text-danger fw-light fs-6").attr("id", "info-for-title"));
        $("#info-for-title").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-title").remove();
        }, 1500);
        return false;
    }

    if (title.length > 30) {
        $("#input-for-title").append($(document.createElement("p")).text("ⓘ 30자 이내로 입력해주세요.").attr("class", "form-text text-danger fw-light fs-6").attr("id", "info-for-title"));
        $("#info-for-title").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-title").remove();
        }, 1500);
        return false;
    }

    if (category == '') {
        $("#input-for-category").append($(document.createElement("p")).text("ⓘ 카테고리를 선택해주세요.").attr("class", "form-text text-danger fw-light").attr("id", "info-for-category"));
        $("#info-for-category").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-category").remove();
        }, 1500);
        return false;
    }

    return true;
}

let submitForm = (flag) => {
    if(flag) {
        return;
    } else {
        if (checkForm()) {
            $("#register-form").submit();
        }
    }
}