<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
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
                            <h2 class="fs-4 text-center">Register Here!</h2>

                            <form id="registerForm" action="RegisterServlet" method="POST">
                                <div class="mb-3">
                                    <label for="exampleInputName1" class="form-label">User Name</label>
                                    <input name="name" type="text" class="form-control" id="exampleInputName1" aria-describedby="nameHelp">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input  name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input  name="password" type="password" class="form-control" id="exampleInputPassword1">
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputAboutYou" class="form-label">About you</label>
                                    <textarea  name="about" id="exampleInputAboutYou" class="form-control" aria-label="With textarea"></textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label mb-0">Your Gender</label>
                                    <br/>
                                    <label for="inlineRadio1" class="form-label">Male</label>
                                    <input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="Male" checked>

                                    <label for="inlineRadio2" class="form-label">Female</label>
                                    <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="Female">
                                </div>
                                <div class="mb-3 form-check">
                                    <input name="check" value="Checked" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree Terms & Conditions</label>
                                </div>
                                <div class="container text-center p-0">
                                    <button id="submitBtn" type="submit" class="btn btn-outline-light w-50">Register</button>
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
                $('#registerForm').on('submit', function (event) {
                    event.preventDefault();

//                    getting form data
                    var form = new FormData(this);

//                    hiding register btn and shwoing a loader 
                    $('#submitBtn').hide();
                    $('.loader').show();

//                    sending it to RegisterServelt using ajax
                    $.ajax({
                        url: 'RegisterServlet',
                        data: form,
                        type: 'POST',
                        success: function (data, textStatus, jqXHR) {
                            $('#submitBtn').show();
                            $('.loader').hide();

                            if (data.trim() === 'AlreadyExist') {
                                Swal.fire({
                                    text: "You're already registered, please login",
                                    icon: 'warning'
                                }).then((result) => {
                                    window.location='login.jsp';
                                });
                            }
                            else if (data.trim() === 'done') {
                                Swal.fire({
                                    text: 'Registration Completed, We are redirecting you to login page',
                                    icon: 'success'
                                }).then((result) => {
                                    window.location = 'login.jsp';
                                });
                            } else {
                                Swal.fire({
                                    text: data,
                                    icon: 'warning'
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#submitBtn').show();
                            $('.loader').hide();
                            console.log(jqXHR);
                        },
                        processData: false,
                        contentType: false
                    });

                });
            });

        </script>


    </body>
</html>
