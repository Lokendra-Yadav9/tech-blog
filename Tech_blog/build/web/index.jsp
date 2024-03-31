<%@page import="com.tech.blog.entity.user"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tech Blog</title>
        <!--bootsrap css-->



        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <link href="css/StyleSecond.css" rel="stylesheet" type="text/css"/>
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 90% 93%, 46% 100%, 40% 93%, 0 100%, 0% 35%, 0 0);
            }
            a{
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <!-- nav bar-->

        <%
            user currentUser = (user) session.getAttribute("current_user");
            if (currentUser != null) {
        %>
        <%@include  file="new_navbar.jsp" %>
        <%        } else {

        %>
        <%@include file="normal_navbar.jsp" %>
        <%            }
        %>



        <!-- banner -->
        <div class="container-fluid p-0 m-0">

            <div class="jumbotron primary-background text-white banner-background"> 
                <div class="container p-5">
                    <h3 class="display-2">Welcome Tech Blogger's</h3>
                    <p>Computer programming or coding is the composition of sequences of instructions, called programs, that computers can follow to perform tasks.It involves designing and implementing algorithms, step-by-step specifications of procedures, by writing code in one or more programming languages.</p>
                    <p>Programmable devices have existed for centuries. As early as the 9th century, a programmable music sequencer was invented by the Persian Banu Musa brothers.</p>
                    <a href="profile.jsp" class="btn btn-outline-light"><span class="fa fa-code-fork"></span> Start ! it's Free</a>  


                    <%
                        if (currentUser == null) {
                    %>
                    <a class="btn btn-outline-light" href="login_page.jsp"><span class="fa fa-user-circle-o fa-spin"></span> Login</a>  
                    <%        }

                    %>

                </div>
            </div>
        </div>

        <!--cards-->
        <div class="container mt-3">
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Java Programming</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn primary-background text-white">Read more</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Card title</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn primary-background text-white">Go somewhere</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Card title</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn primary-background text-white">Go somewhere</a>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Card title</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn primary-background text-white">Go somewhere</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Card title</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn primary-background text-white">Go somewhere</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Card title</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn primary-background text-white">Go somewhere</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!--footer connect-->
        <div class="mt-5">   
            <%@include file="MyFooter.jsp" %>
        </div>



        <!--bootstrap js-->





        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>


        <!--jQuery cdn-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>


        <script src="js/MyJs.js" type="text/javascript"></script>
    </body>
</html>
