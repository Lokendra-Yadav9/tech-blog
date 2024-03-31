
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Something went wrong! </title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 100%, 90% 93%, 46% 100%, 40% 93%, 0 100%, 0% 35%, 0 0);
            }          
        </style>
    </head>
    <body>
        <div class="container text-center">
            <img src="img/computer.png" class="img-fluid">
            <h3 class="display-4 ">Sorry! Something went wrong...</h3>
            <h5> <%= exception %> </h5>
            <a href="index.jsp" class="btn btn-lg text-white primary-background mt-3">Home</a>
        </div>
    </body>
</html>
