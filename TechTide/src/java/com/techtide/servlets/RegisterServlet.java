package com.techtide.servlets;

import com.techtide.dao.UserDao;
import com.techtide.entities.User;
import com.techtide.helpers.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.Instant;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            Thread.sleep(500);

            String check = request.getParameter("check");
//            checking if terms & condition checked or not
            if (check == null) {
                out.println("Please check terms & conditions");
            } else {

//                getting form data
                String name, email, password, about, gender;
                name = request.getParameter("name");
                email = request.getParameter("email");
                password = request.getParameter("password");
                about = request.getParameter("about");
                gender = request.getParameter("gender");

//                getting UserDao object
                UserDao uDao = new UserDao(ConnectionProvider.getConnection());

//                setting user values
                User user = new User();
                user.setName(name);
                user.setEmail(email);
                user.setPassword(password);
                user.setAbout(about);
                user.setGender(gender);

//                checking if user already exist
                if (uDao.getUserByEmail(email)) {
                    out.println("AlreadyExist");
                } else {

//                calling UserDao method to saveUser in db
                    user.setReg_date(Timestamp.from(Instant.now()));
                    if (uDao.registerUser(user)) {
                        out.println("done");
                    } else {
                        out.print("Something Went Wrong");
                    }
                }

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
