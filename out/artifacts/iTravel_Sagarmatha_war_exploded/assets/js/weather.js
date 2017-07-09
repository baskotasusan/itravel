$(function () {
    $.get("http://api.openweathermap.org/data/2.5/weather", {
        "q": $("#initialAddress").val(),
        "appid": "5039f6a0d872c67ff627191515c6304e"
    }).done(updateSingleWeather);

    $.get("http://api.openweathermap.org/data/2.5/forecast", {
        "q": $("#initialAddress").val(),
        "appid": "5039f6a0d872c67ff627191515c6304e"
    }).done(updateFiveDaysForecast);

    $("#forecastheading").text("5 Days Forecast of " + $("#initialAddress").val());

    function getDay(date) {
        let realDate = new Date(date);
        var dayOfWeek = realDate.getDay();
        return isNaN(dayOfWeek) ? realDate.getDate() : ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][dayOfWeek];
    }

    function updateSingleWeather(response) {
        $("#locationInfo").text(response.name);
        $("#degree").html(parseInt(response.main.temp - 273) + " &#8451;");
        $("#weather-image").append(
            $("<img />", {
                "src": "http://openweathermap.org/img/w/" + response.weather[0].icon + ".png",
                "title": response.weather[0].description,
                "alt": response.weather[0].main
            })
        );
        $("#type").text(response.weather[0].main);

    }

    function updateFiveDaysForecast(response) {
        $("#forecast").removeClass("hidden");

        for (let i = 0; i < response.list.length; i++) {
            let singleWeather = "<div class='col-xs-2 singleweather'>";
            date = response.list[i].dt_txt.split(" ");
            singleWeather += "<p class='text-left'>" + getDay(date[0]) + "</p>";
            singleWeather += "<p><span class='glyphicon glyphicon-time'></span> " + date[1] + "</p>";
            singleWeather += "<p><img src='http://openweathermap.org/img/w/" + response.list[i].weather[0].icon + ".png'/>" + parseInt(response.list[i].main.temp - 273) + " &#8451;</p>";
            singleWeather += "</div>";
            $("#forecastdata").append(singleWeather);
        }

    }

    $("#searchBtn").click(function (event) {
        event.preventDefault();
        $("#forecastdata").empty();
        $("#weather-image").empty();

        $.get("http://api.openweathermap.org/data/2.5/weather", {
            "q": $("#address").val(),
            "appid": "5039f6a0d872c67ff627191515c6304e"
        }).done(updateSingleWeather);

        $.get("http://api.openweathermap.org/data/2.5/forecast", {
            "q": $("#address").val(),
            "appid": "5039f6a0d872c67ff627191515c6304e"
        }).done(updateFiveDaysForecast);

        $("#forecastheading").text("5 Days Forecast of " + $("#address").val());
    })
});