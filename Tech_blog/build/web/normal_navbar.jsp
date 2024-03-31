<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Navbar</title>


        <!--font awesome cdn-->
        <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!--bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
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
                        <li class="nav-item">
                            <a class="nav-link" aria-disabled="true" href="login_page.jsp"><span class="fa fa-sign-in"></span> Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " aria-disabled="true" href="register_page.jsp"><span class="fa fa-user-plus"></span> Sign up</a>
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
                </div>
            </div>



        </nav>



        <!--bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

        <!--jQuery cdn-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>



        <script src="js/MyJs.js" type="text/javascript"></script>
    </body>
</html>
