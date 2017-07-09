$(function () {
    $("#edit-profile").submit(function (event) {
        event.preventDefault();

        let fullName = $("#edit-fullname").val();
        let state = $("#edit-state").val();
        let city = $("#edit-city").val();
        let street = $("#edit-street").val();
        let zipCode = $("#edit-zipcode").val();
        let birthYear = $("#edit-birth-year").val();

        $.post("/UpdateProfile", {
            "fullname": fullName,
            "state": state,
            "city": city,
            "street": street,
            "zipcode": zipCode,
            "birthyear": birthYear
        })
            .done(function (response) {
                if (response.status === "success") {
                    $("#closeButton").click();
                    location.reload();

                } else {
                    alert("Unable to update profile!");

                }

            })
            .fail(function () {
                alert("Unable to update profile!");

            });

    })
});