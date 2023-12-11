<%@page import="com.techtide.helpers.PostContentLength"%>
<%@page import="com.techtide.entities.Blog"%>
<%@page import="com.techtide.dao.BlogDao"%>
<%@page import="com.techtide.dao.UserDao"%>
<%@page import="com.techtide.dao.LikeDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <%@include file="cdn/css.jsp" %>
        <link rel="stylesheet" href="css/style.css"/>
        <style>
            .clip-path{
                padding-bottom: 50px;
                clip-path: polygon(20% 100%, 0 95%, 0 0, 100% 0, 100% 100%, 89% 98%, 100% 90%, 79% 99%, 63% 94%, 41% 100%, 53% 88%, 35% 94%);
            }
        </style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid p-0">
            <div class="jumbotron primary-background clip-path">
                <div class="container ps-3 pt-3">
                    <div class="row">
                        <div class="col-md-10 offset-md-1">
                            <h2 class="display-5 color-white">Welcome to TechTide</h2>
                            <p class="fs-5 color-white">Where Knowledge Meets Innovation!</p>
                            <p>At Techtide, we're committed to delivering cutting-edge 
                                content that not only keeps you informed about the latest 
                                trends but also empowers you to navigate the rapidly changing 
                                landscape of technology. Whether you're a seasoned developer, 
                                an aspiring tech enthusiast, or someone simply curious about the 
                                digital realm, Techtide is your beacon for well-researched articles, 
                                in-depth tutorials, and thought-provoking insights.
                            </p>
                            <div class="container ps-0">
                                <a href="#" class="btn btn-outline-light"><i class="fa-solid fa-arrow-up-right-from-square"></i> Join Our Community</a>
                                <a href="login.jsp" class="btn btn-outline-light"><i class="fa-solid fa-arrow-right-to-bracket"></i> Start! It's Free</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container ps-3">
                <div class="row">
                    <div class="col-md-10 offset-md-1">
                        <div class="container-fluid p-0">
                            <div class="row mb-2">
                                <%                                    User user = (User) session.getAttribute("currentUser");
                                    LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
                                    UserDao uDao = new UserDao(ConnectionProvider.getConnection());
                                    BlogDao bdao = new BlogDao(ConnectionProvider.getConnection());
                                    ArrayList<Blog> blogs = bdao.getAllBlogs();
                                    for (Blog blog : blogs) {
                                %>
                                <div class="col-md-4 mb-2">
                                    <div class="card">
                                        <img src="PostImages/<%= blog.getImage()%>" class="card-img-top" alt="...">
                                        <div class="card-body">
                                            <h5 class="card-title"><%=blog.getTitle()%></h5>
                                            <p class="card-text"><%= PostContentLength.getThreeHundradLettterInContent(blog.getContent())%></p>
                                            <div class="container p-0" style="text-align: left; font-size: 8px;">
                                                <span class="text-right text-secondary" style="">Post Date: <%= blog.getPostDate().toLocaleString()%></span><br/>
                                                <span class="text-right text-secondary" style="">Author: <%= uDao.getUserNameByPostId(blog.getId()).getName()%></span>
                                            </div>
                                            <a href="details_blog.jsp?post_id=<%= blog.getId()%>" class="btn primary-background color-white mt-2">Continue Reading</a>
                                            <%
                                                if (user == null) {
                                            %>
                                            <a href="login.jsp" class="btn primary-background color-white mt-2"><i class="fa-regular fa-thumbs-up"></i><span style="font-size: 13px;"><%= ldao.getTotalLikeByPostId(blog.getId())%></span></a>
                                                    <%                    } else {
                                                    %>
                                            <a onclick="doLike(<%=blog.getId()%>, this)" class="like btn primary-background color-white mt-2"><i class="like-icon fa-regular fa-thumbs-up"></i><span class="like-count" style="font-size: 13px;"><%= ldao.getTotalLikeByPostId(blog.getId())%></span></a>
                                                    <%    }
                                                    %>
                                            <a href="#"class="btn primary-background color-white mt-2"><i class="fa-regular fa-comments"></i><span style="font-size: 13px;">13</span></a>
                                        </div>
                                    </div>
                                </div>
                                <%                                    }
                                %>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="cdn/js.jsp" %>
        <script src="js/script.js"></script>
        <%@include  file="components/footer.jsp" %>


        <script>
//                            doLike to post
                                             function doLike(postId, userId, tmp) {
                                                 $.ajax({
                                                     url: "DoLikePost",
                                                     data: {
                                                         pid: postId,
                                                         uid: userId
                                                     },
                                                     success: function (data, textStatus, jqXHR) {
                                                         if (data.trim() === "true".trim()) {
                                                             $(tmp).children('.like-icon').removeClass('fa-regular');
                                                             $(tmp).children('.like-icon').addClass('fa-solid');
                                                             let count = $(tmp).children('.like-count').text();
                                                             count++;
                                                             $(tmp).children('.like-count').html(count);
                                                         }
                                                     },
                                                     error: function (jqXHR, textStatus, errorThrown) {
                                                         console.log(jqXHR);
                                                     }
                                                 });
                                             }
        </script>
    </body>
</html>
