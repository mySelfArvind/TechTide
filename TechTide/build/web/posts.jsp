<%@page import="com.techtide.helpers.PostContentLength"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techtide.entities.Blog"%>
<%@page import="com.techtide.dao.BlogDao"%>
<%@page import="com.techtide.dao.LikeDao"%>
<%@page import="com.techtide.dao.UserDao"%>
<%@page import="com.techtide.helpers.ConnectionProvider"%>
<%@page import="com.techtide.entities.User"%>
<%
    try {
        Thread.sleep(300);
    } catch (Exception e) {
        e.printStackTrace();
    }

%>
<%    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }

%>

<%    UserDao uDao = new UserDao(ConnectionProvider.getConnection());
    LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
%>

<div class="container-fluid">
    <div class="row">
        <%            BlogDao bDao = new BlogDao(ConnectionProvider.getConnection());
            int cid = Integer.parseInt(request.getParameter("cid"));
            int uid = Integer.parseInt(request.getParameter("uid"));
            ArrayList<Blog> blog = null;
            if (cid == 0) {
                blog = bDao.getAllBlogsForBlogOwner(uid, 0);
            } else {
                blog = bDao.getAllBlogsForBlogOwner(uid, cid);
            }

            if (blog.size() == 0) {
                out.println("<div class='container display-6'>No Post Found In This Category</div>");
                return;
            }

            for (Blog b : blog) {
        %>
        <div class="col-md-6">
            <div class="card">
                <img src="PostImages/<%= b.getImage()%>" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title text-start text-capitalize"><%=b.getTitle()%></h5>
                    <p class="card-text text-start"><%= PostContentLength.getThreeHundradLettterInContent(b.getContent())%></p>
                    <div class="container p-0" style="text-align: left; font-size: 8px;">
                        <span class="text-right text-secondary" style="">Post Date: <%= b.getPostDate().toLocaleString()%></span><br/>
                        <span class="text-right text-secondary" style="">Author: <%= uDao.getUserNameByPostId(b.getId()).getName()%></span>
                    </div>
                    <a href="details_blog.jsp?post_id=<%= b.getId()%>" class="btn primary-background color-white mt-2">Continue Reading</a>
                    <a onclick="doLike(<%=b.getId()%>,<%=user.getId()%>, this)" class="like btn primary-background color-white mt-2"><i class="like-icon fa-regular fa-thumbs-up"></i><span class="like-count" style="font-size: 13px;"><%= ldao.getTotalLikeByPostId(b.getId())%></span></a>
                    <a href="#"class="btn primary-background color-white mt-2"><i class="fa-regular fa-comments"></i><span style="font-size: 13px;">13</span></a>
                </div>
            </div>
        </div>
        <%    }
        %>
    </div>
</div>

