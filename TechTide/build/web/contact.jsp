<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechTide: Contact</title>
        <%@include file="cdn/css.jsp" %>
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container">
            <div class="row my-4">
                <div class="col-md-6 offset-md-3">
                    <p class="display-6 fs-4 text-center">Please drop a message will contact you</p>
                    <div class="card">
                        <div class="card-body">
                            <form>
                                <div class="mb-3">
                                    <label class="form-label" for="name">Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" required="">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="email">Email<span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="email" required="">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="phone">Phone<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="phone" required="">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label" for="message">Message<span class="text-danger">*</span></label>
                                    <textarea class="form-control" rows="3" id="message" required=""></textarea>
                                </div>
                                <div class="container text-center">
                                    <button type="submit" class="btn primary-background color-white w-25">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include  file="components/footer.jsp" %>
    </body>
</html>
