

<%@page import="com.tech.blog.dao.followDao"%>
<%@page import="com.tech.blog.entity.SoftSkill"%>
<%@page import="com.tech.blog.helper.UserNameExtractor"%>
<%@page import="com.tech.blog.entity.TechnicalSkill"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entity.userInfo"%>
<%@page import="com.tech.blog.dao.userInfoDao"%>
<%@page import="com.tech.blog.dao.Userdao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <!--google material css-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <link href="css/StyleSecond.css" rel="stylesheet" type="text/css"/>
        <style>
            /* The Modal (background) */
            .modals-image {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 9999; /* Sit on top */
                left: 0;
                top: 20%;
                width: 50%; /* Full width */
                height: 50%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
            }

            /* Modal Content */
            .modal-contents {
                margin:5% auto;
                display: block;
                width: 50%;
                max-width: 400px;
            }



            /*--------------------   follower and post show ----------------*/
            .follow-post{
                display: flex;
                justify-content: space-around;
                align-items: center;
                font-family: cursive;
                cursor: pointer;

            }
            .follow-post .a-tag h2{
                font-size: 1.5vw;
                color: #1B3C73;
            }

            .follow-post a span{
                font-size: 1.2vw;
                color: #1B3C73;
            }


        </style>

        <!--this is for cookies--> 
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.1/cookieconsent.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.1/cookieconsent.min.js"></script>
    </head>
    <body class="body-background">


        <%
            user currentUser = (user) session.getAttribute("current_user");
            if (currentUser != null) {
        %>
        <%@include  file="new_navbar.jsp" %>
        <%        } else {
                response.sendRedirect("login_page.jsp");
            }
        %>


        <%
            // Retrieve the user ID from the request parameter
            int userId = Integer.parseInt(request.getParameter("userId"));

            //postdao , by userId
            postDao pdao = new postDao(conn.getConnection());

            // Retrieve user information using the user ID
            Userdao userdao = new Userdao(conn.getConnection());
            user userprofile = userdao.getuserbyId(userId);

            userInfoDao userInfoD = new userInfoDao(conn.getConnection());
            userInfo userinfo = userInfoD.getUserInfoByUFid(userId);

            followDao fd = new followDao(conn.getConnection());
            // Display user information
            if (userprofile != null) {
                // Display user's name, email, qualifications, or any other information
        %>


        <section>
            <div class="container pt-3">
                <div class="row">
                    <div class="col">
                        <nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="index.jsp">Home</a></li> 
                                    <%
                                        String fullName = userprofile.getName();
                                        String[] nameParts = fullName.split(" "); // Assuming the full name consists of first name and last name separated by a space
                                        String firstName = nameParts[0]; // Extracting the first name
%>
                                <li class="breadcrumb-item" aria-current="page" onclick="location.reload(); return false;" style="cursor: pointer;"><%= firstName%> profile</li>

                            </ol>
                        </nav>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-4">
                        <div class="card mb-4">
                            <div class="card-body text-center">
                                <%
                                    String gender = userprofile.getGender();
                                    String imagePath = "";
                                    if (gender != null) {
                                        if (gender.equals("male")) {
                                            imagePath = "maProfile/" + userprofile.getProfile_pic();
                                        } else {
                                            imagePath = "feProfile/" + userprofile.getProfile_pic();
                                        }
                                    }
                                %>
                                <!-- Image to trigger the modal -->
                                <img style="width: 150px;height: 150px; object-fit: cover; border: 1px solid #2196f3; border-radius: 50%; cursor: pointer;" class="img-fluid" src="<%= imagePath%>" onclick="previewImage(this.src)" />

                                <!-- Modal -->
                                <div id="profileModal" class="profileModal">
                                    <!-- Modal content -->
                                    <div class="profileModalContent">
                                        <span class="close" onclick="closeModal()">&times;</span>
                                        <img id="modalImg" src="" alt="Preview Image">
                                    </div>
                                </div>




                                <h5 class="my-3 display-6 fs-2" style="font-weight: 600;"><%= userprofile.getName()%> <i class="fa-solid fa-circle-check text-info" title="vip profile"></i></h5>
                                <p class="text-muted mb-1 " style="font-size: 1.5rem; font-weight: 500;"><%= userinfo.getOccupation()%></p>
                                <p class="text-muted mb-4" style="font-size: 1rem;"><%= userinfo.getAddress()%></p>



                                <div class="follow-post my-3">
                                    <div class="follower-info">
                                        <a class="a-tag" href="#">  <h2>Followers</h2>                                       
                                            <span id="followerCount"><%= fd.countFollowers(userId)%></span> </a>
                                    </div>
                                    <div class="post-info">
                                        <a class="a-tag" href="#posts_containersId"> <h2>Posts</h2> 
                                            <span id="postCount"><%= pdao.getAllPostsCountUserId(userId)%></span> </a>
                                    </div>
                                </div>
                                <%
                                    // Retrieve the postCount value
                                    int postCount = pdao.getAllPostsCountUserId(userId);

                                    // Set the postCount value in the session
                                    session.setAttribute("postCount", postCount);
                                %>

                                <%
                                    if (currentUser.getId() != userId) {
                                        boolean isFollowing = fd.isFollow(currentUser.getId(), userId);
                                        String followButtonClass = isFollowing ? "btn-outline-primary" : "btn-primary";
                                        String followButtonText = isFollowing ? "Following" : "Follow";
                                %>

                                <div class="d-flex justify-content-center mb-2">
                                    <button type="button" class="mx-4 btn <%= followButtonClass%>" id="follow">
                                        <span id="followButtonText"><%= followButtonText%></span>
                                    </button>
                                    <button type="button" class="mx-4 btn btn-outline-primary ms-1">Message</button>
                                </div>
                                <%                                    }
                                %>






                            </div>

                        </div>


                        <%
                            UserNameExtractor uExtract = new UserNameExtractor();

                        %>
                        <div class="card mb-4 mb-lg-0">
                            <div class="card-body p-0">
                                <ul class="list-group list-group-flush rounded-3">
                                    <li class="list-group-item d-flex justify-content-between align-items-center p-3" title="<%= userinfo.getOther_site()%>">
                                        <i class="fas fa-globe fa-lg text-warning"></i>
                                        <a href="<%= userinfo.getOther_site()%>" class="a-tag">   <p class="mb-0">@<%= userprofile.getName()%></p></a>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center p-3" title="<%= userinfo.getGithub()%>">
                                        <i class="fab fa-github fa-lg" style="color: #333333;"></i>
                                        <a href="<%= userinfo.getGithub()%>" class="a-tag" target="_blank" >    <p class="mb-0"><% String githubUserName = uExtract.extractUserName(userinfo.getGithub());%>
                                                <%= githubUserName != null ? githubUserName : userprofile.getName()%></p></a>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center p-3" title="<%= userinfo.getTwitter()%>">
                                        <i class="fab fa-twitter fa-lg" style="color: #55acee;"></i>
                                        <a href="<%= userinfo.getTwitter()%>" class="a-tag" target="_blank">    <p class="mb-0"><% String twitterUserName = uExtract.extractUserName(userinfo.getTwitter());%>
                                                <%= twitterUserName != null ? twitterUserName : userprofile.getName()%></p></a>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center p-3" title="<%= userinfo.getInsta()%>">
                                        <i class="fab fa-instagram fa-lg" style="color: #ac2bac;"></i>
                                        <a href="<%= userinfo.getInsta()%>" class="a-tag" target="_blank">   <p class="mb-0"><% String InstaUserName = uExtract.extractUserName(userinfo.getInsta());%>
                                                <%= InstaUserName != null ? InstaUserName : userprofile.getName()%></p></a>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center p-3" title="<%= userinfo.getFacebook()%>">
                                        <i class="fab fa-facebook-f fa-lg" style="color: #3b5998;"></i>
                                        <a href="<%= userinfo.getFacebook()%>" class="a-tag" target="_blank">   <p class="mb-0"><% String FacebookUserName = uExtract.extractUserName(userinfo.getFacebook());%>
                                                <%= FacebookUserName != null ? FacebookUserName : userprofile.getName()%></p></a>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center p-3" title="<%= userinfo.getLinkedin()%>">
                                        <i class="fab fa-linkedin-in fa-lg" style="color: #3b5998;"></i>
                                        <a href="<%= userinfo.getLinkedin()%>"  class="a-tag" target="_blank"> <p class="mb-0"><% String LinkedinUserName = uExtract.extractUserName(userinfo.getLinkedin());%>
                                                <%= LinkedinUserName != null ? LinkedinUserName : userprofile.getName()%></p></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Full Name</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%= userprofile.getName()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Email</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%= userprofile.getEmail()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Mobile</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%= userinfo.getMobile()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">About</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%= userprofile.getAbout()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Address</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%= userinfo.getAddress()%></p>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Highest study</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <p class="text-muted mb-0"><%= userinfo.getHigherStudy()%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card mb-4 mb-md-0">
                                    <div class="card-body">
                                        <p class="mb-4"><span class="text-primary font-italic me-1"><i class="fa-solid fa-chalkboard-user"></i> Tech Skill's</span> With Status
                                        </p>
                                        <div class="px-2" style="display: flex; align-items: center;justify-content: space-between;">
                                            <h5 class="px-4 display-5 fs-5">Technical skill's with experties</h5>

                                        </div>



                                        <%
                                            // Retrieving technical skills and their levels
                                            List<TechnicalSkill> techSkillsList = userinfo.getTechSkills();

                                            // Check if technical skills are present
                                            if (techSkillsList != null && !techSkillsList.isEmpty()) {
                                                for (int i = 0; i < techSkillsList.size(); i++) {
                                                    TechnicalSkill techSkill = techSkillsList.get(i);
                                        %>
                                        <div class="progressing d-flex justify-content-between"title="<%= techSkill.getName()%> <%= techSkill.getLevel()%>%"> 
                                            <h6 class="mt-4 mb-1 px-2 display-4" style="font-size: 1.1rem;font-weight: 400;"><%= techSkill.getName()%></h6>
                                            <h6 class="mt-4 mb-1 px-2 display-4" style="font-size: 1.1rem;font-weight: 400;"><%= techSkill.getLevel()%>%</h6> 
                                        </div>
                                        <div class="progress rounded progressing" style="height: 5px;" title="<%= techSkill.getLevel()%>%">
                                            <div class="progress-bar primary-background" role="progressbar" style="width: <%= techSkill.getLevel()%>%;" aria-valuenow="<%= techSkill.getLevel()%>"
                                                 aria-valuemin="0" aria-valuemax="100" ></div>
                                        </div>

                                        <%
                                            }
                                        } else {
                                        %>
                                        <p>No technical skills found.</p>
                                        <%
                                            }
                                        %>






                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card mb-4 mb-md-0">
                                    <div class="card-body">
                                        <p class="mb-4"><span class="text-primary font-italic me-1"><i class="fa-solid fa-users-gear"></i> Soft Skill's</span> With Status
                                        </p>
                                        <div class="px-2" style="display: flex; align-items: center;justify-content: space-between;">
                                            <h5 class="px-4 display-5 fs-5">Soft Skill's with Experties</h5>
                                        </div>


                                        <%
                                            // Retrieving soft skills and their levels
                                            List<SoftSkill> softSkillsList = userinfo.getSoftSkills();

                                            // Check if soft skills are present
                                            if (softSkillsList != null && !softSkillsList.isEmpty()) {

                                                for (int i = 0; i < softSkillsList.size(); i++) {
                                                    SoftSkill softSkill = softSkillsList.get(i);
                                        %>
                                        <div class="progressing d-flex justify-content-between" title="<%= softSkill.getName()%>  <%= softSkill.getLevel()%>%"> 
                                            <h6 class="mt-4 mb-1 px-2 display-4" style="font-size: 1.1rem;font-weight: 400;"><%= softSkill.getName()%></h6>
                                            <h6 class="mt-4 mb-1 px-2 display-4" style="font-size: 1.1rem;font-weight: 400;"><%= softSkill.getLevel()%>%</h6> 
                                        </div>
                                        <div class="progress rounded progressing" style="height: 5px;"> 
                                            <div class="progress-bar primary-background" role="progressbar" style="width: <%= softSkill.getLevel()%>%;" aria-valuenow="<%= softSkill.getLevel()%>"
                                                 aria-valuemin="0" aria-valuemax="100" title="<%= softSkill.getLevel()%>%"></div>
                                        </div>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <p>No soft skills found.</p>
                                        <%
                                            }
                                        %>






                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr class="my-5 text-light">
                <div class="row" id="posts_containersId">
                    <!--first left column-->

                    <div class="col-md-3">
                        <div class="list-group">
                            <a type="button" onclick="getPost_S(0, <%= userId%>)" class="list-group-item list-group-item-action active" aria-current="true">
                                All categories
                            </a>
                            <%
                                postDao d = new postDao(conn.getConnection());
                                ArrayList<category> list1 = d.getAllCategories();
                                for (category cat : list1) {
                            %>
                            <a type="button" onclick="getPost_S(<%= cat.getCid()%>,<%= userId%>)" class="list-group-item list-group-item-action"><%= cat.getName()%></a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <!--second right column-->
                    <div class="col-md-9">
                        <div class="container text-center" id="loader">
                            <span class="fa-solid fa-spinner fa-3x fa-Spin"></span>
                        </div>

                        <div class="container-fluid"  id="post-container">


                        </div>
                    </div>
                </div>                         




            </div>
        </section>

        <%
            }
        %>

        <!--footer connect-->
        <div class="mt-5">   
            <%@include file="MyFooter.jsp" %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>


        <!--jQuery cdn-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>




        <!--sweet alert-->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script src="js/MyJs.js" type="text/javascript"></script>
        <!--<script src="js/followAndMessage.js" type="text/javascript"></script>-->

        <script>

                                function getPost_S(catId, userId) {
                                    $("#loader").show();
                                    $("#post-container").hide();
                                    $.ajax({
                                        url: "UserPostContainer.jsp",
                                        data: {
                                            cid: catId,
                                            userId: userId // Pass userId parameter here
                                        },
                                        success: function (data, textStatus, jqXHR) {
                                            $("#loader").hide();
                                            $("#post-container").show();
                                            $("#post-container").html(data);
                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            console.log("error:", errorThrown);
                                        }
                                    });
                                }



                                // Assuming userId is defined somewhere in your JSP page


                                $(document).ready(function () {
                                    // Assuming userId is defined somewhere in your JSP page
                                    var userId = <%= Integer.parseInt(request.getParameter("userId"))%>;
                                    getPost_S(0, userId); // Pass userId to the function
                                });

        </script>



        <script>
            // Get all the list items
            var listItems = document.querySelectorAll('.list-group-item');

            // Function to handle click event
            function handleItemClick(event) {
                // Remove active class from all list items
                listItems.forEach(function (item) {
                    item.classList.remove('active');
                });
                // Add active class to the clicked list item
                event.target.classList.add('active');
            }

            // Add click event listener to each list item
            listItems.forEach(function (item) {
                item.addEventListener('click', handleItemClick);
            });



            function previewImage(imageSrc) {
                var modal = document.getElementById('profileModal');
                var modalImg = document.getElementById('modalImg');
                modal.style.display = 'block';
                modalImg.src = imageSrc;
            }

            function closeModal() {
                var modal = document.getElementById('profileModal');
                modal.style.display = 'none';
            }

// Close the modal if clicked outside of it
            window.onclick = function (event) {
                var modal = document.getElementById('profileModal');
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            };


        </script>


        <script>
            $(document).ready(function () {
                $('#follow').click(function () {
                    var followerId = <%= currentUser.getId()%>; // Replace with the logged-in user's ID
                    var followedId = <%= userId%>; // Replace with the ID of the user being followed

                    var buttonText = $('#follow').text().trim();
                    var action = (buttonText === 'Follow') ? 'follow' : 'unfollow';

                    $.ajax({
                        url: 'followServlet',
                        type: 'POST',
                        data: {followerId: followerId, followedId: followedId, action: action},
                        success: function (response) {
                            if (action === 'follow') {
                                $('#follow').text('Following');
                                $('#follow').removeClass('btn-primary').addClass('btn-outline-primary');

                                // Increment follower count by one
                                var followerCount = parseInt($('#followerCount').text());
                                $('#followerCount').text(followerCount + 1);
                            } else {
                                $('#follow').text('Follow');
                                $('#follow').addClass('btn-primary').removeClass('btn-outline-primary');

                                // Decrement follower count by one
                                var followerCount = parseInt($('#followerCount').text());
                                $('#followerCount').text(followerCount - 1);
                            }

                        },
                        error: function (xhr, status, error) {
                            console.error(xhr.responseText);
                        }
                    });
                });
            });

        </script>



    </body>
</html>
