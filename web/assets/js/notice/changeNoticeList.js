let changeList = (id) => {
    let data = {
        "id": id,
    };

    $.ajax({
        url: "/notice/changeListByCategory",
        type: "get",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            let list = JSON.parse(response.list);
            changeListContent(id, list);
        }
    });
}

let changeListContent = (id, list) => {
    $($("#ul-for-items").children()).attr("style", "background-color: #031059; color: #FFFFFF;");
    $("#item-" + id).attr("style", "background-color: #e2e3e5; color: #212529");

    let result = $("#div-for-list").empty();
    if (list.length == 0) {
        result.append($(document.createElement("p")).text("아직 등록된 글이 없습니다.").attr("class", "mt-2"));
    } else {
        let table = $(document.createElement("table")).attr("class", "table");
        // thead 처리
        let thead = $(document.createElement("thead")).attr("class", "table-secondary");
        let tr = $(document.createElement("tr"));
        let theadList = ["번호", "카테고리", "제목", "작성자", "작성일"];

        theadList.forEach(item => {
            tr.append($(document.createElement("th")).text(item));
        })

        thead.append(tr);
        table.append(thead);

        // tbody 처리
        let tbody = $(document.createElement("tbody"));
        list.forEach(n => {
            let tr = $(document.createElement("tr")).attr("onclick", "location.href='/notice/printOne.jsp?id=" + n.id + "'");
            tr.append($(document.createElement("td")).text(n.id));
            tr.append($(document.createElement("td")).text(n.category));
            tr.append($(document.createElement("td")).text(n.title));
            tr.append($(document.createElement("td")).text(n.writer));
            tr.append($(document.createElement("td")).text(n.entry_date));

            tbody.append(tr);
        });
        table.append(tbody);

        result.append(table);
    }
}