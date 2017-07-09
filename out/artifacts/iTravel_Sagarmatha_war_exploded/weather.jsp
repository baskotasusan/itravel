<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>iTravel - Weather</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css"/>
    <!-- Weather Stylesheets -->
    <link rel="stylesheet" type="text/css" href="assets/css/weather.css"/>

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="assets/js/weather.js"></script>
</head>
<body>

<div class="container">

    <div class="page-header">
        <h3><a href="/Home"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>&nbsp; Home</a></h3>
        <h1>Weather Service
            <small>for iTravel</small>
        </h1>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="form-inline">
                    <input type="hidden" id="initialAddress" value="${loggedInUser.city}, ${loggedInUser.state}"/>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" class="form-control" id="address" placeholder="Enter City or ZipCode...">
                    </div>
                    <button id="searchBtn" type="button" class="btn btn-default">Search</button>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <h3 id="city"><span
                                class="glyphicon glyphicon-globe"></span> <span id="locationInfo"></span>
                        </h3>
                    </div>
                    <div class="col-sm-1">
                        <div id="weather-image"></div>
                    </div>
                    <div class="col-sm-11">
                        <h2 id="degree"></h2>
                        <h4>
                            <div id="type" class="text-capitalize"></div>
                        </h4>
                    </div>
                </div>

                <div class="bottom-part row">
                    <div class="panel panel-default hidden" id="forecast">
                        <div id="forecastheading" class="panel-heading"></div>
                    </div>
                </div>
                <div class="col-xs-12" id="forecastdata"></div>
            </div>
        </div>
    </div>

</div>

</body>
</html>