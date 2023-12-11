<%@page import="java.text.DateFormat"%>
<%@page import="com.techtide.dao.UserDao"%>
<%@page import="com.techtide.entities.Blog"%>
<%@page import="com.techtide.dao.BlogDao"%>
<%@page import="com.techtide.dao.LikeDao"%>
<%@page errorPage="error/custom_error1.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
%>
<%
    LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
    int bid = Integer.parseInt(request.getParameter("post_id"));
    BlogDao bDao = new BlogDao(ConnectionProvider.getConnection());
    Blog blog = bDao.getBlogByBlogId(bid);

//getting user by post_id
    UserDao uDao = new UserDao(ConnectionProvider.getConnection());
    User u = uDao.getUserNameByPostId(bid);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= blog.getTitle()%></title>
        <!--css-->
        <%@include  file="cdn/css.jsp" %>
        <link rel="stylesheet" href="css/style.css"/>
    </head>
    <body>
        <!--NAVBAR START-->
        <%@include file="components/navbar.jsp" %>
        <!--NAVBAR END-->
        <div class="container">
            <div class="row mt-3">
                <div class="col-md-8 offset-md-2">
                    <h4 class="display-5 mb-5"><%= blog.getTitle()%></h4>
                    <img src="PostImages/<%=blog.getImage()%>" class="w-100 mb-0" alt="Image Not Found"/>
                    <div class="row mt-0 mb-5">
                        <div class="col-md-8 text-start">Posted By <a href="#"><%=u.getName()%></a></div>
                        <div class="col-md-4 text-end">On <%=DateFormat.getDateTimeInstance().format(blog.getPostDate())%></div>
                    </div>
                    <p class="lh-base"><%=blog.getContent()%></p>
                    <div class="container p-0 mb-3">

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
        </div>
        <%@include  file="cdn/js.jsp" %>
        <script src="js/script.js"></script>
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
