<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechTide: About Us</title>
        <%@include file="cdn/css.jsp" %>
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid p-0 m-0">
            <div class="row m-0 p-0">
                <img src="img/about_pic.png" class="img-fluid p-0" width="100%" style="height: 250px;" alt="alt"/>
            </div>
            <div class="row m-0 p-0 text-center ">
                <h4 class="display-5 fs-1 mb-0 pb-0">Welcome to TechTide <br class="mt-0 pt-0"> <span class="fs-5 mt-0">Where Knowledge Meets Innovation!</span></h4>
            </div>
            <div class="row mt-4 m-0 p-0">
                <div class="container">
                    <div class="row">
                        <div class="col-md-10 offset-md-1">
                            At TechTide, we believe in the transformative power of knowledge and its seamless integration with innovation. In a world where technology evolves at a breakneck pace, staying ahead requires more than just awareness; it demands a deep understanding of the trends that shape our digital landscape.
                        </div>
                    </div>
                    <div class="row mt-5 m-0 p-0">
                        <div class="col-md-10 offset-md-1">
                            <h6 class="mb-0">Who We Are</h6>
                            <p>Whether you're a seasoned developer pushing the boundaries of what's possible, an aspiring tech enthusiast looking to delve into the intricacies of the digital realm, or simply someone curious about the limitless possibilities of technology, TechTide is your beacon. We strive to be more than a source of information; we aim to be your partner on the journey of exploration and discovery.</p>
                        </div>
                    </div>
                    <div class="row mt-5 m-0 p-0">
                        <div class="col-md-10 offset-md-1">
                            <h6 class="mb-0">Our Vision</h6>
                            <p>Our vision is to be a guiding force in the tech space, inspiring individuals to embrace the opportunities that technology presents. We envision a community of empowered individuals who not only stay abreast of the latest trends but actively contribute to shaping the future of technology.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="components/footer.jsp" %>
    </body>
</html>
