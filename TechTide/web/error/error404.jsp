<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Oops... Looks like you got lost!</title>
        <%@include file="../cdn/css.jsp" %>
        <link rel="stylesheet" href="../TechTide/css/style.css"/>
    </head>
    <body>
        
        <%@include file="../components/navbar.jsp" %>
        
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3 text-center">
                    <img src="../TechTide/img/404-error.png" alt="Image Not Found" style="width: 400px;"/>
                    <p class="display-6" style="color:#407FF6;">Page Is Not Available</p>
                </div>
            </div>
        </div>
        <%@include file="../cdn/js.jsp" %>
    </body>
</html>
