let checkForm = function () {
    let name = $("#name").val();
    let country = $("#country").val();
    let autonomous_district = $("#autonomous_district").val();
    let detailed_address = $("#detailed_address").val();
    let phone = $("#phone").val();

    /* 극장 이름 */
    if (name.trim() == '' || name == null) {
        $("#input-for-name").append($(document.createElement("p")).text("ⓘ 극장 이름은 비워둘 수 없습니다.").attr("class", "form-text text-danger fw-light fs-6").attr("id", "info-for-name"));
        $("#info-for-name").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-name").remove();
        }, 1500);
        return false;
    }
    if (name.length > 25) {
        $("#input-for-name").append($(document.createElement("p")).text("ⓘ 25자 이내로 입력해주세요.").attr("class", "form-text text-danger fw-light fs-6").attr("id", "info-for-name"));
        $("#info-for-name").fadeOut(1500);
        setTimeout(() => {
            $("#info-for-name").remove();
        }, 1500);
        return false;
    }

    /* 시도 */
    if (country == '' || country == null) {
        return showInputInfoForTable("tr-for-address", "info-for-address", "ⓘ 시도를 선택해주세요.");
    }

    /* 자치구 */
    if (autonomous_district.trim() == '' || autonomous_district == null) {
        return showInputInfoForTable("tr-for-address", "info-for-address", "ⓘ 자치구는 비워둘 수 없습니다.");
    }
    if (autonomous_district.length > 10) {
        return showInputInfoForTable("tr-for-address", "info-for-address", "ⓘ 자치구: 10자 이내로 입력해주세요.");
    }

    /* 상세 주소 */
    if (detailed_address.trim() == '' || detailed_address == null) {
        return showInputInfoForTable("tr-for-address", "info-for-address", "ⓘ 상세 주소는 비워둘 수 없습니다.");
    }
    if (detailed_address.length > 35) {
        return showInputInfoForTable("tr-for-address", "info-for-address", "ⓘ 상세 주소: 35자 이내로 입력해주세요.");
    }

    /* 전화 번호 */
    if (phone.trim() == '' || phone == null) {
        return showInputInfoForTable("tr-for-phone", "info-for-phone", "ⓘ 전화 번호는 비워둘 수 없습니다.");
    }
    if (!(/^(?:\d{2}|\d{3}|\d{4})-(?:\d{3}|\d{4})-\d{4}$/.test(phone))) {
        if(!(/^\d{4}-\d{4}$/.test(phone))) {
            return showInputInfoForTable("tr-for-phone", "info-for-phone", "ⓘ 전화 번호 형식을 확인해주세요.");
        }
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
}

let showInputInfoForTable = (trId, infoId, infoText) => {
    let tr = $(document.createElement("tr")).append($(document.createElement("td")));
    let td = $(document.createElement("td")).text(infoText).attr("class", "form-text text-danger fw-light").attr("colspan", "3");
    tr.append(td).attr("id", infoId);
    $("#" + trId).after(tr);
    $("#" + infoId).fadeOut(1500);
    setTimeout(() => {
        $("#" + infoId).remove();
    }, 1500);
    return false;
}