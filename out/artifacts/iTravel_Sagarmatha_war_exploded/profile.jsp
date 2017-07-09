<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>iTravel - Profile</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!--Google Map Api--->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCd-ipzIa-0P6g9jycRCEfwPIXttyC5024"
            async defer></script>

    <!-- Script file to manipulate users posts. -->
    <script src="assets/js/profileposts.js"></script>

    <!-- Profile Page Script Codes -->
    <script src="assets/js/profile.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>
</head>
<body id="profile-page">

<div class="modal fade" id="edit-profile" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="closeButton"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Profile</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="edit-Profile-form">
                    <div class="form-group">
                        <label for="edit-fullname" class="col-sm-2 control-label">Full Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit-fullname"
                                   placeholder="Full Name" value="${loggedInUser.fullName}" tabindex="1" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="edit-email"
                                   placeholder="Email" value="${loggedInUser.email}" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-password" class="col-sm-2 control-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="edit-password"
                                   placeholder="Password" value="${loggedInUser.password}" disabled>
                        </div>
                    </div>

                    <div class="form-group form-inline">
                        <label for="edit-state" class="col-sm-2 control-label">State</label>
                        <div class="col-sm-10">
                            <select id="edit-state" class="form-control" tabindex="2"
                                    name="register-state">
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
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-city" class="col-sm-2 control-label">City</label>
                        <div class="col-sm-10">
                            <input type="text" name="register-city" id="edit-city" tabindex="3"
                                   class="form-control" placeholder="City" value="${loggedInUser.city}" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-street" class="col-sm-2 control-label">Street</label>
                        <div class="col-sm-10">
                            <input type="text" name="register-street" id="edit-street" tabindex="4"
                                   class="form-control" placeholder="Street" value="${loggedInUser.street}" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-zipcode" class="col-sm-2 control-label">Zip Code</label>
                        <div class="col-sm-10">
                            <input type="text" name="register-zipcode" id="edit-zipcode" tabindex="5"
                                   class="form-control" placeholder="Zip Code" value="${loggedInUser.zipCode}"
                                   pattern="[0-9]{5}" title="Zip Code should be 5 digits" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-birth-year" class="col-sm-2 control-label">Birth Year</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit-birth-year"
                                   placeholder="YYYY" pattern="[0-9]{4}"
                                   title="Enter your 4 digit birth year" tabindex="5" value="${loggedInUser.birthYear}"
                                   required>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary" form="edit-Profile-form">Update</button>
            </div>
        </div>
    </div>
</div>

<div id="profile">
    <div class="container">
        <div class="row">
            <header>
                <div class="col-md-12 col-xs-12 back">
                    <a href="/Home"><span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span></a>
                    <p>@<span>${loggedInUser.fullName}</span></p>


                </div>
            </header>
            <div id="profileInfo">
                <div class="col-md-12 col-xs-12">
                    <div class="profileImage">
                        <img src="http://lorempixel.com/200/200/">
                        <p id="profileName" class="prof-pic">${loggedInUser.fullName}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-xs-4" id="profilePageInfo">
                <div class="panel panel-primary">
                    <div class="panel-body bg-success">
                        <h3>
                            ${loggedInUser.fullName}
                            <button class="pull-right btn-sm btn-link" data-toggle="modal"
                                    data-target="#edit-profile"><span
                                    class="glyphicon glyphicon-edit" aria-hidden="true"></span> &nbsp;Edit
                            </button>
                        </h3>
                    </div>
                    <ul class="list-group">
                        <li class="list-group-item list-group-item-info">Address: ${loggedInUser.address}</li>
                        <li class="list-group-item list-group-item-warning">Gender: ${loggedInUser.gender}</li>
                        <li class="list-group-item list-group-item-danger">Birth Year: ${loggedInUser.birthYear} A.D.
                        </li>
                        <li class="list-group-item list-group-item-info">Email: ${loggedInUser.email}</li>
                    </ul>
                </div>
            </div>
            <div class="col-md-8 col-xs-8">
                <div class="newPost" id="statusUpdate">
                    <p><em>Share your travelling experience with others...</em></p>
                    <textarea id="postcontent" rows="5" placeholder="where are you visiting??"></textarea>
                    <a id="submitpost" class="btn btn-primary">Post</a>
                </div>

                <div id="allposts">

                    <c:forEach var="singlePost" items="${requestScope.posts}">
                        <div class="posts" id="completePost${singlePost.id}">
                            <div class="box">
                                <div class="header">
                                    <div class="userProfileImage">
                                        <img src="http://lorempixel.com/100/100/">

                                    </div>
                                    <div class="username">
                                        <p id="userName">${singlePost.postedBy}</p>
                                        <div class="postTime">
                                            <p>Posted on ${singlePost.dateTime} <a name="${singlePost.location}"
                                                                                   class="loadMap"><span
                                                    class="glyphicon glyphicon-globe"
                                                    aria-hidden="true"></span> ${singlePost.location}</a></p>
                                        </div>

                                    </div>
                                    <div title="${singlePost.id}" class="delete">
                                        <a><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></a>
                                    </div>
                                </div>
                                <div class="userPost">
                                    <p>${singlePost.content}</p>
                                </div>
                                <hr/>

                                <div class="footer">

                                    <c:choose>
                                        <c:when test="${singlePost.likedByMe.equalsIgnoreCase('true')}">
                                            <a id="${singlePost.id}" class="likeBtn redcolor"><span
                                                    class="glyphicon glyphicon-heart"
                                                    aria-hidden="true"></span>
                                                <em>Unlike</em>&nbsp;<span
                                                        class="badge"
                                                        id="likeBadge${singlePost.id}">${singlePost.totalLikes}</span></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a id="${singlePost.id}" class="likeBtn"><span
                                                    class="glyphicon glyphicon-heart"
                                                    aria-hidden="true"></span>
                                                <em>Like</em>&nbsp;<span
                                                        class="badge"
                                                        id="likeBadge${singlePost.id}">${singlePost.totalLikes}</span></a>
                                        </c:otherwise>
                                    </c:choose>

                                    <a name="${singlePost.id}" class="viewshowcomments"><span
                                            class="glyphicon glyphicon-comment"
                                            aria-hidden="true"></span>
                                        Comment</a>
                                </div>
                                <div class="comments hidden" id="comments${singlePost.id}">

                                    <div id="commentsBox${singlePost.id}">

                                    </div>

                                    <div id="addComment">

                                        <img src="http://lorempixel.com/100/100/" class="userProfileImage">
                                        <textarea rows="2" cols="50" id="commentText${singlePost.id}" class="comment"
                                                  placeholder="jabsdhasbdyi"></textarea><a
                                            name="${singlePost.id}"
                                            class="btn btn-primary postComment">Comment</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </c:forEach>
                </div>
                <%--<div class="posts">--%>
                <%--<div class="box">--%>
                <%--<div class="header">--%>
                <%--<div class="userProfileImage">--%>
                <%--<img src="assets/images/kristina_rose88.jpg">--%>

                <%--</div>--%>
                <%--<div class="username">--%>
                <%--<p id="userName">zlhvlhsa</p>--%>
                <%--<div class="postTime">--%>
                <%--<p>18 hours ago</p>--%>
                <%--</div>--%>

                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="userPost">--%>
                <%--<div class="userPostImage">--%>
                <%--<img src="assets/images/bhaktapur.jpg" alt="" class="img-responsive" width="100%"--%>
                <%--height="100%">--%>
                <%--</div>--%>
                <%--<p>gascjgsa shdvyasitd shvdyasvdxhvasyv vsyayd gavsdtyavsd hvsdtavsd hvsdas vtyvas hvysvad--%>
                <%--hvyvsd hvvd vuvsd hsdvsd hkgsfvkgsa hdctyasfd hgdvtysafd hvdkytsavd sdcytasvd gcdtyasvdg--%>
                <%--gtsdv </p>--%>
                <%--</div>--%>
                <%--<hr/>--%>

                <%--<div class="footer">--%>
                <%--<a href=""><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>--%>
                <%--Like&nbsp;<span class="badge"></span></a>--%>
                <%--<a href="#"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span> Comment</a>--%>
                <%--</div>--%>
                <%--<div class="comments">--%>
                <%--<div id="abc">--%>
                <%--<div class="userInfo">--%>
                <%--<div class="userImage">--%>
                <%--<img src="assets/images/kristina_rose88.jpg" class="userProfileImage">--%>
                <%--</div>--%>

                <%--<div class="postedDetails">--%>
                <%--<p>Kristina</p>--%>
                <%--<div class="postTime">--%>
                <%--<p>18 hrs</p>--%>
                <%--</div>--%>
                <%--</div>--%>

                <%--</div>--%>
                <%--<p id="postedComments">Nice Status</p>--%>

                <%--</div>--%>
                <%--<div id="addComment">--%>

                <%--<img src="assets/images/kristina_rose88.jpg" class="userProfileImage">--%>
                <%--<textarea rows="2" cols="50" id="comment" placeholder="jabsdhasbdyi"></textarea><a--%>
                <%--href="" class="btn btn-primary">Comment</a>--%>
                <%--</div>--%>
                <%--</div>--%>

                <%--</div>--%>
                <%--</div>--%>

            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="mapModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div id="map" class="center-block">

                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>