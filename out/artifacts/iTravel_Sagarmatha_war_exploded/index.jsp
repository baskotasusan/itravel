<%
    if(session.getAttribute("loggedInUser") != null) {
        response.sendRedirect("Home");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>iTravel - Sagarmatha</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Login Script File -->
    <script src="assets/js/loginregister.js"></script>

</head>
<body>
<div id="wrapper">
    <div class="container">
        <div class="col-md-6 col-xs-12"></div>
        <div class="col-md-6 col-xs-12 login down">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Log In</a></li>
                <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Sign Up</a></li>
            </ul>



            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="home">
                    <img src="assets/images/logo1.png" alt="logo">
                    <h1>Welcome to iTravel</h1>
                    <input type="text" id="loginMessage" class="hidden" disabled>
                    <input id="email" type="text" name="email" placeholder="Email" pattern="[a-z0-9._+\]+@[a-z0-9.\-]+\.[a-z]{2,3}"><br>
                    <input id="password" type="password" name="password" placeholder="Password"><br>
                    <a id="loginBtn">Sign In</a>

                </div>
                <div role="tabpanel" class="tab-pane" id="profile">
                    <form id="registerform" action="/RegisterUser" method="post" role="form">
                        <div class="form-group">
                            <input type="text" id="registerMessage" class="form-control hidden" disabled>
                        </div>
                        <div class="form-group">
                            <input type="text" name="fullname" id="register-full-name" tabindex="1"
                                   class="form-control" placeholder="Full Name" required>
                        </div>
                        <div class="form-group">
                            <input type="email" name="registeremail" id="register-email" tabindex="3"
                                   class="form-control" placeholder="Email Address" value=""  pattern="[a-z0-9._+\]+@[a-z0-9.\-]+\.[a-z]{2,3}" required>
                        </div>
                        <div class="form-group">
                            <input type="password" name="registerpassword" id="registerpassword" tabindex="4"
                                   class="form-control" placeholder="Password"  pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
                        </div>
                        <div class="form-group">
                            <input type="password" name="confirmpassword"
                                   id="confirmpassword" tabindex="5" class="form-control"
                                   placeholder="Confirm Password" required>
                        </div>
                        <div class="form-group form-inline">
                            <select class="form-control" tabindex="6" id="register-state"
                                    name="state">
                                <option value="AL">Alabama</option>
                                <option value="AK">Alaska</option>
                                <option value="AZ">Arizona</option>
                                <option value="AR">Arkansas</option>
                                <option value="CA">California</option>
                                <option value="CO">Colorado</option>
                                <option value="CT">Connecticut</option>
                                <option value="DE">Delaware</option>
                                <option value="DC">District Of Columbia</option>
                                <option value="FL">Florida</option>
                                <option value="GA">Georgia</option>
                                <option value="HI">Hawaii</option>
                                <option value="ID">Idaho</option>
                                <option value="IL">Illinois</option>
                                <option value="IN">Indiana</option>
                                <option value="IA" selected>Iowa</option>
                                <option value="KS">Kansas</option>
                                <option value="KY">Kentucky</option>
                                <option value="LA">Louisiana</option>
                                <option value="ME">Maine</option>
                                <option value="MD">Maryland</option>
                                <option value="MA">Massachusetts</option>
                                <option value="MI">Michigan</option>
                                <option value="MN">Minnesota</option>
                                <option value="MS">Mississippi</option>
                                <option value="MO">Missouri</option>
                                <option value="MT">Montana</option>
                                <option value="NE">Nebraska</option>
                                <option value="NV">Nevada</option>
                                <option value="NH">New Hampshire</option>
                                <option value="NJ">New Jersey</option>
                                <option value="NM">New Mexico</option>
                                <option value="NY">New York</option>
                                <option value="NC">North Carolina</option>
                                <option value="ND">North Dakota</option>
                                <option value="OH">Ohio</option>
                                <option value="OK">Oklahoma</option>
                                <option value="OR">Oregon</option>
                                <option value="PA">Pennsylvania</option>
                                <option value="RI">Rhode Island</option>
                                <option value="SC">South Carolina</option>
                                <option value="SD">South Dakota</option>
                                <option value="TN">Tennessee</option>
                                <option value="TX">Texas</option>
                                <option value="UT">Utah</option>
                                <option value="VT">Vermont</option>
                                <option value="VA">Virginia</option>
                                <option value="WA">Washington</option>
                                <option value="WV">West Virginia</option>
                                <option value="WI">Wisconsin</option>
                                <option value="WY">Wyoming</option>
                            </select>
                            <input type="text" name="city" id="register-city" tabindex="7" class="form-control" placeholder="City" value="" required>
                            <input type="text" name="street" id="register-street" tabindex="8" class="form-control" placeholder="Street" value="" required>
                            <input type="text" name="zipcode" pattern="\d{5}" title="Zip code must contain exactly 5 digits" id="register-zip" tabindex="8" class="form-control" placeholder="Zip" value="" required>
                        </div>
                        <div class="form-group">
                            <label for="register-dob">Birth Year</label>
                            <input type="text" name="birthyear"
                                   id="register-dob" pattern="\d{4}" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <div class="radio-inline">
                                <label><input type="radio" tabindex="10" name="gender" value="Male" required checked>Male</label>
                            </div>
                            <div class="radio-inline">
                                <label><input type="radio" tabindex="11" name="gender" value="Female" required>Female</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="submit" name="register-submit" id="registerBtn"
                                           tabindex="12" class="form-control btn btn-register"
                                           value="Register Now">
                                </div>
                            </div>
                        </div>
                    </form>


                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>