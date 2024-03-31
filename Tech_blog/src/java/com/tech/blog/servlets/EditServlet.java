package com.tech.blog.servlets;

import com.tech.blog.dao.Userdao;
import com.tech.blog.entity.message;
import com.tech.blog.entity.user;
import com.tech.blog.helper.conn;
import com.tech.blog.helper.helper;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
            /* TODO output your page here. You may use following sample code. */      

            // fetch all data 
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");
            String about = request.getParameter("user_about");
            Part part = request.getPart("user_profile");
            
            String imgName = part.getSubmittedFileName();

            HttpSession s = request.getSession();
            user users = (user) s.getAttribute("current_user");

            users.setName(name);
            users.setEmail(email);
            users.setPassword(password);
            users.setAbout(about);
            String oldPath=users.getProfile_pic();
            if (imgName != "" || part.getSize()>0) {
                users.setProfile_pic(imgName);
            }else{
                 users.setProfile_pic( users.getProfile_pic());
            }

            // update in database
            Userdao userdao = new Userdao(conn.getConnection());
            boolean ans = userdao.updateUser_details(users);
            if (ans) {
                message msg = new message("Profile details updated..", "success", "alert-success");
                s.setAttribute("msg", msg);

                String path;
                if (users.getGender().trim().equals("male")) {
                    path = request.getRealPath("/") + "maProfile" + File.separator + users.getProfile_pic();
                } else {
                    path = request.getRealPath("/") + "feProfile" + File.separator + users.getProfile_pic();
                }
                
                String Old_img_path;
                if (users.getGender().trim().equals("male")) {
                    Old_img_path = request.getRealPath("/") + "maProfile" + File.separator + oldPath;
                } else {
                    Old_img_path  = request.getRealPath("/") + "feProfile" + File.separator + oldPath;
                }

               if(path.isEmpty() ) helper.delete_profile(Old_img_path);
                if (helper.Save_newImage(part.getInputStream(), path)) {
                    msg = new message("Profile details updated..", "success", "alert-success");
                    s.setAttribute("msg", msg);
                } else {
//                    msg = new message("invalid details! try again..", "error", "alert-danger");
//                    s.setAttribute("msg", msg);
                }
            } else {
                message msg = new message("invalid details! try again..", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }
            response.sendRedirect("profile.jsp");
        
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
