<%@page import="com.techtide.helpers.Message"%>
<%@page import="com.techtide.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/error/custom_error1.jsp" %>
<%

    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect(" login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=user.getName()%> - Home</title>
        <!--css-->
        <%@include  file="cdn/css.jsp" %>
        <link rel="stylesheet" href="css/style.css"/>

    <div id="fb-root"></div>
</head>
<body>
    <!--NAVBAR START-->
    <%@include file="components/navbar.jsp" %>
    <!--NAVBAR END-->


    <!--PROFILE UPDATE MESSAFE START-->
    <%            Message msg = (Message) session.getAttribute("msg");
        if (msg != null) {
    %>
    <div class="alert <%=msg.getCssClass()%> rounded-0 text-center" role="alert">  
        <i class="fa-solid fa-circle-check me-1" style="font-size: 20px;"></i> <%=msg.getContent()%>
    </div>
    <%
            session.removeAttribute("msg");
        }
    %>
    <!--PROFILE UPDATE MESSAFE END-->

    <!--BODY OF PROFILE PAGE START-->

    <div class="container mt-5">
        <div class="row">
            <div class="col-lg-4 p-0 ">
                <!--POST CATEGORIES-->
                <div class="list-group rounded-0">
                    <a onclick="getAllPosts(<%=user.getId()%>, 0, this)"  class=" c-link list-group-item list-group-item-action active" aria-current="true">
                        All Posts
                    </a>
                    <%
                        CategoryDao cdao = new CategoryDao(ConnectionProvider.getConnection());
                        ArrayList<Category> category1 = cdao.getAllCategory();
                        for (Category c : category1) {
                    %>
                    <a onclick="getAllPosts(<%=user.getId()%>,<%=c.getId()%>, this)" class=" c-link list-group-item list-group-item-action"><%=c.getCategory()%></a>
                    <%
                        }
                    %>
                </div>
            </div>
            <!--POSTS-->
            <div class="col-lg-8">
                <!--loader-->
                <div class="container text-center" id="loader">
                    <i class="fa-solid fa-spinner fa-spin fa-3x primary-color"></i><br>
                    <span class="primary-color">Please Wait...</span>
                </div>
                <!--post content-->
                <div class="container-fluid text-center" id="post-content">
                    <!--Showing all the posts with the help of ajax from posts.jsp page-->
                </div>
            </div>
        </div>
    </div>

    <!--BODY OF PROFILE PAGE END-->
    <%@include  file="cdn/js.jsp" %>
    <script src="js/script.js"></script>
    <script>
                        //            all posts
                        function getAllPosts(uId, catId, temp) {
                            $('.c-link').removeClass('active');
                            $(temp).addClass('active');
                            $('#loader').show();
                            $('#post-content').hide();
                            $.ajax({
                                url: "posts.jsp",
                                data: {uid: uId, cid: catId},
                                success: function (data, textStatus, jqXHR) {
                                    console.log(data);
                                    $('#loader').hide();
                                    $('#post-content').show();
                                    $('#post-content').html(data);
                                }, error: function (jqXHR, textStatus, errorThrown) {
                                    console.log(jqXHR);
                                }
                            });
                        }

                        $(document).ready(function () {
                            let allPostRef = $('.c-link')[0];
                            getAllPosts(<%=user.getId()%>, 0, allPostRef);
                        });
    </script>

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
