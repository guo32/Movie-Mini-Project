let checkForm = () => {
    let start_time = $("#start_time").val();
    let end_time = $("#end_time").val();

    /* << 시작 시간 처리 >>
    * 1. 공백
    * 2. 현재 일자, 시간보다 빠름
    * */
    if (start_time == "") {
        return showInputInfoForTable("tr-for-start-time", "info-for-start-time", "ⓘ 시작하는 시간을 입력해주세요.");
    }

    // 현재 시간
    let now = new Date();

    let temp = start_time.split("T");
    let start_date_arr = temp[0].split("-");
    let start_time_arr = temp[1].split(":");
    start_time = new Date(Number(start_date_arr[0]), Number(start_date_arr[1]) - 1, Number(start_date_arr[2]), Number(start_time_arr[0]), Number(start_time_arr[1]));

    if (start_time < now) {
        return showInputInfoForTable("tr-for-start-time", "info-for-start-time", "ⓘ 시작하는 시간이 유효하지 않습니다.");
    }

    /* << 종료 시간 처리 >>
    * 1. 공백
    * 2. 시작 시간보다 빠름
    * */
    if (end_time == "") {
        return showInputInfoForTable("tr-for-end-time", "info-for-end-time", "ⓘ 끝나는 시간을 입력해주세요.");
    }

    temp = end_time.split("T");
    let end_date_arr = temp[0].split("-");
    let end_time_arr = temp[1].split(":");
    end_time = new Date(Number(end_date_arr[0]), Number(end_date_arr[1]) - 1, Number(end_date_arr[2]), Number(end_time_arr[0]), Number(end_time_arr[1]));

    if (start_time > end_time) {
        return showInputInfoForTable("tr-for-end-time", "info-for-end-time", "ⓘ 끝나는 시간은 시작하는 시간보다 빠를 수 없습니다.");
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