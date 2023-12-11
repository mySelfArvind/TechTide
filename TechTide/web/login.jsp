<%@page import="com.techtide.helpers.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error/custom_error1.jsp" %>


<%

    User user = (User) session.getAttribute("currentUser");
    if (user != null) {
        response.sendRedirect("profile.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <%@include file="cdn/css.jsp" %>
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>


        <div class="container p-0">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card primary-background mt-4 color-white">
                        <div class="card-body">
                            <h2 class="fs-4 text-center">Login Here!</h2>

                            <div id="loginMsg" class="alert alert-danger" role="alert" style="display: none;">  
                            </div>

                            <%
                                Message msg = (Message) session.getAttribute("msg");
                                if (msg != null) {
                            %>
                            <div id="loginMsg" class="alert <%=msg.getCssClass()%>" role="alert">  
                                <i class="fa-solid fa-circle-check me-1" style="font-size: 20px;"></i> <%=msg.getContent()%>
                            </div>
                            <%
                                    session.removeAttribute("msg");
                                }
                            %>

                            <form id="loginForm" action="LoginServlet" method="POST">
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input name="password" type="password" class="form-control" id="exampleInputPassword1">
                                </div>
                                <div id="loginBtn" class="container text-center">
                                    <button type="submit" class="btn btn-outline-light w-25">Login</button>
                                    <br/>
                                    <a href="register.jsp" class="link-light">Don't have an account ?</a>
                                </div>
                                <div class="container text-center loader" style="display: none;">
                                    <i class="fa-solid fa-spinner fa-spin fa-4x"></i>
                                    <p>Please Wait...</p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <%@include file="cdn/js.jsp" %>


        <script>
            $(document).ready(function () {
                $('#loginForm').on('submit', function (event) {
                    event.preventDefault();
                    var form = new FormData(this);

                    $('#loginBtn').hide();
                    $('.loader').show();
                    $.ajax({
                        url: 'LoginServlet',
                        data: form,
                        type: 'POST',
                        success: function (data, textStatus, jqXHR) {
                            $('#loginBtn').show();
                            $('.loader').hide();
                            console.log(data);
                            if (data.trim() === 'done') {
                                window.location = 'profile.jsp';
                            } else {
                                $('#loginMsg').html('<i class="fa-solid fa-triangle-exclamation me-1" style="font-size: 20px;"></i>' + data);
                                $('#loginMsg').show();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#loginBtn').show();
                            $('.loader').hide();
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>

    </body>
</html>
