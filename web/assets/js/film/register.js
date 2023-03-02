function checkForm() {
    let title = $("#title").val();
    let director = $("#director").val();
    let rating = $("#rating").val();
    let description = $("#description").val();

    /* 영화 제목 */
    if (title == '' || title == null) {
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

    /* 감독 */
    if (director == '' || director == null) {
        return showInputInfo("input-for-director", "info-for-director", "ⓘ 감독은 비워둘 수 없습니다.");
    }
    if (director.length > 20) {
        return showInputInfo("input-for-director", "info-for-director", "ⓘ 20자 이내로 입력해주세요.");
    }

    /* 등급 */
    if (rating == '' || rating == null) {
        return showInputInfo("input-for-rating", "info-for-rating", "ⓘ 등급을 선택해주세요.");
    }

    /* 줄거리 */
    if (description == '' || description == null) {
        return showInputInfo("input-for-description", "info-for-description", "ⓘ 줄거리는 비워둘 수 없습니다.");
    }
    if (description.length > 21000) {
        return showInputInfo("input-for-description", "info-for-description", "ⓘ 길이가 너무 깁니다.");
    }

    return true;
}

let submitForm = () => {
    let result = checkForm();
    if (result == true) {
        $("#register-form").submit();
    }
}

let showInputInfo = (inputId, infoId, infoText) => {
    $("#" + inputId).append($(document.createElement("p")).text(infoText).attr("class", "form-text text-danger fw-light").attr("id", infoId));
    $("#" + infoId).fadeOut(1500);
    setTimeout(() => {
        $("#" + infoId).remove();
    }, 1500);

    return false;
}