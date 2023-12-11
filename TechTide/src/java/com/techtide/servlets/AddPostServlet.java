package com.techtide.servlets;

import com.techtide.dao.BlogDao;
import com.techtide.entities.Blog;
import com.techtide.helpers.ConnectionProvider;
import com.techtide.helpers.Image;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.Instant;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            Getting form data
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            Part part = request.getPart("post_image");
            String post_image_name = part.getSubmittedFileName();
            int category = Integer.parseInt(request.getParameter("category"));
            int user_id = Integer.parseInt(request.getParameter("user_id"));
//            Setting it Blog object
            Blog blog = new Blog();
            blog.setTitle(title);
            blog.setContent(content);
            blog.setImage(post_image_name);
            blog.setPostDate(Timestamp.from(Instant.now()));
            blog.setCat_id(category);
            blog.setUser_id(user_id);
            BlogDao bDao = new BlogDao(ConnectionProvider.getConnection());
            if (bDao.addBlog(blog)) {
                String path = request.getRealPath("PostImages") + File.separator + post_image_name;
                if (Image.saveNewImage(path, part)) {
                    out.println("Post Added Successfully");
                } else {
                    out.println("Something Went Wrong");
                }
            } else {
                out.println("Something Went Wrong");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
