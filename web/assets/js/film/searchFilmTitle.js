let search = () => {
    let text = $('#film-search').val();
    if (text.trim() == '') {
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
            url: "/film/search",
            type: "get",
            data: data,
            success: (message) => {
                let response = JSON.parse(message);
                let filmList = JSON.parse(response.list);
                printList(filmList);
            },
        });
    }
}

let printList = (list) => {
    let result = $('#film-list').empty();
    if (list.length == 0) {
        let div = $(document.createElement("div")).text("검색 결과가 없습니다.");
        result.append(div);
    } else {
        list.forEach(film => {
            let allOuterWrapDiv = $(document.createElement("div")).attr("class", "row mb-2");
            let outerWrapDiv = $(document.createElement("div")).attr("class", "col mb-6");
            let innerWrapDiv = $(document.createElement("div")).attr("class", "row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-m d-250 position-relative");

            /* 기본 정보 */
            let infoDiv = $(document.createElement("div")).attr("class", "col p-4 d-flex flex-column position-static");
            let title = $(document.createElement("h3")).attr("class", "mb-1").text(film.title);
            let description = $(document.createElement("p")).attr("class", "card-text mb-auto").text(film.description);
            let filmLink = $(document.createElement("a")).attr("class", "stretched-link").attr("href", "/film/printOne.jsp?id=" + film.id).text("상세보기");
            infoDiv.append(title).append(description).append(filmLink);

            /* 이미지 */
            let imageDiv = $(document.createElement("div")).attr("class", "col-auto d-none d-lg-block bg-success").attr("style", "width: 150px;");
            if (film.poster == null) {
                let rect = $(document.createElement("div")).attr("style", "width: 100%; height: 100%; background-color: #0d0d0d;").append($(document.createElement("p")).attr("style", "position: relative; top: 43%; left: 25%; color: #f2f2f2").text("No image"));
                imageDiv.append(rect);
            } else {
                let img = $(document.createElement("img")).attr("src", "../resource/img/" + film.poster).attr("width", "100%");
                imageDiv.append(img);
            }

            innerWrapDiv.append(infoDiv).append(imageDiv);
            outerWrapDiv.append(innerWrapDiv);
            allOuterWrapDiv.append(outerWrapDiv);

            result.append(allOuterWrapDiv);
        });
    }
}