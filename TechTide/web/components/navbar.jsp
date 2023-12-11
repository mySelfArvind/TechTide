<%@page import="java.util.ArrayList"%>
<%@page import="com.techtide.entities.Category"%>
<%@page import="com.techtide.dao.CategoryDao"%>
<%@page import="com.techtide.helpers.ConnectionProvider"%>
<%@page import="com.techtide.entities.User"%>
<%
    User navbarUser = (User) session.getAttribute("currentUser");
%>
<nav class="navbar navbar-expand-lg navbar-light primary-background shadow-sm sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp" style="color: #FC0000;">TechTide</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="color-white nav-link" aria-current="page" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="color-white nav-link" href="#">Blog</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="color-white nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Categories
                    </a>
                    <ul class="dropdown-menu bg-white" aria-labelledby="navbarDropdown">
                        <%
                            CategoryDao cDao1 = new CategoryDao(ConnectionProvider.getConnection());
                            ArrayList<Category> categories = cDao1.getAllCategory();
                            for (Category category : categories) {
                        %>
                        <li><a class="primary-color navbar-categories-li dropdown-item" href="#"><%=category.getCategory()%></a></li>
                        <%
                            }

                        %>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="color-white nav-link" href="aboutUs.jsp">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="color-white nav-link" href="contact.jsp">Contact</a>
                </li>
                <%                    if (navbarUser != null) {
                %>
                <li class="nav-item">
                    <a class="color-white nav-link" href="#" data-bs-toggle="modal" data-bs-target="#do-post-modal"><i class="fa-brands fa-ioxhost"></i> Do Post</a>
                </li>
                <li class="nav-item">
                    <a class="color-white nav-link" href="profile.jsp   "><i class="fa-regular fa-address-card"></i> Profile</a>
                </li>
                <%
                    }
                %>



            </ul>
            <%
                if (navbarUser == null) {
            %>
            <form class="d-flex">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>
            <%
            } else {
            %>
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="color-white nav-link" href="#" data-bs-toggle="modal" data-bs-target="#profile-modal"><i class="fa-solid fa-user"></i> <%=navbarUser.getName()%></a>
                </li>
                <li class="nav-item">
                    <a class="color-white nav-link" href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                </li>
            </ul>
            <%
                }
            %>

        </div>
    </div>
</nav>


<%
    if (navbarUser != null) {
%>
<!--profile modal start-->
<div class="modal fade" id="profile-modal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background">
                <h5 class="modal-title text-danger" id="exampleModalLabel">TechTide</h5>
                <button type="button" class="btn-close color-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pb-0">
                <div class="container text-center">
                    <img src="../TechTide/profile/<%=navbarUser.getProfile()%>" width="60px" height="60px" alt="alt" style="border-radius: 50%;"/>
                    <p class="font-monospace mt-2"><%= navbarUser.getName()%></p>
                </div>

                <!--PROFILE DETAILS-->
                <div id="profile-details">
                    <table class="table table-borderless w-75">
                        <tbody>
                            <tr>
                                <td class="fw-normal">ID:</td>
                                <td class="fw-normal"><%=navbarUser.getId()%></td>
                            </tr>
                            <tr>
                                <td class="fw-normal">Email:</td>
                                <td class="fw-normal"><%=navbarUser.getEmail()%></td>
                            </tr>
                            <tr>
                                <td class="fw-normal">Gender:</td>
                                <td class="fw-normal"><%=navbarUser.getGender()%></td>
                            </tr>
                            <tr>
                                <td class="fw-normal">Registration:</td>
                                <td class="fw-normal"><%=navbarUser.getReg_date()%></td>
                            </tr>
                            <tr>
                                <td class="fw-normal">About:</td>
                                <td class="fw-normal"><%=navbarUser.getAbout()%></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!--PROFILE EDIT-->
                <div id="profile-edit" style="display: none;">
                    <form id="profile-edit-form" action="EditServlet" method="POST" enctype="multipart/form-data">
                        <table class="table table-borderless w-75">
                            <tbody>
                                <tr>
                                    <td class="fw-normal">Name:</td>
                                    <td class="fw-normal"><input required class="form-control" type="text" name="name" value="<%=navbarUser.getName()%>"/></td>
                                </tr>
                                <tr>
                                    <td class="fw-normal">Email:</td>
                                    <td class="fw-normal"><input required class="form-control" type="email" name="email" value="<%=navbarUser.getEmail()%>"/></td>
                                </tr>
                                <tr>
                                    <td class="fw-normal">Password:</td>
                                    <td class="fw-normal"><input required class="form-control" type="password" name="password" value="<%=navbarUser.getPassword()%>"/></td>
                                </tr>
                                <tr>
                                    <td class="fw-normal">About:</td>
                                    <td><textarea required class="form-control" id="exampleFormControlTextarea1" rows="3" name="about"><%=navbarUser.getAbout()%></textarea></td>
                                </tr>
                                <tr>
                                    <td class="fw-normal">Profile:</td>
                                    <td class="fw-normal"><input required class="form-control" type="file" name="profile"/></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td class="text-center">
                                        <button type="submit" class="btn primary-background color-white">Update Details</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>

            </div>
            <div class="modal-footer primary-background">
                <div class="container text-center">
                    <button id="EditBtn" type="button" class="btn btn-outline-light">Edit Profile</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--profile modal end-->


<!--post modal start-->
<!-- Modal -->
<div class="modal fade" id="do-post-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" id="modalForClose">
        <div class="modal-content">
            <div class="modal-header primary-background" >
                <h5 class="modal-title text-danger" id="exampleModalLabel">TechTide</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="add-post-form" action="AddPostServlet" method="POST" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="exampleInputTitle1" class="form-label">Title <span class="text-danger">*</span></label>
                        <input name="title" required="" type="text" class="form-control" id="exampleInputTitle1" aria-describedby="titleHelp">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputTitle1" class="form-label">Content <span class="text-danger">*</span></label>
                        <textarea name="content" required class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputTitle1" class="form-label">Image <span class="text-danger">*</span></label>
                        <input name="post_image" required="" class="form-control form-control-sm" id="formFileSm" type="file">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputTitle1" class="form-label">Post Category <span class="text-danger">*</span></label>

                        <select name="category" required="" class="form-select" aria-label="Default select example">

                            <%
                                CategoryDao cDao = new CategoryDao(ConnectionProvider.getConnection());
                                ArrayList<Category> category = cDao.getAllCategory();
                                for (Category c : category) {
                            %>
                            <option value="<%=c.getId()%>"><%=c.getCategory()%></option>
                            <%}%>
                        </select>

                    </div>
                </div>
                <input name="user_id" class="form-control form-control-sm d-none" value="<%=navbarUser.getId()%>" id="formFileSm" type="text" >
                <div class="modal-footer primary-background">
                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-light">Post Now</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%
    }
%>
<!--post modal end-->
