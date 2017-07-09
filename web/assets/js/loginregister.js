$(function () {
    $("#loginBtn").click(function (event) {
        $.post("/Authenticate", {
            "email": $("#email").val(),
            "password": $("#password").val()
        }).done(function (response) {
            if (response.status === "success") {
                window.location.replace("/Home");

            } else {
                $("#loginMessage").val(response.message).removeClass("hidden");

            }

        }).fail(function () {
            $("#loginMessage").val("Oops, something went wrong!").removeClass("hidden");

        });
    });


    $("#registerform").submit(function (e) {

        $("#registerMessage").addClass("hidden");

        if($("#registerpassword").val() !== $("#confirmpassword").val()){
            $("#registerMessage").val("Password did not match").removeClass("hidden");
            e.preventDefault();
        }

        // if ($("#registerpassword").val() !== $("#confirmpassword")) {
        //     $("#registerMessage").val("Two Passwords Do Not Match!").removeClass("hidden");
        //     e.preventDefault();
        //
        // }

        // $.post("/RegisterUser", {
        //     "fullname": $('[name=fullname]').val(),
        //     "gender": $('[name=gender]').val(),
        //     "state": $('[name=state]').val(),
        //     "city": $('[name=city]').val(),
        //     "street": $('[name=street]').val(),
        //     "zipcode": $('[name=zipcode]').val(),
        //     "birthyear": $('[name=birthyear]').val(),
        //     "email": $('[name=registeremail]').val(),
        //     "password": $('[name=registerpassword]').val()
        //
        // }).done(function (response) {
        //     if (response.status === "success") {
        //         window.location.replace("/home.jsp");
        //
        //     } else {
        //         $("#registerMessage").val(response.message).removeClass("hidden");
        //
        //     }
        //
        // }).fail(function () {
        //     $("#registerMessage").val("Oops, something went wrong!").removeClass("hidden");
        //
        // });

    });
});