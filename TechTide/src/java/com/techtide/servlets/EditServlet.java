package com.techtide.servlets;

import com.techtide.dao.UserDao;
import com.techtide.entities.User;
import com.techtide.helpers.ConnectionProvider;
import com.techtide.helpers.Image;
import com.techtide.helpers.Message;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

   
     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            getting form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String about = request.getParameter("about");
            Part profile = request.getPart("profile");
            String profile_name = profile.getSubmittedFileName();

//          Getting current logged in user
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");

//            getting old profile image name
            String old_file_path = request.getRealPath("profile") + File.separator + user.getProfile();

//          setting details to user object
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);
            user.setProfile(profile_name);

//            calling method to update the into the db
            UserDao uDao = new UserDao(ConnectionProvider.getConnection());
            if (uDao.updateUserDetails(user)) {
                out.println("details updates");
//                getting path where to upload new profile photod
                String path = request.getRealPath("profile") + File.separator + profile_name;
//                deleting old profile pic
                if (Image.deleteOldImage(old_file_path)) {
//            saving new file to the folder
                    if (Image.saveNewImage(path, profile)) {
                        Message msg = new Message("Profile Updated Successfully", "alert-success", "success");
                        session.setAttribute("msg", msg);
                        response.sendRedirect("profile.jsp");
                    } else {
                        out.println("Profile pic did't updated");
                    }
                } else {
                    out.println("Not Deleted");
                }
            } else {
                out.print("Something went wrong");
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
