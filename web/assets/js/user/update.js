let checkForm = () => {
    let newPassword = $("#newPassword").val();
    let oldPassword = $("#oldPassword").val();
    let nickname = $("#nickname").val();

    if (newPassword.trim() != '' || newPassword.trim() != null) {
        if (!(newPassword.includes("!") || newPassword.includes("@")) || newPassword.length < 6 || newPassword > 12) {
            $("#div-for-new-password").append($(document.createElement("p")).text("ⓘ 6자 이상 12자 이하의 특수문자(!, @)가 포함된 문장이어야 합니다.").attr("class", "text-danger fw-light").attr("style", "font-size: 85%").attr("id", "info-for-new-password"));
            $("#info-for-new-password").fadeOut(1500);
            setTimeout(() => {
                $("#info-for-new-password").remove();
            }, 1500);
            return false;
        }
    }

    if (oldPassword.trim() == '') {
        $("#div-for-old-password").append($(document.createElement("p")).text("ⓘ 기존 비밀번호를 입력해주세요.").attr("class", "text-danger fw-light").attr("style", "font-size: 85%").attr("id", "info-for-old-password"));
        $("#info-for-old-password").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-old-password").remove();
        }, 1500);
        return false;
    }

    if (nickname.trim() == '') {
        $("#div-for-nickname").append($(document.createElement("p")).text("ⓘ 닉네임은 비워둘 수 없습니다.").attr("class", "text-danger fw-light").attr("style", "font-size: 85%").attr("id", "info-for-nickname"));
        $("#info-for-nickname").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-nickname").remove();
        }, 1500);
        return false;
    }

    return true;
}

let submitForm = () => {
    if (checkForm()) {
        if (checkDoubleSubmit()) {
            return;
        } else {
            $("#update-form").submit();
        }
    }
};