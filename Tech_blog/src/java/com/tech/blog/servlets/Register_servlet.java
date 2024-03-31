package com.tech.blog.servlets;

import com.tech.blog.dao.Userdao;
import com.tech.blog.dao.userInfoDao;
import com.tech.blog.entity.user;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class Register_servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //  fetch data 
            String check = request.getParameter("check");

            if (check == null) {
                out.println("box not checked");
            } else {
                String name = request.getParameter("user_name");
                String email = request.getParameter("user_email");
                String password = request.getParameter("user_password");
                String gender = request.getParameter("gender");
                String about = request.getParameter("user_about");

                // user class object
                user new_user = new user(name, email, password, gender, about);

                // user dao object
                Userdao user_dao = new Userdao(conn.getConnection());
                try {
                    if (user_dao.Saveuser(new_user)) {
                        out.println("done");
                        int userId = user_dao.getUserIdByEmail(email);
                        userInfoDao ufDao=new userInfoDao(conn.getConnection());

                        // Insert empty userInfo entry for the new user
                        if (ufDao.insertEmptyUserInfo(userId)) {
                            out.println("User registered successfully.");
                        } else {
                            out.println("Error adding userInfo entry.");
                        }
                    } else {
                        out.println("Error found");
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                    e.printStackTrace(); // Print the full stack trace for debugging
                }
            }
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
