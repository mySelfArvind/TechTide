<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Something Went Wrong! Please Try Again Later</title>
        <%@include file="../cdn/css.jsp" %>
        <link rel="stylesheet" href="../TechTide/css/style.css"/>
    </head>
    <body>
        <%@include file="../components/navbar.jsp" %>
        <main class="d-flex align-items-center" style="height: 50vh;">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 offset-md-3 text-center text-danger">
                        <h3>Something Went Wrong On Server</h3>
                        <i class="fa-solid fa-circle-exclamation fa-8x"></i>
                        <p>Please try again later!</p>
                    </div>
                </div>
            </div>    
        </main>

        <%@include file="../cdn/js.jsp" %>
        <<script src="../js/script.js"></script>
    </body>
</html>
