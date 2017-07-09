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
    <title>iTravel - Home</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!--Google Map Api--->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCd-ipzIa-0P6g9jycRCEfwPIXttyC5024"
            async defer></script>

    <!-- Script file to manipulate users posts. -->
    <script src="assets/js/homeposts.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="assets/js/bootstrap.min.js"></script>
</head>
<body id="main-page">
<div id="home-page">
    <div class="container-fluid">
        <header>
            <div class="col-md-4 col-xs-12 home">
                <a href="/Home"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>&nbsp; Home</a>
            </div>
            <div class="col-md-4 col-xs-12 logo">
                <h1>iTravel</h1>
            </div>
            <div class="col-md-4 col-xs-12 profile">
                <a href="/Profile">Profile&nbsp; <span class="glyphicon glyphicon-user" aria-hidden="true"></span></a>

            </div>
        </header>
        <div id="content">
            <div class="container">
                <div class="row">
                    <aside class="col-md-2 sidebar-outer">
                        <div class="sidebar">
                            <div class="info">
                                <a href="/Profile">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/user.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>${loggedInUser.fullName}</p>
                                        </div>
                                    </div>
                                </a>
                                <a href="/weather.jsp">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/weather.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Weather Service</p>
                                        </div>
                                    </div>
                                </a>
                                <a href="/Logout">
                                    <div class="profileShortcut">
                                        <div class="userImage">
                                            <img src="assets/images/logout.png" alt="">
                                        </div>
                                        <div class="name">
                                            <p>Logout</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </aside>
                    <section class="col-md-10 col-md-offset-2">
                        <div class="newPost" id="statusUpdate">
                            <p><em>Share your travelling experience with others...</em></p>
                            <textarea id="postcontent" rows="5" placeholder="where are you visiting??"></textarea>
                            <a id="submitpost" class="btn btn-primary">Post</a>
                        </div>
                        <div id="allposts">
                            <c:forEach var="singlePost" items="${requestScope.posts}">
                                <div class="posts">
                                    <div class="box">
                                        <div class="header">
                                            <div class="userProfileImage">
                                                <img src="http://lorempixel.com/100/100/">

                                            </div>
                                            <div class="username">
                                                <p id="userName">${singlePost.postedBy}</p>
                                                <div class="postTime">
                                                    <p>Posted on ${singlePost.dateTime} <a name="${singlePost.location}" class="loadMap"><span
                                                            class="glyphicon glyphicon-globe"
                                                            aria-hidden="true"></span> ${singlePost.location}</a></p>
                                                </div>
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
                                                <textarea rows="2" cols="50" id="commentText${singlePost.id}"
                                                          class="comment"
                                                          placeholder="jabsdhasbdyi"></textarea><a
                                                    name="${singlePost.id}"
                                                    class="btn btn-primary postComment">Comment</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </c:forEach>

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
                            <%--<p>gascjgsa shdvyasitd shvdyasvdxhvasyv vsyayd gavsdtyavsd hvsdtavsd hvsdas--%>
                            <%--vtyvas hvysvad hvyvsd hvvd vuvsd hsdvsd hkgsfvkgsa hdctyasfd hgdvtysafd--%>
                            <%--hvdkytsavd sdcytasvd gcdtyasvdg gtsdv </p>--%>
                            <%--</div>--%>
                            <%--<hr/>--%>

                            <%--<div class="footer">--%>
                            <%--<a href=""><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>--%>
                            <%--Like&nbsp;<span class="badge">5</span></a>--%>
                            <%--<a href="#"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span>--%>
                            <%--Comment</a>--%>
                            <%--</div>--%>
                            <%--<div class="comments">--%>
                            <%--<div id="abc">--%>
                            <%--<div class="userInfo">--%>
                            <%--<div class="userImage">--%>
                            <%--<img src="assets/images/kristina_rose88.jpg"--%>
                            <%--class="userProfileImage">--%>
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
                            <%--<textarea rows="2" cols="50" id="comment"--%>
                            <%--placeholder="jabsdhasbdyi"></textarea><a href=""--%>
                            <%--class="btn btn-primary">Comment</a>--%>
                            <%--</div>--%>
                            <%--</div>--%>

                            <%--</div>--%>
                            <%--</div>--%>
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
                            <%--<img src="assets/images/bhaktapur.jpg" alt="">--%>
                            <%--</div>--%>
                            <%--<p>gascjgsa shdvyasitd shvdyasvdxhvasyv vsyayd gavsdtyavsd hvsdtavsd hvsdas--%>
                            <%--vtyvas hvysvad hvyvsd hvvd vuvsd hsdvsd hkgsfvkgsa hdctyasfd hgdvtysafd--%>
                            <%--hvdkytsavd sdcytasvd gcdtyasvdg gtsdv </p>--%>
                            <%--</div>--%>
                            <%--<hr/>--%>

                            <%--<div class="footer">--%>
                            <%--<a href=""><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>--%>
                            <%--Like&nbsp;<span class="badge"></span></a>--%>
                            <%--<a href="#"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span>--%>
                            <%--Comment</a>--%>
                            <%--</div>--%>
                            <%--<div class="comments">--%>
                            <%--<div id="abc">--%>
                            <%--<div class="userInfo">--%>
                            <%--<div class="userImage">--%>
                            <%--<img src="assets/images/kristina_rose88.jpg"--%>
                            <%--class="userProfileImage">--%>
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
                            <%--<textarea rows="2" cols="50" id="comment"--%>
                            <%--placeholder="jabsdhasbdyi"></textarea><a href=""--%>
                            <%--class="btn btn-primary">Comment</a>--%>
                            <%--</div>--%>
                            <%--</div>--%>

                            <%--</div>--%>
                            <%--</div>--%>
                        </div>
                    </section>

                </div>
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