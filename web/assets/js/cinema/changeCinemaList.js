let changeCinema = (country, num) => {
    // 시도 메뉴 class 초기화
    $("#country-list").children().attr("class", "nav-item me-1 rounded-top p-2").attr("style", "background-color: #d9d9d9; color: #0d0d0d");

    // 선택된 메뉴 class 변경
    let id = "#item-" + country;
    $(id).attr("class", "nav-item me-1 rounded-top p-2").attr("style", "background-color: #023E73; color: #FFFFFF");
    let data = {
        "country": country,
    };

    $.ajax({
        url: "/cinema/printCinemaByCountry",
        type: "get",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            let cinemaList = JSON.parse(response.list);
            printCinemaList(cinemaList, num);
        },
    });
}

let printCinemaList = (list, num) => {
    let ul = $("#cinema-list").empty();
    if (list.length == 0) {
        let li = $(document.createElement("li")).text("영화관이 존재하지 않습니다.");
        ul.append(li);
    } else {
        list.forEach(cinema => {
            let li = $(document.createElement("li"));
            let link = $(document.createElement("a")).attr("class", "nav-link p-1 link-dark bg-light m-1 rounded").attr("style", "font-size: 90%").text(cinema.name).attr("id", "cinema-" + cinema.id);
            if (num == 0) {
                link.attr("href", "/cinema/printOne.jsp?id=" + cinema.id);
            } else {
                link.attr("onclick", "changeScreenInfo(" + cinema.id + ")");
            }
            li.append(link);
            ul.append(li);
        });
    }
}