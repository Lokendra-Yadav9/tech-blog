<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.tech.blog.dao.Userdao"%>
<%@page import="com.tech.blog.entity.Comment"%>
<%@page import="com.tech.blog.dao.commentDao"%>
<%@page import="com.tech.blog.dao.likeDao"%>
<%@page import="com.tech.blog.helper.dateFormatter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.tech.blog.entity.category"%>
<%@page import="com.tech.blog.entity.message"%>
<%@page import="com.tech.blog.entity.post"%>
<%@page import="com.tech.blog.helper.conn"%>
<%@page import="com.tech.blog.dao.postDao"%>
<%@page import="com.tech.blog.entity.user"%>
<%@page import="java.util.Timer, java.util.TimerTask"%>

<%@page errorPage="error_page.jsp" %>
<%

    user users = (user) session.getAttribute("current_user");

    if (users == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<%
    int pid = Integer.parseInt(request.getParameter("postId"));
    postDao d = new postDao(conn.getConnection());
    post sPost = d.GetFullPostByPid(pid);

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= sPost.getpTitle()%></title>

        <!--bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <!--font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" >

        <!--highlight.js--> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/default.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>

        <!--my css-->
        <link href="css/myStyle.css" rel="stylesheet" type="text/css">

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 90% 93%, 46% 100%, 40% 93%, 0 100%, 0% 35%, 0 0);
            }
            .active{
                background: #fff!important;
                background: none!important;
            }
            .carousel-item{
               width: 100%;
               height: 600px;
            
               
            }
            .carousel-item img{
                width: 100%;
                height: 100%;
                object-fit: fill;
            }
        </style>


    </head>


    <body class="body-background">
        <!--nav bar-->

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk fa-spin"></span> Tech blog</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="profile.jsp"><span class="fa fa-desktop"></span> Learn with Lokendra</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <!--<span class="fa fa-address-card-o"></span> Categories-->
                                <span class="fa-solid fa-layer-group"></span> Categories
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Programming</a></li>
                                <li><a class="dropdown-item" href="#">Data Structure</a></li>
                                <!--<li><hr class="dropdown-divider"></li>-->
                                <li><a class="dropdown-item" href="#">DataBase Management</a></li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#"><span class="fa fa-address-book"></span> Contact</a>
                        </li>

                        <li class="nav-item ml-3" style="margin-left: 20px;">
                            <a class="nav-link active shadow-sm btn-block" href="#!" data-bs-toggle="modal" data-bs-target="#posting_modal"><span class="fa-solid fa-blog"></span> Do Post</a>
                        </li>

                    </ul>


                    <form id="searchForm" class="d-flex flex-column mx-4" role="search">
                        <div class="search-box">
                            <button id="searchButton" class="btn-search"><i class="fas fa-search"></i></button>
                            <input id="searchInput" type="text" class="input-search text-light primary-background form-control" placeholder="Type to Search...">
                        </div>
                        <div id="searchResults" class="mt-3 d-none">
                            <hr class="primary-background" style="color: black;">
                        </div>
                    </form>


                    <%
                        String gender = users.getGender();
                        String imagePath = "";
                        if (gender != null) {
                            if (gender.equals("male")) {
                                imagePath = "maProfile/" + users.getProfile_pic();
                            } else {
                                imagePath = "feProfile/" + users.getProfile_pic();
                            }
                        }
                    %>

                    <ul class="navbar-nav mr-right">
                        <li class="nav-item">
                            <a class="nav-link" aria-disabled="true" href="#!" data-bs-toggle="modal" data-bs-target="#profile_Modal"> <span> <img style="width: 40px;height: 40px; object-fit: cover; border-radius: 50%; cursor: pointer;" class="img-fluid" src="<%= imagePath%>" /></span> &nbsp; <%= users.getName()%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link mt-2" aria-disabled="true" href="Logout_servlet"><span class="fa fa-sign-out"></span> Log out</a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>

        <!--end navbar-->
        <%
            message m = (message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert <%= m.getCssClass()%>" id="alertDiv" role="alert">
            <%= m.getContent()%>
        </div>
        <%
                // Set up a timer to remove the message after a certain time period (e.g., 5 seconds)
                final HttpSession sessionFinal = session; // Assign session to a final variable
                Timer timer = new Timer();
                timer.schedule(new TimerTask() {
                    public void run() {
                        sessionFinal.removeAttribute("msg"); // Use the final variable inside the TimerTask
                    }
                }, 5000); // 5000 milliseconds = 5 seconds
            }
        %>
        <script>
            // Get the alert div element
            var alertDiv = document.getElementById("alertDiv");
            // Check if the alert div exists
            if (alertDiv) {
                // Hide the alert div after 5 seconds
                setTimeout(function () {
                    alertDiv.style.display = "none";
                }, 5000);
            }
        </script>
        <!--profile modal start--> 

        <!-- Button trigger modal -->
        <!-- Modal -->
        <div class="modal fade container-fluid" id="profile_Modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="transition: all 0.2s ease-in-out;">
            <div class="modal-dialog" style="transition: all 0.5s ease-in-out;">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Tech blog</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <div id class="container  d-flex flex-column align-items-center ">
                            <%
                                if (users.getGender().trim().equals("male")) {
                            %>  

                            <img  style="width: 150px;height: 150px; object-fit: cover; border: 1px solid #2196f3; border-radius: 50%;" class=" img-fluid" src="maProfile/<%= users.getProfile_pic()%>"> 
                            <% } else {%>
                            <img style="width: 150px;height: 150px; object-fit: cover; border: 1px solid #2196f3; border-radius: 50%;" class="img-fluid" src="feProfile/<%= users.getProfile_pic()%>">
                            <% }%>      

                            <!--i have to make image viewer-->
                            <h1 class="modal-title fs-5" id="exampleModalLabel"><%= users.getName()%></h1>
                            <!--details-->
                            <div id="profile_details">
                                <table class="table">
                                    <tbody class="">
                                        <tr>
                                            <th scope="row">ID </th>
                                            <th>:</th>
                                            <td><%= users.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Name </th>
                                            <th>:</th>
                                            <td><%= users.getName()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender</th>
                                            <th>:</th>
                                            <td><%= users.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email</th>
                                            <th>:</th>
                                            <td><%= users.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">About</th>
                                            <th>:</th>
                                            <td><%= users.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row" style="white-space: nowrap;">Register Date</th>
                                            <th>:</th>
                                            <td><%= users.getDatesTime().toString()%></td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                            <div id="profile_Edit" style="display: none;" class="container-fluid">
                                <h5 class="text-warning text-center">Please edit carefully</h5>


                                <!--  edit table-->
                                <form id="imageForm" action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <th scope="row">ID </th>
                                                <th>:</th>
                                                <td><%= users.getId()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">Name </th>
                                                <th>:</th>
                                                <td><input class="form-control" type="text" name="user_name" value="<%= users.getName()%>"> </td>

                                            </tr>
                                            <tr>
                                                <th scope="row">Gender</th>
                                                <th>:</th>
                                                <td><%= users.getGender()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">Email</th>
                                                <th>:</th>
                                                <td><input class="form-control" type="email" name="user_email" value="<%= users.getEmail()%>"></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">Password</th>
                                                <th>:</th>
                                                <td><input class="form-control" type="password" name="user_password" value="<%= users.getPassword()%>"></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">About</th>
                                                <th>:</th>
                                                <td><textarea  rows="3" cols="10" class="form-control" type="text" name="user_about"><%= users.getAbout()%></textarea> </td>

                                            </tr>
                                            <tr>
                                                <th scope="row" style="white-space: nowrap;">Register Date</th>
                                                <th>:</th>
                                                <td><%= users.getDatesTime().toString()%></td>
                                            </tr>
                                            <tr>
                                                <th scope="row" style="white-space: nowrap;">Select Profile</th>
                                                <th>:</th>
                                                <td><input type="file" name="user_profile" class="form-control" ></td>                          
                                            </tr>

                                        </tbody>
                                    </table>
                                    <div class="container text-center">
                                        <button class="btn btn-success text-center text-white" id="save">Save</button>
                                    </div> 
                                </form>      
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-info text-danger" onclick="goToUserInfoPage()" >Your Profile</button>
                        <button id="profile-edit-save" type="button" class="btn primary-background text-white">Edit</button>
                    </div>
                </div>
            </div>
        </div>

        <!--profile modal end-->


        <!--the main of this display blog servlet-->

        <div class="container">
            <div class="row">
                <div class="col-md-8 offset-md-2 p-2 ">
                    <div class="card bg-transparent" style="border:1px solid lightblue">
                        <div class="card-header bg-light">
                            <h5 class="card-title display-3 heading-text" ><%= sPost.getpTitle()%></h5>
                        </div>

                        <div id="carouselExampleIndicators" class="carousel slide card-img-top p-2 display-img">
                            <div class="carousel-indicators">
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                            </div>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="Blog_images/<%= sPost.getpPic()%>" class="d-block w-100" alt="...">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://images.unsplash.com/photo-1599507593354-2b6d036eab4f?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="d-block w-100" alt="blog image not Available">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://plus.unsplash.com/premium_photo-1661877737564-3dfd7282efcb?q=80&w=1800&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="d-block w-100" alt="blog image not Available">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>

                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-2 text-light" style="font-size: 18px;letter-spacing: 0.8px; font-weight: 400;"><a href="Userprofile.jsp?userId=<%= sPost.getUserId()%>" class="text-light"><%= d.GetNameByUserId(sPost.getUserId())%></a>  has posted </h5>

                                <div>
                                    <!-- Facebook -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #3b5998;" href="#!" role="button">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>

                                    <!-- Twitter -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #55acee;" href="#!" role="button">
                                        <i class="fab fa-twitter"></i>
                                    </a>

                                    <!-- Google -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #dd4b39;" href="#!" role="button">
                                        <i class="fab fa-google"></i>
                                    </a>

                                    <!-- Instagram -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #ac2bac;" href="#!" role="button">
                                        <i class="fab fa-instagram"></i>
                                    </a>

                                    <!-- Linkedin -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #0082ca;" href="#!" role="button">
                                        <i class="fab fa-linkedin-in"></i>
                                    </a>

                                    <!-- Youtube -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #ed302f;" href="#!" role="button">
                                        <i class="fab fa-youtube"></i>
                                    </a>

                                    <!-- Github -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #333333;" href="#!" role="button">
                                        <i class="fab fa-github"></i>
                                    </a>

                                    <!-- Whatsapp -->
                                    <a class="btn text-white me-2" data-mdb-ripple-init style="background-color: #25d366;" href="#!" role="button">
                                        <i class="fab fa-whatsapp"></i>
                                    </a>
                                </div>
                            </div>


                            <div class="card-text read-more p-2 mt-2 bg-light" style="border: 1px solid #cccccc; border-radius: 5px;">
                                <p class="card-text p-2" style="text-align: justify; font-size: 1.3em;"><%= sPost.getpContent()%></p>
                            </div>

                            <div style="position: relative;bottom: -50p[x];border-radius: 5px;">
                                <button id="copyBtn" class="copy-btn btn btn-secondary">Copy <i class="fa-regular fa-copy"></i></button>
                                <pre class="pre" id="codeBlock">
                                      <code contenteditable="true" class="<%= d.GetCategoryNameByCatId(sPost.getCatid())%>"><%= sPost.getpCode()%></code>
                                </pre>
                            </div>
                        </div>

                        <div class="card-footer bg-body-secondary text-dark d-flex justify-content-between align-items-center" style="font-size:1.2em; margin-top: -50px;">
                            <div>
                                <small class="mb-3"><span class="fa-solid fa-chalkboard-user fa-spin"></span>  Blogger name - <%= d.GetNameByUserId(sPost.getUserId())%></small><br>
                                <small class="mb-3"><span class="fa-solid fa-layer-group"></span>  Blog category - <%= d.GetCategoryNameByCatId(sPost.getCatid())%></small><br>
                                <small class="mb-3"><span class="fa-regular fa-calendar-check"></span>  Blog posted on - <%= dateFormatter.formatPostDate(sPost.getpDate())%></small>
                            </div>

                            <%
                                likeDao dao = new likeDao(conn.getConnection());

                            %>

                            <div class="d-flex align-items-end">

                                <a href="#!" onclick="userLiked(<%= sPost.getPid()%>, <%= users.getId()%>)" class="text-center btn-sm" style="text-decoration: none;">
                                    <%
                                        boolean isLikedByUser = dao.isLikedByUser(users.getId(), sPost.getPid());
                                        String heartIconClass = isLikedByUser ? "fa-solid text-danger" : "fa-regular";
                                    %>
                                    <i id="heartIcon_<%= sPost.getPid()%>" class="fa-heart fa-2x <%= heartIconClass%>" style="font-size: 1.6em;"></i><br>
                                    <span id="likeCounter_<%= sPost.getPid()%>"><%= dao.countLikesOnPost(sPost.getPid())%></span>
                                </a>

                                <%
                                    int postId = Integer.parseInt(request.getParameter("postId"));
                                    Userdao daoo = new Userdao(conn.getConnection());
                                    commentDao cd = new commentDao(conn.getConnection());

                                %>

                                <a href="#!" onclick="toggleCommentSection()" class="text-center btn-sm mx-5" style="text-decoration: none;">
                                    <i class="fa-regular fa-comment" style="color: #101010;font-weight: 300;font-size: 1.3em;"></i><br>
                                    <span><%= cd.getAllComments(postId)%></span>
                                </a>

                            </div>


                        </div>
                        <div id="commentSection" class="comment-section pt-4 form-floating" style='display: none;'>
                            <h2 class="text-light form-label text-center"style="font-weight: 300;">Comments..<h2>
                                    <form id="commentForm" action="javascript:void(0)"class="text-center form-control" style="border-radius:0px;">
                                        <textarea id="commentText" placeholder="Leave a comment here" class="form-control" rows="3" name="commentText" style="outline: none;"></textarea>
                                        <button class="text-center mt-3 m-2 btn btn-outline-success" onclick="submitComment(<%= users.getId()%>,<%= sPost.getPid()%>)">Comment</button>
                                    </form>

                                    <div class="container" id="commentContainer">


                                        <%    ArrayList<Comment> comments = cd.getAllCommentsByPostId(postId);
                                            // Iterate over the comments ArrayList
                                            for (Comment comment : comments) {
                                                // Access properties of each Comment object
                                                int commentId = comment.getCommentId();
                                                int userId = comment.getUserId();
                                                String commentText = comment.getCommentText();
                                                // Timestamp timestamp = comment.getTimestamp();
                                                // Add more properties as needed

                                                Timestamp timestamp = comment.getTimestamp();
                                                LocalDateTime commentTime = timestamp.toLocalDateTime();

                                                // Calculate elapsed time
                                                LocalDateTime now = LocalDateTime.now();
                                                long minutes = ChronoUnit.MINUTES.between(commentTime, now);
                                                String timeElapsed;

                                                if (minutes < 1) {
                                                    timeElapsed = "Just now";
                                                } else if (minutes < 60) {
                                                    timeElapsed = minutes + " minutes ago";
                                                } else if (minutes < 1440) {
                                                    long hours = minutes / 60;
                                                    timeElapsed = hours + " hours ago";
                                                } else {
                                                    long days = minutes / 1440;
                                                    timeElapsed = days + " days ago";
                                                }

                                        %>



                                        <div class="row bg-light">
                                            <div class="col-md-10 offset-md-1 mt-3" style="border: 1px solid #cccccc; border-radius: 8px">
                                                <div class="d-flex justify-content-between mt-2 align-items-start">
                                                    <div class="comment-avatar">
                                                        <% String profilePicUrl = daoo.getProfilePicUrl(userId).trim();
                                                            gender = daoo.getGenderByUserId(userId).trim();
                                                            String imageSrc = gender.equalsIgnoreCase("male") ? "maProfile/" : "feProfile/";
                                                        %>
                                                        <img style="width: 55px; height: 50px; object-fit: cover; border: 1px solid #2196f3; border-radius: 50%;" class="img-fluid" src="<%= imageSrc + profilePicUrl%>">

                                                    </div>

                                                    <div class="d-flex justify-content-between w-100 align-items-center mt-2 mx-3">
                                                        <h6 class="comment-name by-author text-center"><a href="Userprofile.jsp?userId=<%= userId%>" class='text-success' style="font-size: 20px;"><%= daoo.getUserName(userId)%></a></h6>
                                                        <div class="commentTime" style="font-size: 15px;">
                                                            <span ><%= timeElapsed%></span>
                                                            <i class="fa fa-reply"></i>
                                                            <i class="fa-solid fa-trash-can"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="comment-content py-3 mx-3" style="font-size: 1rem; font-weight: 400;">
                                                    <i class="fa-solid fa-quote-left" style="text-align: start;opacity: 0.7;transform: scale(0.6);"></i>   <%= commentText%>   
                                                </div>

                                            </div>
                                        </div>

                                        <%

                                            }
                                        %>
                                    </div>





                                    </div>  
                                    </div>


                                    </div>
                                    </div>

                                    </div>



                                    <!--end of the display blog servlet-->



                                    <!--add post modal--> 

                                    <!-- Modal -->
                                    <div class="modal fade" id="posting_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" style="transition: all 0.2s ease-in-out;">
                                        <div class="modal-dialog" style="transition: all 0.5s ease-in-out;">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Provide the post details here..</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form id="PostServletForm" action="AddPostServlet" method="post">

                                                        <div class="mb-3 form-group">
                                                            <select class="form-control" name="categoryName">
                                                                <option selected="true" disabled="true">---Select Categories---</option>
                                                                <%
                                                                    postDao pdao = new postDao(conn.getConnection());
                                                                    ArrayList<category> list = pdao.getAllCategories();
                                                                    for (category c : list) {
                                                                %>
                                                                <option value="<%= c.getCid()%>"><%= c.getCid()%> - <%= c.getName()%> </option>
                                                                <%
                                                                    }
                                                                %>
                                                            </select>

                                                        </div>
                                                        <div class="mb-3 form-group">
                                                            <input type="text" name="pfTitle"  class="form-control" placeholder="Enter blog title">
                                                        </div>
                                                        <div class="mb-3 form-group">
                                                            <textarea name="pfContent" rows="6" class="form-control" placeholder="Enter blog content" ></textarea>
                                                        </div>
                                                        <div class="mb-3 form-group">
                                                            <textarea name="pfCode" rows="6" class="form-control" placeholder="Enter blog code (if any)" ></textarea>
                                                        </div>
                                                        <div class="mb-3 form-group">
                                                            <label class="mb-2">Upload blog images..</label>
                                                            <input type="file"  class="form-control" name="pfImg">
                                                        </div>

                                                        <div class="container text-center">
                                                            <button id="post_it" type="submit" class="btn btn-outline-info">Post it</button>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <!--post modal ended-->



                                    <!--footer connect-->
                                    <div class="mt-5">   
                                        <%@include file="MyFooter.jsp" %>
                                    </div>

                                    <!--bootstrap js-->


                                    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
                                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>


                                    <!--jQuery cdn-->
                                    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>


                                    <!--sweet alert-->
                                    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

                                    <!--highlight.js--> 



                                    <script src="js/comment.js" type="text/javascript"></script>   
                                    <script src="js/MyJs.js" type="text/javascript"></script>  

                                    <script>
                                            $(document).ready(function () {
                                                let editSave = false;
                                                $("#profile-edit-save").click(function () {
                                                    if (editSave == false) {
                                                        $("#profile_details").hide();
                                                        $("#profile_Edit").show();
                                                        editSave = true;
                                                        $(this).text("Back");
                                                    } else {
                                                        $("#profile_details").show();
                                                        $("#profile_Edit").hide();
                                                        editSave = false;
                                                        $(this).text("Edit");
                                                    }
                                                });
                                            });
                                    </script>

                                    <script>
                                        $(document).ready(function () {
                                            $("#PostServletForm").on("submit", function (event) {
                                                event.preventDefault();
//                                                console.log("lokendra singh");
                                                let formData = new FormData(this);
                                                $.ajax({
                                                    url: "AddPostServlet",
                                                    type: "post",
                                                    data: formData,
                                                    success: function (data, textStatus, jqXHR) {
                                                        swal({
                                                            title: "Good job!",
                                                            text: "Blog is posted successfully!",
                                                            icon: "success",
                                                            timer: 3000, // 3 seconds
                                                            buttons: false // Disable the buttons
                                                        }).then(() => {
                                                            window.location.href = "profile.jsp";
                                                        });
                                                    },
                                                    error: function (jqXHR, textStatus, errorThrown) { // Changed "Error" to "error"
                                                        swal("Oops...", "Something went wrong!", "error");
                                                    },
                                                    processData: false,
                                                    contentType: false
                                                });
                                            });
                                        });
                                    </script>

                                    <script>
                                        document.addEventListener('DOMContentLoaded', (event) => {
                                            hljs.highlightAll();
                                        });
                                    </script>


                                    <script>

                                        function  getPost_S(catId) {
                                            $("#loader").show();
                                            $("#post-container").hide();
                                            $.ajax({
                                                url: "postContainer.jsp",
                                                data: {cid: catId},
                                                success: function (data, textStatus, jqXHR) {
                                                    $("#loader").hide();
                                                    $("#post-container").show();
                                                    $("#post-container").html(data);
                                                    //                        console.log(data);
                                                },
                                                error: function (jqXHR, textStatus, errorThrown) {
                                                    console.log("error:", errorThrown);
                                                }
                                            });
                                        }


                                        $(document).ready(function () {
                                            getPost_S(0);
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
                                    </script>

                                    <script>
                                        $(document).ready(function () {

                                            $('.copy-btn').click(function () {
                                                // Find the code block associated with the clicked button
                                                var codeBlock = $(this).closest('div').find('code');
                                                var codeText = codeBlock.text();

                                                // Create a temporary textarea element to facilitate copying
                                                var textarea = document.createElement('textarea');
                                                textarea.value = codeText;
                                                document.body.appendChild(textarea);

                                                // Copy the text from the textarea to the clipboard
                                                textarea.select();
                                                document.execCommand('copy');

                                                // Remove the temporary textarea element
                                                document.body.removeChild(textarea);

                                                // Update the button text to indicate "Copied!" with the Font Awesome icon
                                                $(this).html('Copied! <i class="fa-solid fa-copy"></i>');

                                                // Reset button text after 2 seconds
                                                var button = $(this);
                                                setTimeout(function () {
                                                    button.html('Copy <i class="fa-regular fa-copy"></i>');
                                                }, 2000);
                                            });
                                        });
                                    </script>


                                    </body>
                                    </html>
