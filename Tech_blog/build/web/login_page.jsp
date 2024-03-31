
<%@page import="com.tech.blog.entity.message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>

        <!--bootsrap css-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <!--font awesome cdn-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 90% 93%, 46% 100%, 40% 93%, 0 100%, 0% 35%, 0 0);
            }
        </style>
    </head>
    <body>
        <%@include file="normal_navbar.jsp" %>
        
        
        
        <main class="d-flex align-items-center primary-background banner-background" style="height: 80vh"> 
            <div class="container">
                <div class="row">
                    <div class="col-md-3 offset-4">
                        <div class="card">
                            <div class="card-header primary-background text-center text-white">
                                <i class="fa fa-sign-in fa-3x"></i>
                                <h4>Login here</h4>
                            </div>

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


                            <div class="card-body">
                                <form id="loginForm"  action="loginServlet" method="post">
                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                                        <input type="email" name="email" required="true" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                        <!--<div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>-->
                                    </div>
                                    <div class="mb-3">
                                        <label for="exampleInputPassword1" class="form-label">Password</label>
                                        <input type="password" name="password" required="true" class="form-control" id="exampleInputPassword1">
                                    </div>
                                    <div class="mb-3 container text-center">
                                        <button type="submit" class="btn primary-background text-white text-center">Submit</button>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

                            <div class="mt-4"></div>
                            <%@include file="MyFooter.jsp" %>

        <!--bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>



        <!--jQuery cdn-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>




        <script src="js/MyJs.js" type="text/javascript"></script>
    </body>
</html>
