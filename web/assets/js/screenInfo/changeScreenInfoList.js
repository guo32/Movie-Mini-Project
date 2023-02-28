let changeScreenInfo = (id) => {
    let data = {
        "id": id,
    };
    $.ajax({
        url: "/screenInfo/printScreenInfoByCinemaId",
        type: "get",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            let list = JSON.parse(response.list);
            printScreenInfoList(list);
        },
    });
}

let printScreenInfoList = (list) => {
    let result = $("#screen-info-wrap").empty();
    if (list.length == 0) {
        result.append($(document.createElement("div")).text("상영 정보가 존재하지 않습니다."));
    } else {
        list.forEach(screenInfo => {
            let outer = $(document.createElement("div"));
            let film = $(document.createElement("div")).text(screenInfo.film);
            let time = $(document.createElement("div")).text(screenInfo.time);
            outer.append(film).append(time);
            result.append(outer);
        });
    }
}