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
            let date_list = JSON.parse(response.dateList);
            printScreenInfoList(list, date_list);
        },
    });
}

let printScreenInfoList = (list, date_list) => {
    let result = $("#screen-info-wrap").empty();
    if (list.length == 0) {
        result.append($(document.createElement("div")).text("상영 정보가 존재하지 않습니다."));
    } else {
        date_list.forEach(date => {
            let allOuterWrap = $(document.createElement("div")).attr("class", "col");
            let outerWrap = $(document.createElement("div")).attr("class", "card mb-4 rounded-3 shadow-sm");
            let cardHeader = $(document.createElement("div")).attr("class", "card-header py-3");
            cardHeader.append($(document.createElement("h6")).text(date).attr("class", "text-secondary"));
            outerWrap.append(cardHeader);

            let cardBody = $(document.createElement("div")).attr("class", "card-body");
            list.forEach(screenInfo => {
                if (date == screenInfo.date) {
                    let table = $(document.createElement("table")).attr("class", "table table-sm");
                    let thead = $(document.createElement("thead")).attr("class", "table-secondary text-center");
                    let trForThead = $(document.createElement("tr"));
                    let tdForThead = $(document.createElement("td"));
                    let film = $(document.createElement("span")).text(screenInfo.film);
                    let cinema = $(document.createElement("span")).text(screenInfo.cinema).attr("class", "badge rounded-pill text-bg-success fw-lighter");
                    let theater = $(document.createElement("span")).text(screenInfo.theater).attr("class", "badge rounded-pill text-bg-warning fw-lighter");

                    tdForThead.append(film).append(cinema).append(theater);

                    //outer.append(film).append(time);
                    trForThead.append(tdForThead);
                    thead.append(trForThead);

                    let tbody = $(document.createElement("tbody"));
                    let trForTbody = $(document.createElement("tr"));
                    let tdForTbody = $(document.createElement("td")).text(screenInfo.time + " " + screenInfo.capacity + "석");

                    trForTbody.append(tdForTbody);
                    tbody.append(trForTbody);

                    table.append(thead).append(tbody);
                    cardBody.append(table);
                }
            });
            outerWrap.append(cardBody);
            allOuterWrap.append(outerWrap);
            result.append(allOuterWrap);
        });
    }
}