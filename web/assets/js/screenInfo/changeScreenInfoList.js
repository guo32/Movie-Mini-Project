let changeScreenInfo = (id) => {
    $($("#cinema-list").children()).children().attr("class", "nav-link p-1 link-dark bg-light m-1 rounded");
    $("#cinema-" + id).attr("class", "nav-link p-1 link-dark bg-warning m-1 rounded");
    let data = {
        "id": id,
    };
    $.ajax({
        url: "/screenInfo/printScreenInfoByCinemaId",
        type: "get",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            let cinemaName = response.cinema;
            let list = JSON.parse(response.list);
            let date_list = JSON.parse(response.dateList);
            printScreenInfoList(cinemaName, list, date_list);
        },
    });
}

let printScreenInfoList = (cinemaName, list, date_list) => {
    let result = $("#screen-info-wrap").empty();
    // result.append($(document.createElement("div")).text(cinemaName));
    if (list.length == 0) {
        result.append($(document.createElement("div")).text("상영 정보가 존재하지 않습니다."));
    } else {
        date_list.forEach(date => {
            let week = ['일', '월', '화', '수', '목', '금', '토']
            let allOuterWrap = $(document.createElement("div")).attr("class", "col");
            let outerWrap = $(document.createElement("div")).attr("class", "card mb-4 rounded-3 shadow-sm");
            let cardHeader = $(document.createElement("div")).attr("class", "card-header py-3");
            cardHeader.append($(document.createElement("h6")).text(date).attr("class", "text-secondary"));
            cardHeader.append($(document.createElement("h4")).text(week[new Date(date).getDay()]).attr("class", "my-0 fw-normal"));
            outerWrap.append(cardHeader);

            let cardBody = $(document.createElement("div")).attr("class", "card-body");
            list.forEach(screenInfo => {
                if (date == screenInfo.date) {
                    let table = $(document.createElement("table")).attr("class", "table table-sm");
                    let thead = $(document.createElement("thead")).attr("class", "table-secondary text-center");
                    let trForThead = $(document.createElement("tr"));
                    let tdForThead = $(document.createElement("td"));
                    let film = $(document.createElement("span")).text(screenInfo.film).on("click", () => {
                        location.href = "../film/printOne.jsp?id=" + screenInfo.filmId;
                    });
                    let cinema = $(document.createElement("span")).text(screenInfo.cinema).attr("class", "badge rounded-pill text-bg-success fw-lighter mx-1");
                    let theater = $(document.createElement("span")).text(screenInfo.theater).attr("class", "badge rounded-pill text-bg-warning fw-lighter");

                    tdForThead.append(film);

                    //outer.append(film).append(time);
                    trForThead.append(tdForThead);
                    thead.append(trForThead);

                    let tbody = $(document.createElement("tbody"));
                    let trForTbody = $(document.createElement("tr"));
                    let tdForTbody = $(document.createElement("td")).text(screenInfo.time + " " + screenInfo.capacity + "석").append(cinema).append(theater);

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