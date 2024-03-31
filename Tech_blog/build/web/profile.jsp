<%@page import="com.tech.blog.dao.categoryDao"%>
<%@page import="com.tech.blog.entity.category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.conn"%>
<%@page import="com.tech.blog.dao.postDao"%>
<%@page import="com.tech.blog.entity.message"%>
<%@page import="com.tech.blog.entity.user"%>

<%@page errorPage="error_page.jsp" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>profile page</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <link href="css/StyleSecond.css" rel="stylesheet" type="text/css"/>


        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 90% 93%, 46% 100%, 40% 93%, 0 100%, 0% 35%, 0 0);
            }
            #profile_btn:hover{
                color: white;
            }



            /*save cate button*/
            .tooltip-container {
                --background: #1B3C73;
                background: var(--background)!important;
                position: relative;
                cursor: pointer;
                transition: all 0.2s;
                font-size: 14px;
                border-radius: 6px;
                width: 10em;
                color: #fff;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .tooltip {
                position: absolute;
                top: 0;
                left: 30%;
                transform: translateX(-60%);
                padding: 0.3em 0.6em;
                opacity: 0;
                pointer-events: none;
                transition: all 0.3s;
                background: var(--background);
                border-radius: 5px;
                width: 13em;
                text-align: center;

            }

            .tooltip::before {
                position: absolute;
                content: "";
                height: 0.6em;
                width: 0.6em;
                bottom: -0.2em;
                left: 50%;
                transform: translate(-50%) rotate(45deg);
                background: var(--background);
            }

            .tooltip-container:hover .tooltip {
                top: -100%;
                opacity: 1;
                visibility: visible;
                pointer-events: auto;
                animation: shake 500ms ease-in-out forwards;
            }

            @keyframes shake {
                0% {
                    transform: rotate(2deg);
                }
                50% {
                    transform: rotate(-3deg);
                }
                70% {
                    transform: rotate(3deg);
                }

                100% {
                    transform: rotate(0deg);
                }
            }

            .texts {
                position: relative;
                padding: 0.4em 0.8em;
                overflow: hidden;
            }

            .texts::before {
                content: "(^_^)/";
                position: absolute;
                width: 100%;
                top: 100%;
                left: 50%;
                transform: translateX(-50%);
                padding: inherit;
                background-color: var(--background);
                transition: 0.3s;
            }

            .tooltip-container:hover .texts::before {
                top: 0;
            }



            /*loader in postContainer*/
            .spinner {
                position: absolute;
                width: 9px;
                height: 9px;
            }

            .spinner div {
                position: absolute;
                width: 50%;
                height: 150%;
                background: #000000;
                transform: rotate(calc(var(--rotation) * 1deg)) translate(0, calc(var(--translation) * 1%));
                animation: spinner-fzua35 1s calc(var(--delay) * 1s) infinite ease;
            }

            .spinner div:nth-child(1) {
                --delay: 0.1;
                --rotation: 36;
                --translation: 150;
            }

            .spinner div:nth-child(2) {
                --delay: 0.2;
                --rotation: 72;
                --translation: 150;
            }

            .spinner div:nth-child(3) {
                --delay: 0.3;
                --rotation: 108;
                --translation: 150;
            }

            .spinner div:nth-child(4) {
                --delay: 0.4;
                --rotation: 144;
                --translation: 150;
            }

            .spinner div:nth-child(5) {
                --delay: 0.5;
                --rotation: 180;
                --translation: 150;
            }

            .spinner div:nth-child(6) {
                --delay: 0.6;
                --rotation: 216;
                --translation: 150;
            }

            .spinner div:nth-child(7) {
                --delay: 0.7;
                --rotation: 252;
                --translation: 150;
            }

            .spinner div:nth-child(8) {
                --delay: 0.8;
                --rotation: 288;
                --translation: 150;
            }

            .spinner div:nth-child(9) {
                --delay: 0.9;
                --rotation: 324;
                --translation: 150;
            }

            .spinner div:nth-child(10) {
                --delay: 1;
                --rotation: 360;
                --translation: 150;
            }

            @keyframes spinner-fzua35 {
                0%, 10%, 20%, 30%, 50%, 60%, 70%, 80%, 90%, 100% {
                    transform: rotate(calc(var(--rotation) * 1deg)) translate(0, calc(var(--translation) * 1%));
                }

                50% {
                    transform: rotate(calc(var(--rotation) * 1deg)) translate(0, calc(var(--translation) * 1.5%));
                }
            }


        </style>

        <!--this is for cookies--> 
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.1/cookieconsent.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.1/cookieconsent.min.js"></script>
    </head>
    <body class="body-background">
        <%

            user users = (user) session.getAttribute("current_user");

            if (users == null) {
                response.sendRedirect("login_page.jsp");
            }
        %>
        <!--navbar-->

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
                            <a class="nav-link active btn-block" href="#!" data-bs-toggle="modal" data-bs-target="#posting_modal"><span class="fa-solid fa-blog"></span> Do Post</a>
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
                            <a class="nav-link" aria-disabled="true" href="#!" data-bs-toggle="modal" data-bs-target="#profile_Modal"> <span> <img style="width: 40px;height: 40px; object-fit: cover; border-radius: 50%; cursor: pointer;" class="img-fluid" title="<%= users.getName()%>" src="<%= imagePath%>" /></span> &nbsp; <%= users.getName()%></a>
                        </li>
                        <li class="nav-item">
                            <!--<a class="nav-link mt-2" aria-disabled="true" href="Logout_servlet"><span class="fa fa-sign-out"></span> Log out</a>-->



                            <a class="Btn nav-link mt-2 mx-2 primary-background active" aria-disabled="true" href="Logout_servlet">

                                <div class="sign"><svg viewBox="0 0 512 512"><path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"></path></svg></div>

                                <div class="text">Logout</div>
                            </a>



                        </li>
                    </ul>

                </div>
            </div>



        </nav>

        <!--end navbar-->
        <!--image alert--> 



        <!--image alert remove-->

        <%@ page import="java.util.Timer, java.util.TimerTask" %>

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
                                if (gender != null) {

                                    if (gender.equals("male")) {
                                        imagePath = "maProfile/" + users.getProfile_pic();
                                    } else {
                                        imagePath = "feProfile/" + users.getProfile_pic();
                                    }
                                }
                            %>
                            <!-- Image to trigger the modal -->
                            <img style="width: 150px;height: 150px; object-fit: cover; border: 1px solid #2196f3; border-radius: 50%; cursor: pointer;" class="img-fluid" src="<%= imagePath%>" onclick="previewImage(this.src)" />

                            <div id="profileModal" class="profileModal">
                                <!-- Modal content -->
                                <div class="profileModalContent">
                                    <span class="close" onclick="closeModal()">&times;</span>
                                    <img id="modalImg" src="" alt="Preview Image">
                                </div>
                            </div>


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
                    <div class="modal-footer d-flex align-items-center  justify-content-between">

                        <div>  <a href="Userprofile.jsp?userId=<%= users.getId()%>"> <button type="button" class="btn primary-background text-light">View Profile</button> </a> </div>
                        <div> <button type="button" class="btn primary-background text-light" onclick="goToUserInfoPage()" >Complete Your Profile</button>
                            <button id="profile-edit-save" type="button" class="btn primary-background text-white">Edit</button> </div>

                    </div>
                </div>
            </div>
        </div>

        <!--profile modal end-->


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


                            <%
                                categoryDao CatedAo = new categoryDao(conn.getConnection());
                                int cid = CatedAo.getLastCategoryId();
                            %>


                            <div class="mb-3 form-group">
                                <select class="form-control" name="categoryName" id="categorySelect">
                                    <option selected="true" disabled="true">---Select Categories---</option>

                                    <option value="other">Other</option> 

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

                                <input type="text" class="form-control mt-2" name="otherCategory" id="otherCategoryInput" placeholder="Enter Other Category" style="display: none;">
                                <input type="text" class="form-control mt-2" name="otherCategoryDescp" id="otherCategoryDescpInput" placeholder="Enter Category Description (Optional)" style="display: none;">

                                <button class="tooltip-container text-light mt-2 offset-4" id="saveCateBtn" style="display: none;">
                                    <span class="tooltip text-light">First Save the category!</span>
                                    <span class="texts text-light" style="color:white;">Save category</span>
                                </button>


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
                            <!--  <div class="mb-3 form-group">
                                                            <label class="mb-2">Upload blog images..</label>
                                                            <input type="file"  class="form-control" name="pfImg">
                                                        </div> -->

                            <div class="mb-3 form-group">
                                <label class="mb-2">Upload blog images or paste image URL:</label>
                                <div class="input-group">
                                    <input type="file" class="form-control" name="pfImg"  id="pfImgUpload" style="display: none;" accept="image/*">
                                    <input type="text" class="form-control" name="pfImgURL" id="pfImgURL" placeholder="Paste image URL here">
                                    <button type="button" class="btn btn-primary" onclick="toggleInput()">Toggle</button>
                                </div>
                            </div>




                            <div class="container text-center">
                                <!--<button id="post_it" type="submit" class="btn btn-outline-info">Post it</button>-->


                                <button id="post_it" type="submit" style="--clr: #7808d0" class="button primary-background" href="#">
                                    <span class="button__icon-wrapper">
                                        <svg width="10" class="button__icon-svg" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 15">
                                        <path fill="currentColor" d="M13.376 11.552l-.264-10.44-10.44-.24.024 2.28 6.96-.048L.2 12.56l1.488 1.488 9.432-9.432-.048 6.912 2.304.024z"></path>
                                        </svg>

                                        <svg class="button__icon-svg  button__icon-svg--copy" xmlns="http://www.w3.org/2000/svg" width="10" fill="none" viewBox="0 0 14 15">
                                        <path fill="currentColor" d="M13.376 11.552l-.264-10.44-10.44-.24.024 2.28 6.96-.048L.2 12.56l1.488 1.488 9.432-9.432-.048 6.912 2.304.024z"></path>
                                        </svg>
                                    </span>
                                    Post it
                                </button>



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


        <!--main screen profile page-->
        <main>
            <div class="container">
                <div class="row mt-3">
                    <!--first left column-->

                    <div class="col-md-3">
                        <div class="list-group">
                            <a type="button" onclick="getPost_S(0)" class="list-group-item list-group-item-action active" aria-current="true">
                                All categories
                            </a>
                            <%
                                postDao d = new postDao(conn.getConnection());
                                ArrayList<category> list1 = d.getAllCategories();
                                for (category cat : list1) {
                            %>
                            <a type="button" onclick="getPost_S(<%= cat.getCid()%>)" class="list-group-item list-group-item-action"><%= cat.getName()%></a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <!--second right column-->
                    <div class="col-md-9">
                        <div class="container text-center mt-3" id="loader" style="display: flex; justify-content: center;align-items: center;">
                            <!--<span class="fa-solid fa-spinner fa-3x fa-Spin"></span>-->
                            <div class="spinner">
                                <div></div>   
                                <div></div>    
                                <div></div>    
                                <div></div>    
                                <div></div>    
                                <div></div>    
                                <div></div>    
                                <div></div>    
                                <div></div>    
                                <div></div>    
                            </div>
                        </div>

                        <div class="container-fluid"  id="post-container">

                        </div>
                    </div>
                </div>
            </div>
        </main>


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
                    event.preventDefault(); // Prevent the default form submission
                    let formData = new FormData(this); // Get the form data

                    // AJAX request to AddPostServlet
                    $.ajax({
                        url: "AddPostServlet",
                        type: "post",
                        data: formData,
                        success: function (data, textStatus, jqXHR) {
                            // Show success message and redirect after posting blog
                            swal({
                                title: "Good job!",
                                text: "Blog is posted successfully!",
                                icon: "success",
                                timer: 2000, // 3 seconds
                                buttons: false // Disable the buttons
                            }).then(() => {
                                window.location.href = "profile.jsp"; // Redirect to profile page
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            // Show error message if something goes wrong
                            swal("Oops...", "Something went wrong!", "error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });

        </script>

        <script>
            function toggleInput() {
                var uploadInput = document.getElementById('pfImgUpload');
                var urlInput = document.getElementById('pfImgURL');

                // Toggle display of upload input and URL input
                if (uploadInput.style.display === 'none') {
                    uploadInput.style.display = 'block';
                    urlInput.style.display = 'none';
                } else {
                    uploadInput.style.display = 'none';
                    urlInput.style.display = 'block';
                }
            }
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
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            }
        </script>


        <script>
            window.addEventListener("load", function () {
                window.cookieconsent.initialise({
                    "palette": {
                        "popup": {
                            "background": "#000"
                        },
                        "button": {
                            "background": "#f1d600"
                        }
                    },
                    "theme": "edgeless",
                    "content": {
                        "message": "This website uses cookies to ensure you get the best experience on our website.",
                        "dismiss": "Got it!",
                        "link": "Learn more",
                        "href": "/cookie-policy"
                    }
                });
            });
        </script>



        <script>

            document.addEventListener("DOMContentLoaded", function () {

                document.getElementById("saveCateBtn").addEventListener("click", function () {
                    var otherCategoryInput = document.getElementById("otherCategoryInput").value;
                    var otherCategoryDescpInput = document.getElementById("otherCategoryDescpInput").value;

                    // Send category data to server using AJAX
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "AddCategoryServlet", true);
                    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            var response = xhr.responseText;
                            if (response === "failure") {
                                console.error("Failed to save category.");
                            } else {
                                // Category saved successfully, update the dropdown list
                                var categoryId = parseInt(response);
                                var categoryName = otherCategoryInput;

                                // Create a new option element
                                var option = document.createElement("option");
                                option.value = categoryId;
                                option.text = categoryId + " - " + categoryName;

                                // Append the new option to the dropdown list
                                var categorySelect = document.getElementById("categorySelect");
                                categorySelect.appendChild(option);

                                // Select the newly added option
                                categorySelect.value = categoryId;

                                swal({
                                    title: "Well Done!",
                                    text: "successfully added the category!",
                                    icon: "success",
                                    timer: 2000, // 3 seconds
                                    buttons: false // Disable the buttons
                                });
                                // Hide the "Other" category input fields
                                document.getElementById("otherCategoryInput").value = "";
                                document.getElementById("otherCategoryDescpInput").value = "";
                                document.getElementById("otherCategoryInput").style.display = "none";
                                document.getElementById("otherCategoryDescpInput").style.display = "none";
                                document.getElementById("saveCateBtn").style.display = "none";
                            }
                        }
                    };
                    xhr.send("otherCategory=" + encodeURIComponent(otherCategoryInput) + "&otherCategoryDescp=" + encodeURIComponent(otherCategoryDescpInput));
                });


            });

        </script>



    </body>
</html>
