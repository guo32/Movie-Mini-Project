let auth = () => {
    let username = $('#username').val();
    let password = $('#password').val();
    let data = {
        "username" : username,
        "password" : password,
    };

    $.ajax({
        url: "/user/auth",
        type: "post",
        data: data,
        success: function (message) {
            let response = JSON.parse(message);
            if (response.status == "success") {
                location.href = "../index.jsp";
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "로그인 실패",
                    text: "아이디 또는 비밀번호가 일치하지 않습니다.",
                });
            }
        },
    });
}