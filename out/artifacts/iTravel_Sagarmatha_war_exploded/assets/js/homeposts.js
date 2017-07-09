$(function () {

    let start = 10;
    let limit = 10;

    const initMap = data => {
        var coordinates = {lat: data.lat, lng: data.lng};

        const map = new google.maps.Map(document.getElementById('map'), {
            center: coordinates,
            zoom: 12
        });

        var marker = new google.maps.Marker({
            position: coordinates,
            map: map
        });

    };

    $(window).scroll(function () {
        if ($(window).scrollTop() == $(document).height() - $(window).height()) {
            $.get("/LoadMorePosts", {"start": start, "posttype": "public"})
                .done(function (response) {
                    $.each(response, function (index, value) {
                        appendNewPost(value);
                    });
                    start += limit;

                });
        }
    });

    $("#submitpost").click(function (event) {

        if ($("#postcontent").val() === "") {
            alert("Posts cannot be empty...");
            return;
        }

        let currentLocation = "";
        $.getJSON('https://geoip-db.com/json/geoip.php?jsonp=?')
            .done(function (location) {
                currentLocation = location.city;
                currentLocation += ", " + location.state;

                $.post("/SubmitPost", {
                    "postcontent": $("#postcontent").val(),
                    "location": currentLocation
                }).done(function (response) {
                    if (response.status === "success") {
                        $("#postcontent").val("");
                        updatePublishedNewPost(response.post);

                    } else {
                        alert("Unable to publish your post... Please try again...");

                    }

                }).fail(function () {
                    alert("Unable to publish your post... Please try again...");

                });
            });
    });

    function ajaxFailure(xhr, status, exception) {
        alert("Unable to update...");
    }

    $(".likeBtn").on('click', updateLike);

    $(".viewshowcomments").on('click', loadComments);

    $(".postComment").on('click', postComment);

    $(".delete").on('click', deletePost);

    $(".loadMap").on('click', loadMap);

    // $("#mapModal").on("shown.bs.modal", function () {
    //     google.maps.event.trigger(map, "resize");
    // });

    function loadMap() {

        let location = this.name;

        $('#mapModal').modal('show');

        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15
        });

        var geocoder = new google.maps.Geocoder();

        geocoder.geocode({
                'address': location
            },
            function(results, status) {
                if(status == google.maps.GeocoderStatus.OK) {
                    new google.maps.Marker({
                        position: results[0].geometry.location,
                        map: map
                    });

                    window.setTimeout(function () {
                        google.maps.event.trigger(map, "resize");
                        map.setCenter(results[0].geometry.location);
                    }, 1000);


                }
            });

        // $.get("https://maps.googleapis.com/maps/api/geocode/json", {"address": location})
        //     .done(function (response) {
        //         initMap(response.results[0].geometry.location);
        //     });
    }

    function updatePublishedNewPost(post) {
        post = JSON.parse(post);

        var singlePost = `<div class="posts">
                                    <div class="box">
                                        <div class="header">
                                            <div class="userProfileImage">
                                                <img src="http://lorempixel.com/100/100/">

                                            </div>
                                            <div class="username">
                                                <p id="userName">` + post.postedBy + `</p>
                                                <div class="postTime">
                                                    <p>Posted on ` + post.dateTime + ` <a name="` + post.location + `" id="loadMap` + post.id + `" class="loadMap"><span
                                                        class="glyphicon glyphicon-globe"
                                                        aria-hidden="true"></span>` + post.location + `</a></p>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="userPost">
                                            <p>` + post.content + `</p>
                                        </div>
                                        <hr/>

                                        <div class="footer">`;

        if (post.likedByMe === "true") {
            singlePost += `<a id="` + post.id + `" class="likeBtn redcolor"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Unlike</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        } else {
            singlePost += `<a id="` + post.id + `" class="likeBtn"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Like</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        }

        singlePost += `<a name="` + post.id + `" class="viewshowcomments" id="viewcomments` + post.id + `"><span
                                                    class="glyphicon glyphicon-comment"
                                                    aria-hidden="true"></span>
                                                Comment</a>
                                        </div>
                                        <div class="comments hidden" id="comments` + post.id + `">

                                            <div id="commentsBox` + post.id + `">

                                            </div>

                                            <div id="addComment">

                                                <img src="http://lorempixel.com/100/100/" class="userProfileImage">
                                                <textarea rows="2" cols="50" id="commentText` + post.id + `" class="comment"
                                                          placeholder="jabsdhasbdyi"></textarea><a
                                                    name="` + post.id + `"
                                                    class="btn btn-primary postComment" id="postcomment` + post.id + `">Comment</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>`;

        $("#allposts").prepend(singlePost);

        $("#" + post.id).on('click', updateLike);
        $("#viewcomments" + post.id).on('click', loadComments);
        $("#postcomment" + post.id).on('click', postComment);
        $("#loadMap" + post.id).on('click', loadMap);

    }

    function appendNewPost(post) {
        var singlePost = `<div class="posts">
                                    <div class="box">
                                        <div class="header">
                                            <div class="userProfileImage">
                                                <img src="http://lorempixel.com/100/100/">

                                            </div>
                                            <div class="username">
                                                <p id="userName">` + post.postedBy + `</p>
                                                <div class="postTime">
                                                    <p>Posted on ` + post.dateTime + ` <a name="` + post.location + `" id="loadMap` + post.id + `" class="loadMap"><span
                                                        class="glyphicon glyphicon-globe"
                                                        aria-hidden="true"></span>` + post.location + `</a></p>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="userPost">
                                            <p>` + post.content + `</p>
                                        </div>
                                        <hr/>

                                        <div class="footer">`;

        if (post.likedByMe === "true") {
            singlePost += `<a id="` + post.id + `" class="likeBtn redcolor"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Unlike</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        } else {
            singlePost += `<a id="` + post.id + `" class="likeBtn"><span
                                                            class="glyphicon glyphicon-heart"
                                                            aria-hidden="true"></span>
                                                        <em>Like</em>&nbsp;<span
                                                                class="badge"
                                                                id="likeBadge` + post.id + `">` + post.totalLikes + `</span></a>`;
        }

        singlePost += `<a name="` + post.id + `" class="viewshowcomments" id="viewcomments` + post.id + `"><span
                                                    class="glyphicon glyphicon-comment"
                                                    aria-hidden="true"></span>
                                                Comment</a>
                                        </div>
                                        <div class="comments hidden" id="comments` + post.id + `">

                                            <div id="commentsBox` + post.id + `">

                                            </div>

                                            <div id="addComment">

                                                <img src="http://lorempixel.com/100/100/" class="userProfileImage">
                                                <textarea rows="2" cols="50" id="commentText` + post.id + `" class="comment"
                                                          placeholder="jabsdhasbdyi"></textarea><a
                                                    name="` + post.id + `"
                                                    class="btn btn-primary postComment" id="postcomment` + post.id + `">Comment</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>`;

        $("#allposts").append(singlePost);

        $("#" + post.id).on('click', updateLike);
        $("#viewcomments" + post.id).on('click', loadComments);
        $("#postcomment" + post.id).on('click', postComment);
        $("#loadMap" + post.id).on('click', loadMap);
    }


    function loadComments() {
        let id = this.name;

        $("#comments" + this.name).toggleClass("hidden");
        if (!$("#comments" + this.name).hasClass("hidden")) {
            $.post("/LoadComments", {"post_id": id})
                .done(function (response) {
                    $("#comments" + id + " .singleComment").remove();

                    $.each(response, function (index, comment) {

                        let commentDiv = `<div id="` + comment.id + `" class="singleComment">
                                                <div class="userInfo">
                                                    <div class="userImage">
                                                        <img src="http://lorempixel.com/100/100/"
                                                             class="userProfileImage">
                                                    </div>

                                                    <div class="postedDetails">
                                                        <p>` + comment.postedBy + `</p>
                                                        <div class="postTime">
                                                            <p>` + comment.dateTime + `</p>
                                                        </div>
                                                        <p id="postedComments">` + comment.comment + `</p>
                                                    </div>

                                                </div>

                                            </div>`;

                        $("#commentsBox" + id).prepend(commentDiv);

                    });
                })
                .fail(ajaxFailure);
        }

    }

    function postComment() {
        let id = this.name;
        let comment = $("#commentText" + id).val();

        if (comment === "") {
            alert("Comments cannot be empty...");
            return;
        }

        $.post("/PostComment", {"post_id": id, "comment": comment})
            .done(function (response) {
                console.log(response);
                if (response.status === "success") {
                    $("#commentText" + id).val("");

                    let comment = JSON.parse(response.message);

                    let commentDiv = `<div id="` + comment.id + `" class="singleComment">
                                                <div class="userInfo">
                                                    <div class="userImage">
                                                        <img src="http://lorempixel.com/100/100/"
                                                             class="userProfileImage">
                                                    </div>

                                                    <div class="postedDetails">
                                                        <p>` + comment.postedBy + `</p>
                                                        <div class="postTime">
                                                            <p>` + comment.dateTime + `</p>
                                                        </div>
                                                        <p id="postedComments">` + comment.comment + `</p>
                                                    </div>

                                                </div>

                                            </div>`;

                    $("#commentsBox" + id).append(commentDiv);

                } else {
                    alert(response.message);

                }
            })
            .fail(ajaxFailure);
    }

    function updateLike() {

        let id = this.id;
        let likeBtn = $(this);

        $.post("/UpdateLike", {"post_id": id}) //here post id comes from post
            .done(function (response) { //data from LikeServlet may be json or out(success)
                if (response.status === "success" && response.message === "Liked") {
                    likeBtn.addClass("redcolor");
                    let currentLikes = parseInt($("#likeBadge" + id).text());
                    currentLikes++;
                    $("#likeBadge" + id).text(currentLikes);
                    likeBtn.find("em").text("Unlike");

                } else if (response.status === "success" && response.message === "Unliked") {
                    likeBtn.removeClass("redcolor");
                    let currentLikes = parseInt($("#likeBadge" + id).text());
                    currentLikes--;
                    $("#likeBadge" + id).text(currentLikes);
                    likeBtn.find("em").text("Like");

                } else {
                    ajaxFailure();
                }
            })
            .fail(ajaxFailure);

    }

    function deletePost() {
        let id = this.title;

        let r = confirm("Are you sure to delete this post?");
        if (r === true) {
            $.post("/DeletePost", {"post_id": id})
                .done(function (response) {
                    if (response.status === "success") {
                        $("#completePost" + id).remove();

                    } else {
                        alert(response.message);

                    }
                }).fail(ajaxFailure);
        }
    }

});
