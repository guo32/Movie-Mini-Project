function checkForm() {
    let username = $("#username").val();
    let password = $("#password").val();
    let nickname = $("#nickname").val();

    if (username == '' || username == null) {
        $("#div-for-username").append($(document.createElement("p")).text("ⓘ 아이디는 비워둘 수 없습니다.").attr("class", "text-danger fw-light").attr("style", "font-size: 85%").attr("id", "info-for-username"));
        $("#info-for-username").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-username").remove();
        }, 1500);
        return false;
    }
    if (!(password.includes("!") || password.includes("@")) || password.length < 6 || password > 12) {
        /*Swal.fire({
            icon: "warning",
            title: "올바르지 않은 비밀번호 형식",
            html: "<p>올바르지 않은 비밀번호 형식입니다.</p><p class='fw-light fs-6 text-secondary'>6자 이상 12자 이하의 특수문자(!, @)가 포함된 문장이어야 합니다.</p>",
        });*/
        $("#div-for-password").append($(document.createElement("p")).text("ⓘ 6자 이상 12자 이하의 특수문자(!, @)가 포함된 문장이어야 합니다.").attr("class", "text-danger fw-light").attr("style", "font-size: 85%").attr("id", "info-for-password"));
        $("#info-for-password").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-password").remove();
        }, 1500);
        return false;
    }
    if (nickname == '' || nickname == null) {
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
            $("#register-form").submit();
        }
    }
};