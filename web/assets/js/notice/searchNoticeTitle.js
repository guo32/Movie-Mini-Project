let search = () => {
    let text = $("#notice-search").val();
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
            url: "/notice/search",
            type: "get",
            data: data,
            success: (message) => {
                let response = JSON.parse(message);
                let noticeList = JSON.parse(response.list);
                printList(noticeList);
            },
        });
    }
}

let printList = (list) => {
    let result = $("#wrap-for-list").empty();
    if (list.length == 0) {
        result.append($(document.createElement("div")).text("검색 결과가 없습니다.").attr("class", "my-2"));
    } else {
        let div = $(document.createElement("div"));

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
        div.append(table);

        result.append(div);
    }
}