
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!--bootsrap css-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>

        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 90% 93%, 46% 100%, 40% 93%, 0 100%, 0% 35%, 0 0);
            }
        </style>
    </head>
    <body>
        <%@include file="normal_navbar.jsp" %>
        <main class="d-flex align-items-center primary-background banner-background" style="height: 90vh"> 
            <div class="container pb-4">
                <div class="row">
                    <div class="col-md-6 offset-3">
                        <div class="card">
                            <div class="card-header primary-background text-center text-white">
                                <i class="fa fa-user-plus fa-2x"></i>
                                <h4>Register here</h4>
                            </div>
                            <div class="card-body">
                                <form id="forms" action="Register_servlet" method="POST">
                                    <div class="mb-1">
                                        <label for="user_name" class="form-label">user name</label>
                                        <input type="text" name="user_name" class="form-control" id="user_name" aria-describedby="emailHelp">
                                    </div>
                                    <div class="mb-1">
                                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                                        <input type="email" name="user_email" class="form-control" id="InputEmail1" aria-describedby="emailHelp">
                                    </div>
                                    <div class="mb-1">
                                        <label for="exampleInputPassword1" class="form-label">Password</label>
                                        <input type="password" name="user_password" class="form-control" id="InputPassword1">
                                    </div>
                                    <div class="mb-1">
                                        <label for="gender" class="mb-1">Select gender</label>
                                        <br>
                                        <input type="radio" class="mx-1"  id="gender" name="gender" value="male"> Male
                                        <input type="radio" class="mx-1"  id="gender" name="gender" value="female"> Female
                                        <input type="radio" class="mx-1"  id="gender" name="gender" value="other"> Other
                                    </div>

                                    <div class="mb-1">
                                        <label for="exampleFormControlTextarea1" class="form-label">Tell me something yourself</label>
                                        <textarea class="form-control" name="user_about" id="exampleFormControlTextarea1" rows="2"></textarea>
                                    </div>
                                    <div class="mb-1 form-check">
                                        <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="Check1">agree terms and condition's</label>
                                    </div>
                                    <div class="text-center" id="loader" style="display:none;"><span class="fa fa-spinner fa-spin fa-3x"></span><h5> Please wait...</h5></div>
                                    <button type="submit" class="btn primary-background text-white text-center" id="submit-btn">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="mt-4"></div>
        <%@include file="MyFooter.jsp" %>



        <!--bootstrap js-->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>


        <!--jQuery cdn-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <!--sweet alert-->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>



        <script src="js/MyJs.js" type="text/javascript"></script>



        <!--ajax page--> 
        <script>
            $(document).ready(function () {
                console.log("loading..");

                $('#forms').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $("#submit-btn").hide();
                    $("#loader").show();

                    // ajax 
                    $.ajax({
                        url: "Register_servlet",
                        type: "POST",
                        data: form,
                        success: function (data, textstaus, jqXHR) {
                            console.log(data);
                            if (data.trim() === "done") {
                                $("#submit-btn").show();
                                $("#loader").hide();

                                swal("Registered successfully ...  we are going to  redirect to Login Page")
                                        .then((value) => {
                                            window.window.location = "login_page.jsp";
                                        });
                            } else {
                                swal(data);
                                $("#submit-btn").show();
                                $("#loader").hide();
                            }
                        },
                        error: function (jqXHR, textstatus, errorThrown) {

                            swal("Something went wrong.. try again!");

                        },
                        processData: false,
                        contentType: false
                    });

                })

            })
        </script>
    </body>
</html>
