let search = () => {
    let text = $('#cinema-search').val();
    if (text == '') {
        Swal.fire({
            icon: 'warning',
            text: '입력된 내용이 없습니다.',
        });
        return;
    } else {
        let data = {
            "text": text,
        };

        $.ajax({
            url: "/cinema/search",
            type: "get",
            data: data,
            success: (message) => {
                let response = JSON.parse(message);
                let cinemaList = JSON.parse(response.list);
                printList(cinemaList);
            },
        });
    }
}

let printList = (list) => {
    let result = $("#cinema-list-in-page");
    if (list.length == 0) {
        Swal.fire({
            icon: 'warning',
            text: '검색 결과가 없습니다.',
        });
    } else {
        result.empty();
        list.forEach(cinema => {
            let allOuterWrapDiv = $(document.createElement("div")).attr("class", "row");
            let outerWrapDiv = $(document.createElement("div")).attr("class", "col mb-6");
            let wrapDiv = $(document.createElement("div")).attr("class", "row g-0 border rounded overflow-hidden flex-md-row mb-3 shadow-sm h-m d-250 position-relative");
            let contentDiv = $(document.createElement("div")).attr("class", "col p-3 d-flex flex-column position-static");
            let innerDiv = $(document.createElement("div")).attr("class", "row col-12");
            let b = $(document.createElement("b")).attr("class", "col-auto fs-5 mx-2 mt-1 text-dark").text(cinema.name);
            let p = $(document.createElement("p"));
            p.attr("class", "col card-text mb-auto text-muted mt-1").text(cinema.country + " " + cinema.autonomous_district + " " + cinema.detailed_address + " | " + cinema.phone);
            let a = $(document.createElement("a")).attr("href", "/cinema/printOne.jsp?id=" + cinema.id).attr("class", "stretched-link");
            innerDiv.append(b).append(p).append(a);
            contentDiv.append(innerDiv);
            wrapDiv.append(contentDiv);
            outerWrapDiv.append(wrapDiv);
            allOuterWrapDiv.append(outerWrapDiv);

            result.append(allOuterWrapDiv);
        });
    }
}