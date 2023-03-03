let changeCountry = (country) => {
    let data = {
        "country" : country,
    };

    $.ajax({
        url: "/screenInfo/changeAutonomousDistrictByCountry",
        type: "get",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            let autonomousDistrictList = JSON.parse(response.list);
            changeAutonomousDistrictOption(autonomousDistrictList);
        }
    });
}

let changeAutonomousDistrictOption = (list) => {
    let selectForAutonomousDistrict = $("#autonomous_district");
    selectForAutonomousDistrict.empty();
    selectForAutonomousDistrict.append($(document.createElement("option")).attr("value", "-1").text("자치구 선택"));

    list.forEach(data => {
        let option = $(document.createElement("option")).attr("value", data.autonomousDistrict).text(data.autonomousDistrict + " (" + data.count + ")");
        selectForAutonomousDistrict.append(option);
    });
}

let changeAutonomousDistrict = (autonomousDistrict) => {
    let country = $("#country").val();
    let data = {
        "country": country,
        "autonomousDistrict": autonomousDistrict,
    };
    $.ajax({
        url: "/screenInfo/changeCinemaByAutonomousDistrict",
        type: "get",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            let cinemaList = JSON.parse(response.list);
            // console.log(cinemaList);
            changeCinemaOption(cinemaList);
        },
    });
}

let changeCinemaOption = (list) => {
    let selectForCinema = $("#cinema_id");
    selectForCinema.empty();
    selectForCinema.append($(document.createElement("option")).attr("value", "-1").text("영화관 선택"));

    list.forEach(cinema => {
        let option = $(document.createElement("option")).attr("value", cinema.cinemaId).text(cinema.cinemaName);
        selectForCinema.append(option);
    });
}

let changeCinema = (cinemaId) => {
    let data = {
        "cinemaId": cinemaId,
    };
    $.ajax({
        url: "/screenInfo/changeTheaterByCinema",
        type: "get",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            let list = JSON.parse(response.list);

            console.log(list);
            changeTheaterOption(list);
        },
    });
}

let changeTheaterOption = (list) => {
    let selectForTheater = $("#theater_id");
    selectForTheater.empty();
    if (list.length == 0) {
        selectForTheater.append($(document.createElement("option")).attr("value", "-1").text("해당 극장에는 상영관이 존재하지 않습니다."));
    } else {
        selectForTheater.append($(document.createElement("option")).attr("value", "-1").text("상영관 선택"));

        list.forEach(theater => {
            let option = $(document.createElement("option")).attr("value", theater.theaterId).text(theater.theaterName + " (" + theater.capacity + "석)");
            selectForTheater.append(option);
        });
    }
}